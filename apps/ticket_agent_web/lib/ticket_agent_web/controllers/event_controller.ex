defmodule TicketAgentWeb.EventController do
  use TicketAgentWeb, :controller
  alias TicketAgent.Listing
  alias TicketAgent.Finders.{ShowFinder, WaitlistFinder}
  plug TicketAgentWeb.Plugs.EventLoader when action in [:show]

  def index(conn, _params) do
    conn
    |> assign(:page_title, "Upcoming Shows at Push Comedy Theater")
    |> render("index.html", events: ShowFinder.upcoming_listings)
  end

  def show(conn, _) do
    case Regex.match?(~r/.*(ics)$/, conn.request_path) do
      true -> 
        value = Listing.to_ical(conn.assigns.listing)

        conn
        |> put_resp_content_type("text/calendar")
        |> put_resp_header("content-disposition", "attachment; filename=\"#{conn.assigns.listing.slug}.ics\"")
        |> send_resp(200, value)        
      false -> 
        render_page(conn)
      end
  end

  defp render_page(conn) do
    email_address = case Coherence.current_user(conn) do
      nil -> nil
      user -> user.email
    end

    # waitlist =
    #   email_address
    #   |> WaitlistFinder.find_by_email_and_listing_id(conn.assigns.listing.id)
waitlist = nil
    conn
    |> assign(:waitlisted, !is_nil(waitlist))
    |> render("show.html")    
  end
end
