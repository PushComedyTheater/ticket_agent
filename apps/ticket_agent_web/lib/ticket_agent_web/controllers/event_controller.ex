defmodule TicketAgentWeb.EventController do
  use TicketAgentWeb, :controller
  alias TicketAgent.Listing
  alias TicketAgent.Finders.{ListingFinder, WaitlistFinder}
  plug TicketAgentWeb.Plugs.ShowLoader when action in [:show]

  def index(conn, _params) do
    events = 
      ListingFinder.active_show_listings

    # events
    # |> Enum.sort(fn(x,y) ->
    #   # IO.inspect Enum.at(x.listings, 0).start_at
    #   # IO.inspect Enum.at(y.listings, 0).start_at
    #   Enum.at(x.listings, 0).start_at > Enum.at(y.listings, 0).start_at
    # end)
    # |> Enum.each(fn(event) ->
    #   IO.inspect event.title
    #   IO.inspect Enum.at(event.listings, 0).start_at
    # end)
    conn
    |> assign(:page_title, "Upcoming Shows at Push Comedy Theater")
    |> render("index.html", events: events)
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

    waitlist =
      email_address
      |> WaitlistFinder.find_by_email_and_listing_id(conn.assigns.listing.id)

    conn
    |> assign(:waitlisted, !is_nil(waitlist))
    |> render("show.html")    
  end
end
