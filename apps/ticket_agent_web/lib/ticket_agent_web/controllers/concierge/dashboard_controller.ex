defmodule TicketAgentWeb.Concierge.DashboardController do
  require Logger
  import Ecto.Query
  alias TicketAgent.{Listing, Repo, Ticket}
  alias TicketAgent.State.TicketState
  use TicketAgentWeb, :controller

  def index(conn, params) do

    render conn, "index.html"
  end
end
