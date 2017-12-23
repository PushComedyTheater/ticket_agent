defmodule TicketAgentWeb.EventController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Event, Listing, Repo}
  alias TicketAgent.Finders.{ListingFinder, TicketFinder}
  plug TicketAgentWeb.Plugs.ShowLoader when action in [:show]

  def index(conn, _params) do
    conn
    |> assign(:page_title, "Upcoming Shows at Push Comedy Theater")
    |> render("index.html", listings: Listing.upcoming_shows)
  end

  def show(conn, %{"slug" => slug} = params) do
    conn
    |> render("show.html")
  end
end
