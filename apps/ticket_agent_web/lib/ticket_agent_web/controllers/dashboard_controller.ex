defmodule TicketAgentWeb.DashboardController do
  alias TicketAgent.Finders.OrderFinder
  use TicketAgentWeb, :controller

  def index(conn, _params) do
    orders =
      Coherence.current_user(conn)
      |> OrderFinder.find_all_customer_orders()

    render(conn, "index.html", %{orders: orders})
  end
end
