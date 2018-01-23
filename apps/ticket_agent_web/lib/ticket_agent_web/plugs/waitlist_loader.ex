defmodule TicketAgentWeb.Plugs.WaitlistLoader do
  require Logger
  import Plug.Conn
  import Phoenix.Controller
  alias TicketAgent.{Listing, Repo, Ticket}
  alias TicketAgent.Finders.TicketFinder
  import Ecto.Query

  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"slug" => slug}} = conn, _) do
    conn

    # email_address = case Coherence.current_user(conn) do
    #   nil -> nil
    #   user -> user.email
    # end

    # waitlist = false
    #   # email_address
    #   # |> WaitlistFinder.find_by_email_and_listing_id(conn.assigns.listing.listing_id)
    
    # listing = 
    #   Listing
    #   |> Repo.get_by!(slug: listing_id)
    #   |> Repo.preload(:event)

    # %{min_price: min_ticket_price, max_price: max_ticket_price} = TicketFinder.price_range([listing.id])
    
    # conn
    # |> assign(:page_image, TicketAgentWeb.SharedView.listing_image(listing))
    # |> assign(:listing, %{title: listing.title, start_at: listing.start_at, end_at: listing.end_at, slug: listing.slug})
    # |> assign(:min_ticket_price, min_ticket_price)
    # |> assign(:max_ticket_price, max_ticket_price)
  end
end