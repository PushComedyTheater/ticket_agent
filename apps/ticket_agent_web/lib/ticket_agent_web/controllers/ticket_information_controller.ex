defmodule TicketAgentWeb.TicketInformationController do
  use TicketAgentWeb, :controller
  alias TicketAgent.Listing
  plug TicketAgentWeb.Plugs.ValidateShowRequest
  plug TicketAgentWeb.Plugs.ShowLoader

  def new(conn, params) do
    message = """
      Awesome!  
      So that we can keep everybody straight, we'd like to know a little more about our guests.
      <br />
      <br />
      Please fill out the name and email address for these tickets.  We'll email a copy of the ticket to everyone.
    """
    conn
    |> assign(:message, message)
    |> render(:new)
  end
end
