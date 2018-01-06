defmodule TicketAgentWeb.Concierge.DashboardController do
  require Logger
  alias TicketAgent.Finders.ListingFinder
  use TicketAgentWeb, :controller

  def index(conn, _) do
    listings = ListingFinder.active_show_listings
    render conn, "index.html", listings: listings
  end
end
