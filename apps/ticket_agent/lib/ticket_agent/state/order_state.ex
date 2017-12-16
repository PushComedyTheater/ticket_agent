defmodule TicketAgent.State.OrderState do
  require Logger
  alias Ecto.Multi
  alias TicketAgent.{Listing, Order, Repo, Ticket}
  alias TicketAgent.Finders.TicketFinder
  import Ecto.{Changeset, Query}

  def set_order_processing_transaction(order) do
    Logger.info "set_order_processing_transaction for order #{order.slug}"
    Multi.new()
    |> Multi.update_all(:processing_order,
      from(
        o in Order,
        where: o.id == ^order.id,
        where: o.status == "started"
      ),
      [
        set: [
          status: "processing"
        ]
      ],
      returning: true
    )
  end

  def set_order_completed_transaction(order) do
    Multi.new()
    |> Multi.update_all(:processing_order,
      from(
        o in Order,
        where: o.id == ^order.id,
        where: o.status == "processing"
      ),
      [
        set: [
          status: "completed",
          completed_at: NaiveDateTime.utc_now(),
        ]
      ],
      returning: true
    )
  end

  def reserve_tickets(%{id: order_id} = order, listing_id, input_tickets) do
    ticket_count = Enum.count(input_tickets)

    existing_count =
      listing_id
      |> TicketFinder.find_by_listing_and_order(order_id)
      |> Enum.count()

    ticket_count = ticket_count - existing_count
    Logger.info "There are #{existing_count} existing tickets, meaning we have to create #{ticket_count} tickets"

    ticket = if ticket_count > 0 do
      {:ok, _} =
        listing_id
        |> lock_operation(order_id, ticket_count)
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
    else
      tickets =
        listing_id
        |> TicketFinder.find_by_listing_and_order(order_id)
    end
    minium_ticket = Enum.min_by(tickets, fn(ticket) -> ticket.locked_until end)
    {order, tickets, minium_ticket.locked_until}
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

    seconds_to_add = Application.get_env(:ticket_agent, :ticket_lock_length, 302)
    Logger.info "seconds_to_add set to #{inspect seconds_to_add}"
    locked_until = NaiveDateTime.utc_now() |> Calendar.NaiveDateTime.add!(seconds_to_add)

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

  def release_order_tickets(%{id: order_id} = order, listing_id, input_tickets) do
    ticket_count = Enum.count(input_tickets)
    input_ticket_ids = Enum.map(input_tickets, fn(ticket) -> ticket["id"] end)

    Logger.info "There are #{ticket_count} existing tickets to be released"

    Repo.update_all(
      from(
        t in Ticket,
        where: t.listing_id == ^listing_id,
        where: t.order_id == ^order_id,
        where: t.status == "locked" or t.status == "processing",
        where: t.id in ^input_ticket_ids
      ),
      set: [
          status: "available",
          order_id: nil,
          locked_until: nil,
          guest_name: nil,
          guest_email: nil
        ]
    )
    |> IO.inspect
  end
end
