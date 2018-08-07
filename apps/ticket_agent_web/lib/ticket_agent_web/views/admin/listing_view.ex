defmodule TicketAgentWeb.Admin.ListingView do
  alias TicketAgent.{Listing, ListingImage}
  use TicketAgentWeb, :view
  import Scrivener.HTML

  def render("index.json", %{listings: listings, draw_number: draw_number}) do
    %{
      recordsTotal: listings.total_entries,
      draw: draw_number,
      recordsFiltered: listings.total_entries,
      data: Enum.map(listings, &listing_json/1)
    }
  end

  def listing_json(listing) do
    tickets = listing.tickets
    available = Enum.filter(tickets, fn x -> x.status == "available" end)

    %{
      slug: listing.slug,
      title: listing.title,
      status: listing.status,
      type: listing.type,
      start_at: order_timestamp(listing.start_at),
      end_at: listing.end_at,
      ticket_count: Enum.count(listing.tickets),
      available_count: Enum.count(available)
    }
  end

  def render("create.json", %{redirect_url: url}) do
    %{
      message: "ok",
      redirect_url: url
    }
  end

  def listing_type(true) do
    [Class: "class", Show: "show", Workshop: "workshop"]
  end

  def listing_type(false) do
    [Show: "show", Workshop: "workshop"]
  end

  def cover_image(%Listing{} = listing) do
    image = Enum.find(listing.images, fn x -> x.type == "cover" end)
    public_id = ListingImage.public_id(image)
    Cloudinex.Url.for("covers/#{public_id}")
  end

  def social_image(%Listing{} = listing) do
    image = Enum.find(listing.images, fn x -> x.type == "social" end)
    public_id = ListingImage.public_id(image)
    Cloudinex.Url.for("social/#{public_id}")
  end

  def purchased_tickets(tickets) do
    Enum.filter(tickets, fn ticket ->
      ticket.status == "purchased" || ticket.status == "emailed" || ticket.status == "checkedin"
    end)
  end

  def ticket_status(%{status: status}) when status == "purchased" do
    "<span class=\"label label-success\">Purchased</span>"
  end

  def ticket_status(%{status: status}) when status == "emailed" do
    "<span class=\"label label-warning\">Emailed</span>"
  end

  def ticket_status(%{status: status}) when status == "checkedin" do
    "<span class=\"label label-primary\">Checked In</span>"
  end

  def my_datetime_select(form, field, opts \\ []) do
    builder = fn b ->
      ~e"""
      Date: <%= b.(:month, []) %> / <%= b.(:day, []) %> / <%= b.(:year, []) %>
      Time: <%= b.(:hour, []) %> : <%= b.(:minute, []) %>
      """
    end

    datetime_select(form, field, [builder: builder] ++ opts)
  end
end
