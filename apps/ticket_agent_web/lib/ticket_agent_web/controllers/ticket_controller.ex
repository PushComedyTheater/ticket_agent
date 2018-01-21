defmodule TicketAgentWeb.TicketController do
  use TicketAgentWeb, :controller
  plug TicketAgentWeb.Plugs.TicketAuthCheck when action in [:new]
  plug TicketAgentWeb.Plugs.TicketDetailsLoader when action in [:new]

  def new(conn, %{"ticket_id" => id}) do
    message = """
      Please choose how many tickets you would like to purchase for this show.
      <br />
      <br />
      Supplies are limited and we restrict the number of tickets per purchase.
    """
    conn
    |> assign(:message, message)
    |> render("new.html")
  end
end
