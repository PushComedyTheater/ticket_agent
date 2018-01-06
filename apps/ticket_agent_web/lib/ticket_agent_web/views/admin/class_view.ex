defmodule TicketAgentWeb.Admin.ClassView do
  alias TicketAgent.Listing
  use TicketAgentWeb, :view

  def current_class_listing(class), do: Listing.current_class_listing(class)
end
