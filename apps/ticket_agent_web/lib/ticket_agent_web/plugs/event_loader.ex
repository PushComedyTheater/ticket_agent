defmodule TicketAgentWeb.Plugs.EventLoader do
  require Logger
  import Plug.Conn
  alias TicketAgentWeb.SharedView
  alias TicketAgent.Finders.{ListingFinder, OrderFinder, ShowFinder, TicketFinder}
  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"slug" => slug}} = conn, _) do
    Logger.info("EventLoader->slug #{slug}")
    current_user = Coherence.current_user(conn)

    ShowFinder.load_show_details_by_slug(slug)
    |> ListingFinder.load_listing_details_for_event()
    |> setup_with_event(current_user, conn)
  end

  def setup_with_event({nil, _}, _, conn) do
    Logger.error("EventLoader->Cannot find listing")

    conn
    |> Plug.Conn.put_status(404)
    |> Phoenix.Controller.render(
      TicketAgentWeb.ErrorView,
      "404.html",
      message: "Cannot find listing"
    )
    |> Plug.Conn.halt()
  end

  def setup_with_event({event, listings}, user, conn) do
    Logger.info("EventLoader->setup_with_event and NO user")

    tickets = setup_tickets(listings)
    {min, max} = load_min_max(tickets)

    conn
    |> load_flash_message()
    |> Plug.Conn.assign(:page_title, "#{event.title} at Push Comedy Theater")
    |> Plug.Conn.assign(
      :page_description,
      SharedView.open_graph_description(event.description, true)
    )
    |> Plug.Conn.assign(:page_image, SharedView.event_image(event.image_url))
    |> assign(:tickets, tickets)
    |> assign(:min_ticket_price, min)
    |> assign(:max_ticket_price, max)
    |> assign(:event, event)
    |> assign(:listings, listings)
    |> assign_user(user, event)
  end

  def load_min_max(tickets) do
    tickets
    |> Enum.reduce({100_000, 0}, fn ticket, {min, max} ->
      min =
        if ticket.price < min do
          ticket.price
        else
          min
        end

      max =
        if ticket.price > max do
          ticket.price
        else
          max
        end

      {min, max}
    end)
  end

  def assign_user(conn, nil, _) do
    conn
    |> assign(:purchase_orders, [])
    |> assign(:has_purchased_event, false)
  end

  def assign_user(conn, user, event) do
    purchase_orders = OrderFinder.customer_event_orders(user.id, event.id)
    has_purchased_event = Enum.count(purchase_orders) > 0

    conn
    |> assign(:purchase_orders, purchase_orders)
    |> assign(:has_purchased_event, has_purchased_event)
  end

  def setup_tickets(listings) when length(listings) > 0 do
    tickets =
      listings
      |> Enum.reduce([], fn listing, acc ->
        acc = acc ++ [listing.id]
      end)
      |> TicketFinder.all_available_tickets_by_listing_ids()

    tickets
  end

  def setup_tickets(_), do: []

  def load_flash_message(%{params: params} = conn) do
    import TicketAgentWeb.Gettext
    import Phoenix.Controller, only: [put_flash: 3]

    case params["msg"] do
      nil ->
        conn

      "show_expired" ->
        put_flash(
          conn,
          :error,
          dgettext("show_expired", "This show is no longer available for purchase.")
        )

      "released_tickets" ->
        put_flash(
          conn,
          :error,
          dgettext("released_tickets", "Your tickets were released due to session timeout.")
        )

      "cancelled_order" ->
        put_flash(
          conn,
          :error,
          dgettext("cancelled_order", "Your tickets were released when you cancelled your order.")
        )

      _ ->
        put_flash(conn, :error, dgettext("unknown", "Your tickets were released."))
    end
  end
end
