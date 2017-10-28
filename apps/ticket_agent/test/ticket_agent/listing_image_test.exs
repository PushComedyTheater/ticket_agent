defmodule TicketAgent.ListingImageTest do
  use TicketAgent.DataCase
  alias TicketAgent.ListingImage
  import TicketAgent.Factory

  describe "gets public_id" do
    test "public id" do
      image = insert(:listing_image, url: "https://test/apple.png")
      assert "apple" == ListingImage.public_id(image)
    end
  end
end
