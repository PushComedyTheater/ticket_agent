defmodule TicketAgentWeb.TicketController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Event, Listing, Repo}
  plug TicketAgentWeb.Plugs.ShowLoader when action in [:new]

  def new(conn, %{"show_id" => id, "guest_checkout" => "true"}), do: render_new(conn, id, true)
  def new(conn, %{"show_id" => id}) do
    if !Coherence.logged_in?(conn) do
      conn
      |> redirect(to: ticket_auth_path(conn, :new, %{show_id: id}))
    else
      render_new(conn, id, false)
    end
  end

  defp render_new(conn, show_id, guest) do
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
