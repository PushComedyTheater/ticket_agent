defmodule TicketAgentWeb.OrderView do
  use TicketAgentWeb, :view

  def render("create.json", %{
        order: order,
        tickets: tickets,
        locked_until: locked_until,
        pricing: pricing,
        pass_fees: pass_fees
      }) do
    %{
      order_slug: order.slug,
      status: order.status,
      locked_until: locked_until,
      tickets: render_many(tickets, TicketAgentWeb.TicketView, "show.json"),
      pricing: pricing,
      pass_fees: pass_fees
    }
  end

  def render("delete.json", %{}) do
    %{
      message: "ok"
    }
  end
end
