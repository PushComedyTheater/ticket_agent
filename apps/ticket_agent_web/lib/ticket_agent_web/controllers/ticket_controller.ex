defmodule TicketAgentWeb.TicketController do
  use TicketAgentWeb, :controller

  def new(conn, %{"show_id" => id}) do
    if !Coherence.logged_in?(conn) do
      redirect(
        conn,
        to: registration_path(
          conn, :new, [redirect_url: ticket_path(conn, :new, [show_id: id])]))
      # redirect conn, to: session_path() "/session/new?redirect=/tickets/new?show_id=#{id}"
    else
      IO.inspect "LOGGED IN"
    end
    render conn, "new.html"
  end
end
