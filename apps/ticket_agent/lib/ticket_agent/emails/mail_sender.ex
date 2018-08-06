defmodule TicketAgent.Emails.MailSender do
  require Logger
  alias TicketAgent.Emails.OrderEmail
  alias TicketAgent.Mailer
  alias TicketAgent.State.{OrderState, TicketState}

  def send_order_receipt_email(order) do
    Logger.info("Sending order receipt email #{order.id}")

    OrderEmail.order_receipt_email(order.id)
    |> Mailer.deliver!()

    transaction = TicketState.email_purchased_tickets_for_order(order)

    case Repo.transaction(transaction) do
      {:ok, _} ->
        Logger.info("Updated tickets to emailed")
        ticket

      _ ->
        Logger.info("Ticket #{ticket_id} was not updated")
        Repo.get!(Ticket, ticket_id)
    end
  end

  def send_admin_order_receipt_email(order_id) do
    Logger.info("Sending admin email #{order_id}")

    OrderEmail.admin_order_receipt_email(order.id)
    |> Mailer.deliver!()
  end
end
