defmodule TicketAgentWeb.OrderController do
  require Logger
  use TicketAgentWeb, :controller
  alias TicketAgent.{Event, Listing, Order, Random, Repo}
  alias TicketAgent.State.{OrderState, TicketState}
  alias TicketAgent.Finders.OrderFinder
  plug TicketAgentWeb.Plugs.ValidateShowRequest when action in [:new]
  plug TicketAgentWeb.Plugs.ShowLoader when action in [:new]
  plug Coherence.Authentication.Session, [protected: true] when action in [:index, :show]

  def show(conn, %{"id" => order_id} = params) do
    # case Coherence.current_user(conn) do
      # nil ->
      #   conn
      #   |> redirect(to: order_path(conn, :new, %{show_id: id}))
    # end

    # order = OrderFinder.find_order(order_id, current_user.id)

    conn
    |> render("show.html")
  end

  def new(conn, %{"show_id" => show_id}) do
    message = "Please verify that your order is correct.  Then enter your credit card number or use your browser to pay below."

    conn
    |> assign(:message, message)
    |> render("new.html")
  end

  def create(conn, params) do
    {order, tickets, locked_until, pricing} =
      params
      |> OrderFinder.find_or_create_order(Coherence.current_user(conn))
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

  def delete(conn, %{"tickets" => tickets} = params) do
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

  defp maybe_reserve_tickets(order, %{"tickets" => tickets} = params) do
    TicketState.reserve_tickets(order, tickets)
  end

  defp maybe_release_tickets(order, ticket_ids) do
    order
    |> TicketState.release_tickets(ticket_ids)
    |> Ecto.Multi.append(OrderState.release_order(order))
    |> Repo.transaction
  end
end
