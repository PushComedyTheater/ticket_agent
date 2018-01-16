defmodule TicketAgentWeb.Api.ListingTicketsView do
  use TicketAgentWeb, :view

  def render("show.json", %{page: page}) do
    %{
      tickets: render_many(page.entries, __MODULE__, "ticket.json"),
      page_number: page.page_number,
      page_size: page.page_size, 
      total_entries: page.total_entries, 
      total_pages: page.total_pages
    }
  end

  def render("ticket.json", ticket) do
    ticket = ticket.listing_tickets
    %{
      slug: ticket.slug,
      guest_name: ticket.guest_name,
      status: ticket.status,
      locked_until: order_timestamp(ticket.locked_until),
      purchased_at: order_timestamp(ticket.purchased_at),
      emailed_at: order_timestamp(ticket.emailed_at),
      checked_in_at: order_timestamp(ticket.checked_in_at)
    }
  end
end
