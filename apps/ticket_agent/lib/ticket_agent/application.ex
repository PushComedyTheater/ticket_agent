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
    # if Mix.env != :test do
    # :ok = :error_logger.add_report_handler(Sentry.Logger)
    # end

    Supervisor.start_link([
      supervisor(TicketAgent.Repo, []),
      supervisor(TicketAgent.Clock, []),
    ], strategy: :one_for_one, name: TicketAgent.Supervisor)
  end

  defp ensure_porcelain_init() do
    Task.async(fn ->
      # Wait ten seconds after deploy and then try to reinit porcelain
      :timer.sleep(10000)
      Porcelain.Init.init()
    end)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ensure_porcelain_init()
    :ok
  end
end
