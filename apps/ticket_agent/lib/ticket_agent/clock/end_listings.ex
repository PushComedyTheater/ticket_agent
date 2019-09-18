defmodule TicketAgent.Clock.EndListings do
  use GenServer
  require Logger
  import Process, only: [send_after: 3]
  alias Ecto.Multi
  import Ecto.Query, only: [from: 2]
  alias TicketAgent.{Listing, Repo}

  def start_link(interval \\ 5_000) do
    Logger.info("Starting EndListings link with interval #{interval}")
    GenServer.start_link(__MODULE__, interval, name: __MODULE__)
  end

  def init(interval) do
    tick(interval)
    {:ok, interval}
  end

  # Process
  def handle_info(:tick, interval) do
    case Repo.transaction(expired_listings_transaction()) do
      {:ok, %{completing_listings: {count, _}}} ->
        if count > 0 do
          Logger.info("Completed #{count} listings")
        end

      _ ->
        nil
        # no op      
    end

    tick(interval)
    {:noreply, interval}
  end

  def handle_info(_, interval) do
    {:noreply, interval}
  end

  def expired_listings_transaction() do
    Multi.new()
    |> Multi.update_all(
      :completing_listings,
      from(
        l in Listing,
        where: l.status == "active",
        where: fragment("? <= (NOW() AT TIME ZONE 'UTC')", l.end_at)
      ),
      [
        set: [
          status: "completed"
        ]
      ],
      returning: true
    )
  end

  defp tick(interval) do
    send_after(self(), :tick, interval)
  end
end
