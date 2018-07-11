defmodule TicketAgent.Finders.ShowFinder do
  require Logger
  import Ecto.Query
  alias TicketAgent.{Event, Listing, Repo, ShowDetail, Ticket}

  def upcoming_listings do
    listing_query =
      from listing in Listing,
      where: listing.status == "active",
      where: listing.type in ["class", "show"],
      where: fragment("? >= NOW() - interval '1 hour'", listing.start_at),
      where: not is_nil(listing.event_id),
      group_by: listing.event_id,
      order_by: [min(listing.start_at)],
      select: %{
        listing_count: count(listing.id),
        event_id: listing.event_id,
        start_at: min(listing.start_at),
        listing_ids: fragment("json_agg(?)", listing.id)
      }

    query =
      from event in Event,
      join: listing in subquery(listing_query), on: listing.event_id == event.id,
      where: event.status == "normal",
      order_by: listing.start_at,
      select: %{
        event_slug: event.slug,
        event_title: event.title,
        event_description: event.description,
        event_image_url: event.image_url,
        event_id: event.id,
        listing_count: listing.listing_count,
        start_at: listing.start_at,
        listing_ids: listing.listing_ids
      }

    Repo.all(query)
    |> Enum.map(fn(detail) -> struct(ShowDetail, detail) end)
  end

  def load_show_details_by_slug(slug) do
    slug =
      slug
      |> String.split("-")
      |> hd


    query = from event in Event,
            left_join: listing in assoc(event, :listings),
            preload: [:event_tags],
            preload: [listings: listing],
            where: event.slug == ^slug,
            order_by: listing.start_at,
            select: event


    Repo.one(query)
  end
end
