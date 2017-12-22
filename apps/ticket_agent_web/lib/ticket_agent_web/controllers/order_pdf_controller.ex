defmodule TicketAgentWeb.OrderPdfController do
  require Logger
  use TicketAgentWeb, :controller
  alias TicketAgent.{Order, Repo, User}
  alias TicketAgent.Finders.OrderFinder

  @host Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")

  def show(conn, params) do
    value = load_order(conn, params)
    html conn, value
  end

  defp onetime do
  end

  defp load_order(conn, %{"order_id" => order_id}) do
    order = Repo.get_by(Order, slug: order_id)
    email = TicketAgent.UserEmail.order_email(Enum.at(Repo.all(User), 0), order.id)
    email.html_body
    # |> TicketAgent.Mailer.deliver!

  end
end
