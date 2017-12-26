defmodule TicketAgentWeb.EventController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Event, Listing, Repo}
  alias TicketAgent.Finders.{ListingFinder, TicketFinder, WaitlistFinder}
  plug TicketAgentWeb.Plugs.ShowLoader when action in [:show]

  def index(conn, _params) do
    conn
    |> assign(:page_title, "Upcoming Shows at Push Comedy Theater")
    |> render("index.html", listings: Listing.upcoming_shows)
  end

  def show(conn, params) do
    email_address = case Coherence.current_user(conn) do
      nil -> nil
      user -> user.email
    end
    waitlist =
      email_address
      |> WaitlistFinder.find_by_email_and_listing_id(conn.assigns.listing.id)

    conn
    |> assign(:waitlisted, !is_nil(waitlist))
    |> render("show.html")
  end
end
