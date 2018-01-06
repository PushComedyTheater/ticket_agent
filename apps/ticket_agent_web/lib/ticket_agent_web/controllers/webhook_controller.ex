defmodule TicketAgentWeb.WebhookController do
  require Logger
  alias TicketAgent.{Repo, WebhookDetail}
  alias TicketAgent.Webhooks.Stripe
  use TicketAgentWeb, :controller

  def create(conn, %{"provider" => "stripe"} = params) do
    Logger.info "Processing Stripe Webhook"
    %WebhookDetail{}
    |> WebhookDetail.changeset(%{request: params})
    |> Repo.insert

    Stripe.process_webhook(params)

    conn
    |> put_status(200)
    |> render("create.json", %{})
  end

  def create(conn, %{"provider" => "mailgun"} = params) do
    Logger.info "Processing MailGun Webhook"
    %WebhookDetail{}
    |> WebhookDetail.changeset(%{request: params})
    |> Repo.insert

    conn
    |> put_status(200)
    |> render("create.json", %{})
  end

  def create(conn, _params) do
   conn
    |> put_status(200)
    |> render("create.json", %{})
  end
end
