defmodule TicketAgentWeb.WebhookController do
  use TicketAgentWeb, :controller

  def create(conn, params) do
   conn
    |> put_status(200)
    |> render("create.json", %{})
  end
end
