defmodule TicketAgentWeb.Admin.EmailTemplateController do
  use TicketAgentWeb, :controller
  require Logger
  import Ecto.Query
  alias TicketAgent.Generators.OrderPdfGenerator
  alias TicketAgent.{Listing, Order, Repo, Ticket}
  alias TicketAgent.Emails.{OneTimeLogin, OrderEmail, UserWelcomeEmail}

  @host         Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")
  @template_dir Application.app_dir(:ticket_agent, "priv/email_templates")

  def show(conn, %{"type" => "user_welcome_email"}) do
    current_user = Coherence.current_user(conn)
    email = UserWelcomeEmail.welcome_email(current_user.name, current_user.email)

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, email.html_body)

  end

  def show(conn, %{"type" => "one_time_login"}) do
    current_user = Coherence.current_user(conn)

    listing = Repo.one(from x in Listing, order_by: [desc: x.id], limit: 1)

    email = OneTimeLogin.one_time_login(current_user, listing.id)

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, email.html_body)
  end

  def show(conn, %{"type" => "order_pdf", "id" => order_slug}) do
    value =
      Order
      |> Repo.get_by([slug: order_slug])
      |> Repo.preload([:user, :credit_card, :tickets, listing: [:event]])
      |> OrderPdfGenerator.generate_order_pdf_binary()

    conn
    |> put_resp_content_type("application/pdf")
    |> send_resp(200, value)
  end

  def show(conn, %{"type" => "order_email", "id" => order_slug}) do
    order =
      Order
      |> Repo.get_by([slug: order_slug])

    email = OrderEmail.order_receipt_email(order.id)

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, email.html_body)
  end
end
