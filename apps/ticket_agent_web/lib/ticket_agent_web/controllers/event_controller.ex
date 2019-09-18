defmodule TicketAgentWeb.EventController do
  use TicketAgentWeb, :controller
  alias TicketAgent.Listing
  alias TicketAgent.Finders.{ShowFinder, WaitlistFinder}
  plug(TicketAgentWeb.Plugs.EventLoader when action in [:show])
  plug(TicketAgentWeb.Plugs.WaitlistLoader when action in [:show])

  def index(conn, _params) do
    conn
    |> assign(:page_title, "Upcoming Shows at Push Comedy Theater")
    |> render("index.html", events: ShowFinder.upcoming_listings())
  end

  def show(conn, %{"slug" => slug}) do
    conn
    |> render("show.html")
  end
end
