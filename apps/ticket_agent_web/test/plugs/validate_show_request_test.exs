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
        |> ValidateShowRequest.call([])

      assert html_response(conn, 302)
    end

    test "redirect if the show and slug don't match", %{conn: conn} do
      listing = insert(:listing)
      other_listing = insert(:listing)

      storage =
        insert(
          :user_storage,
          details: %{"listing" => %{"slug" => other_listing.slug}}
        )

      uid =
        storage.id
        |> Base.encode64()

      conn =
        conn
        |> Map.put(:params, %{"listing_id" => listing.slug, "uid" => uid})
        |> ValidateShowRequest.call([])

      assert html_response(conn, 302)
    end

    test "sets stuff if the show and slug match", %{conn: conn} do
      listing = insert(:listing)

      storage =
        insert(
          :user_storage,
          details: %{
            "listing" => %{
              "slug" => listing.slug
            },
            "tickets" => %{
              "default_0" => %{
                "email" => "patrick@pushcomedytheater.com",
                "group" => "default",
                "listing_id" => listing.id,
                "name" => "Patrick Veverka",
                "price" => 500,
                "valid" => true
              }
            }
          }
        )

      uid =
        storage.id
        |> Base.encode64()

      conn =
        conn
        |> Map.put(:params, %{"listing_id" => listing.slug, "uid" => uid})
        |> ValidateShowRequest.call([])

      assert conn.assigns.listing_id == listing.slug

      assert conn.assigns.tickets == %{
               "default" => [
                 %{
                   "email" => "patrick@pushcomedytheater.com",
                   "group" => "default",
                   "listing_id" => listing.id,
                   "name" => "Patrick Veverka",
                   "price" => 500,
                   "valid" => true
                 }
               ]
             }
    end
  end
end
