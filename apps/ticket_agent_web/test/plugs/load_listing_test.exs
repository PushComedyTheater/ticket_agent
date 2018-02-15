defmodule TicketAgentWeb.Plugs.LoadListingTest do
  use TicketAgentWeb.ConnCase, async: true
  import TicketAgent.Factory
  alias TicketAgentWeb.Plugs.LoadListing

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(TicketAgentWeb.Router, :browser)
      |> get("/")

    {:ok, %{conn: conn}}
  end

  describe "call/2" do
    test "returns conn with listing when params and start > now", %{conn: conn} do
      event = insert(:event)
      start_at = NaiveDateTime.utc_now() |> Calendar.NaiveDateTime.add!(600)
      listing = insert(:listing, event: event, start_at: start_at)

      conn =
        conn
        |> Map.put(:params, %{"listing" => %{"id" => listing.id}})
        |> LoadListing.call([])        

      assert conn.assigns.listing
      assert conn.assigns.listing.id == listing.id
    end

    test "returns conn without listing when params", %{conn: conn} do
      event = insert(:event)
      start_at = NaiveDateTime.utc_now() |> Calendar.NaiveDateTime.subtract!(600)
      listing = insert(:listing, event: event, start_at: start_at)

      conn =
        conn
        |> Map.put(:params, %{"listing" => %{"id" => listing.id}})
        |> LoadListing.call([])        

      refute Map.has_key?(conn.assigns, :listing)
      assert json_response(conn, 422)
    end    

    test "returns conn with listing when params have listing_id and start > now", %{conn: conn} do
      event = insert(:event)
      start_at = NaiveDateTime.utc_now() |> Calendar.NaiveDateTime.add!(600)
      listing = insert(:listing, event: event, start_at: start_at)

      conn =
        conn
        |> Map.put(:params, %{"listing_id" => listing.slug})
        |> LoadListing.call([])        

      assert conn.assigns.listing
      assert conn.assigns.listing.id == listing.id
    end

    test "returns conn without listing when params have listing_id", %{conn: conn} do
      event = insert(:event)
      start_at = NaiveDateTime.utc_now() |> Calendar.NaiveDateTime.subtract!(600)
      listing = insert(:listing, event: event, start_at: start_at)

      conn =
        conn
        |> Map.put(:params, %{"listing_id" => listing.slug})
        |> LoadListing.call([])        

      refute Map.has_key?(conn.assigns, :listing)
      assert json_response(conn, 422)
    end    

    test "no listing", %{conn: conn} do
      conn =
        conn
        |> Map.put(:params, %{"listing" => %{"id" => "00000000-0000-0000-0000-000000000000"}})
        |> LoadListing.call([])        

      refute Map.has_key?(conn.assigns, :listing)
      assert json_response(conn, 422)
    end

    test "no params", %{conn: conn} do
      conn =
        conn
        |> LoadListing.call([])        

      refute Map.has_key?(conn.assigns, :listing)
      assert json_response(conn, 422)
    end    
  end
end
