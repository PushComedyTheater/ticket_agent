defmodule TicketAgentWeb.SharedView do
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
    og_data(conn, :page_image, "https://cdn.pushcomedytheater.com/images/logo.jpg")
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
