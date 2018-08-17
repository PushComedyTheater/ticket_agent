defmodule TicketAgentWeb.OrderControllerTest do
  import TicketAgent.Factory
  use TicketAgentWeb.ConnCase, async: true

  setup %{conn: conn} do
    conn_without = conn

    user = insert(:user)

    conn =
      conn
      |> assign(:current_user, user)

    {:ok, %{conn: conn, conn_without: conn_without}}
  end

  test "index redirects", %{conn: conn} do
    action = order_path(conn, :index)
    conn = get(conn, action)
    assert html_response(conn, 302)
  end

  describe "#SHOW" do
    test "requires active user", %{conn_without: conn} do
      order = insert(:order)
      action = order_path(conn, :show, order)
      conn = get(conn, action)
      assert html_response(conn, 302)
    end

    test "requires active user who owns", %{conn: conn} do
      user = insert(:user)
      order = insert(:order, user: user)
      action = order_path(conn, :show, order)
      conn = get(conn, action)
      assert html_response(conn, 404)
    end

    test "shows with user who owns", %{conn: conn} do
      listing = insert(:listing)
      order = insert(:order, user: conn.assigns.current_user)
      insert(:ticket, listing: listing, order: order)
      action = order_path(conn, :show, order)
      conn = get(conn, action, %{"msg" => "test"})
      assert html_response(conn, 200) =~ "Thank you so much for your order."
    end
  end
end
