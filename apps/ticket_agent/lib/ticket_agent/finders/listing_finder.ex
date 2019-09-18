defmodule TicketAgent.Finders.ListingFinder do
  require Logger
  import Ecto.Query
  alias TicketAgent.{Class, Event, Listing, Repo}

  def upcoming_listings do
  end

  def active_show_listings do
    query =
      from(listing in Listing,
        where: listing.status == "active",
        where: is_nil(listing.class_id),
        where: fragment("? >= NOW() - interval '1 hour'", listing.start_at),
        order_by: [asc: :start_at],
        preload: [:tickets],
        select: listing
      )

    Repo.all(query)
  end

  def active_class_listings do
    query =
      from(class in Class,
        left_join: listings in assoc(class, :listings),
        where: is_nil(listings.end_at) or fragment("? > NOW()", listings.end_at),
        where: not is_nil(listings.class_id),
        preload: [:prerequisite, :class_tickets],
        order_by: class.type,
        group_by: class.id
      )

    Repo.all(query)
  end

  def find_listing_by_slug(slug) do
    slug =
      slug
      |> String.split("-")
      |> hd

    query =
      from(listing in Listing,
        where: listing.slug == ^slug,
        select: listing
      )

    Repo.one(query)
  end

  def find_by_id(listing_id) do
    Listing
    |> Repo.get(listing_id)
    |> Repo.preload(:event)
  end

  def find_by_slug(slug) do
    query =
      from(
        listing in Listing,
        where: listing.slug == ^slug,
        preload: [:event],
        select: listing
      )

    Repo.one(query)
  end

  def load_listing_details_for_event(nil), do: {nil, []}

  def load_listing_details_for_event(%{id: event_id} = event) do
    query =
      from(listing in Listing,
        where: listing.status == "active",
        where: fragment("? >= NOW() - interval '1 hour'", listing.start_at),
        where: not is_nil(listing.event_id),
        where: listing.event_id == ^event_id,
        order_by: listing.start_at,
        select: listing
      )

    listings = Repo.all(query)
    {event, listings}
  end
end
