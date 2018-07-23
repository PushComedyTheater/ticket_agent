defmodule TicketAgent.State.TicketState do
  require Logger
  alias Ecto.Multi
  alias TicketAgent.{Repo, Ticket}
  alias TicketAgent.Finders.TicketFinder
  import Ecto.Query
  @seconds_to_add Application.get_env(:ticket_agent, :ticket_lock_length, 302)

  # Tickets can go from processing -> locked
  def lock_processing_tickets(order, timestamp \\ NaiveDateTime.utc_now()) do
    Logger.info "lock_processing_tickets->order_id       = #{order.id}"
    Logger.info "lock_processing_tickets->timestamp      = #{inspect timestamp}"
    Logger.info "lock_processing_tickets->seconds_to_add = #{inspect @seconds_to_add}"

    locked_until = timestamp |> Calendar.NaiveDateTime.add!(@seconds_to_add)

    Multi.new()
    |> Multi.update_all(:locked_processing_tickets,
      from(
        t in Ticket,
        where: t.order_id == ^order.id,
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

  # Tickets can go from locked -> processing
  def unlock_tickets_to_processing_for_order(order) do
    Logger.info "unlock_tickets_to_processing_for_order->order_id  = #{order.id}"

    Multi.new()
    |> Multi.update_all(:unlocked_processing_tickets,
      from(
        t in Ticket,
        where: t.order_id == ^order.id,
        where: t.status == "locked"
      ),
      [
        set: [
          status: "processing",
          locked_until: nil
        ]
      ],
      returning: true
    )
  end

  # Tickets can go from processing/locked -> purchased
  def purchase_processing_tickets_for_order(order, timestamp \\ NaiveDateTime.utc_now()) do
    Logger.info "purchase_processing_tickets_for_order->order_id       = #{order.id}"
    Logger.info "purchase_processing_tickets_for_order->timestamp      = #{inspect timestamp}"

    Multi.new()
    |> Multi.update_all(:purchased_processing_tickets,
      from(
        t in Ticket,
        where: t.order_id == ^order.id,
        where: t.status in ["locked", "processing"]
      ),
      [
        set: [
          status: "purchased",
          locked_until: nil,
          purchased_at: timestamp
        ]
      ],
      returning: true
    )
  end

  # Tickets can go from purchased -> emailed
  def email_purchased_ticket(ticket_id, timestamp \\ NaiveDateTime.utc_now()) do
    Logger.info "email_purchased_ticket->ticket_id = #{inspect ticket_id}"
    Logger.info "email_purchased_ticket->timestamp = #{inspect timestamp}"

    Multi.new()
    |> Multi.update_all(:emailed_tickets,
      from(
        t in Ticket,
        where: t.id == ^ticket_id,
        where: t.status  == "purchased"
      ),
      [
        set: [
          status: "emailed",
          emailed_at: timestamp
        ]
      ],
      returning: true
    )
  end

  # Tickets can go from purchased/email -> checkedin
  def set_ticket_checkedin(ticket_id, user_id, timestamp \\ NaiveDateTime.utc_now()) do
    Logger.info "set_ticket_checkedin->ticket_id = #{inspect ticket_id}"
    Logger.info "set_ticket_checkedin->user_id   = #{inspect user_id}"
    Logger.info "set_ticket_checkedin->timestamp = #{inspect timestamp}"

    Multi.new()
    |> Multi.update_all(:checked_in_tickets,
      from(
        t in Ticket,
        where: t.id == ^ticket_id,
        where: t.status in ["emailed", "purchased"]
      ),
      [
        set: [
          status: "checkedin",
          checked_in_at: timestamp,
          checked_in_by: user_id
        ]
      ],
      returning: true
    )
  end

  # Locks a particular number of tickets
  def lock_tickets(listing_id, order_id, quantity, group, timestamp \\ NaiveDateTime.utc_now()) do
    locked_until = timestamp |> Calendar.NaiveDateTime.add!(@seconds_to_add)

    Logger.info "lock_tickets->listing_id     = #{inspect listing_id}"
    Logger.info "lock_tickets->order_id       = #{inspect order_id}"
    Logger.info "lock_tickets->quantity       = #{inspect quantity}"
    Logger.info "lock_tickets->group          = #{inspect group}"
    Logger.info "lock_tickets->timestamp      = #{inspect timestamp}"
    Logger.info "lock_tickets->seconds_to_add = #{inspect @seconds_to_add}"
    Logger.info "lock_tickets->locked_until   = #{inspect locked_until}"

    subset_query =
      from(
        t in Ticket,
        where: t.listing_id == ^listing_id,
        where: t.status == "available",
        where: is_nil(t.locked_until),
        where: is_nil(t.order_id),
        where: is_nil(t.guest_name),
        where: is_nil(t.guest_email),
        where: t.group == ^group,
        limit: ^quantity
      )

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
      returning: true
    )
  end

  # Reserves tickets for a particular order
  def reserve_tickets(%{id: order_id} = order, input_tickets, group) do
    listing_id = Enum.at(input_tickets, 0)["listing_id"]

    order
    |> filter_created_tickets(listing_id, input_tickets, group)
    |> create_new_tickets(listing_id, order_id, group)
  end

  def release_tickets(order) do
    Logger.info "release_tickets->order_id  = #{order.id}"

    Multi.new()
    |> Multi.update_all(:release_tickets,
      from(
        t in Ticket,
        where: t.order_id == ^order.id
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

  def filter_created_tickets(order, listing_id, input_tickets, group) do
    Logger.info "filter_created_tickets->order.id:         #{inspect order.id}"
    Logger.info "filter_created_tickets->listing_id:       #{inspect listing_id}"
    Logger.info "filter_created_tickets->group:            #{inspect group}"
    # Logger.info "filter_created_tickets->input_tickets:    #{inspect input_tickets}"


    existing_tickets =
      listing_id
      |> TicketFinder.find_by_listing_and_order_and_group(order.id, group)

    Logger.info "find_existing_tickets->existing_tickets count: #{inspect Enum.count(existing_tickets)}"

    input_tickets
    |> Enum.filter(fn(ticket) ->
      Enum.find(existing_tickets, fn(existing_ticket) ->
        (
          (
            existing_ticket.id == ticket["ticket_id"]
          ) ||
          (
            (existing_ticket.guest_name == ticket["name"]) &&
            (existing_ticket.guest_email == ticket["email"]) &&
            (existing_ticket.group == ticket["group"]) &&
            (existing_ticket.price == ticket["price"])
          )
        )
      end)
      |> is_nil
    end)
  end

  def create_new_tickets(tickets, _, _, _) when length(tickets) == 0 do
    Logger.info "create_new_tickets-> no tickets to create"
    :ok
  end

  def create_new_tickets(tickets, listing_id, order_id, group) when length(tickets) > 0 do
    ticket_count = Enum.count(tickets)

    {:ok, item} =
      listing_id
      |> lock_tickets(order_id, ticket_count, group)
      |> Repo.transaction()

    available_tickets =
      listing_id
      |> TicketFinder.find_by_listing_and_order_and_group(order_id, group)

    tickets
    |> Enum.with_index()
    |> Enum.map(fn({%{"name" => name, "email" => email}, index}) ->
      Enum.at(available_tickets, index)
      |> Ecto.Changeset.change([guest_name: name, guest_email: email])
      |> Repo.update!
    end)
    :ok
  end

  def load_minimum_locked_until(order, listing_id) do
    tickets =
      listing_id
      |> TicketFinder.find_by_listing_and_order(order.id)

    minimum_ticket = Enum.min_by(tickets, fn(ticket) -> ticket.locked_until end)
    {order, tickets, minimum_ticket.locked_until}
  end
end
