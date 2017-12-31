defmodule TicketAgentWeb.Concierge.CheckinController do
  require Logger
  import Ecto.Query
  alias TicketAgent.{Listing, Repo, Ticket}
  alias TicketAgent.State.TicketState
  use TicketAgentWeb, :controller

  def show(conn, %{"ticket_id" => ticket_id} = params) do
    ticket = Repo.get(Ticket, ticket_id)
    render conn, "show.html", ticket: ticket
  end

  def show(conn, %{"listing_id" => listing_id} = params) do
    user = Coherence.current_user(conn)
    token = Coherence.SessionService.sign_user_token(conn, user)
    render(
      conn, "show_all.html",
      session_token: Coherence.SessionService.sign_user_token(conn, user)
    )
  end

  def create(conn, %{"ticket_id" => ticket_id} = params) do
    user = Coherence.current_user(conn)
    transaction = TicketState.set_ticket_checkedin_transaction(ticket_id, user.id)

    ticket = case Repo.transaction(transaction) do
      {:ok, %{available_tickets: {1, [ticket]}}} ->
        Logger.info "Updated ticket #{ticket_id}"
        ticket
      anything ->
        Logger.info "Ticket #{ticket_id} was not updated"
        Repo.get!(Ticket, ticket_id)
    end

    TicketAgentWeb.ListingChannel.broadcast_change(ticket.listing_id, ticket)

    json conn, "OK"
  end
end
