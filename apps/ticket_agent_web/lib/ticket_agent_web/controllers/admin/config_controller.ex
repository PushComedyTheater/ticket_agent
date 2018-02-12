defmodule TicketAgentWeb.Admin.ConfigController do
  use TicketAgentWeb, :controller

  def index(conn, params) do
    ticket_agent_config = 
      Enum.map(Application.get_all_env(:ticket_agent), fn({key, value}) ->
        key
      end)


    conn
    |> render("index.html", ticket_agent_config: ticket_agent_config)
  end
end