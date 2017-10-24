defmodule TicketAgentWeb.ShowController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Listing, Repo}
  import Ecto.Query

  def index(conn, _params) do
    conn = assign(conn, :page_title, "Upcoming Shows at Push Comedy Theater")
    render conn, "index.html", shows: Listing.upcoming_shows
  end

  def show(conn, %{"titled_slug" => titled_slug}) do
    [slug|_] = titled_slug |> String.split("-")
    show = Repo.get_by!(Listing, slug: slug)
           |> Repo.preload([:images, :listing_tags])

    conn = assign(conn, :page_title, "#{show.title} at Push Comedy Theater")
    conn = assign(
      conn,
      :page_description,
      TicketAgentWeb.LayoutView.open_graph_description(show.description)
      )

    render(conn, "show.html", show: show)

  end
end
