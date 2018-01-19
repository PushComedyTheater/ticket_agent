defmodule TicketAgentWeb.Plugs.LoadListing do
  alias TicketAgent.{Listing, Repo}
  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"listing" => %{"id" => listing_id}}} = conn, _) when not is_nil(listing_id) do
    listing = 
      Listing
      |> Repo.get(listing_id)
      |> Repo.preload([:images])
    conn
    |> Plug.Conn.assign(:listing, listing)
  end

  def call(conn, _), do: conn
end
