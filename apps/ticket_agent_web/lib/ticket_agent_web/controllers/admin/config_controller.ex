defmodule TicketAgentWeb.Admin.ConfigController do
  use TicketAgentWeb, :controller
  plug(TicketAgentWeb.Plugs.MenuLoader, %{root: "config"})

  def index(conn, params) do
    conn
    |> render("index.html")
  end
end
