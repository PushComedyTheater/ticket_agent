defmodule TicketAgentWeb.OrderController do
  require Logger
  use TicketAgentWeb, :controller
  alias TicketAgent.{Repo}
  alias TicketAgent.State.{OrderState, TicketState}
  alias TicketAgent.Finders.OrderFinder
  plug TicketAgentWeb.Plugs.TicketInfoLoader when action in [:new]
  plug TicketAgentWeb.Plugs.ValidateShowRequest when action in [:new]
  plug TicketAgentWeb.Plugs.LoadListingWithRedirect when action in [:new]

  @host Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")

  def index(conn, _) do
    conn
    |> redirect(to: dashboard_path(conn, :index))
  end

  def show(conn, %{"id" => order_id} = params) do
    current_user = Coherence.current_user(conn)
    order = 
      order_id
      |> OrderFinder.find_order(current_user.id)
      |> Repo.preload([:credit_card, :tickets])
    
    if order do
      conn = case params["msg"] do
        nil -> conn
        _ ->
          conn
          |> put_flash(:info, "Thank you so much for your order.  You can find details about your order below.  Please check your email to receive your tickets.")
      end

      conn
      |> render("show.html", order: order, host: @host)
    else
      conn
      |> put_status(404)
      |> render(TicketAgentWeb.ErrorView, :"404", message: "Cannot find that order.")
      |> halt()
    end      
  end

  def new(conn, params) do
    message = "Please verify that your order is correct.  Then enter your credit card number or use your browser to pay below."

    conn
    |> assign(:message, message)
    |> render("new.html")
  end

  def create(conn, %{"listing" => %{"id" => listing_id}} = params) do
    order = 
      conn
      |> Coherence.current_user()
      |> OrderFinder.find_or_create_order()
    
    tickets_stored = 
      params["tickets"]
      |> Enum.map(fn({group, tickets}) ->
        Logger.info "Processing group #{group}"
        TicketState.reserve_tickets(order, tickets, group)
      end)
      |> Enum.find(fn(response) -> response != :ok end)
      |> is_nil

    if tickets_stored do
      Logger.info "All tickets were stored"
       {order, tickets, locked_until, pricing} = 
        order
        |> Repo.reload()
        |> TicketState.load_minimum_locked_until(listing_id)
        |> OrderState.calculate_price

      conn
      |> put_status(200)
      |> render(
        "create.json",
        %{
          order: order,
          tickets: tickets,
          locked_until: locked_until,
          pricing: pricing
        }
      )        
    else
      conn
      |> put_status(500)
      |> render(
        "create.json",
        %{}
      )      
    end
  end

  def delete(conn, _) do
    case OrderFinder.find_started_order(Coherence.current_user(conn)) do
      nil ->
        Logger.warn("Not able to find this order")
      order ->
        maybe_release_tickets(order)
    end

    conn
    |> render("delete.json", %{})
  end

  defp maybe_reserve_tickets(order, %{"tickets" => tickets}) do
    TicketState.reserve_tickets(order, tickets)
  end

  defp maybe_release_tickets(order) do
    order
    |> TicketState.release_tickets()
    |> Ecto.Multi.append(OrderState.release_order(order))
    |> Repo.transaction
  end
end
