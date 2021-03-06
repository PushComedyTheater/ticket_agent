defmodule TicketAgentWeb.Backend.ListingView do
  alias TicketAgent.{Listing, ListingImage}
  use TicketAgentWeb, :view
  import Scrivener.HTML

  def render("create.json", %{}) do
    %{
      message: "ok"
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
