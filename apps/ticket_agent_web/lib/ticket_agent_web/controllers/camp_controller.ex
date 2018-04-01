defmodule TicketAgentWeb.CampController do
  alias TicketAgent.Listing
  use TicketAgentWeb, :controller

  def index(conn, _params) do
    camps = Listing.camps

    conn
    |> assign(:camps, camps)
    |> render("index.html")
  end

  def show(conn, %{"id" => camp}) when camp == "pre-teen" or camp == "teen" do
    conn
    |> assign(:camp, camp)
    |> render("#{camp}.html")
  end
end
