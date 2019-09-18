defmodule TicketAgent.Clock.CheckWaitlist do
  use GenServer
  require Logger
  import Process, only: [send_after: 3]
  import Ecto.Query, only: [from: 2]
  alias TicketAgent.{Repo, Waitlist}

  def start_link(interval \\ 5_000) do
    Logger.info("Starting link with interval #{interval}")
    GenServer.start_link(__MODULE__, interval, name: __MODULE__)
  end

  def init(interval) do
    tick(interval)
    {:ok, interval}
  end

  # Process
  def handle_info(:tick, interval) do
    # recent_waitlist_query()
    # |> Repo.all
    # |> AdminEmail.send_admin_waitlist_email
    # |> update_to_sent

    tick(interval)
    {:noreply, interval}
  end

  def handle_info(_, interval) do
    {:noreply, interval}
  end

  def recent_waitlist_query() do
    from(
      w in Waitlist,
      where: w.admin_notified == false,
      where: is_nil(w.message_sent_at),
      where: fragment("? >= (NOW() AT TIME ZONE 'UTC') - '6 hours'::INTERVAL", w.inserted_at),
      select: w
    )
  end

  def update_to_sent([]), do: "Nothing to update"

  def update_to_sent(waitlists) do
    ids = Enum.map(waitlists, fn list -> list.id end)

    from(
      w in Waitlist,
      where: w.id in ^ids
    )
    |> Repo.update_all(set: [admin_notified: true, message_sent_at: NaiveDateTime.utc_now()])
  end

  defp tick(interval) do
    send_after(self(), :tick, interval)
  end
end
