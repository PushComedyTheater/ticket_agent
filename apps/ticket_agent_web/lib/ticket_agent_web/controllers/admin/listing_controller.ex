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

  def new(conn, _params) do
    changeset = Listing.changeset(
      %Listing{
        start_time: NaiveDateTime.utc_now(),
        end_time: NaiveDateTime.utc_now(),
        slug: Listing.generate_slug(),
        type: "show"})

    render conn, "new.html", changeset: changeset
  end
end
