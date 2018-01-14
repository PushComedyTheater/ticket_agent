defmodule TicketAgentWeb.Plugs.LoadListingTest do
  use TicketAgentWeb.ConnCase, async: true
  import TicketAgent.Factory
  alias TicketAgentWeb.Plugs.LoadListing

  describe "call/2" do
    test "returns conn with listing when params" do
      listing = insert(:listing)

      conn =
        build_conn()
        |> Map.put(:params, %{"listing" => %{"id" => listing.id}})
        |> LoadListing.call([])        

      assert conn.assigns.listing
    end
  end
end
