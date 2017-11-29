defmodule TicketAgentWeb.EventController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Event, Repo}

  def index(conn, _params) do
    conn = assign(conn, :page_title, "Upcoming Shows at Push Comedy Theater")
    render conn, "index.html", shows: Event.upcoming_events
  end

  def show(conn, %{"titled_slug" => titled_slug}) do
    [slug|_] = titled_slug |> String.split("-")

    show = Repo.get_by!(Event, slug: slug)
           |> Repo.preload([:listings])

    IO.inspect show
    # conn = assign(conn, :page_title, "#{show.title} at Push Comedy Theater")
    # conn = assign(conn, :page_title_modal, "#{show.title}")
    # conn = assign(
    #   conn,
    #   :page_description,
    #   TicketAgentWeb.LayoutView.open_graph_description(show.description)
    # )
    render(conn, "show.html", show: show)
  end
end
