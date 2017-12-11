defmodule TicketAgent.Clock do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    children = [
      worker(TicketAgent.Clock.ResetTickets, [])
    ]
    supervise(children, strategy: :one_for_one, name: TicketAgent.ClockSupervisor)
  end

end
