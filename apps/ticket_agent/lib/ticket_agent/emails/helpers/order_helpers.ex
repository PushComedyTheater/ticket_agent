defmodule TicketAgent.OrderHelpers do
  alias TicketAgent.{Listing, Repo}

  def google_calendar_link(listing) do
    url = "http://www.google.com/calendar/render?action=TEMPLATE"

    url =
      url <>
        "&dates=#{calendar_timestamp(listing.start_at)}/#{calendar_timestamp(listing.end_at)}"

    url = url <> "&location=Push+Comedy+Theater,+763+Granby+St,+Norfolk,+VA+23510,+USA"
    url = url <> "&pli=1sf=true"
    url <> "&text=#{URI.encode(listing.title)}"
  end

  def event_date(date) do
    date
    |> Calendar.DateTime.shift_zone!("America/New_York")
    |> Calendar.Strftime.strftime!("%b %d, %Y")
  end

  def event_time(date) do
    date
    |> Calendar.DateTime.shift_zone!("America/New_York")
    |> Calendar.Strftime.strftime!("%l:%M %P")
  end

  def calendar_timestamp(date) do
    date
    |> Calendar.Strftime.strftime!("%Y%m%dT%H%M%SZ")
  end

  def sold_ticket_count(%Listing{tickets: %Ecto.Association.NotLoaded{}} = listing) do
    sold_ticket_count(Repo.preload(listing, [:tickets]))
  end

  def sold_ticket_count(%Listing{tickets: tickets}) do
    sold_tickets =
      tickets
      |> Enum.filter(fn ticket ->
        Enum.member?(~w(purchased emailed checkedin), ticket.status)
      end)

    ticket_count(%{tickets: sold_tickets})
  end

  def ticket_count(%{tickets: tickets}) when length(tickets) > 1,
    do: "#{Enum.count(tickets)} tickets"

  def ticket_count(%{tickets: tickets}), do: "1 ticket"

  def listing_ticket_count(listing) do
    tickets =
      case Ecto.assoc_loaded?(listing.tickets) do
        true ->
          listing.tickets

        false ->
          listing
          |> Repo.preload(:tickets)
          |> Map.get(:tickets)
      end

    tickets =
      tickets
      |> Enum.filter(fn ticket -> ticket.status == "purchased" end)

    IO.inspect(tickets)
    ticket_count(%{tickets: tickets})
  end

  def listing_image_with_dimensions(%Listing{event_id: event_id} = show, width, height)
      when not is_nil(event_id) do
    listing_with_dimensions(show.event.image_url, width, height)
  end

  def listing_image_with_dimensions(%Listing{class_id: class_id} = show, width, height)
      when not is_nil(class_id) do
    show =
      case Ecto.assoc_loaded?(show.class) do
        true -> show
        false -> Repo.preload(show, :class)
      end

    listing_with_dimensions(show.class.image_url, width, height)
  end

  def listing_with_dimensions(image_url, width, height) do
    public_id =
      image_url
      |> String.split("/")
      |> List.last()
      |> String.split(".")
      |> List.first()

    public_id = "covers/" <> public_id

    Cloudinex.Url.for(public_id, %{
      width: width,
      height: height,
      gravity: "north",
      crop: "fill",
      flags: 'progressive'
    })
  end

  def ticket_word(ticket_count) do
    cond do
      ticket_count == 1 ->
        "1 ticket"

      ticket_count > 1 ->
        "#{ticket_count} tickets"
    end
  end

  def money(price) do
    "$" <> :erlang.float_to_binary(price / 100, decimals: 2)
  end

  def ticket_table(order) do
    Enum.map_join(order.tickets, "", fn ticket ->
      "<tr><td>#{ticket.name}</td><td>$#{:erlang.float_to_binary(ticket.price / 100, decimals: 2)}</td></tr>"
    end)
  end

  def ticket_table_text(order) do
    Enum.map_join(order.tickets, "\n", fn ticket ->
      "#{ticket.name}      $#{:erlang.float_to_binary(ticket.price / 100, decimals: 2)}"
    end)
  end
end
