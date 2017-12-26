defmodule TicketAgent.Emails.AdminEmail do
  import Swoosh.Email
  alias Swoosh.Email
  alias TicketAgent.{Listing, Order, Repo}

  def host do
    Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")
  end
end
