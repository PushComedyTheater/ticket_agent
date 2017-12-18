defmodule TicketAgentWeb.OrderView do
  use TicketAgentWeb, :view

  def render("create.json", %{order: order, tickets: tickets, locked_until: locked_until, pricing: pricing}) do
    %{
      order_slug: order.slug,
      status: order.status,
      locked_until: locked_until,
      tickets: render_many(tickets, TicketAgentWeb.TicketView, "show.json"),
      pricing: pricing
    }
  end

  def render("delete.json", %{}) do
    %{
      message: "ok"
    }
  end
end
