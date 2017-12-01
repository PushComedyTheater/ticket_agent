defmodule TicketAgentWeb.EventView do
  alias TicketAgent.Listing
  use TicketAgentWeb, :view
  @months ~w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
  @helpers TicketAgentWeb.Router.Helpers

  def cover_image(show) do
    social_image =
      show.images
      |> Enum.find(fn x -> x.type == "cover" end)

    public_id =
      social_image.url
      |> String.split("/")
      |> List.last()
      |> String.split(".")
      |> List.first()

    Cloudinex.Url.for(public_id, %{
      width: 1050,
      height: 400,
      gravity: "north",
      crop: "fill",
      flags: 'progressive'
    })
  end

  def aggregated_tags(shows) do
    Enum.reduce(shows, [], fn([show, _], acc) ->
      tags = Enum.map(show.listing_tags, fn(x) -> x.tag end)
      acc = acc ++ tags
    end)
    |> Enum.uniq
    |> Enum.sort
  end

  def show_tags(show) do
    show.listing_tags
    |> Enum.map(&(&1.tag))
    |> Poison.encode!
  end

  def ticket_link(conn, show) do
    available_ticket_count = Listing.available_ticket_count(show)

    type =
      link(
        "Buy Tickets",
        to: ticket_path(conn, :new, show_id: show.slug),
        class: "btn u-btn-primary g-font-size-13 text-uppercase g-py-10 g-px-15"
      )

    link =
      if Enum.count(available_ticket_count) > 0 do
        link(
          "Buy Tickets",
          to: "#modal",
          data_modal_target: "#modal",
          data_modal_effect: "#slit",
          class: "btn u-btn-primary g-font-size-13 text-uppercase g-py-10 g-px-15"
        )
      else
        link(
          "Sold Out",
          to: "#",
          class: "btn u-btn-red g-font-size-13 text-uppercase g-py-10 g-px-15"
        )
      end

    content_tag :div do
      content_tag :div, id: "modal", class: "text-left g-max-width-600 g-bg-white g-pa-20" do
        [link]
      end

      error = content_tag(:p, "Hello")
      [link, error]
    end
  end

  def cost(show) do
    show
    |> Listing.ticket_cost()
  end

  def event_date(date) do
    Calendar.Strftime.strftime!(date, "%b %d, %Y - %l:%M%p")
  end

  def listing_tags(show) do
    Enum.take(show.listing_tags, 5)
    |> Enum.map_join(", ", fn tag -> tag.tag end)
  end

  def social_image(show) do
    social_image =
      show.images
      |> Enum.find(fn x -> x.type == "social" end)

    public_id =
      social_image.url
      |> String.split("/")
      |> List.last()
      |> String.split(".")
      |> List.first()

    Cloudinex.Url.for(public_id, %{
      width: 350,
      height: 264,
      gravity: "north",
      crop: "thumb",
      fetch_format: 'auto',
      flags: 'progressive'
    })
  end
end
