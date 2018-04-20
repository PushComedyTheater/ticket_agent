defmodule TicketAgentWeb.Admin.ConfigController do
  use TicketAgentWeb, :controller

  def index(conn, params) do
    conn
    |> render("index.html")
  end
end
