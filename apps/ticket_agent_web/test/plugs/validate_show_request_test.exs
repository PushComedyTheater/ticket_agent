defmodule TicketAgentWeb.Plugs.ValidateShowRequestTest do
  use TicketAgentWeb.ConnCase, async: true
  import TicketAgent.Factory
  alias TicketAgentWeb.Plugs.ValidateShowRequest

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(TicketAgentWeb.Router, :browser)
      |> get("/")

    {:ok, %{conn: conn}}
  end

  describe "call/2" do
    test "redirects when there is nothing", %{conn: conn} do
      conn =
        conn
        |> Map.put(:cookies, %{"ticket_data" => ""})
        |> ValidateShowRequest.call([])

      assert html_response(conn, 302)
      refute conn.cookies["ticket_data"]
    end

    test "redirects when cookies aren't there", %{conn: conn} do
      listing = insert(:listing)

      conn =
        conn
        |> Map.put(:params, %{"listing_id" => listing.slug})
        |> ValidateShowRequest.call([])

      assert html_response(conn, 302)
      refute conn.cookies["ticket_data"]
    end

    test "redirect if the show and slug don't match", %{conn: conn} do
      listing = insert(:listing)
      other_listing = insert(:listing)
      cookies = %{
        "listing" =>
          %{
            "slug" => other_listing.slug
          },
          "tickets" => []
      }
      |> Poison.encode!()
      |> Base.encode64()

      conn =
        conn
        |> Map.put(:params, %{"listing_id" => listing.slug})
        |> Map.put(:cookies, %{"ticket_data" => cookies})
        |> ValidateShowRequest.call([])

      assert html_response(conn, 302)
    end  

    test "sets stuff if the show and slug match", %{conn: conn} do
      listing = insert(:listing)

      cookies = %{
        "listing" =>
          %{
            "slug" => listing.slug
          },
          "tickets" => []
      }
      |> Poison.encode!()
      |> Base.encode64()

      conn =
        conn
        |> Map.put(:params, %{"listing_id" => listing.slug})
        |> Map.put(:cookies, %{"ticket_data" => cookies})
        |> ValidateShowRequest.call([])

      assert conn.assigns.listing_id == listing.slug
      assert conn.assigns.tickets == []
    end    
  end
end
