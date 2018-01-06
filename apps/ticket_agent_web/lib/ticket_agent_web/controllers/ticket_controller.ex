defmodule TicketAgentWeb.TicketController do
  use TicketAgentWeb, :controller
  plug TicketAgentWeb.Plugs.ShowLoader when action in [:new]

  def new(conn, %{"show_id" => id}) do
    if !Coherence.logged_in?(conn) do
      conn
      |> redirect(to: ticket_auth_path(conn, :new, %{show_id: id}))
    else
      render_new(conn)
    end
  end

  defp render_new(conn) do
    message = """
      Please choose how many tickets you would like to purchase for this show.
      <br />
      <br />
      Supplies are limited and we can only allow a maximum of #{conn.assigns.available_ticket_count} tickets per purchase.
    """
    conn
    |> assign(:message, message)
    |> render("new.html")
  end
end
