defmodule TicketAgent.Finders.ListingFinder do
  require Logger
  import Ecto.Query
  alias TicketAgent.{Listing, Random, Repo, Ticket}

  def active_show_listings do
    query = from listing in Listing,
            where: listing.status == "active",
            where: is_nil(listing.class_id),
            where: fragment("? >= NOW() - interval '1 hour'", listing.start_at),
            order_by: [asc: :start_at],
            preload: [:tickets],
            select: listing

    Repo.all(query)
  end

  def find_listing_by_slug(slug) do
    slug =
      slug
      |> String.split("-")
      |> hd

    query = from listing in Listing,
            where: listing.slug == ^slug,
            select: listing

    Repo.one(query)
  end

  def find_listing_and_tickets_by_slug(slug) do
    slug =
      slug
      |> String.split("-")
      |> hd

    query = from listing in Listing,
            where: listing.slug == ^slug,
            preload: [:images, :listing_tags],
            select: listing

    case Repo.one(query) do
      nil ->
        nil
      listing ->
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
end
