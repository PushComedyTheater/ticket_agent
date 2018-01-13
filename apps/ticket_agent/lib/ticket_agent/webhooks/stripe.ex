defmodule TicketAgent.Webhooks.Stripe do
  require Logger
  alias TicketAgent.{User}
  alias TicketAgent.Finders.UserFinder

  def process_webhook(%{"type" => "customer.deleted"} = webhook) do
    Logger.info "process_webhook->Customer Deleted Webhook = #{inspect webhook}"

    email = get_in(webhook, ["data", "object", "email"])
    stripe_customer_id = get_in(webhook, ["data", "object", "id"])

    case UserFinder.find_by_email_stripe_id(email, stripe_customer_id) do
      nil ->
        Logger.error "User with email #{email} and stripe_customer_id #{stripe_customer_id} not found"
      {:ok, user} ->
        Logger.info "User found #{inspect user}"
        User.update_stripe_customer_id(user, nil) |> IO.inspect
      anything ->
        IO.inspect anything
    end
  end

  def process_webhook(%{"type" => "charge.succeeded"} = webhook) do
    Logger.info "process_webhook->Charge Succeeded Webhook = #{inspect webhook}"
  end

  def process_webhook(%{"type" => "customer.source.created"} = webhook) do
    Logger.info "process_webhook->Customer Source Created Webhook = #{inspect webhook}"
  end

  def process_webhook(%{"type" => "customer.created"} = webhook) do
    Logger.info "process_webhook->Customer Created Webhook = #{inspect webhook}"
  end

  def process_webhook(webhook) do
    Logger.info "Unknown Webhook = #{inspect webhook}"
  end
end
