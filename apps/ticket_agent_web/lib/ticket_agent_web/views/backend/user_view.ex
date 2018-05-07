defmodule TicketAgentWeb.Backend.UserView do
  use TicketAgentWeb, :view
  import Scrivener.HTML

  def role_name("admin"), do: "Admin"
  def role_name("concierge"), do: "Concierge"
  def role_name("oauth_customer"), do: "User"
  def role_name("customer"), do: "User"
  def role_name("guest"), do: "Guest"
  def role_name(name), do: name

  def stripe_customer_link(%{role: role}) when role in ["admin", "concierge"], do: ""
  def stripe_customer_link(%{stripe_customer_id: nil}), do: ""
  def stripe_customer_link(%{stripe_customer_id: stripe_customer_id}) do
    link(
      "View On Stripe",
      to: "https://dashboard.stripe.com/customers/#{stripe_customer_id}",
      target: "_blank"
    )
  end




end
