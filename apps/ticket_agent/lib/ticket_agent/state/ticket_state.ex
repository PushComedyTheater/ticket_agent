require Logger
defmodule TicketAgent.State.TicketState do
  alias Ecto.Multi
  alias TicketAgent.{Repo, Ticket}
  alias TicketAgent.Finders.TicketFinder
  import Ecto.Query

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

  def set_ticket_checkedin_transaction(ticket_id, user_id) do
    Logger.info "set_ticket_checkedin_transaction->ticket_id = #{inspect ticket_id}"

    Multi.new()
    |> Multi.update_all(:available_tickets,
      from(
        t in Ticket,
        where: t.id == ^ticket_id,
        where: t.status in ["emailed", "purchased"]
      ),
      [
        set: [
          status: "checkedin",
          checked_in_at: NaiveDateTime.utc_now(),
          checked_in_by: user_id
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

      input_tickets
      |> Enum.with_index()
      |> Enum.map(fn({%{"name" => name, "email" => email}, index}) ->
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

  def release_tickets(%{id: order_id}, input_ticket_ids) do

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
end