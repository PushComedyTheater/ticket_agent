defmodule TicketAgentWeb.Api.ListingTicketsController do
  use Coherence.Config
  alias TicketAgent.Finders.{ListingFinder, TicketFinder}
  alias TicketAgent.{Repo, Ticket}
  use TicketAgentWeb, :controller

  def show(conn, %{"listing_slug" => slug} = params) do
    listing = ListingFinder.find_listing_by_slug(slug)

    page = TicketFinder.paginate_tickets_for_listing(listing.id, params)
    render(
      conn,
      "show.json",
      page: page
    )
  end
end
