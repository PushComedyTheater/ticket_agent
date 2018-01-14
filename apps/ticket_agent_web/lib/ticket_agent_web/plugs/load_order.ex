defmodule TicketAgentWeb.Plugs.LoadOrder do
  require Logger
  alias TicketAgent.{Repo}
  alias TicketAgent.Finders.OrderFinder
  alias TicketAgent.State.OrderState
  alias TicketAgentWeb.ErrorView

  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"order_id" => order_id}} = conn, _) when not is_nil(order_id) do
    current_user = Coherence.current_user(conn)

    order = 
      order_id
      |> OrderFinder.find_order(current_user.id)
      |> Repo.preload([:credit_card, :tickets])
      |> OrderState.calculate_order_cost()

      case order do
        nil ->
          Logger.error "load_order_plug->Cannot find order with slug #{order_id}"
          conn
          |> Plug.Conn.put_status(403)
          |> Phoenix.Controller.render(
                TicketAgentWeb.ErrorView,
                "error.json",
                message: "Order missing.")
          |> Plug.Conn.halt()
        order ->
          conn
          |> Plug.Conn.assign(:order, order)        
      end
  end

  def call(conn, _), do: conn
end
