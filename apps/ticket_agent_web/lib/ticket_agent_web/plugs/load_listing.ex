defmodule TicketAgentWeb.Plugs.LoadListing do
  import Plug.Conn
  import Phoenix.Controller
  alias TicketAgent.{Listing, Repo}
  alias TicketAgent.Finders.ListingFinder

  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"listing" => %{"id" => listing_id}}} = conn, _)
      when not is_nil(listing_id) do
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
    message = "Could not find that listing"

    conn
    |> put_status(422)
    |> put_view(TicketAgentWeb.ErrorView)
    |> render("error.json", %{code: "reset", reason: message})
    |> halt()
  end

  def setup_conn(%{start_at: start_at, class_id: nil, event_id: event_id} = listing, conn) do
    case past_date(start_at) do
      true ->
        message = "That listing has expired."

        conn
        |> put_status(422)
        |> put_view(TicketAgentWeb.ErrorView)
        |> render("error.json", %{code: "reset", reason: message})
        |> halt()

      false ->
        conn
        |> Plug.Conn.assign(:listing, listing)
    end
  end

  def setup_conn(%{end_at: end_at, class_id: class_id, event_id: nil} = listing, conn) do
    case past_date(end_at) do
      true ->
        message = "That listing has expired."

        conn
        |> put_status(422)
        |> put_view(TicketAgentWeb.ErrorView)
        |> render("error.json", %{code: "reset", reason: message})
        |> halt()

      false ->
        conn
        |> Plug.Conn.assign(:listing, listing)
    end
  end

  defp past_date(start_at) do
    utc_now =
      DateTime.utc_now()
      |> Calendar.NaiveDateTime.to_date_time_utc()

    start_at =
      start_at
      |> Calendar.NaiveDateTime.to_date_time_utc()

    DateTime.compare(start_at, utc_now) == :lt
  end
end
