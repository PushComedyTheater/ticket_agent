defmodule TicketAgentWeb.WebhookController do
  require Logger
  alias TicketAgent.Webhooks.Stripe
  use TicketAgentWeb, :controller

  def create(conn, %{"provider" => "stripe"} = params) do
    Logger.info "Processing Stripe Webhook"
    
    Stripe.process_webhook(params)

    conn
    |> put_status(200)
    |> render("create.json", %{})
  end

  def create(conn, params) do
   conn
    |> put_status(200)
    |> render("create.json", %{})
  end
end
