defmodule TicketAgentWeb.Admin.WebHookView do
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

  def records_json(%{source: "mailgun"} = record) do
    %{
      id: record.id,
      source: "Mailgun - #{record.request["event-data"]["event"]}",
      recipient: record.request["event-data"]["recipient"],
      date: order_timestamp(record.inserted_at),
      request: record.request
    }
  end

  def records_json(record) do
    %{
      id: record.id,
      source: record.source,
      date: order_timestamp(record.inserted_at),
      request: record.request
    }
  end
end
