defmodule TicketAgentWeb.CampController do
  use TicketAgentWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{"id" => camp}) when camp == "pre-teen" or camp == "teen" do
    conn
    |> assign(:camp, camp)
    |> render("#{camp}.html")
  end
end
