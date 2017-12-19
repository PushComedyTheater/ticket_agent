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

        utc_now =
          DateTime.utc_now()
          |> Calendar.NaiveDateTime.to_date_time_utc

        Logger.info "start_at = #{start_at}"
        Logger.info "utc_now = #{utc_now}"
        Logger.info "start_at < utc_now = #{start_at < utc_now}"
        Logger.info "DateTime.compare(start_at, utc_now) = #{DateTime.compare(start_at, utc_now)}"
        past_date = (DateTime.compare(start_at, utc_now) == :lt)
        Logger.info past_date

        available_ticket_count = Enum.count(available_tickets)
        available_ticket_count = cond do
          past_date ->
            Logger.error "This listing is in the past"
            0
          available_ticket_count > 20 ->
            20
          true ->
            available_ticket_count
        end

        ticket_price = Enum.at(available_tickets, 0).price

        conn
        |> Plug.Conn.assign(:ticket_price, ticket_price)
        |> Plug.Conn.assign(:past_date, past_date)
        |> Plug.Conn.assign(:page_title, "#{listing.title} at Push Comedy Theater")
        |> Plug.Conn.assign(:page_description, TicketAgentWeb.SharedView.open_graph_description(listing.description, true))
        |> Plug.Conn.assign(:page_image, TicketAgentWeb.SharedView.listing_image(listing))
        |> Plug.Conn.assign(:listing, listing)
        |> Plug.Conn.assign(:available_ticket_count, available_ticket_count)
      end
  end
end
