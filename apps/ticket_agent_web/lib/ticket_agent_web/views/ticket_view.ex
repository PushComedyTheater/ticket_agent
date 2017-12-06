defmodule TicketAgentWeb.TicketView do
  alias TicketAgent.Listing
  use TicketAgentWeb, :view

  def event_date(date) do
    #Sat, Dec 2, 2017
    Calendar.Strftime.strftime!(date, "%a %b %d, %Y")
  end  

  def event_time(date) do
    Calendar.Strftime.strftime!(date, "%l:%M%p")
  end  
  
  def full_event_time(%{start_at: start_at, end_at: end_at}) when start_at != end_at do
    "#{event_time(start_at)} - #{event_time(end_at)}"
  end
  def full_event_time(%{start_at: start_at, end_at: end_at}) when start_at == end_at, do: event_time(start_at)
  def full_event_time(_), do: "Unknown"

  def event_cost(show) do
    Listing.ticket_cost(show)
  end
end
