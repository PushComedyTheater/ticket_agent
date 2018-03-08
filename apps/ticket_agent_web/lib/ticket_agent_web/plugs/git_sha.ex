defmodule TicketAgentWeb.Plugs.GitSHA do
  require Logger
  import Plug.Conn
  def init(opts), do: opts

  def call(conn, _) do
    sha =
      Application.get_env(:ticket_agent_web, :release)

    conn
    |> put_resp_header("sha", sha)
  end
end
