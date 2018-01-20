defmodule TicketAgent.Finders.ShowFinder do
  require Logger
  import Ecto.Query
  alias TicketAgent.{Event, Listing, Repo, ShowDetail, Ticket}

  def upcoming_listings do
    # SELECT count(id) as listing_count, event_id, min(start_at) as start_at
    # FROM listings 
    # WHERE status = 'active' 
    # AND start_at >= NOW() - interval '1 hour'
    # AND event_id IS NOT NULL
    # GROUP BY event_id
    # ORDER BY min(start_at)

    listing_query = 
      from listing in Listing,
      where: listing.status == "active",
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

    # SELECT 
    # events.slug,
    # events.title,
    # events.description,
    # events.image_url,
    # l1.listing_count,
    # l1.start_at
    # FROM events
    # INNER JOIN
    # subquery as l1 on l1.event_id = events.id
    # WHERE events.status = 'normal'    

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

    query = from listing in Listing,
            left_join: event in assoc(listing, :event), on: listing.event_id == event.id,
            left_join: event_tag in assoc(event, :event_tags), on: event_tag.event_id == event.id,
            left_join: ticket in assoc(listing, :tickets), on: ticket.listing_id == listing.id,
            where: event.slug == ^slug,
            where: ticket.status == "available",
            group_by: [listing.id, event.image_url],
            order_by: listing.start_at,
            select: %{
              listing_id:           listing.id,
              listing_title:        listing.title,
              listing_description:  listing.description,
              listing_slug:         listing.slug,
              listing_start_at:     listing.start_at,
              listing_end_at:       listing.end_at,
              ticket_count:         fragment("count(DISTINCT ?)", ticket.id),
              min_ticket_price:     min(ticket.price),
              max_ticket_price:     max(ticket.price),
              event_image_url:      event.image_url,
              listing_tags:         fragment("json_agg(DISTINCT ?)", event_tag.tag)
            }

    Repo.all(query)
  end  
end