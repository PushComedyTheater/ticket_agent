defmodule TicketAgentWeb.Admin.ListingController do
  alias TicketAgent.Repo
  alias TicketAgent.Class
  alias TicketAgent.Listing
  import Ecto.Query
  use TicketAgentWeb, :controller

  def index(conn, _params) do
    listings = Repo.all(Listing)
    render conn, "index.html", listings: listings
  end

  def new(conn, %{"class_id" => class_id}) do
    class = Repo.get(Class, class_id)
    changeset = conn.assigns.current_user
                |> Listing.from_class(class)
    render conn, "new.html", changeset: changeset, class: class
  end

  def show(conn, %{"titled_slug" => titled_slug}) do
    show = load_show(titled_slug)
    render(conn, "show.html", show: show)
  end

  def new(conn, _params) do
    changeset = Listing.changeset(
      %Listing{
        start_at: NaiveDateTime.utc_now(),
        end_at: NaiveDateTime.utc_now(),
        slug: Listing.generate_slug()})

    render conn, "new.html", changeset: changeset
  end

  def edit(conn, %{"titled_slug" => titled_slug}) do
    show = load_show(titled_slug)
    changeset = Listing.changeset(show, %{})
    render(conn, "edit.html", show: show, changeset: changeset)
  end

  def load_show(titled_slug) do
    [slug|_] = titled_slug |> String.split("-")

    Repo.get_by!(Listing, slug: slug)
    |> Repo.preload(:class)
    |> Repo.preload(:images)
    |> Repo.preload(:tickets)
  end
end
