defmodule TicketAgentWeb.TicketView do
  use TicketAgentWeb, :view

  def render("create.json", %{}) do
    %{
      status: "ok"
    }
  end

  def render("show.json", %{ticket: ticket}) do
    %{
      id: ticket.id,
      ticket_name: ticket.name,
      name: ticket.guest_name,
      email: ticket.guest_email,
      status: ticket.status,
      locked_until: ticket.locked_until,
      price: ticket.price,
      group: ticket.group
    }
  end

  def event_date(date) do
    # Sat, Dec 2, 2017
    Calendar.Strftime.strftime!(date, "%a %b %d, %Y")
  end

  def full_event_time(%{start_at: start_at, end_at: end_at}) when start_at != end_at do
    "#{event_time(start_at)} - #{event_time(end_at)}"
  end

  def full_event_time(%{start_at: start_at, end_at: end_at}) when start_at == end_at,
    do: event_time(start_at)

  def full_event_time(_), do: "Unknown"
end
