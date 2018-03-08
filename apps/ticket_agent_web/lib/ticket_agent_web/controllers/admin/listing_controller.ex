defmodule TicketAgentWeb.Admin.ListingController do
  alias TicketAgent.{Class, Event, Listing, Random, Repo, Ticket}
  import Ecto.Query
  use TicketAgentWeb, :controller
  plug TicketAgentWeb.Plugs.Admin.MenuLoader, %{root: "listings"}

  def index(conn, params) do
    params = cond do
      Map.has_key?(params, "status") ->
        params
      true ->
        params

    end

    listings = Listing.list_listings(params)
    render conn, "index.html", listings: listings
  end

  def new(conn, %{"class_id" => "new"}) do
    conn
    |> render("new_class.html")
  end

  def new(conn, %{"class_id" => class_id}) do
    current_user = Coherence.current_user(conn)
    class =
      Class
      |> Repo.get(class_id)

    conn
    |> render("new_class.html", class: class)
  end

  def new(conn, %{"event_id" => "new"}) do
    conn
    |> render("new_event.html")
  end

  def new(conn, %{"event_id" => event_id}) do
    event = Repo.get(Event, event_id)

    changeset = Listing.change_listing(%Listing{
      title: event.title,
      event_id: event_id,
      start_at: NaiveDateTime.utc_now,
      end_at: NaiveDateTime.utc_now |> Calendar.NaiveDateTime.add!(86400),
      description: event.description
    })

    conn
    |> assign(:changeset, changeset)
    |> assign(:event, event)
    |> render("new_event.html")
  end

  def new(conn, _params) do
    class_query = from c in Class,
                  order_by: c.type,
                  select: c

    classes = Repo.all(class_query)

    event_query = from e in Event,
                  order_by: e.title,
                  select: e
    events = Repo.all(event_query)

    conn
    |> assign(:classes, classes)
    |> assign(:events, events)
    |> render("new.html")

  end

  def show(conn, %{"titled_slug" => titled_slug}) do
    show = load_show(titled_slug)

    ticket_query =
      from(
        t in Ticket,
        where: t.listing_id == ^show.id,
        where: t.status in ["purchased", "emailed", "checkedin"]
      )

    sold_ticket_count = Repo.aggregate(ticket_query, :count, :id)
    sold_ticket_price = case Repo.aggregate(ticket_query, :sum, :price) do
      nil ->
        0
      other ->
        other
    end

    weeks =
      ticket_query
      |> count_by_day(:purchased_at)
      |> Repo.all

    labels = Enum.map(weeks, fn([k,_]) ->
      k
    end)

    data = Enum.map(weeks, fn([_,v]) ->
      v
    end)

    render(
      conn,
      "show.html",
      show: show,
      sold_ticket_count: sold_ticket_count,
      labels: labels,
      data: data,
      sold_ticket_price: sold_ticket_price
    )
  end

  def create(conn, %{"class_id" => class_id, "title" => title, "description" => description, "listings" => listings} = params) do
    current_user = Coherence.current_user(conn)
    TicketAgent.ListingsGenerator.create_from_class(Map.put(params, "user", current_user))

    conn
    |> render("create.json")
  end

  def create(conn, params) do
    IO.inspect params
    conn
  end

  def edit(conn, %{"titled_slug" => titled_slug}) do
    show = load_show(titled_slug)
    changeset = Listing.changeset(show, %{})
    render(conn, "edit.html", show: show, changeset: changeset)
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
    |> order_by(
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

  def load_show(titled_slug) do
    [slug|_] = titled_slug |> String.split("-")

    Repo.get_by!(Listing, slug: slug)
    |> Repo.preload(:class)
    |> Repo.preload(:event)
    |> Repo.preload(:tickets)
    |> Repo.preload(tickets: :order)
  end
end
