defmodule TicketAgentWeb.OrderController do
  require Logger
  use TicketAgentWeb, :controller
  alias TicketAgent.{Order, Repo}
  alias TicketAgent.State.{OrderState, TicketState}
  alias TicketAgent.Finders.OrderFinder
  plug TicketAgentWeb.Plugs.ValidateShowRequest when action in [:new]
  plug TicketAgentWeb.Plugs.ShowLoader when action in [:new]

  @host Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")

  def index(conn, _) do
    conn
    |> redirect(to: dashboard_path(conn, :index))
  end

  def show(conn, %{"id" => order_id} = params) do
    order = Repo.get_by(Order, slug: order_id)
            |> Repo.preload([:user, :credit_card, :tickets, :listing])
    # case Coherence.current_user(conn) do
      # nil ->
      #   conn
      #   |> redirect(to: order_path(conn, :new, %{show_id: id}))
    # end

    # order = OrderFinder.find_order(order_id, current_user.id)

    conn = case params["msg"] do
      nil -> conn
      _ ->
        conn
        |> put_flash(:info, "Thank you so much for your order.  You can find details about your order below.  Please check your email to receive your tickets.")
    end

    conn
    |> render("show.html", order: order, host: @host)
  end

  def new(conn, %{"show_id" => _}) do
    message = "Please verify that your order is correct.  Then enter your credit card number or use your browser to pay below."

    conn
    |> assign(:message, message)
    |> render("new.html")
  end

  def create(conn, params) do
    {order, tickets, locked_until, pricing} =
      Coherence.current_user(conn)
      |> OrderFinder.find_or_create_order()
      |> maybe_reserve_tickets(params)
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
  end

  def delete(conn, %{"tickets" => tickets}) do
    ticket_ids = Enum.map(tickets, fn(ticket) -> ticket["id"] end)

    case OrderFinder.find_started_order(Coherence.current_user(conn)) do
      nil ->
        Logger.warn("Not able to find this order")
      order ->
        order
        |> maybe_release_tickets(ticket_ids)
    end

    conn
    |> render("delete.json", %{})
  end

  defp maybe_reserve_tickets(order, %{"tickets" => tickets}) do
    TicketState.reserve_tickets(order, tickets)
  end

  defp maybe_release_tickets(order, ticket_ids) do
    order
    |> TicketState.release_tickets(ticket_ids)
    |> Ecto.Multi.append(OrderState.release_order(order))
    |> Repo.transaction
  end
end
