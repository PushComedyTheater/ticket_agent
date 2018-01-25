defmodule TicketAgentWeb.Plugs.TicketInfoLoader do
  require Logger
  import Plug.Conn
  import Phoenix.Controller
  alias TicketAgent.{Listing, Repo, Ticket}
  alias TicketAgent.Finders.TicketFinder
  import Ecto.Query

  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"listing_id" => listing_id}} = conn, _) do
    listing = 
      Listing
      |> Repo.get_by!(slug: listing_id)
      |> Repo.preload(:event)

    %{min_price: min_ticket_price, max_price: max_ticket_price} = TicketFinder.price_range([listing.id])
    
    conn
    |> assign(:page_image, TicketAgentWeb.SharedView.event_image(listing.event.image_url))
    |> assign(:listing, listing)
    |> assign(:min_ticket_price, min_ticket_price)
    |> assign(:max_ticket_price, max_ticket_price)
  end
end