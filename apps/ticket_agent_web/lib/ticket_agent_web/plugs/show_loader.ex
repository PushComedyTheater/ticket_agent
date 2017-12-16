defmodule TicketAgentWeb.Plugs.ShowLoader do
  require Logger
  import Plug.Conn
  alias TicketAgent.Finders.ListingFinder
  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"show_id" => slug}} = conn, _), do: load_listing(slug, conn)
  def call(%Plug.Conn{params: %{"slug" => slug}} = conn, _), do: load_listing(slug, conn)

  defp load_listing(slug, conn) do
    Logger.info "ShowLoader.load_listing for slug #{slug}"
    case ListingFinder.find_listing_by_slug(slug) do
      nil ->
        Logger.info "ShowLoader.load_listing no listing for slug #{slug}"
        conn
        |> put_status(404)
        |> Phoenix.Controller.render(TicketAgentWeb.ErrorView, "404.html")

      {listing, available_tickets} ->
        start_at =
          listing.start_at
          |> Calendar.NaiveDateTime.to_date_time_utc

        past_date = start_at < DateTime.utc_now

        available_ticket_count = cond do
          past_date ->
            Logger.error "This listing is in the past"
            0
          Enum.count(available_tickets) > 20 ->
            20
          true ->
            Enum.count(available_tickets)
        end

        smallest_unit_price = Enum.at(available_tickets, 0).price
        ticket_price = smallest_unit_price / 100

        conn
        |> Plug.Conn.assign(:buyer_name, Map.get(conn.assigns, :buyer_name, nil))
        |> Plug.Conn.assign(:buyer_email, Map.get(conn.assigns, :buyer_email, nil))
        |> Plug.Conn.assign(:smallest_unit_price, smallest_unit_price)
        |> Plug.Conn.assign(:ticket_price, ticket_price)
        |> Plug.Conn.assign(:ticket_price_string, :erlang.float_to_binary((ticket_price / 1), decimals: 2))
        |> Plug.Conn.assign(:past_date, past_date)
        |> Plug.Conn.assign(:page_title, "#{listing.title} at Push Comedy Theater")
        |> Plug.Conn.assign(:page_description, TicketAgentWeb.SharedView.open_graph_description(listing.description, true))
        |> Plug.Conn.assign(:page_image, TicketAgentWeb.SharedView.listing_image(listing))
        |> Plug.Conn.assign(:listing, listing)
        |> Plug.Conn.assign(:available_ticket_count, available_ticket_count)
        |> Plug.Conn.assign(:available_tickets, available_tickets)
      end
  end
end
