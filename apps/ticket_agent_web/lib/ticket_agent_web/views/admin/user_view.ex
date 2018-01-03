defmodule TicketAgentWeb.Admin.UserView do
  use TicketAgentWeb, :view
  import Scrivener.HTML

  def role_name("admin"), do: "Admin"
  def role_name("concierge"), do: "Concierge"
  def role_name("oauth_customer"), do: "User"
  def role_name("customer"), do: "User"
  def role_name("guest"), do: "Guest"
  def role_name(name), do: name
end
