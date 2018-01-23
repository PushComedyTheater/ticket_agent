defmodule TicketAgent.Finders.TicketFinder do
  import Ecto.Query
  alias TicketAgent.{Listing, Order, Repo, Ticket}

  def paginate_tickets_for_listing(listing_id, params \\ %{}) do
    query = from(
      t in Ticket,
      where: t.listing_id == ^listing_id,
      order_by: :purchased_at
    )
    |> Repo.paginate(params)
  end

  def find_by_listing_and_order(listing_id, order_id) do
    from(
      t in Ticket,
      where: t.listing_id == ^listing_id,
      where: t.order_id == ^order_id,
      where: t.status == "locked" or t.status == "purchased",
      select: t
    )
    |> Repo.all()
  end

  def count_by_listing_and_user(_, nil), do: {false, nil}
  def count_by_listing_and_user(listing_id, %{id: user_id}) do
    orders =
      from(
        t in Ticket,
        left_join: o in Order, on: o.id == t.order_id,
        where: o.user_id == ^user_id,
        where: t.listing_id == ^listing_id,
        select: o
      )
      |> Repo.all

    count = Enum.count(orders)

    cond do
      count > 0 ->
        {true, hd(orders)}
      true ->
        {false, nil}
    end

  end

  def listing_price(listing_id) do
    from(
      t in Ticket,
      where: t.listing_id == ^listing_id,
      limit: 1,
      select: t.price
    )
    |> Repo.all
  end

  def price_range(listing_ids) do
    from(
      t in Ticket,
      where: t.listing_id in ^listing_ids,
      select: %{
        min_price: min(t.price),
        max_price: max(t.price)
      }
    )
    |> Repo.one
  end

  def all_available_tickets_by_listing_slug(listing_slug) do
# SELECT json_agg(distinct t0."name"), t0."price", count(t0.id) 
# FROM "tickets" AS t0 
# LEFT OUTER JOIN "listings" AS l1 ON l1."id" = t0."listing_id" 
# WHERE (l1."slug" = 'JL18Y9') AND (t0."status" = 'available') AND (t0."locked_until" IS NULL) 
# AND (t0."order_id" IS NULL) AND (t0."guest_name" IS NULL) AND (t0."guest_email" IS NULL) 
# GROUP BY t0.price    
    from(
      ticket in Ticket,
      left_join: listing in Listing, on: listing.id == ticket.listing_id,
      where: listing.slug == ^listing_slug,
      where: ticket.status == "available",
      where: is_nil(ticket.locked_until),
      where: is_nil(ticket.order_id),
      where: is_nil(ticket.guest_name),
      where: is_nil(ticket.guest_email),
      group_by: ticket.price,
      select: %{
        name: fragment("json_agg(DISTINCT ?)", ticket.name),
        price: ticket.price,
        ticket_count: count(ticket.id),
        ticket_id: max(fragment("CAST(? AS CHAR(100))", ticket.id))
      }
    )
    |> Repo.all
  end  

  def all_available_tickets_by_listing_ids(listing_ids) do
    from(
      t in Ticket,
      where: t.listing_id in ^listing_ids,
      where: t.status == "available",
      where: is_nil(t.locked_until),
      where: is_nil(t.order_id),
      where: is_nil(t.guest_name),
      where: is_nil(t.guest_email),
      select: t
    )
    |> Repo.all
  end


  def all_tickets_for_checkin(listing_id) do
    from(
      t in Ticket,
      where: t.listing_id == ^listing_id,
      where: t.status in ["purchased", "emailed", "checkedin"],
      order_by: fragment("substring(? from '[a-zA-Z]*$') ASC", t.guest_name),
      select: t
    )
    |> Repo.all
  end
end
