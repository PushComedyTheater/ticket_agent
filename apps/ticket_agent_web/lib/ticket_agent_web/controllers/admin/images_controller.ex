defmodule TicketAgentWeb.Admin.ImageController do
  use TicketAgentWeb, :controller
  plug :put_layout, {TicketAgentWeb.Admin.ImageView, :index}

  def index(conn, params) do
    previous_cursor = Map.get(params, "nc", nil)
    {cursor, resources} = load_resources(previous_cursor)
    render(
      conn,
      :index,
      resources: resources,
      next_cursor: cursor,
      previous_cursor: previous_cursor
    )
  end

  defp load_resources(cursor) do
    {:ok, %{"next_cursor" => cursor, "resources" => resources}} = Cloudinex.resources([next_cursor: cursor, tags: true])
    {cursor, resources}
  end
end
