defmodule TicketAgentWeb.Admin.DashboardController do
  alias TicketAgent.Finders.ListingFinder
  use TicketAgentWeb, :controller
  plug(TicketAgentWeb.Plugs.MenuLoader)

  def index(conn, _params) do
    conn
    |> assign(:shows, ListingFinder.active_show_listings())
    |> assign(:classes, ListingFinder.active_class_listings())
    |> render("index.html")
  end
end
