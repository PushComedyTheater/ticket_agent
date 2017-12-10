defmodule TicketAgent.Finders.TicketFinder do
  import Ecto.Query
  alias TicketAgent.{Ticket, Repo}

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
end
