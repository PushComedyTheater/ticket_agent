defmodule TicketAgentWeb.TicketController do
  use TicketAgentWeb, :controller

  def new(conn, %{"show_id" => id, "guest_checkout" => "true"}), do: render_new(conn, id)
  def new(conn, %{"show_id" => id}) do
    if !Coherence.logged_in?(conn) do
      redirect(
        conn,
        to: registration_path(
          conn, :new, [redirect_url: ticket_path(conn, :new, [show_id: id])]
        )
      )
    end
    render_new(conn, id)
  end

  defp render_new(conn, show_id) do
    render conn, "new.html"
  end
end
