defmodule TicketAgent.Application do
  @moduledoc """
  The TicketAgent Application Service.

  The ticket_agent system business domain lives in this application.

  Exposes API to clients such as the `TicketAgentWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(TicketAgent.Repo, []),
    ], strategy: :one_for_one, name: TicketAgent.Supervisor)
  end
end
