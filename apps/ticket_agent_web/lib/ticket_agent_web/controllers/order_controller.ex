defmodule TicketAgentWeb.OrderController do
  require Logger
  use TicketAgentWeb, :controller

  alias TicketAgent.{Event, Listing, Order, OrderFinder, OrderState, Random, Repo, TicketState}
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
    # {order, tickets, locked_until} = 
    #   params
    #   |> find_or_create_order()
    #   |> maybe_reserve_tickets(params)

    order = find_or_create_order(params)
    tickets = []
    locked_until = NaiveDateTime.utc_now()
    
    conn
    |> put_status(200)
    |> render("create.json", %{order: order, tickets: tickets, locked_until: locked_until})
  end

  defp maybe_reserve_tickets(order, params) do
    IO.inspect "maybereserve"
    order
    |> TicketState.reserve_tickets(params["listing_id"], params["tickets"])
  end

  defp find_or_create_order(%{"order_id" => "", "name" => name, "email" => email, "total_price" => total_price} = params) do
    # create order since it's not
    Logger.info "No order id was passed from the template (params: #{inspect params}"

    case OrderFinder.find_started_order(email, total_price) do
      nil ->
        Logger.info "Creating a new order for this user"
        %Order{}
        |> Order.changeset(%{
          slug: Random.generate_slug(),
          name: name,
          email_address: email,
          total_price: total_price,
          status: "started"
        })
        |> Repo.insert!
      order ->
        Logger.info "Found an existing started order #{inspect order}"
        order
    end
  end

  defp find_or_create_order(%{"order_id" => order_id, "name" => name, "email" => email, "total_price" => total_price} = params) do
    # create order since it's not
    Logger.info "Order ID #{order_id} was passed from the template (params: #{inspect params}"
    order = Repo.get_by!(Order, slug: order_id)

    order
    |> Order.changeset(%{
      name: name,
      email_address: email,
      total_price: total_price
    })
    |> Repo.update!    
  end  
end
