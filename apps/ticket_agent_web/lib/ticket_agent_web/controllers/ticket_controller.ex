defmodule TicketAgentWeb.TicketController do
  use TicketAgentWeb, :controller
  alias TicketAgent.Finders.TicketFinder
  plug TicketAgentWeb.Plugs.TicketAuthCheck when action in [:new]
  plug TicketAgentWeb.Plugs.TicketInfoLoader when action in [:new]
  
  # plug TicketAgentWeb.Plugs.TicketDetailsLoader when action in [:new]

  def new(conn, %{"listing_id" => listing_id}) do
    message = """
      Please choose how many tickets you would like to purchase for this show.
      <br />
      <br />
      Supplies are limited and we restrict the number of tickets per purchase.
    """

    tickets = load_tickets(conn.assigns.listing.id)
    conn
    |> assign(:message, message)
    |> assign(:available_tickets, tickets)
    |> render("new.html")
  end

  def load_tickets(listing_id) do
    TicketFinder.all_available_tickets_by_listing_id(listing_id)
    |> Enum.chunk_by(fn(ticket) ->
      ticket.name
    end)
  end
end
