defmodule TicketAgentWeb.Admin.OrderControllerTest do
  import TicketAgent.Factory
  import TicketAgent.ExpectJson
  use TicketAgentWeb.ConnCase, async: true

  setup %{conn: conn} do
    conn_without = conn

    user = insert(:user, role: "admin")

    conn =
      conn
      |> assign(:current_user, user)

    bypass = Bypass.open()
    Application.put_env(:ticket_agent, :stripe_api_url, "http://localhost:#{bypass.port}")

    {:ok, %{conn: conn, conn_without: conn_without, bypass: bypass}}
  end

  # test "index redirects", %{conn: conn} do
  #   action = admin_order_path(conn, :index)
  #   conn = get(conn, action)
  #   assert html_response(conn, 200)
  # end

  test "post it", %{conn: conn, bypass: bypass} do
    order = insert(:order)
    ticket = insert(:ticket, order: order)
    details = insert(:order_detail, order: order, charge_id: "abc123")

    response = ~s<
{
  "id": "re_1D0wD52eZvKYlo2CoP4IEjIk",
  "object": "refund",
  "amount": 6000,
  "balance_transaction": "txn_1D0wD52eZvKYlo2CDSvQTF7H",
  "charge": "ch_1D0wD32eZvKYlo2CmcOOlXP5",
  "created": 1534705511,
  "currency": "usd",
  "metadata": {
    "instrument_id": "f8dd0761-4e51-4584-8fe6-07757de3e71e",
    "account_id": "test-account"
  },
  "reason": null,
  "receipt_number": null,
  "status": "succeeded"
}    >

    expect_json(bypass, fn conn ->
      assert "/refunds" == conn.request_path
      assert "POST" == conn.method
      {:ok, body, conn} = Plug.Conn.read_body(conn, length: 1_000_000)

      assert body == "charge=abc123&refund_application_fee=true"

      Plug.Conn.resp(conn, 200, response)
    end)

    action = admin_order_path(conn, :delete, order.slug)

    conn = delete(conn, action, %{})
    assert %{"message" => "ok"} == json_response(conn, 200)
  end
end
