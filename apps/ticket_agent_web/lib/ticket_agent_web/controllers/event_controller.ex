defmodule TicketAgentWeb.EventController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Event, Listing, Repo}

  def index(conn, _params) do
    conn = assign(conn, :page_title, "Upcoming Shows at Push Comedy Theater")
    render conn, "index.html", shows: Listing.upcoming_shows
  end

  def show(conn, %{"titled_slug" => titled_slug}) do
    [slug|_] = titled_slug |> String.split("-")

    listing = Repo.get_by!(Listing, slug: slug)
           |> Repo.preload([:images, :tickets, :listing_tags])

    conn = assign(conn, :page_title, "#{listing.title} at Push Comedy Theater")
    conn = assign(conn, :page_title_modal, "#{listing.title}")
    conn = assign(
      conn,
      :page_description,
      TicketAgentWeb.LayoutView.open_graph_description(listing.description)
    )
    render(conn, "show.html", show: listing)
  end
end
