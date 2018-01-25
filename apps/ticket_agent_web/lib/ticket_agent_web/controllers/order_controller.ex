defmodule TicketAgentWeb.OrderController do
  require Logger
  use TicketAgentWeb, :controller
  alias TicketAgent.{Repo}
  alias TicketAgent.State.{OrderState, TicketState}
  alias TicketAgent.Finders.OrderFinder
  plug TicketAgentWeb.Plugs.TicketInfoLoader when action in [:new]
  plug TicketAgentWeb.Plugs.ValidateShowRequest when action in [:new]
  plug TicketAgentWeb.Plugs.ListingLoader when action in [:new]
  # plug TicketAgentWeb.Plugs.ShowLoader when action in [:new]

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

  # %{
  #   "listing" => %{
  #     "id" => "b22969ad-2122-4761-ba9d-86a94a9c635c", 
  #     "slug" => "C9KMXL"
  #   }, 
  #   "locked_until" => nil, 
  #   "order_id" => nil, 
  #   "pricing" => %{}, 
  #   "tickets" => [
  #     %{"email" => "luz@veverka.net", "id" => "531d1d25-6446-457e-a1d4-b567efaf2fe8_0", "listing_id" => "b22969ad-2122-4761-ba9d-86a94a9c635c", "name" => "Luz Veverka", "price" => 500, "ticket_id" => "531d1d25-6446-457e-a1d4-b567efaf2fe8"}, %{"email" => "patrick@veverka.net", "id" => "b73038e1-7011-4e06-9a08-dbda904353cb_0", "listing_id" => "b22969ad-2122-4761-ba9d-86a94a9c635c", "name" => "Patrick Veverka", "price" => 5000, "ticket_id" => "b73038e1-7011-4e06-9a08-dbda904353cb"}]}
  def create(conn, params) do
    # {order, tickets, locked_until, pricing} =
      Coherence.current_user(conn)
      |> OrderFinder.find_or_create_order()
      |> maybe_reserve_tickets(params)
      # |> OrderState.calculate_price

    raise "FUCK"
    # conn
    # |> put_status(200)
    # |> render(
    #   "create.json",
    #   %{
    #     order: order,
    #     tickets: tickets,
    #     locked_until: locked_until,
    #     pricing: pricing
    #   }
    # )
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
