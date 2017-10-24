defmodule TicketAgentWeb.Admin.ListingView do
  alias TicketAgent.{Listing, ListingImage}
  use TicketAgentWeb, :view

  def listing_type(true) do
    ["Class": "class", "Show": "show", "Workshop": "workshop"]
  end

  def listing_type(false) do
    ["Show": "show", "Workshop": "workshop"]
  end

  def cover_image(%Listing{} = listing) do
    image = Enum.find(listing.images, fn(x) -> x.type == "cover" end)
    public_id = ListingImage.public_id(image)
    Cloudinex.Url.for("covers/#{public_id}")
  end

  def social_image(%Listing{} = listing) do
    image = Enum.find(listing.images, fn(x) -> x.type == "social" end)
    public_id = ListingImage.public_id(image)
    Cloudinex.Url.for("social/#{public_id}")
  end

  def my_datetime_select(form, field, opts \\ []) do
    builder = fn b ->
    ~e"""
    Date: <%= b.(:month, []) %> / <%= b.(:day, []) %> / <%= b.(:year, []) %>
    Time: <%= b.(:hour, []) %> : <%= b.(:minute, []) %>
    """
    end

    datetime_select(form, field, [builder: builder] ++ opts)
  end
end
