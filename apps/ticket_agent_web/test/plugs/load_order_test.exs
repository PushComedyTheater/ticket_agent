defmodule TicketAgentWeb.Plugs.LoadOrderTest do
  use TicketAgentWeb.ConnCase, async: true
  import TicketAgent.Factory
  alias TicketAgentWeb.Plugs.LoadOrder

  setup %{conn: conn} do
    conn_without = conn

    user = insert(:user)
    
    conn =
      conn
      |> assign(:current_user, user)

    {:ok, %{conn: conn, conn_without: conn_without}}
  end  

  describe "call/2" do
    test "returns conn with order when params", %{conn: conn} do
      order = insert(:order, user: conn.assigns.current_user)

      conn =
        conn
        |> Map.put(:params, %{"order_id" => order.slug})
        |> LoadOrder.call([])        

      assert conn.assigns.order
    end
  end
end
