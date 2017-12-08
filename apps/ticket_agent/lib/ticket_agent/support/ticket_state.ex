require Logger
defmodule TicketAgent.TicketState do
  alias Ecto.Multi
  alias TicketAgent.{Listing, Order, Repo, Ticket}
  import Ecto.{Changeset, Query}

  def reserve_tickets(%{id: order_id} = order, listing_id, tickets) do
    ticket_count = Enum.count(tickets)

    existing_count = 
      listing_id
      |> find_query(order_id)
      |> Repo.aggregate(:count, :id)
    
    ticket_count = ticket_count - existing_count
    Logger.info "There are #{existing_count} existing tickets, meaning we have to create #{ticket_count} tickets"

    # func = reserve_transaction(listing_id, ticket_count, order_id, tickets)
    # {:ok, _} = Repo.transaction(func)

    # tickets = 
    #   listing_id
    #   |> find_query(order_id)
    #   |> Repo.all

    # minium_ticket = Enum.min_by(tickets, fn(ticket) -> ticket.locked_until end)
    
    # {:ok, datetime} = Calendar.NaiveDateTime.to_date_time(minium_ticket.locked_until, "UTC") 
    # locked_until = Calendar.DateTime.Format.iso8601_basic(datetime)

    # tickets =
    #   tickets
    #   |> Enum.reduce([], fn(ticket, acc) ->
    #     acc ++ [
    #       %{
    #         id: ticket.id,
    #         email: ticket.guest_email,
    #         name: ticket.guest_name,
    #         slug: ticket.slug
    #       }
    #     ]
    #   end)
    {order, [], NaiveDateTime.utc_now()}
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
      where: t.status == "locked",
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