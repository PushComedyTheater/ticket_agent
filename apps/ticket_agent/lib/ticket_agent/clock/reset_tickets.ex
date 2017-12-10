defmodule TicketAgent.Clock.ResetTickets do
  use GenServer
  require Logger
  import Process, only: [send_after: 3]
  import Ecto.Query, only: [from: 2]
  alias TicketAgent.{Order, Repo, Ticket}

  def start_link(interval \\ 5_000) do
    GenServer.start_link(__MODULE__, interval, name: __MODULE__)
  end

  def init(interval) do
    tick(interval)
    {:ok, interval}
  end

  # Process
  def handle_info(:tick, interval) do
    expired_tickets_query()
    |> Repo.all
    |> Enum.each(&release_ticket/1)

    tick(interval)
    {:noreply, interval}
  end

  def handle_info(_, interval) do
    {:noreply, interval}
  end

  def release_ticket(ticket) do
    Logger.info "TicketAgent.Clock.ResetTickets: Releasing Ticket #{ticket.slug}"

    ticket
    |> Ecto.Changeset.cast(
      %{
        status: "available", 
        locked_until: nil,
        order_id: nil,
        guest_name: nil,
        guest_email: nil
      }, 
      [
        :status, 
        :locked_until,
        :order_id,
        :guest_name,
        :guest_email
      ]
    )
    |> Repo.update!
  end

  def expired_tickets_query() do
    threshold = NaiveDateTime.add(NaiveDateTime.utc_now(), -10)

    from(
      t in Ticket, 
      where: t.status == "locked",
      where: fragment("? <= (NOW() AT TIME ZONE 'UTC')", t.locked_until),
      select: t
    )  
  end

  defp tick(interval) do
    send_after(self(), :tick, interval)
  end
end
