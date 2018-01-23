defmodule TicketAgentWeb.Plugs.ListingLoader do
  require Logger
  import Plug.Conn
  import Phoenix.Controller
  alias TicketAgent.Finders.ListingFinder

  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"listing_id" => listing_slug}} = conn, _) do
    listing_slug
    |> TicketAgent.Finders.ListingFinder.find_by_slug()
    |> setup_conn(conn)
  end

  def setup_conn(%{start_at: start_at} = listing, conn) do
    case past_date(start_at) do
      true ->
        conn
        |> put_flash(:error, "The show #{listing.slug} has ended.")
        |> redirect(to: "/events/#{Phoenix.Param.to_param(listing.event)}")        
      false ->
        conn
        |> Plug.Conn.assign(:listing, listing)
    end
  end

  defp past_date(start_at) do
    utc_now =
      DateTime.utc_now()
      |> Calendar.NaiveDateTime.to_date_time_utc
    
    start_at =
      start_at
      |> Calendar.NaiveDateTime.to_date_time_utc

    (DateTime.compare(start_at, utc_now) == :lt)
  end  
end
