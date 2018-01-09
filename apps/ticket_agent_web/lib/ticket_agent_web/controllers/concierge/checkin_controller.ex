defmodule TicketAgentWeb.Concierge.CheckinController do
  require Logger
  alias TicketAgent.{Repo, Ticket}
  alias TicketAgent.Finders.ListingFinder
  alias TicketAgent.State.TicketState
  use TicketAgentWeb, :controller

  def show(conn, %{"ticket_id" => ticket_id}) do
    ticket = Repo.get(Ticket, ticket_id)
    render conn, "show.html", ticket: ticket
  end

  def show(conn, %{"listing_slug" => listing_slug}) do
    # lisitn
    listing = ListingFinder.find_listing_by_slug(listing_slug) |> IO.inspect
    user = Coherence.current_user(conn)
    token = Coherence.SessionService.sign_user_token(conn, user)
    render(
      conn, "show_all.html",
      session_token: token,
      listing_slug: listing_slug,
      listing: listing
    )
  end

  def create(conn, %{"ticket_id" => ticket_id}) do
    user = Coherence.current_user(conn)
    transaction = TicketState.set_ticket_checkedin(ticket_id, user.id)

    ticket = case Repo.transaction(transaction) do
      {:ok, %{checked_in_tickets: {1, [ticket]}}} ->
        Logger.info "Updated ticket #{ticket_id}"
        ticket
      _ ->
        Logger.info "Ticket #{ticket_id} was not updated"
        Repo.get!(Ticket, ticket_id)
    end

    TicketAgentWeb.ListingChannel.broadcast_change(ticket.listing_id, ticket)

    json conn, "OK"
  end
end
