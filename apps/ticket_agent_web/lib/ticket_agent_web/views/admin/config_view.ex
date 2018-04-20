defmodule TicketAgentWeb.Admin.ConfigView do
  use TicketAgentWeb, :view

  def get_application_env(stanza, key, default \\ nil) do
    case Application.get_env stanza, key, default do
      {:system, env_var} -> System.get_env env_var
      value ->
        "#{inspect value}"
    end
  end
end
