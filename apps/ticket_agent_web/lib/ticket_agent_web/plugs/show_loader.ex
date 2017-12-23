defmodule TicketAgentWeb.Plugs.ShowLoader do
  require Logger
  import Plug.Conn
  alias TicketAgent.Finders.{ListingFinder, TicketFinder}
  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"show_id" => slug}} = conn, _), do: load_listing(slug, conn)
  def call(%Plug.Conn{params: %{"slug" => slug}} = conn, _), do: load_listing(slug, conn)

  defp load_listing(slug, conn) do
    Logger.info "ShowLoader.load_listing for slug #{slug}"

    ListingFinder.find_listing_by_slug(slug)
    |> setup_conn_with_listing(conn)
  end

  defp setup_conn_with_listing(nil, conn) do
    Logger.info "ShowLoader.load_listing no listing"
    conn
    |> put_status(404)
    |> Phoenix.Controller.render(TicketAgentWeb.ErrorView, :"404", message: "Cannot find")
    |> halt()
  end

  defp setup_conn_with_listing({listing, available_tickets}, conn) do
    past_date = past_date(listing)

    {has_purchased_tickets, order} =
      listing.id
      |> TicketFinder.count_by_listing_and_user(
        Coherence.current_user(conn)
      )

    available_ticket_count = available_ticket_count(available_tickets, past_date)

    ticket_price = ticket_price(listing, available_tickets)

    conn
    |> load_flash_message()
    |> Plug.Conn.assign(:has_purchased_tickets, has_purchased_tickets)
    |> Plug.Conn.assign(:ticket_price, ticket_price)
    |> Plug.Conn.assign(:past_date, past_date)
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
      anything ->
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

  defp ticket_price(listing, []) do
    TicketFinder.listing_price(listing.id) |> hd
  end

  defp ticket_price(_, available_tickets) when length(available_tickets) > 0 do
    Enum.at(available_tickets, 0).price
  end

  defp past_date(listing) do
    start_at =
      listing.start_at
      |> Calendar.NaiveDateTime.to_date_time_utc

    utc_now =
      DateTime.utc_now()
      |> Calendar.NaiveDateTime.to_date_time_utc

    (DateTime.compare(start_at, utc_now) == :lt)
  end
end
