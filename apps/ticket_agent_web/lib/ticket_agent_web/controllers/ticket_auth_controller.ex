defmodule TicketAgentWeb.TicketAuthController do
  use TicketAgentWeb, :controller
  plug TicketAgentWeb.Plugs.ShowLoader

  def new(conn, params) do
    message = """
      In order to complete your purchase, please login to (or create) your Push Comedy Theater account for the best experience.
      <br />
      <br />
      No account?  No problem!  You can always choose to checkout as a guest.
    """
    conn
    |> assign(:message, message)
    |> assign(:user_return_to, ticket_path(conn, :new, show_id: params["show_id"]))
    |> put_session("user_return_to", ticket_path(conn, :new, show_id: params["show_id"]))
    |> render(:new, email: "")
  end
end