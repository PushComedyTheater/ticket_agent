defmodule TicketAgent.Finders.ListingFinder do
  require Logger
  import Ecto.Query
  alias TicketAgent.{Listing, Random, Repo, Ticket}

  def find_listing_by_slug(slug) do
    slug = 
      slug
      |> String.split("-")
      |> hd

    query = from listing in Listing,
            where: listing.slug == ^slug,
            preload: [:images, :listing_tags],
            select: listing

    listing = Repo.one(query)

    query = from ticket in Ticket,
            where: ticket.listing_id == ^listing.id,
            where: ticket.status == "available",
            where: is_nil(ticket.locked_until),
            where: fragment("? <= NOW()", ticket.sale_start),
            select: ticket

    available_tickets = Repo.all(query)
    
    {listing, available_tickets}
  end
end