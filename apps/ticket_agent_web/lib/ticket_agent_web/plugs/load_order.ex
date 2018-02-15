defmodule TicketAgentWeb.Plugs.LoadOrder do
  require Logger
  alias TicketAgent.{Repo}
  alias TicketAgent.Finders.OrderFinder
  alias TicketAgent.State.OrderState
  alias TicketAgentWeb.ErrorView
  import Plug.Conn
  import Phoenix.Controller

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
          |> put_status(422)
          |> put_view(TicketAgentWeb.ErrorView)
          |> render("error.json", %{code: "reset", reason: "Order missing."})
          |> halt()
        order ->
          conn
          |> Plug.Conn.assign(:order, order)        
      end
  end

  def call(conn, _), do: conn
end
