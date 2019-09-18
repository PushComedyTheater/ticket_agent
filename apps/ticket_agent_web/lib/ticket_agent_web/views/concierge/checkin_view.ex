defmodule TicketAgentWeb.Concierge.CheckinView do
  use TicketAgentWeb, :view

  def purchased_tickets(tickets) do
    Enum.filter(tickets, fn ticket ->
      ticket.status == "purchased" ||
        ticket.status == "emailed" ||
        ticket.status == "checkedin"
    end)
  end
end
