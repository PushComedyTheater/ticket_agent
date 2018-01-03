defmodule TicketAgentWeb.Admin.ListingController do
  alias TicketAgent.{Class, Listing, Random, Repo, Ticket}
  import Ecto.Query
  use TicketAgentWeb, :controller
  plug TicketAgentWeb.Plugs.Admin.MenuLoader, %{root: "listings"}

  def index(conn, params) do
    params = cond do
      Map.has_key?(params, "status") ->
        IO.inspect "yay"
        params
      true ->
        params
        
    end
    
    listings = Listing.list_listings(params)
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

    ticket_query =
      from(
        t in Ticket,
        where: t.listing_id == ^show.id,
        where: t.status == "purchased"
      )

    sold_ticket_count = Repo.aggregate(ticket_query, :count, :id)
    sold_ticket_price = case Repo.aggregate(ticket_query, :sum, :price) do
      nil ->
        0
      other ->
        other
    end

    IO.inspect sold_ticket_price



    weeks =
      ticket_query
      |> count_by_day(:purchased_at)
      |> Repo.all

    labels = Enum.map(weeks, fn([k,v]) ->
      k
    end)

    data = Enum.map(weeks, fn([k,v]) ->
      v
    end)

    render(conn, "show.html", show: show, sold_ticket_count: sold_ticket_count, labels: labels, data: data, sold_ticket_price: sold_ticket_price)
  end

  def count_by_day(query, date_field) do
    query
    |> group_by(
      [r],
      (
        fragment(
          "CONCAT(date_part('month', ?), '/', date_part('day', ?), '/', date_part('year', ?))",
          (
            field(r, ^date_field)
          ),
          (
            field(r, ^date_field)
          ),
          (
            field(r, ^date_field)
          )
        )
      )
    )
    |> select(
      [r],
      [
        (
          fragment(
            "CONCAT(date_part('month', ?), '/', date_part('day', ?), '/', date_part('year', ?))",
            (field(r, ^date_field)),
            (field(r, ^date_field)),
            (field(r, ^date_field))
          )
        ),
        count("*")
      ]
    )
  end




  # SELECT
  # CONCAT(date_part('month', t0."purchased_at"), '/', date_part('day', t0."purchased_at"), '/', date_part('year', t0."purchased_at")) as date,
  # count('*')
  # FROM "tickets" AS t0 WHERE (t0."listing_id" = '0a6da2f9-e925-4a37-ac11-a3500b6d6b6d') AND (t0."status" = 'purchased')
  # GROUP BY
  # CONCAT(date_part('month', t0."purchased_at"), '/', date_part('day', t0."purchased_at"), '/', date_part('year', t0."purchased_at"))
  # ORDER BY CONCAT(date_part('month', t0."purchased_at"), '/', date_part('day', t0."purchased_at"), '/', date_part('year', t0."purchased_at"))
  #
  def new(conn, _params) do
    changeset = Listing.changeset(
      %Listing{
        start_at: NaiveDateTime.utc_now(),
        end_at: NaiveDateTime.utc_now(),
        slug: Random.generate_slug()})

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
    |> Repo.preload(:event)
    |> Repo.preload(:images)
    |> Repo.preload(:tickets)
  end
end
