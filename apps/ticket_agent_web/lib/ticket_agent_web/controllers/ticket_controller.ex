defmodule TicketAgentWeb.TicketController do
  use TicketAgentWeb, :controller

  def new(conn, %{"show_id" => id}) do
    render conn, "new.html"
  end
end
