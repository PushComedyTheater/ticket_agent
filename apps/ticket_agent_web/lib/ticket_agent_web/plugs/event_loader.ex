defmodule TicketAgentWeb.Plugs.EventLoader do
  require Logger
  import Plug.Conn
  alias TicketAgentWeb.SharedView
  alias TicketAgent.Finders.{ListingFinder, ShowFinder, TicketFinder}
  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"slug" => slug}} = conn, _) do
    Logger.info "EventLoader->slug #{slug}"

    ShowFinder.load_show_details_by_slug(slug)
    |> setup_conn_with_listings(conn)
  end

  def setup_conn_with_listing(nil, conn) do
    Logger.error "load_order_plug->Cannot find listing"
    conn
    |> Plug.Conn.put_status(404)
    |> Phoenix.Controller.render(
          TicketAgentWeb.ErrorView,
          "404.html",
          message: "Cannot find listing")
    |> Plug.Conn.halt()    
  end

  def setup_conn_with_listings(event_listings, conn) do
    past_date = Enum.all?(event_listings, &past_date/1)
    listing = Enum.at(event_listings, 0)

    {ticket_count, min_ticket_price, max_ticket_price} = 
      event_listings
      |> load_ticket_details()

    purchased_tickets = Enum.reduce(event_listings, [], fn(listing, acc) ->
      {has_purchased_tickets, order} =
        listing.listing_id
        |> TicketFinder.count_by_listing_and_user(Coherence.current_user(conn))
      acc = if has_purchased_tickets do
        acc ++ [order]
      else
        acc
      end
      acc
    end)

    conn
    |> load_flash_message()
    |> Plug.Conn.assign(:past_date, past_date)
    |> Plug.Conn.assign(:page_title, "#{listing.listing_title} at Push Comedy Theater")
    |> Plug.Conn.assign(:page_description, SharedView.open_graph_description(listing.listing_description, true))
    |> Plug.Conn.assign(:page_image, SharedView.event_image(listing))
    |> Plug.Conn.assign(:listings, event_listings)
    |> Plug.Conn.assign(:listing, listing)
    |> Plug.Conn.assign(:available_ticket_count, ticket_count)
    |> Plug.Conn.assign(:min_ticket_price, min_ticket_price)
    |> Plug.Conn.assign(:max_ticket_price, max_ticket_price)
    |> Plug.Conn.assign(:purchased_tickets, purchased_tickets)
  end

  def load_flash_message(%{params: params} = conn) do
    import TicketAgentWeb.Gettext
    import Phoenix.Controller, only: [put_flash: 3]
    case params["msg"] do
      nil -> conn
      "show_expired" ->
        put_flash(conn, :error, dgettext("show_expired", "This show is no longer available for purchase."))
      "released_tickets" ->
        put_flash(conn, :error, dgettext("released_tickets", "Your tickets were released due to session timeout."))
      "cancelled_order" ->
        put_flash(conn, :error, dgettext("cancelled_order", "Your tickets were released when you cancelled your order."))
      _ ->
        put_flash(conn, :error, dgettext("unknown", "Your tickets were released."))
    end
  end

  def load_ticket_details(event_listings) do
    event_listings
    |> Enum.reduce({0, 100000, 0}, fn(listing, {ticket_count, min, max}) -> 
      ticket_count = ticket_count + listing.ticket_count

      min = if listing.min_ticket_price < min do
        listing.min_ticket_price
      else
        min
      end

      max = if listing.max_ticket_price > max do
        listing.max_ticket_price
      else
        max
      end
      {ticket_count, min, max}
    end)    
  end

  defp past_date(listing) do
    utc_now =
      DateTime.utc_now()
      |> Calendar.NaiveDateTime.to_date_time_utc
    
    start_at =
      listing.listing_start_at
      |> Calendar.NaiveDateTime.to_date_time_utc

    (DateTime.compare(start_at, utc_now) == :lt)
  end
end
