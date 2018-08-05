defmodule TicketAgentWeb.Admin.OrderView do
  use TicketAgentWeb, :view
  import Scrivener.HTML
  alias TicketAgent.Listing

  def order_status(status) do
    status
  end

  def listing_name(nil), do: ""
  def listing_name(listing) do
    listing.title
  end
end
