defmodule TicketAgentWeb.OrderPdfView do
  use TicketAgentWeb, :view

  def render("show.pdf", %{}) do
    %{
      message: "ok"
    }
  end
end
