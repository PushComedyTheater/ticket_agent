defmodule TicketAgentWeb.ChargeControllerTest do
  import TicketAgent.Factory
  import TicketAgent.ExpectJson
  alias TicketAgent.{Repo, OrderDetail}
  use TicketAgentWeb.ConnCase, async: true
  alias TicketAgent.State.OrderState

  setup %{conn: conn} do
    user = insert(:user)
    
    conn =
      conn
      |> assign(:current_user, user)

    bypass = Bypass.open
    Application.put_env(:ticket_agent, :stripe_api_url, "http://localhost:#{bypass.port}")

    {:ok, %{conn: conn, bypass: bypass}}
  end

  test "happy path", %{conn: conn, bypass: bypass}do
    locked_until = NaiveDateTime.utc_now() |> Calendar.NaiveDateTime.add!(600) |> NaiveDateTime.to_string()
    listing = insert(:listing)
    order = insert(:order, status: "started")
    ticket = insert(:ticket, order: order, status: "locked", locked_until: locked_until, price: 8000)
    order = OrderState.calculate_order_cost(order)

    user = insert(:user, stripe_customer_id: "ldskafj")
    conn =
      conn
      |> assign(:current_user, user)
    
    params = %{
      "listing" => %{
        "id" => listing.id,
        "slug" => listing.slug
      }, 
      "locked_until" => locked_until, 
      "method_name" => "basic-card", 
      "order_id" => order.slug, 
      "payer_email" => conn.assigns.current_user.email, 
      "payer_name" => conn.assigns.current_user.name, 
      "payer_phone" => "+17577453485", 
      "pricing" => %{
        "processing_fee" => order.processing_fee, 
        "subtotal" => order.subtotal, 
        "total" => order.total_price
      }, 
      "shippingOption" => nil, 
      "shipping_address" => nil, 
      "tickets" => [], 
      "token" => %{
        "card" => %{
          "card_country" => "US", 
          "card_type" => "Visa", 
          "city" => "Virginia Beach", 
          "country" => "US", 
          "cvc_check" => "unchecked", 
          "exp_month" => 12, 
          "exp_year" => 2022, 
          "funding" => "credit", 
          "id" => "card_1BivrgBwsbTzoyHbaYq6EcsS", 
          "last4" => "4242", 
          "line1" => "824 Moultrie Court", 
          "line1_check" => "unchecked", 
          "line2" => "", 
          "metadata" => %{}, 
          "name" => "Patrick Test", 
          "state" => "VA", 
          "zip" => "23455", 
          "zip_check" => "unchecked"
        }, 
        "client_ip" => "71.120.226.187", 
        "created" => 1515637945, 
        "email" => "patrick.veverka@gmail.com", 
        "livemode" => false, 
        "token_id" => "tok_1BivrhBwsbTzoyHbTyrlUduC", 
        "used" => false
      }
    }
    action = charge_path(conn, :create)

    response = ~s<{
      "id": "cus_C762tFGaC3ctq4"
    }>

    expect_json bypass, fn conn ->
      assert "/charges" == conn.request_path
      assert "POST" == conn.method
      Plug.Conn.resp(conn, 200, response)
    end

    conn = post(conn, action, params)
    assert %{"message" => "ok"} == json_response(conn, 200)
    
    order = Repo.reload(order)
    ticket = Repo.reload(ticket)

    assert order.status == "completed"
    assert ticket.status == "purchased"
  end

  test "ticket not locked", %{conn: conn}do
    locked_until = NaiveDateTime.utc_now() |> Calendar.NaiveDateTime.add!(600) |> NaiveDateTime.to_string()
    listing = insert(:listing)
    order = insert(:order, status: "started")
    ticket = insert(:ticket, order: order, status: "available", locked_until: locked_until, price: 8000)
    order = OrderState.calculate_order_cost(order)

    user = insert(:user, stripe_customer_id: "ldskafj")
    conn =
      conn
      |> assign(:current_user, user)
    
    params = %{
      "listing" => %{
        "id" => listing.id,
        "slug" => listing.slug
      }, 
      "locked_until" => locked_until, 
      "method_name" => "basic-card", 
      "order_id" => order.slug, 
      "payer_email" => conn.assigns.current_user.email, 
      "payer_name" => conn.assigns.current_user.name, 
      "payer_phone" => "+17577453485", 
      "pricing" => %{
        "processing_fee" => order.processing_fee, 
        "subtotal" => order.subtotal, 
        "total" => order.total_price
      }, 
      "shippingOption" => nil, 
      "shipping_address" => nil, 
      "tickets" => [], 
      "token" => %{
        "card" => %{
          "card_country" => "US", 
          "card_type" => "Visa", 
          "city" => "Virginia Beach", 
          "country" => "US", 
          "cvc_check" => "unchecked", 
          "exp_month" => 12, 
          "exp_year" => 2022, 
          "funding" => "credit", 
          "id" => "card_1BivrgBwsbTzoyHbaYq6EcsS", 
          "last4" => "4242", 
          "line1" => "824 Moultrie Court", 
          "line1_check" => "unchecked", 
          "line2" => "", 
          "metadata" => %{}, 
          "name" => "Patrick Test", 
          "state" => "VA", 
          "zip" => "23455", 
          "zip_check" => "unchecked"
        }, 
        "client_ip" => "71.120.226.187", 
        "created" => 1515637945, 
        "email" => "patrick.veverka@gmail.com", 
        "livemode" => false, 
        "token_id" => "tok_1BivrhBwsbTzoyHbTyrlUduC", 
        "used" => false
      }
    }
    action = charge_path(conn, :create)

    conn = post(conn, action, params)
    assert %{"code" => "reset", "reason" => "There was an error.  Please try again"} == json_response(conn, 422)
    
    order = Repo.reload(order)
    ticket = Repo.reload(ticket)

    assert order.status == "cancelled"
    assert ticket.status == "available"
  end
end