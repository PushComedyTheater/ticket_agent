ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(TicketAgent.Repo, :manual)
{:ok, _} = Application.ensure_all_started(:ex_machina)
