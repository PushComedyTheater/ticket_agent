defmodule TicketAgent.OrderHelpers do
  alias TicketAgent.Random

  def google_calendar_link(listing) do
    url = "http://www.google.com/calendar/render?action=TEMPLATE"
    url = url <> "&dates=#{calendar_timestamp(listing.start_at)}/#{calendar_timestamp(listing.end_at)}"
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

  def listing_image_with_dimensions(show, width, height) do
    image =
      show.images
      |> hd

    public_id =
      image.url
      |> String.split("/")
      |> List.last()
      |> String.split(".")
      |> List.first()

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

  def generate_ical(listing) do
    events = [
      %ICalendar.Event{
        summary: listing.title,
        dtstart: listing.start_at,
        dtend:   listing.end_at,
        description: Curtail.truncate(HtmlSanitizeEx.strip_tags(listing.description), length: 400),
        location: "Push Comedy Theater, 763 Granby St, Norfolk, VA 23510, USA",
        url: "http://pushcomedytheater.com/events/#{listing.slug}"
      }
    ]
    ics = %ICalendar{ events: events } |> ICalendar.to_ics

    File.write!("#{listing.slug}.ics", ics)
  end

  def money(price) do
    "$" <> :erlang.float_to_binary(price / 100, decimals: 2)
  end

  def ticket_table(order) do
    Enum.map_join(order.tickets, "", fn(ticket) ->
      "<tr><td>#{ticket.description}</td><td>$#{:erlang.float_to_binary(ticket.price / 100,decimals: 2)}</td></tr>"
    end)
  end
end
