defmodule TicketAgentWeb.OrderView do
  use TicketAgentWeb, :view

  def render("create.json", %{order: order, tickets: tickets, locked_until: locked_until}) do
    %{
      slug: order.slug,
      name: order.name,
      email: order.email_address,
      total_price: order.total_price,
      status: order.status,
      locked_until: locked_until,
      tickets: render_many(tickets, TicketAgentWeb.TicketView, "show.json")
    }
  end

  def render("delete.json", %{}) do
    %{
      message: "ok"
    }
  end
end
