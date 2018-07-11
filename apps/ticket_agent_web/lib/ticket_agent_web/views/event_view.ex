defmodule TicketAgentWeb.EventView do
  use TicketAgentWeb, :view
  alias TicketAgent.Finders.TicketFinder

  def load_event_image(event, width \\ 1050)
  def load_event_image(%{image_url: image_url}, width) do
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
  def load_event_image(_, _), do: ""

  def event_buy_timestamp(nil), do: ""
  def event_buy_timestamp(date) do
    date
    |> Calendar.DateTime.shift_zone!("America/New_York")
    |> Calendar.Strftime.strftime!("%m/%d/%Y at %l:%M%p")
  end

  def purchased_order_list(conn, orders) do
    Enum.map_join(orders, ", ", fn(order) ->
      safe_to_string(link(event_date(order.completed_at), to: order_path(conn, :show, order), target: "_blank"))
    end)
  end

  def aggregated_tags(shows) do
    Enum.reduce(shows, [], fn([show, _], acc) ->
      tags = Enum.map(show.listing_tags, fn(x) -> x.tag end)
      acc ++ tags
    end)
    |> Enum.uniq
    |> Enum.sort
  end

  def show_tags(show) do
    show.listing_tags
    |> Enum.map(&(&1.tag))
    |> Poison.encode!
  end

  def event_cost(event) do
    range =
      event.listing_ids
      |> TicketFinder.price_range()
      |> cost_range

    case range do
      "FREE" -> "FREE"
      range -> "$#{range}"
    end
  end

  def listing_cost(listing) do
    ticket = Enum.at(listing.tickets, 0)
    ticket.price / 100
    |> :erlang.float_to_binary(decimals: 2)
  end

  def full_event_date(%{listing_count: listing_count}) when listing_count > 1 do
    "Multiple Dates"
  end

  def full_event_date(%{listing_count: listing_count, start_at: start_at}) when listing_count == 1 do
    start_at
    |> Calendar.DateTime.shift_zone!("America/New_York")
    |> Calendar.Strftime.strftime!("%b %d, %Y - %l:%M%p")
  end

  def event_date_long(date) do
    date
    |> Calendar.DateTime.shift_zone!("America/New_York")
    |> Calendar.Strftime.strftime!("%b %d, %Y - %l:%M%p")
  end

  def listing_tags(show) do
    Enum.take(show.listing_tags, 5)
    |> Enum.map_join(", ", fn tag -> tag.tag end)
  end

  defp cost_range(%{min_price: nil, max_price: nil}), do: "FREE"
  defp cost_range(%{min_price: 0, max_price: 0}), do: "FREE"
  defp cost_range(%{min_price: min, max_price: max}) when max == min do
    max / 100
    |> :erlang.float_to_binary(decimals: 2)
  end

  defp cost_range(%{min_price: min, max_price: max}) do
    min =
      min / 100
      |> :erlang.float_to_binary(decimals: 2)

    max =
      max / 100
      |> :erlang.float_to_binary(decimals: 2)

    "#{min} - #{max}"
  end
end
