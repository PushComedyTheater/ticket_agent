defmodule TicketAgent.Emails.MailSender do
  require Logger
  alias TicketAgent.Emails.OrderEmail
  alias TicketAgent.{Listing, Mailer, Repo}
  alias TicketAgent.State.{OrderState, TicketState}

  def send_order_receipt_email(order) do
    Logger.info("Sending order receipt email #{order.id}")

    OrderEmail.order_receipt_email(order.id)
    |> Mailer.deliver!()

    transaction = TicketState.email_purchased_tickets_for_order(order)

    case Repo.transaction(transaction) do
      {:ok, _} ->
        Logger.info("Updated tickets to emailed")

      _ ->
        Logger.info("Ticket was not updated")
    end
  end

  def send_admin_order_receipt_email(order) do
    Logger.info("Sending admin email #{order.id}")

    OrderEmail.admin_order_receipt_email(order.id)
    |> Mailer.deliver!()
  end

  def send_order_cancellation_email(order) do
    Logger.info("Sending order cancellation email #{order.id}")

    OrderEmail.order_cancellation_email(order.id)
    |> Mailer.deliver!()
  end

  def send_admin_order_cancellation_email(order) do
    Logger.info("Sending admin email #{order.id}")

    OrderEmail.admin_order_receipt_email(order.id)
    |> Mailer.deliver!()
  end
end
