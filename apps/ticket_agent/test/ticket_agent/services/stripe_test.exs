defmodule TicketAgent.Services.StripeTest do
  import TicketAgent.Factory
  import TicketAgent.ExpectJson
  use ExUnit.Case, async: false  
  use TicketAgent.DataCase
  alias TicketAgent.Services.Stripe

  setup do
    bypass = Bypass.open
    Application.put_env(:ticket_agent, :stripe_api_url, "http://localhost:#{bypass.port}")
    {:ok, bypass: bypass}
  end  

  describe "load_stripe_token" do
    test "loads a stripe token if user record has one" do
      user = insert(:user, stripe_customer_id: "abc123")
      {:ok, "abc123"} = Stripe.load_stripe_token(user, "blah")
    end

    test "loads a stripe token from stripe", %{bypass: bypass} do
      user = insert(:user, stripe_customer_id: nil)
      response = ~s<{
        "id": "cus_C762tFGaC3ctq4"
      }>

      expect_json bypass, fn conn ->
        assert "/customers" == conn.request_path
        assert "POST" == conn.method
        Plug.Conn.resp(conn, 200, response)
      end
      {:ok, "cus_C762tFGaC3ctq4"} = Stripe.load_stripe_token(user, "blah")
    end  
    
    test "loads from stripe with error", %{bypass: bypass} do
      user = insert(:user, stripe_customer_id: nil)
      response = ~s<{
        "message": "No such token: s",
        "type": "invalid_request_error",
        "param": "source"
      }>

      expect_json bypass, fn conn ->
        assert "/customers" == conn.request_path
        assert "POST" == conn.method
        Plug.Conn.resp(conn, 400, response)
      end
      {:token_error, "No such token: s"} = Stripe.load_stripe_token(user, "blah")
    end      
  end

  describe "create_customer" do
    test "creates_customer", %{bypass: bypass} do
      user = insert(:user, stripe_customer_id: nil)

      response = ~s<{
        "id": "cus_C762tFGaC3ctq4"
      }>

      expect_json bypass, fn conn ->
        assert "/customers" == conn.request_path
        assert "POST" == conn.method
        Plug.Conn.resp(conn, 200, response)
      end

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

      expect_json bypass, fn conn ->
        assert "/customers" == conn.request_path
        assert "POST" == conn.method
        Plug.Conn.resp(conn, 400, response)
      end

      {:error, "No such token: s"} = Stripe.create_customer(user, "blah", %{})

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

      expect_json bypass, fn conn ->
        assert "/customers" == conn.request_path
        assert "POST" == conn.method
        Plug.Conn.resp(conn, 400, response)
      end

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

      expect_json bypass, fn conn ->
        assert "/customers" == conn.request_path
        assert "POST" == conn.method
        Plug.Conn.resp(conn, 400, response)
      end

      {:error, _} = Stripe.create_customer(user, "blah", %{})

      user = Repo.reload(user)

      assert is_nil(user.stripe_customer_id)
    end      
  end
end
