defmodule TicketAgentWeb.CalendarController do
  alias TicketAgent.Listing
  use TicketAgentWeb, :controller

  def index(conn, _params) do
    camps = Listing.camps

    conn
    |> assign(:camps, camps)
    |> render("index.html")
  end

  def show(conn, params) do
    conn
    |> render("show.json")
  end
end
