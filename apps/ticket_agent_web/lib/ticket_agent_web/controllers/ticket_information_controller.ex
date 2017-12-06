defmodule TicketAgentWeb.TicketInformationController do
  use TicketAgentWeb, :controller
  alias TicketAgent.Listing
  plug TicketAgentWeb.ValidateShowRequest
  plug TicketAgentWeb.ShowLoader

  def new(conn, params) do
    [listing, available_ticket_count] = Listing.listing_with_ticket_count(conn.assigns.show_id)

    message = """
      Please choose how many tickets you would like to purchase for this show.
      <br />
      <br />
      We only allow a maximum of 20 tickets per purchase.
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
