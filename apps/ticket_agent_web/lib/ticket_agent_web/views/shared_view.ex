defmodule TicketAgentWeb.SharedView do
  require Logger

  def google_calendar(listing) do
    url = "http://www.google.com/calendar/render?action=TEMPLATE"
    url = url <> "&dates=#{calendar_timestamp(listing.listing_start_at)}/#{calendar_timestamp(listing.listing_end_at)}"
    url = url <> "&location=Push+Comedy+Theater,+763+Granby+St,+Norfolk,+VA+23510,+USA"
    url = url <> "&pli=1sf=true"
    url <> "&text=#{URI.encode(listing.listing_title)}"
  end

  def calendar_timestamp(date) do
    date
    |> Calendar.Strftime.strftime!("%Y%m%dT%H%M%SZ")
  end
  
  def treeview_root(conn, path_combined) do
    treeview_root = Map.get(conn.assigns, :treeview_root, "unknown")
    cond do
      treeview_root == path_combined ->
        "active treeview menu-open"
      true ->
        "treeview"
    end
  end

  def treeview_action(conn, path_combined) do
    treeview_action = Map.get(conn.assigns, :treeview_action, "unknown")
    cond do
      treeview_action == path_combined ->
        " class=\"active\""
      true ->
        ""
    end    
  end

  def cc_icon("Visa"), do: "visa"
  def cc_icon("American Express"), do: "amex"
  def cc_icon("MasterCard"), do: "mastercard"
  def cc_icon("Discover"), do: "discover"
  def cc_icon("JCB"), do: "jcb"
  def cc_icon("Diners Club"), do: "diners-club"
  def cc_icon("Unknown"), do: "stripe"

  def credit_card_details(nil), do: ""
  def credit_card_details(card) do
    "<i class=\"fa fa-cc-#{cc_icon(card.type)}\"></i> #{card.type} ending in #{card.last_4}<br />"
  end

  def ticket_details(ticket) do
    cond do
      String.length(ticket.guest_name) > 0 ->
        "#{ticket.description} (#{ticket.guest_name})"
      true ->
        ticket.description
    end
  end

  def event_date(date) do
    date
    |> Calendar.DateTime.shift_zone!("America/New_York")
    |> Calendar.Strftime.strftime!("%m/%d/%Y")
  end

  def event_time(date) do
    date
    |> Calendar.DateTime.shift_zone!("America/New_York")
    |> Calendar.Strftime.strftime!("%l:%M%p")
  end

  def order_timestamp(nil), do: ""
  def order_timestamp(date) do
    date
    |> Calendar.DateTime.shift_zone!("America/New_York")
    |> Calendar.Strftime.strftime!("%m/%d/%Y %l:%M%p")
  end

  def cost(ticket_price) when is_integer(ticket_price), do: cost(ticket_price / 1)
  def cost(ticket_price) when is_float(ticket_price) do
    ticket_price
    |> :erlang.float_to_binary(decimals: 2)
  end

  def money(price) do
    "$" <> :erlang.float_to_binary(price / 100, decimals: 2)
  end

  def cost_smallest_unit(ticket_price) when is_integer(ticket_price), do: cost_smallest_unit(ticket_price / 1)
  def cost_smallest_unit(ticket_price) when is_float(ticket_price) do
    (ticket_price / 100)
    |> :erlang.float_to_binary(decimals: 2)
  end

  def formatted_ticket_price(price) do
     price
     |> :erlang.float_to_binary(decimals: 2)
  end

  def full_url(conn), do: "https://#{conn.host}#{conn.request_path}"

  def full_event_time(%{start_at: start_at, end_at: end_at}) when start_at != end_at do
    "#{event_time(start_at)} - #{event_time(end_at)}"
  end
  def full_event_time(%{start_at: start_at, end_at: end_at}) when start_at == end_at, do: event_time(start_at)
  def full_event_time(_), do: "Unknown"

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

  def listing_image(show, width \\ 1050) do
    image = show.event.image_url

    public_id =
      image
      |> String.split("/")
      |> List.last()
      |> String.split(".")
      |> List.first()

    Cloudinex.Url.for(public_id, %{
      width: width,
      height: 400,
      gravity: "north",
      crop: "fill",
      flags: 'progressive'
    })
  end

  def event_image(%{event_image_url: image_url}, width \\ 1050) do
    image = image_url

    public_id =
      image
      |> String.split("/")
      |> List.last()
      |> String.split(".")
      |> List.first()

    Cloudinex.Url.for(public_id, %{
      width: width,
      height: 400,
      gravity: "north",
      crop: "fill",
      flags: 'progressive'
    })
  end

  def open_graph_description(text, true) do
    HtmlSanitizeEx.strip_tags(text) |> truncated_description()
  end

  def open_graph_description(text, false) do
    HtmlSanitizeEx.strip_tags(text)
  end

  def page_description(conn) do
    default = "The Push Comedy Theater is a 90 seat venue in the heart of Norfolk's brand new Arts District."
    og_data(conn, :page_description, default)
  end

  def page_image(conn) do
    og_data(conn, :page_image, "https://cdn.rawgit.com/PushComedyTheater/assets/master/images/logo.jpg")
  end

  def page_title(conn), do: og_data(conn, :page_title, "Push Comedy Theater")

  def truncated_description(text, opts \\ []) do
    max_length  = opts[:max_length] || 300
    omission    = opts[:omission] || "..."

    cond do
      not String.valid?(text) ->
        text
      String.length(text) < max_length ->
        text
      true ->
        length_with_omission = max_length - String.length(omission)

        "#{String.slice(text, 0, length_with_omission)}#{omission}"
    end
  end

  defp og_data(conn, key, default) do
    case Map.get(conn.assigns, key) do
      nil -> default
      something -> something
    end
  end
end
