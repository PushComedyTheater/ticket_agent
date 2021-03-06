defmodule TicketAgentWeb.Admin.ListingController do
  alias TicketAgent.{Class, Event, Listing, Order, Random, Repo, Ticket}
  import Ecto.Query
  use TicketAgentWeb, :controller
  plug(TicketAgentWeb.Plugs.MenuLoader, %{root: "listings"})
  plug(TicketAgentWeb.Plugs.DatatablesParamParser, %{schema: Listing})

  def index(conn, %{"_format" => "json"} = params) do
    records = retrieve_records(conn)

    render(
      conn,
      "index.json",
      records: records,
      page_number: conn.assigns.page_number,
      draw_number: conn.assigns.draw_number
    )
  end

  def index(conn, params) do
    render(conn, "index.html")
  end

  defp retrieve_records(
         %Plug.Conn{
           assigns: %{
             page_size: page_size,
             page_number: page_number,
             search_term: search_term,
             sort_column: sort_column,
             sort_dir: sort_dir
           }
         } = conn
       ) do
    query =
      from(
        l in Listing,
        preload: [:tickets],
        select: l
      )

    query = add_filter(query, search_term)
    Repo.paginate(query, page: page_number, page_size: page_size)
  end

  defp add_filter(query, search_term) when search_term == nil or search_term == "", do: query

  defp add_filter(query, original_search_term) do
    search_term = "%#{original_search_term}%"
    from(z in query, where: ilike(z.title, ^search_term))
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
    changeset =
      Listing.change_listing(%Listing{
        start_at: NaiveDateTime.utc_now(),
        end_at: NaiveDateTime.utc_now() |> Calendar.NaiveDateTime.add!(86400)
      })

    conn
    |> assign(:changeset, changeset)
    |> assign(:event_image_url, "")
    |> assign(:event_id, nil)
    |> render("new_event.html")
  end

  def new(conn, %{"event_id" => event_id}) do
    event = Repo.get(Event, event_id)

    changeset =
      Listing.change_listing(%Listing{
        title: event.title,
        event_id: event_id,
        start_at: NaiveDateTime.utc_now(),
        end_at: NaiveDateTime.utc_now() |> Calendar.NaiveDateTime.add!(86400),
        description: event.description
      })

    conn
    |> assign(:changeset, changeset)
    |> assign(:event, event)
    |> assign(:event_id, event_id)
    |> assign(:event_image_url, event.image_url)
    |> render("new_event.html")
  end

  def new(conn, _params) do
    class_query =
      from(
        c in Class,
        order_by: c.type,
        select: c
      )

    classes = Repo.all(class_query)

    event_query =
      from(
        e in Event,
        order_by: e.title,
        select: e
      )

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

    sold_ticket_price =
      case Repo.aggregate(ticket_query, :sum, :price) do
        nil ->
          0

        other ->
          other
      end

    weeks =
      ticket_query
      |> count_by_day(:purchased_at)
      |> Repo.all()

    order_ids =
      ticket_query
      |> Repo.all()
      |> Enum.uniq_by(fn x ->
        x.order_id
      end)
      |> Enum.map(fn x -> x.order_id end)

    orders =
      from(
        o in Order,
        where: o.id in ^order_ids,
        preload: [:tickets, :user]
      )
      |> Repo.all()

    labels =
      Enum.map(weeks, fn [k, _] ->
        k
      end)

    data =
      Enum.map(weeks, fn [_, v] ->
        v
      end)

    render(
      conn,
      "show.html",
      show: show,
      orders: orders,
      sold_ticket_count: sold_ticket_count,
      labels: labels,
      data: data,
      sold_ticket_price: sold_ticket_price
    )
  end

  def create(
        conn,
        %{
          "class_id" => class_id,
          "title" => _title,
          "description" => _description,
          "listings" => _listings
        } = params
      ) do
    current_user = Coherence.current_user(conn)
    TicketAgent.ListingsGenerator.create_from_class(Map.put(params, "user", current_user))

    conn
    |> render("create.json")
  end

  def create(conn, params) do
    current_user = Coherence.current_user(conn)
    TicketAgent.ListingsGenerator.create_event(Map.put(params, "user", current_user))

    conn
    |> render("create.json", %{redirect_url: "appole"})
  end

  def edit(conn, %{"titled_slug" => titled_slug}) do
    show = load_show(titled_slug)
    changeset = Listing.changeset(show, %{})
    render(conn, "edit.html", show: show, changeset: changeset, titled_slug: titled_slug)
  end

  def update(conn, params) do
  end

  def count_by_day(query, date_field) do
    query
    |> group_by(
      [r],
      fragment(
        "CONCAT(date_part('month', ?), '/', date_part('day', ?), '/', date_part('year', ?))",
        field(r, ^date_field),
        field(r, ^date_field),
        field(r, ^date_field)
      )
    )
    |> order_by(
      [r],
      fragment(
        "CONCAT(date_part('month', ?), '/', date_part('day', ?), '/', date_part('year', ?))",
        field(r, ^date_field),
        field(r, ^date_field),
        field(r, ^date_field)
      )
    )
    |> select([r], [
      fragment(
        "CONCAT(date_part('month', ?), '/', date_part('day', ?), '/', date_part('year', ?))",
        field(r, ^date_field),
        field(r, ^date_field),
        field(r, ^date_field)
      ),
      count("*")
    ])
  end

  def load_show(titled_slug) do
    [slug | _] = titled_slug |> String.split("-")

    Repo.get_by!(Listing, slug: slug)
    |> Repo.preload(:class)
    |> Repo.preload(:event)
    |> Repo.preload(:tickets)
    |> Repo.preload(tickets: :order)
  end
end
