defmodule TicketAgentWeb.EventCalendarController do
  use TicketAgentWeb, :controller
  alias TicketAgent.Listing
  alias TicketAgent.Finders.{ListingFinder}

  def show(conn, %{"slug" => slug}) do
    listing = ListingFinder.find_listing_by_slug(slug)
    
    value = Listing.to_ical(listing)

    conn
    |> put_resp_content_type("text/calendar")
    |> put_resp_header("content-disposition", "attachment; filename=\"#{Phoenix.Param.to_param(listing)}.ics\"")
    |> send_resp(200, value)        
  end
end
