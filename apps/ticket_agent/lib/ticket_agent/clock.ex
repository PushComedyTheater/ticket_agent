defmodule TicketAgent.Clock do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    reset_tickets_interval    = Application.get_env(:ticket_agent, :reset_tickets_interval, 60_000)
    send_order_email_interval = Application.get_env(:ticket_agent, :send_order_email_interval, 60_000)
    end_listings_interval     = Application.get_env(:ticket_agent, :reset_tickets_interval, 1_200_000)
    # waitlist_interval = Application.get_env(:ticket_agent, :reset_tickets_interval, 50_000)
    children = [
      worker(TicketAgent.Clock.ResetTickets, [reset_tickets_interval]),
      worker(TicketAgent.Clock.SendOrderEmails, [send_order_email_interval]),
      worker(TicketAgent.Clock.EndListings, [end_listings_interval]),
      # worker(TicketAgent.Clock.CheckWaitlist, [waitlist_interval])
    ]
    supervise(children, strategy: :one_for_one, name: TicketAgent.ClockSupervisor)
  end

end
