defmodule TicketAgentWeb.EventView do
  use TicketAgentWeb, :view
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
    "10.00"
  end

  def listing_cost(listing) do
    ticket = Enum.at(listing.tickets, 0)
    ticket.price / 100
    |> :erlang.float_to_binary(decimals: 2)
  end

  def full_event_date(%{listings: listings} = event) when length(listings) > 1 do
    listing = Enum.at(listings, 0)
    listing.start_at
    |> Calendar.DateTime.shift_zone!("America/New_York")
    |> Calendar.Strftime.strftime!("%b %d, %Y - %l:%M%p")
  end

  def full_event_date(%{listings: [listing]} = event) do
    listing.start_at
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
end
