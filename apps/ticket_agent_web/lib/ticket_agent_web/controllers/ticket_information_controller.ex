defmodule TicketAgentWeb.TicketInformationController do
  use TicketAgentWeb, :controller
  alias TicketAgent.Listing
  plug TicketAgentWeb.ValidateShowRequest
  plug TicketAgentWeb.Plugs.ShowLoader

  def new(conn, params) do
    [listing, available_ticket_count] = Listing.listing_with_ticket_count(conn.assigns.show_id)

    message = """
      Awesome!  
      So that we can keep everybody straight, we'd like to know a little more about our guests.
      <br />
      <br />
      Please fill out the name and email address for these tickets.  We'll email a copy of the ticket to everyone.
    """
    conn
    |> assign(:message, message)
    |> assign(:page_title, "#{listing.title} at Push Comedy Theater")
    |> assign(:page_title_modal, "#{listing.title}")
    |> assign(:page_description, TicketAgentWeb.LayoutView.open_graph_description(listing.description, true))
    |> assign(:page_image, Listing.listing_image(listing))
    |> render(:new, show: listing)
  end
end
