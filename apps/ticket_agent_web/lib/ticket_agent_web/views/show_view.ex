defmodule TicketAgentWeb.ShowView do
  alias TicketAgent.Listing
  use TicketAgentWeb, :view
  @months ~w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)

  def ticket_link(show) do
    available_tickets = Listing.available_tickets(show)

    if Enum.count(available_tickets) > 0 do
      link("Buy Tickets", to: "/ticket/new", class: "btn u-btn-primary g-font-size-13 text-uppercase g-py-10 g-px-15")
    else
      link("Sold Out", to: "#", class: "btn u-btn-red g-font-size-13 text-uppercase g-py-10 g-px-15")
    end
  end

  def cost(show) do
    cost =
      show
      |> Listing.ticket_cost
      |> :erlang.float_to_binary([decimals: 2])

    "$#{cost}"
  end

  def event_date(date) do
    Calendar.Strftime.strftime!(date, "%b %d, %Y - %l:%M%p")
  end

  def listing_tags(show) do
    Enum.take(show.listing_tags, 5)
    |> Enum.map_join(", ", fn(tag) -> tag.tag end)
    |> IO.inspect
  end

  def cover_image(show) do
    social_image =
      show.images
      |> Enum.find(fn(x) -> x.type == "cover" end)

    public_id =
      social_image.url
      |> String.split("/")
      |> List.last
      |> String.split(".")
      |> List.first

    Cloudinex.Url.for(
    public_id,
    %{
      width: 1050,
      height: 400,
      gravity: "north",
      crop: "fill",
      flags: 'progressive'
      }
    )
  end

  def social_image(show) do
    social_image =
      show.images
      |> Enum.find(fn(x) -> x.type == "social" end)

    public_id =
      social_image.url
      |> String.split("/")
      |> List.last
      |> String.split(".")
      |> List.first

    Cloudinex.Url.for(
    public_id,
    %{
      width: 350,
      height: 264,
      gravity: "north",
      crop: "thumb",
      fetch_format: 'auto',
      flags: 'progressive'
      }
    )
  end
end
