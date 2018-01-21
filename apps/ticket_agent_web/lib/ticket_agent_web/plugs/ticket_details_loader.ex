defmodule TicketAgentWeb.Plugs.TicketDetailsLoader do
  require Logger
  import Plug.Conn
  import Phoenix.Controller
  alias TicketAgent.Finders.{ListingFinder, TicketFinder}
  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"show_id" => slug}} = conn, _) do
    Logger.info "TicketDetailsLoader.load_listing for slug #{slug}"


    ListingFinder.find_listing_and_available_tickets_by_slug(slug)
    |> IO.inspect
    
    conn
    # |> Plug.Conn.assign(:page_image, TicketAgentWeb.SharedView.listing_image(listing))
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

  defp setup_conn_with_listing({listing, available_tickets}, conn) do
    conn = past_date(listing, conn)

    {has_purchased_tickets, order} =
      listing.id
      |> TicketFinder.count_by_listing_and_user(
        Coherence.current_user(conn)
      )

    available_ticket_count = available_ticket_count(available_tickets)

    ticket_prices = ticket_prices(available_tickets)

    conn
    |> load_flash_message()
    |> Plug.Conn.assign(:has_purchased_tickets, true)
    |> Plug.Conn.assign(:ticket_prices, ticket_prices)
    |> Plug.Conn.assign(:available_tickets, available_tickets)
    |> Plug.Conn.assign(:min_ticket_price, Enum.min(ticket_prices))
    |> Plug.Conn.assign(:max_ticket_price, Enum.max(ticket_prices))
    |> Plug.Conn.assign(:page_title, "#{listing.title} at Push Comedy Theater")
    |> Plug.Conn.assign(:page_description, TicketAgentWeb.SharedView.open_graph_description(listing.description, true))
    |> Plug.Conn.assign(:page_image, TicketAgentWeb.SharedView.listing_image(listing))
    |> Plug.Conn.assign(:listing, listing)
    |> Plug.Conn.assign(:purchase_order, order)
    |> Plug.Conn.assign(:available_ticket_count, available_ticket_count)
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

  defp available_ticket_count(available_tickets) do
    count = Enum.count(available_tickets)
    cond do
      count > 20 ->
        20
      true ->
        count
    end
  end

  defp ticket_prices(available_tickets) do
    Enum.uniq_by(available_tickets, fn(ticket) -> ticket.price end)
    |> Enum.map(fn(ticket) -> ticket.price end)
  end
  
  defp past_date(listing, conn) do
    start_at =
      listing.start_at
      |> Calendar.NaiveDateTime.to_date_time_utc

    utc_now =
      DateTime.utc_now()
      |> Calendar.NaiveDateTime.to_date_time_utc

    case (DateTime.compare(start_at, utc_now) == :lt) do
      true -> 
        conn
        |> put_flash(:error, "The show #{listing.slug} has ended.")
        |> redirect(to: "/events/#{Phoenix.Param.to_param(listing.event)}")
      false ->
        conn
    end
  end
end
