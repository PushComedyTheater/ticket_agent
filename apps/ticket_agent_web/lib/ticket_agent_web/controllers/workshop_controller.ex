defmodule TicketAgentWeb.WorkshopController do
  use TicketAgentWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
