defmodule TicketAgentWeb.Admin.OrderView do
  use TicketAgentWeb, :view
  import Ecto.Query
  import Scrivener.HTML
  alias TicketAgent.Listing

  def render("index.json", %{records: records, page_number: page_number, draw_number: draw_number}) do
    %{
      recordsTotal: records.total_entries,
      draw: draw_number,
      recordsFiltered: records.total_entries,
      data: Enum.map(records, &records_json/1)
    }
  end

  def records_json(record) do
    %{
      id: record.id,
      slug: record.slug,
      buyer: record.user.name,
      listing: listing_name(record.listing),
      ticket_count: Enum.count(record.tickets),
      status: record.status,
      total: cost(record.total_price / 100),
      date: order_timestamp(record.completed_at)
    }
  end

  def order_status(status) do
    status
  end

  def listing_name(nil), do: ""

  def listing_name(listing) do
    listing.title
  end
end
