defmodule TicketAgentWeb.OrderController do
  require Logger
  use TicketAgentWeb, :controller

  alias TicketAgent.{Event, Listing, Order, Random, Repo}
  alias TicketAgent.State.OrderState
  alias TicketAgent.Finders.OrderFinder
  plug TicketAgentWeb.ValidateShowRequest when action in [:new]
  plug TicketAgentWeb.ShowLoader when action in [:new]

  def new(conn, %{"show_id" => show_id}) do
    [listing, available_ticket_count] = Listing.listing_with_ticket_count(show_id)

    ticket_cost = Listing.ticket_cost_number(listing)

    cost = (ticket_cost * conn.assigns.ticket_count)
  
    message = "Please verify that your order is correct.  Then enter your credit card number or use your browser to pay below."

    conn
    |> assign(:message, message)
    |> assign(:listing_id, listing.id)
    |> assign(:page_title, "#{listing.title} at Push Comedy Theater")
    |> assign(:page_title_modal, "#{listing.title}")
    |> assign(:total_price_string, :erlang.float_to_binary(cost / 100, decimals: 2))
    |> assign(:total_price, cost)
    |> assign(:ticket_cost, ticket_cost)
    |> assign(:page_description, TicketAgentWeb.LayoutView.open_graph_description(listing.description, true))
    |> assign(:page_image, Listing.listing_image(listing))
    |> render("new.html", show: listing)
  end

  def create(conn, params) do
    {order, tickets, locked_until} = 
      params
      |> OrderFinder.find_or_create_order()
      |> maybe_reserve_tickets(params)

    conn
    |> put_status(200)
    |> render("create.json", %{order: order, tickets: tickets, locked_until: locked_until})
  end

  def delete(conn, params) do
    case OrderFinder.find_started_order(params["email"], params["total_price"]) do
      nil ->
        Logger.warn("Not able to find this order")
      order ->
        order
        |> maybe_release_tickets(params)        
    end

    conn
    |> render("delete.json", %{})
  end

  defp maybe_reserve_tickets(order, %{"listing_id" => listing_id, "tickets" => tickets} = params) do
    order
    |> OrderState.reserve_tickets(listing_id, tickets)
  end

  defp maybe_release_tickets(order, %{"listing_id" => listing_id, "tickets" => tickets} = params) do
    order
    |> OrderState.destroy_order(listing_id, tickets)
  end  
end
