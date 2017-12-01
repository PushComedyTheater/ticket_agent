defmodule TicketAgentWeb.EventController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Event, Listing, Repo}

  def index(conn, _params) do
    conn
    |> assign(:page_title, "Upcoming Shows at Push Comedy Theater")
    |> render("index.html", shows: Listing.upcoming_shows)
  end

  def show(conn, %{"titled_slug" => titled_slug}) do
    [listing, ticket_count] =
      titled_slug
      |> String.split("-")
      |> hd
      |> Listing.listing_with_ticket_count()

    conn
    |> assign(:page_title, "#{listing.title} at Push Comedy Theater")
    |> assign(:page_title_modal, "#{listing.title}")
    |> assign(:page_description, TicketAgentWeb.LayoutView.open_graph_description(listing.description, true))
    |> assign(:page_image, TicketAgentWeb.EventView.cover_image(listing))
    |> render("show.html", show: listing, ticket_count: ticket_count)
  end
end
