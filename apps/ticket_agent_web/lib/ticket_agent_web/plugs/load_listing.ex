defmodule TicketAgentWeb.Plugs.LoadListing do
  import Plug.Conn
  import Phoenix.Controller
  alias TicketAgent.{Listing, Repo}
  alias TicketAgent.Finders.ListingFinder

  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"listing" => %{"id" => listing_id}}} = conn, _) when not is_nil(listing_id) do
    listing_id
    |> ListingFinder.find_by_id()
    |> setup_conn(conn)
  end

  def call(%Plug.Conn{params: %{"listing_id" => listing_slug}} = conn, _) do
    listing_slug
    |> ListingFinder.find_by_slug()
    |> setup_conn(conn)
  end  
  def call(conn, _), do: setup_conn(nil, conn)

  def setup_conn(nil, conn) do
    conn
    |> put_flash(:error, "We could not find that listing.")
    |> redirect(to: "/events")
  end

  def setup_conn(%{start_at: start_at, class_id: nil, event_id: event_id} = listing, conn) do
    IO.inspect start_at
    case past_date(start_at) do
      true ->
        IO.puts "PAST DATE"
        IO.inspect listing
        conn
        |> put_flash(:error, "The show #{listing.slug} has ended.")
        |> redirect(to: "/events/#{Phoenix.Param.to_param(listing.event)}")        
      false ->
        conn
        |> Plug.Conn.assign(:listing, listing)
    end
  end

  def setup_conn(%{end_at: end_at, class_id: class_id, event_id: nil} = listing, conn) do
    IO.inspect "CLAAS"
    case past_date(end_at) do
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

    IO.inspect utc_now
    
    start_at =
      start_at
      |> Calendar.NaiveDateTime.to_date_time_utc

    IO.inspect start_at

    (DateTime.compare(start_at, utc_now) == :lt)
  end  
end
