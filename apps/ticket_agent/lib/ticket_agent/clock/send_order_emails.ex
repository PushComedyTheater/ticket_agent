defmodule TicketAgent.Clock.SendOrderEmails do
  use GenServer
  require Logger
  import Process, only: [send_after: 3]
  alias Ecto.Multi
  import Ecto.Query, only: [from: 2]
  alias TicketAgent.{Order, Repo}
  alias TicketAgent.Emails.OrderEmail
  alias TicketAgent.Mailer

  def start_link(interval \\ 5_000) do
    Logger.info "Starting SendOrderEmails link with interval #{interval}"
    GenServer.start_link(__MODULE__, interval, name: __MODULE__)
  end

  def init(interval) do
    tick(interval)
    {:ok, interval}
  end

  # Process
  def handle_info(:tick, interval) do
    tick(interval)
    process_order_emails()
    {:noreply, interval}
  end

  def handle_info(_, interval) do
    {:noreply, interval}
  end

  def process_order_emails do
    case Repo.transaction(orders_to_be_emailed_transaction()) do
      {:ok, %{emailing_orders: {_, []}, send_email: emails}} ->
        if Enum.count(emails) > 0 do
          Logger.info "Completed #{Enum.count(emails)} orders"
        end
      _ ->
        #no op      
    end
  end
  
  def orders_to_be_emailed_transaction() do
    Multi.new()
    |> Multi.update_all(:emailing_orders,
      from(
        o in Order,
        where: o.status == "completed",
        where: fragment("? >= NOW() - '10 minutes'::INTERVAL", o.completed_at),
        where: is_nil(o.emailed_at)
      ),
      [
        set: [
          status: "completed",
          emailed_at: NaiveDateTime.utc_now
        ]
      ],
      returning: true
    )
    |> Multi.run(:send_email, fn(%{emailing_orders: {_, orders}}) ->
      
      
      {:ok, orders}
    end)
  end

  defp tick(interval) do
    send_after(self(), :tick, interval)
  end

  defp process_orders([]), do: nil
  defp process_orders(orders) do
    Logger.info "Processing #{Enum.count(orders)} orders"
      
    Enum.each(orders, fn(order) ->
      Logger.info "Sending primary email #{order.id}"
      OrderEmail.order_receipt_email(order.id)
      |> Mailer.deliver!

      Logger.info "Sending admin email #{order.id}"
      OrderEmail.admin_order_receipt_email(order.id)
      |> Mailer.deliver!
    end)
    
    Logger.info "Done #{Enum.count(orders)} orders"    
  end    
end
