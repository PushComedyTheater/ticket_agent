defmodule TicketAgentWeb.EventController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Event, Listing, Repo}
  alias TicketAgent.Finders.ListingFinder
  plug TicketAgentWeb.Plugs.ShowLoader when action in [:show]

  def index(conn, _params) do
    conn
    |> assign(:page_title, "Upcoming Shows at Push Comedy Theater")
    |> render("index.html", listings: Listing.upcoming_shows)
  end

  def show(conn, %{"slug" => slug} = params) do
    {listing, available_tickets} =
      slug
      |> ListingFinder.find_listing_by_slug()

    ticket_price = Enum.at(available_tickets, 0).price

    conn = case params["msg"] do
      nil -> conn
      "show_expired" ->
        put_flash(conn, :error, dgettext("show_expired", "This show is no longer available for purchase."))
      "released_tickets" ->
        put_flash(conn, :error, dgettext("released_tickets", "Your tickets were released due to session timeout."))
      "cancelled_order" ->
        put_flash(conn, :error, dgettext("cancelled_order", "Your tickets were released when you cancelled your order."))
      anything ->
        put_flash(conn, :error, dgettext("unknown", "Your tickets were released."))
    end

    conn
    |> render("show.html")
  end
end
