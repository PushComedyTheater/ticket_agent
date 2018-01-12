defmodule TicketAgentWeb.LoadOrder do
  require Logger
  alias TicketAgent.{Order, Repo}
  alias TicketAgent.State.OrderState
  alias TicketAgentWeb.ErrorView
  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"order_id" => order_id}} = conn, _) when not is_nil(order_id) do
    order = 
      Order
      |> Repo.get_by(slug: order_id)
      |> Repo.preload(:tickets)
    
      case order do
      nil ->
        Logger.error "load_order_plug->Cannot find order with slug #{order_id}"
        conn
        |> Plug.Conn.put_status(400)
        |> Phoenix.Controller.put_view(ErrorView)
        |> Phoenix.Controller.render("error.json", message: "Missing order")
        |> Plug.Conn.halt() 
      order ->
        order = OrderState.calculate_order_cost(order)
        conn
        |> Plug.Conn.assign(:order, order)        
    end
  end

  def call(conn, _), do: conn
end
