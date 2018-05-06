defmodule TicketAgentWeb.Backend.DashboardController do
  alias TicketAgent.Finders.ListingFinder
  use TicketAgentWeb, :controller
  plug TicketAgentWeb.Plugs.MenuLoader, %{root: "dashboard"}

  def index(conn, _params) do
    conn
    |> assign(:shows, ListingFinder.active_show_listings)
    |> assign(:classes, ListingFinder.active_class_listings)
    |> render("index.html")
  end
end
