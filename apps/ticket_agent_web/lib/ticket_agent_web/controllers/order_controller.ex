defmodule TicketAgentWeb.OrderController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Event, Listing, Repo}
  plug TicketAgentWeb.ValidateShowRequest
  plug TicketAgentWeb.ShowLoader

  def new(conn, %{"show_id" => show_id}) do
    [listing, available_ticket_count] = Listing.listing_with_ticket_count(show_id)

    ticket_cost = Listing.ticket_cost_number(listing)

    cost = (ticket_cost * conn.assigns.ticket_count) / 100
  
    message = "For each of the ticket(s) that you are purchasing, we will need the names and email addresses so that we may send them a copy of their ticket.<br />"
    conn
    |> assign(:message, message)
    |> assign(:page_title, "#{listing.title} at Push Comedy Theater")
    |> assign(:page_title_modal, "#{listing.title}")
    |> assign(:total_cost_string, :erlang.float_to_binary(cost, decimals: 2))
    |> assign(:total_cost, cost)
    |> assign(:ticket_cost, ticket_cost)
    |> assign(:page_description, TicketAgentWeb.LayoutView.open_graph_description(listing.description, true))
    |> assign(:page_image, Listing.listing_image(listing))
    |> render("new.html", show: listing)
  end
end
