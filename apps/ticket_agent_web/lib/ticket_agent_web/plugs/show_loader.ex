defmodule TicketAgentWeb.ShowLoader do
  import Plug.Conn
  alias TicketAgent.Listing
  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"show_id" => show_id}} = conn, _) do
    case Listing.listing_with_ticket_count(show_id) do
      nil ->
        conn
        |> put_status(404)
        |> Phoenix.Controller.render(TicketAgentWeb.ErrorView, "404.html")
      [listing, ticket_count] ->
        ticket_cost = Listing.ticket_cost_number(listing) / 100

        conn
        |> Plug.Conn.assign(:buyer_name, Map.get(conn.assigns, :buyer_name, nil))
        |> Plug.Conn.assign(:buyer_email, Map.get(conn.assigns, :buyer_email, nil))
        |> Plug.Conn.assign(:ticket_cost_string, :erlang.float_to_binary(ticket_cost, decimals: 2))
        |> Plug.Conn.assign(:page_title, "#{listing.title} at Push Comedy Theater")
        |> Plug.Conn.assign(:page_description, TicketAgentWeb.LayoutView.open_graph_description(listing.description, true))
        |> Plug.Conn.assign(:page_image, Listing.listing_image(listing))
        |> Plug.Conn.assign(:show, listing)
    end
  end
end
