defmodule TicketAgent.Finders.TicketFinder do
  import Ecto.Query
  alias TicketAgent.{Order, Repo, Ticket}

  def find_by_listing_and_order(listing_id, order_id) do
    from(
      t in Ticket,
      where: t.listing_id == ^listing_id,
      where: t.order_id == ^order_id,
      where: t.status == "locked" or t.status == "purchased",
      select: t
    )
    |> Repo.all
  end

  def count_by_listing_and_user(listing_id, nil), do: {false, nil}
  def count_by_listing_and_user(listing_id, %{id: user_id} = user) do
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

  def all_available_tickets(listing_id) do
    from(
      t in Ticket,
      where: t.listing_id == ^listing_id,
      where: t.status == "available",
      where: is_nil(t.locked_until),
      where: is_nil(t.order_id),
      where: is_nil(t.guest_name),
      where: is_nil(t.guest_email),
      select: t.id
    )
    |> Repo.all
  end

  def all_tickets_for_checkin(listing_id) do
    from(
      t in Ticket,
      where: t.listing_id == ^listing_id,
      where: t.status in ["purchased", "emailed", "checkedin"],
      order_by: t.slug,
      select: t
    )
    |> Repo.all
  end
end
