defmodule TicketAgentWeb.Plugs.TicketAuthCheck do
  import Plug.Conn
  alias TicketAgentWeb.Router.Helpers

  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"listing_id" => listing_id}} = conn, _) do
    if !Coherence.logged_in?(conn) do
      conn
      |> Phoenix.Controller.redirect(to: Helpers.ticket_auth_path(conn, :new, %{listing_id: listing_id}))
    else
      conn
    end
  end
  def call(conn, _), do: conn
end