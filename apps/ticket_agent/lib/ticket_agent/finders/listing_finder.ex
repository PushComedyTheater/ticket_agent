defmodule TicketAgent.Finders.ListingFinder do
  require Logger
  import Ecto.Query
  alias TicketAgent.{Listing, Repo}

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
      from listing in Listing,
      where: listing.status == "active",
      where: fragment("? >= NOW() - interval '1 hour'", listing.start_at),
      where: not is_nil(listing.event_id),
      where: listing.event_id == ^event_id,
      order_by: listing.start_at,
      select: listing

    listings = Repo.all(query)
    {event, listings}
  end
end
