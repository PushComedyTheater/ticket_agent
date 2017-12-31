defmodule TicketAgentWeb.Concierge.DashboardController do
  require Logger
  import Ecto.Query
  alias TicketAgent.Finders.ListingFinder
  use TicketAgentWeb, :controller

  def index(conn, params) do
    listings = ListingFinder.active_show_listings
    render conn, "index.html", listings: listings
  end
end
