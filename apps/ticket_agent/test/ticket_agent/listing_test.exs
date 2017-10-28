defmodule TicketAgent.ListingTest do
  use TicketAgent.DataCase
  import TicketAgent.Factory

  describe "param" do
    test "param" do
      listing = insert(:listing, title: "This is the title", slug: "BANANA", type: "class")
      output = Phoenix.Param.to_param(listing)
      assert "BANANA-this-is-the-title" == output
    end
  end
end
