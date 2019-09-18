defmodule TicketAgent.Services.StripeTest do
  import TicketAgent.Factory
  import TicketAgent.ExpectJson
  use ExUnit.Case, async: false
  use TicketAgent.DataCase
  alias TicketAgent.Services.Stripe
  alias TicketAgent.{OrderDetail, Repo}

  setup do
    bypass = Bypass.open()
    Application.put_env(:ticket_agent, :stripe_api_url, "http://localhost:#{bypass.port}")
    {:ok, bypass: bypass}
  end

  describe "load_stripe_token" do
    test "loads a stripe token if user record has one" do
      user = insert(:user, stripe_customer_id: "abc123")
      {:ok, updated_user} = Stripe.load_stripe_token(user, "blah")
      assert updated_user.stripe_customer_id == "abc123"
    end

    test "loads a stripe token from stripe", %{bypass: bypass} do
      user = insert(:user, stripe_customer_id: nil)
      response = ~s<{
        "id": "cus_C762tFGaC3ctq4"
      }>

      expect_json(bypass, fn conn ->
        assert "/customers" == conn.request_path
        assert "POST" == conn.method
        Plug.Conn.resp(conn, 200, response)
      end)

      {:ok, updated_user} = Stripe.load_stripe_token(user, "blah")
      assert updated_user.stripe_customer_id == "cus_C762tFGaC3ctq4"
    end

    test "loads from stripe with error", %{bypass: bypass} do
      user = insert(:user, stripe_customer_id: nil)
      response = ~s<{
        "message": "No such token: s",
        "type": "invalid_request_error",
        "param": "source"
      }>

      expect_json(bypass, fn conn ->
        assert "/customers" == conn.request_path
        assert "POST" == conn.method
        Plug.Conn.resp(conn, 400, response)
      end)

      {:error, :token_error} = Stripe.load_stripe_token(user, "blah")
    end
  end

  describe "create_customer" do
    test "creates_customer", %{bypass: bypass} do
      user = insert(:user, stripe_customer_id: nil)

      response = ~s<{
        "id": "cus_C762tFGaC3ctq4"
      }>

      expect_json(bypass, fn conn ->
        assert "/customers" == conn.request_path
        assert "POST" == conn.method
        Plug.Conn.resp(conn, 200, response)
      end)

      {:ok, updated_user} = Stripe.create_customer(user, "blah", %{})

      user = Repo.reload(user)

      assert user.stripe_customer_id == "cus_C762tFGaC3ctq4"
      assert updated_user.stripe_customer_id == user.stripe_customer_id
    end

    test "handles error", %{bypass: bypass} do
      user = insert(:user, stripe_customer_id: nil)

      response = ~s<{
        "message": "No such token: s",
        "type": "invalid_request_error",
        "param": "source"
      }>

      expect_json(bypass, fn conn ->
        assert "/customers" == conn.request_path
        assert "POST" == conn.method
        Plug.Conn.resp(conn, 400, response)
      end)

      {:error, :stripe_error} = Stripe.create_customer(user, "blah", %{})

      user = Repo.reload(user)

      assert is_nil(user.stripe_customer_id)
    end

    test "handles nested error", %{bypass: bypass} do
      user = insert(:user, stripe_customer_id: nil)

      response = ~s<{
        "error": {
          "message": "No such token: s",
          "type": "invalid_request_error",
          "param": "source"
        }
      }>

      expect_json(bypass, fn conn ->
        assert "/customers" == conn.request_path
        assert "POST" == conn.method
        Plug.Conn.resp(conn, 400, response)
      end)

      {:error, _} = Stripe.create_customer(user, "blah", %{})

      user = Repo.reload(user)

      assert is_nil(user.stripe_customer_id)
    end

    test "handles unknown error", %{bypass: bypass} do
      user = insert(:user, stripe_customer_id: nil)

      response = ~s<{
        "something": {
          "message": "No such token: s",
          "type": "invalid_request_error",
          "param": "source"
        }
      }>

      expect_json(bypass, fn conn ->
        assert "/customers" == conn.request_path
        assert "POST" == conn.method
        Plug.Conn.resp(conn, 400, response)
      end)

      {:error, _} = Stripe.create_customer(user, "blah", %{})

      user = Repo.reload(user)

      assert is_nil(user.stripe_customer_id)
    end
  end

  describe "create_charge" do
    test "create_charge", %{bypass: bypass} do
      order = insert(:order)
      insert(:ticket, price: 500, order: order)
      client_ip = "127.0.0.1"
      user = insert(:user, stripe_customer_id: "cus_C762tFGaC3ctq4")

      response = ~s<{
        "id": "ch_1Biw4sBwsbTzoyHbF5Q5iIvX",
        "object": "charge",
        "amount": 100,
        "amount_refunded": 0,
        "application": null,
        "application_fee": null,
        "balance_transaction": "txn_1BhjpgBwsbTzoyHbZQBdAdNt",
        "captured": false,
        "created": 1515638762,
        "currency": "usd",
        "customer": null,
        "description": "My First Test Charge (created for API docs)",
        "destination": null,
        "dispute": null,
        "failure_code": null,
        "failure_message": null,
        "fraud_details": {
        },
        "invoice": null,
        "livemode": false,
        "metadata": {
        },
        "on_behalf_of": null,
        "order": null,
        "outcome": null,
        "paid": true,
        "receipt_email": null,
        "receipt_number": null,
        "refunded": false,
        "refunds": {
          "object": "list",
          "data": [

          ],
          "has_more": false,
          "total_count": 0,
          "url": "/v1/charges/ch_1Biw4sBwsbTzoyHbF5Q5iIvX/refunds"
        },
        "review": null,
        "shipping": null,
        "source": {
          "id": "card_1BivrgBwsbTzoyHbaYq6EcsS",
          "object": "card",
          "address_city": "Virginia Beach",
          "address_country": "US",
          "address_line1": "824 Moultrie Court",
          "address_line1_check": "unchecked",
          "address_line2": "",
          "address_state": "VA",
          "address_zip": "23455",
          "address_zip_check": "unchecked",
          "brand": "Visa",
          "country": "US",
          "customer": null,
          "cvc_check": "unchecked",
          "dynamic_last4": null,
          "exp_month": 12,
          "exp_year": 2022,
          "fingerprint": "cAwjS7apPABKZsmx",
          "funding": "credit",
          "last4": "4242",
          "metadata": {
          },
          "name": "Patrick Test",
          "tokenization_method": null
        },
        "source_transfer": null,
        "statement_descriptor": null,
        "status": "succeeded",
        "transfer_group": null
      }>

      expect_json(bypass, fn conn ->
        assert "/charges" == conn.request_path
        assert "POST" == conn.method
        {:ok, body, conn} = Plug.Conn.read_body(conn, length: 1_000_000)

        assert body ==
                 "amount=603&application_fee=55&currency=usd&customer=cus_C762tFGaC3ctq4&description=description"

        Plug.Conn.resp(conn, 200, response)
      end)

      assert Enum.count(Repo.all(OrderDetail)) == 0

      Stripe.create_charge(
        order,
        user,
        "description",
        client_ip
      )

      assert Enum.count(Repo.all(OrderDetail)) == 1
    end

    test "handles error", %{bypass: bypass} do
      order = insert(:order)
      insert(:ticket, price: 500, order: order)
      client_ip = "127.0.0.1"
      user = insert(:user, stripe_customer_id: "cus_C762tFGaC3ctq4")

      response = ~s<{
        "error": {
          "message": "No such customer: cus_C762tFGaC3ctq4",
          "param": "customer", 
          "type": "invalid_request_error"
        }
      }>

      expect_json(bypass, fn conn ->
        assert "/charges" == conn.request_path
        assert "POST" == conn.method
        {:ok, body, conn} = Plug.Conn.read_body(conn, length: 1_000_000)

        assert body ==
                 "amount=603&application_fee=55&currency=usd&customer=cus_C762tFGaC3ctq4&description=description"

        Plug.Conn.resp(conn, 400, response)
      end)

      assert Enum.count(Repo.all(OrderDetail)) == 0

      Stripe.create_charge(
        order,
        user,
        "description",
        client_ip
      )

      assert Enum.count(Repo.all(OrderDetail)) == 1
    end

    # test "handles nested error", %{bypass: bypass} do
    #   user = insert(:user, stripe_customer_id: nil)

    #   response = ~s<{
    #     "error": {
    #       "message": "No such token: s",
    #       "type": "invalid_request_error",
    #       "param": "source"
    #     }
    #   }>

    #   expect_json bypass, fn conn ->
    #     assert "/customers" == conn.request_path
    #     assert "POST" == conn.method
    #     Plug.Conn.resp(conn, 400, response)
    #   end

    #   {:error, _} = Stripe.create_customer(user, "blah", %{})

    #   user = Repo.reload(user)

    #   assert is_nil(user.stripe_customer_id)
    # end  

    # test "handles unknown error", %{bypass: bypass} do
    #   user = insert(:user, stripe_customer_id: nil)

    #   response = ~s<{
    #     "something": {
    #       "message": "No such token: s",
    #       "type": "invalid_request_error",
    #       "param": "source"
    #     }
    #   }>

    #   expect_json bypass, fn conn ->
    #     assert "/customers" == conn.request_path
    #     assert "POST" == conn.method
    #     Plug.Conn.resp(conn, 400, response)
    #   end

    #   {:error, _} = Stripe.create_customer(user, "blah", %{})

    #   user = Repo.reload(user)

    #   assert is_nil(user.stripe_customer_id)
    # end      
  end
end
