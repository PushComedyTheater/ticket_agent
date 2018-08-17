defmodule TicketAgentWeb.Admin.OrderControllerTest do
  import TicketAgent.Factory
  use TicketAgentWeb.ConnCase, async: true

  setup %{conn: conn} do
    conn_without = conn

    user = insert(:user, role: "admin")

    conn =
      conn
      |> assign(:current_user, user)

    {:ok, %{conn: conn, conn_without: conn_without}}
  end

  test "index redirects", %{conn: conn} do
    action = admin_order_path(conn, :index)
    conn = get(conn, action)
    assert html_response(conn, 200)
  end
end
