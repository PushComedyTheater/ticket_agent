defmodule TicketAgentWeb.Admin.ListingView do
  alias TicketAgent.{Listing, ListingImage}
  use TicketAgentWeb, :view
  import Scrivener.HTML

  def render("index.json", %{records: records, page_number: page_number, draw_number: draw_number}) do
    %{
      recordsTotal: records.total_entries,
      draw: draw_number,
      recordsFiltered: records.total_entries,
      data: Enum.map(records, &records_json/1)
    }
  end

  def records_json(record) do
    tickets = record.tickets
    available = Enum.filter(tickets, fn x -> x.status == "available" end)

    %{
      slug: record.slug,
      title: record.title,
      status: record.status,
      type: record.type,
      start_at: order_timestamp(record.start_at),
      end_at: record.end_at,
      ticket_count: Enum.count(record.tickets),
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
