defmodule TicketAgentWeb.Plugs.EventLoader do
  require Logger
  import Plug.Conn
  alias TicketAgent.Finders.{ListingFinder, ShowFinder, TicketFinder}
  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"show_id" => slug}} = conn, _), do: load_listing(slug, conn)
  def call(%Plug.Conn{params: %{"slug" => slug}} = conn, _), do: load_listing(slug, conn)

  defp load_listing(slug, conn) do
    Logger.info "ShowLoader.load_listing for slug #{slug}"

    ShowFinder.find_by_slug(slug)
    |> setup_conn_with_listings(conn)
  end

  defp setup_conn_with_listing(nil, conn) do
    Logger.error "load_order_plug->Cannot find listing"
    conn
    |> Plug.Conn.put_status(404)
    |> Phoenix.Controller.render(
          TicketAgentWeb.ErrorView,
          "404.html",
          message: "Cannot find listing")
    |> Plug.Conn.halt()    
  end

  defp setup_conn_with_listings(event_listings, conn) do
    past_date = Enum.all?(event_listings, &past_date/1)
    listing = Enum.at(event_listings, 0)
    {ticket_count, min_ticket_price, max_ticket_price} = 
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
    # Enum.filter(event_listings, fn(listing) ->

    #   {has_purchased_tickets, order} =
    #     listing.listing_id
    #     |> TicketFinder.count_by_listing_and_user(
    #       Coherence.current_user(conn)
    #     )
    #     |> IO.inspect
    # end)


    # {has_purchased_tickets, order} =
    #   listing.id
    #   |> TicketFinder.count_by_listing_and_user(
    #     Coherence.current_user(conn)
    #   )

    # available_ticket_count = available_ticket_count(available_tickets, past_date)

    # ticket_price = ticket_price(available_tickets)

    conn
    |> load_flash_message()
    |> Plug.Conn.assign(:ticket_price, 2500)
    |> Plug.Conn.assign(:past_date, past_date)
    |> Plug.Conn.assign(:page_title, "#{listing.listing_title} at Push Comedy Theater")
    |> Plug.Conn.assign(:page_description, TicketAgentWeb.SharedView.open_graph_description(listing.listing_description, true))
    |> Plug.Conn.assign(:page_image, TicketAgentWeb.SharedView.event_image(listing))
    |> Plug.Conn.assign(:listings, event_listings)
    |> Plug.Conn.assign(:listing, listing)
    |> Plug.Conn.assign(:available_ticket_count, ticket_count)
    |> Plug.Conn.assign(:min_ticket_price, min_ticket_price)
    |> Plug.Conn.assign(:max_ticket_price, max_ticket_price)
    |> Plug.Conn.assign(:has_purchased_tickets, false)
    # |> Plug.Conn.assign(:purchase_order, order)
  end

  defp load_flash_message(%{params: params} = conn) do
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

  defp available_ticket_count(available_tickets, past_date) do
    count = Enum.count(available_tickets)
    cond do
      past_date ->
        Logger.error "This listing is in the past"
        0
      count > 20 ->
        20
      true ->
        count
    end
  end

  defp ticket_price([]) do
    0
  end

  defp ticket_price(available_tickets) when length(available_tickets) > 0 do
    Enum.at(available_tickets, 0).price
  end

  defp past_date(listing) do
    utc_now =
      DateTime.utc_now()
      |> Calendar.NaiveDateTime.to_date_time_utc

    IO.inspect listing.listing_start_at
    

    start_at =
      listing.listing_start_at
      |> Calendar.NaiveDateTime.to_date_time_utc
    IO.inspect start_at
    # raise "FUCK"

    (DateTime.compare(start_at, utc_now) == :lt)
  end
end
