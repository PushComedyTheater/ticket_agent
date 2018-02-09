defmodule TicketAgent.Clock.SendOrderEmails do
  use GenServer
  require Logger
  import Process, only: [send_after: 3]
  alias Ecto.Multi
  import Ecto.Query, only: [from: 2]
  alias TicketAgent.{Order, Repo}

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
    IO.inspect orders_to_be_emailed_transaction()

    Repo.transaction(orders_to_be_emailed_transaction)
    |> IO.inspect
    # case Repo.transaction(expired_listings_transaction()) do
    #   {:ok, %{completing_listings: {count, _}}} ->
    #     if count > 0 do
    #       Logger.info "Completed #{count} listings"
    #     end
    #   _ ->
    #     #no op      
    # end

    tick(interval)
    {:noreply, interval}
  end

  def handle_info(_, interval) do
    {:noreply, interval}
  end

  def orders_to_be_emailed_transaction() do
    Multi.new()
    |> Multi.update_all(:emailing_orders,
      from(
        o in Order,
        where: o.status == "completed",
        where: fragment("? >= (NOW() AT TIME ZONE 'UTC') - '10 minutes'::INTERVAL", o.completed_at),
        where: is_nil(o.emailed_at)
      ),
      [
        set: [
          status: "processing"
        ]
      ],
      returning: true
    )
    |> Multi.run(:send_email, fn(%{emailing_orders: {_, orders}}) ->
      Logger.info "Processing orders"
      Enum.each(orders, fn(order) ->
        Logger.info "Sending primary email #{order.id}"
        TicketAgent.Emails.OrderEmail.order_receipt_email(order.id)
        |> TicketAgent.Mailer.deliver!

        Logger.info "Sending additional emails #{order.id}"
        order
        |> Order.additional_ticket_emails()
        |> Enum.each(fn({ticket_id, name, email}) ->
          Logger.info "Sending email to #{ticket_id} #{email}"
          IO.inspect name
          IO.inspect email
        end)
      end)
      Logger.info "Done processing orders"
      raise "FUCK"
      
      {:ok, orders}
    end)
  end

  defp tick(interval) do
    send_after(self(), :tick, interval)
  end
end
