defmodule TicketAgentWeb.TicketController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Event, Listing, Repo}
  plug TicketAgentWeb.ShowLoader

  def new(conn, %{"show_id" => id, "guest_checkout" => "true"}), do: render_new(conn, id)
  def new(conn, %{"show_id" => id}) do
    if !Coherence.logged_in?(conn) do
      conn
      |> redirect(to: ticket_auth_path(conn, :new, %{show_id: id}))
    else
      render_new(conn, id)
    end
  end

  defp render_new(conn, show_id) do
    [listing, ticket_count] = Listing.listing_with_ticket_count(show_id)

    message = """
      Please choose how many tickets you would like to purchase for this show.
      <br />
      <br />
      We only allow a maximum of 20 tickets per purchase.
    """
    conn
    |> assign(:message, message)
    |> assign(:page_title, "#{listing.title} at Push Comedy Theater")
    |> assign(:page_title_modal, "#{listing.title}")
    |> assign(:page_description, TicketAgentWeb.LayoutView.open_graph_description(listing.description, true))
    |> assign(:page_image, Listing.listing_image(listing))
    |> render("new.html", show: listing, ticket_count: ticket_count)
  end
end
