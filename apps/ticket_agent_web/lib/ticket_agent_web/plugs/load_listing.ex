defmodule TicketAgentWeb.LoadListing do
  import Plug.Conn
  alias TicketAgent.{Listing, Repo}
  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"listing_id" => listing_id}} = conn, _) when not is_nil(listing_id) do
    listing = Repo.get(Listing, listing_id)
    conn
    |> Plug.Conn.assign(:listing, listing)
  end

  def call(conn, _), do: conn
end
