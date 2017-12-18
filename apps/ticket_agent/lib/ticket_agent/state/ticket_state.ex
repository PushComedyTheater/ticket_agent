require Logger
defmodule TicketAgent.State.TicketState do
  alias Ecto.Multi
  alias TicketAgent.{Listing, Order, Repo, Ticket}
  alias TicketAgent.Finders.TicketFinder
  import Ecto.{Changeset, Query}

  @seconds_to_add Application.get_env(:ticket_agent, :ticket_lock_length, 302)

  def set_tickets_processing_transaction(ticket_ids, order_id) do
    Logger.info "set_tickets_processing_transaction->order_id       = #{order_id}"
    Logger.info "set_tickets_processing_transaction->ticket_ids     = #{inspect ticket_ids}"
    Logger.info "set_tickets_processing_transaction->seconds_to_add = #{inspect @seconds_to_add}"

    locked_until = NaiveDateTime.utc_now() |> Calendar.NaiveDateTime.add!(@seconds_to_add)

    Multi.new()
    |> Multi.update_all(:processing_tickets,
      from(
        t in Ticket,
        where: t.id in ^ticket_ids,
        where: t.order_id == ^order_id,
        where: t.status == "locked"
      ),
      [
        set: [
          status: "processing",
          locked_until: locked_until
        ]
      ],
      returning: true
    )
  end

  def set_tickets_locked_transaction(ticket_ids, order_id) do
    Logger.info "set_tickets_locked_transaction->order_id       = #{order_id}"
    Logger.info "set_tickets_locked_transaction->ticket_ids     = #{inspect ticket_ids}"
    Logger.info "set_tickets_locked_transaction->seconds_to_add = #{inspect @seconds_to_add}"

    locked_until = NaiveDateTime.utc_now() |> Calendar.NaiveDateTime.add!(@seconds_to_add)

    Multi.new()
    |> Multi.update_all(:available_tickets,
      from(
        t in Ticket,
        where: t.id in ^ticket_ids,
        where: t.order_id == ^order_id,
        where: t.status == "processing"
      ),
      [
        set: [
          status: "locked",
          locked_until: locked_until
        ]
      ],
      returning: true
    )
  end

  def set_tickets_purchased_transaction(ticket_ids, order_id) do
    Logger.info "set_tickets_purchased_transaction->order_id       = #{order_id}"
    Logger.info "set_tickets_purchased_transaction->ticket_ids     = #{inspect ticket_ids}"

    Multi.new()
    |> Multi.update_all(:purchased_tickets,
      from(
        t in Ticket,
        where: t.id in ^ticket_ids,
        where: t.order_id == ^order_id,
        where: t.status == "processing"
      ),
      [
        set: [
          status: "purchased",
          locked_until: nil
        ]
      ],
      returning: true
    )
  end

  def reserve_tickets(%{id: order_id} = order, input_tickets) do
    listing_id = Enum.at(input_tickets, 0)["listing_id"]

    existing_tickets = TicketFinder.find_by_listing_and_order(listing_id, order_id)

    to_be_created_tickets =
      input_tickets
      |> Enum.filter(fn(ticket) ->
        Logger.info "Looking for existing ticket #{inspect ticket}"
        Enum.find(existing_tickets, fn(existing_ticket) ->
          (existing_ticket.id == ticket["id"]) ||
          (
            existing_ticket.guest_name == ticket["name"] &&
            existing_ticket.guest_email == ticket["email"]
           )
        end)
        |> is_nil
      end)

    to_be_created_ticket_count = Enum.count(to_be_created_tickets)
    Logger.info "Tickets to create = #{inspect to_be_created_tickets} #{to_be_created_ticket_count}"

    if to_be_created_ticket_count > 0 do
      {:ok, _} =
        listing_id
        |> lock_operation(order_id, to_be_created_ticket_count)
        |> Repo.transaction()

      available_tickets =
        listing_id
        |> TicketFinder.find_by_listing_and_order(order_id)

      tickets =
        input_tickets
        |> Enum.with_index()
        |> Enum.map(fn({%{"name" => name, "email" => email, "listing_id" => listing_id}, index}) ->
          ticket =
            Enum.at(available_tickets, index)
            |> Ecto.Changeset.change([guest_name: name, guest_email: email])
            |> Repo.update!
        end)
    end

    tickets =
      listing_id
      |> TicketFinder.find_by_listing_and_order(order_id)

    minimum_ticket = Enum.min_by(tickets, fn(ticket) -> ticket.locked_until end)
    {order, tickets, minimum_ticket.locked_until}
  end

  def release_tickets(%{id: order_id} = order, input_ticket_ids) do
    
    ticket_count = Enum.count(input_ticket_ids)

    Logger.info "There are #{ticket_count} existing tickets to be released"

    Multi.new()
    |> Multi.update_all(:release_tickets,
      from(
        t in Ticket,
        where: t.order_id == ^order_id,
        where: t.status == "locked" or t.status == "processing",
        where: t.id in ^input_ticket_ids
      ),
      [
        set: [
            status: "available",
            order_id: nil,
            locked_until: nil,
            guest_name: nil,
            guest_email: nil
          ]
      ],
      returning: true
    )
  end

  def lock_operation(listing_id, order_id, quantity) do
    timestamp = NaiveDateTime.utc_now()

    subset_query =
      from(
        t in Ticket,
        where: t.listing_id == ^listing_id,
        where: t.status == "available",
        where: is_nil(t.locked_until),
        where: is_nil(t.order_id),
        where: is_nil(t.guest_name),
        where: is_nil(t.guest_email),
        limit: ^quantity
      )

    Logger.info "seconds_to_add set to #{inspect @seconds_to_add}"
    locked_until = NaiveDateTime.utc_now() |> Calendar.NaiveDateTime.add!(@seconds_to_add)

    Multi.new()
    |> Multi.update_all(:lock_tickets,
      from(
        t in Ticket,
        join: s in subquery(subset_query),
        on: s.id == t.id
      ),
      [
        set: [
          status: "locked",
          order_id: order_id,
          locked_until: locked_until
        ]
      ],
      returning: false
    )
  end

  defp reserve_transaction(listing_id, ticket_count, order_id, tickets) do
    fn ->
      load_query(listing_id, ticket_count)
      |> Repo.all()
      |> Enum.with_index()
      |> Enum.reduce([], fn({db_ticket, index}, acc) ->
        %{
          "email" => guest_email,
          "name" => guest_name
        } = Enum.at(tickets, index)
        ticket =
          db_ticket
          |> update_ticket(guest_name, guest_email, order_id)
        acc ++ [ticket]
      end)
    end
  end

  defp update_ticket(db_ticket, guest_name, guest_email, order_id) do
    db_ticket
    |> Ecto.Changeset.cast(
      %{
        status: "locked",
        locked_until: NaiveDateTime.add(NaiveDateTime.utc_now(), 300),
        order_id: order_id,
        guest_name: guest_name,
        guest_email: guest_email
      },
      [
        :status,
        :locked_until,
        :order_id,
        :guest_name,
        :guest_email
      ]
    )
    |> foreign_key_constraint(:order_id)
    |> Repo.update!
  end

  defp find_query(listing_id, order_id) do
    from(
      t in Ticket,
      where: t.listing_id == ^listing_id,
      where: t.order_id == ^order_id,
      where: t.status == "locked" or t.status == "purchased",
      select: t
    )
  end

  defp load_query(listing_id, ticket_count) do
    from(
      t in Ticket,
      where: t.listing_id == ^listing_id,
      where: t.status == "available",
      where: is_nil(t.order_id),
      where: is_nil(t.locked_until),
      where: fragment("? <= NOW()", t.sale_start),
      where: fragment("(? >= NOW() OR ? IS NULL)", t.sale_end, t.sale_end),
      limit: ^ticket_count,
      lock: "FOR UPDATE",
      select: t
    )
  end

  def provision_ticket(%Order{id: order_id} = order, %{"email" => email, "name" => name, "listing_id" => listing_id}) do
    IO.inspect name
    IO.inspect email
    IO.inspect listing_id

    Multi.new()
    |> Multi.update_all(:available_tickets,
      from(
        t in Ticket,
        where: t.listing_id == ^listing_id,
        where: t.status == "available",
        where: is_nil(t.order_id),
        where: is_nil(t.locked_until),
        limit: 5
      ),
      [
        set: [
          status: "locked",
          locked_until: NaiveDateTime.add(NaiveDateTime.utc_now(), 300),
          order_id: order_id
        ]
      ],
      returning: true
    )
    |> IO.inspect

  end

  # def activate_operation(%Channel{id: id}, timestamp \\ NaiveDateTime.utc_now()) do
  #   Multi.new()
  #   |> Multi.update_all(:activate_channel,
  #     from(t in Channel, where: t.status in ["provisioning"] and t.id == ^id),
  #     [set: [status: "active", status_updated_at: timestamp]],
  #     returning: true
  #   )
  # end
end
