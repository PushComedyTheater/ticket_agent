defmodule TicketAgentWeb.WebhookView do
  use TicketAgentWeb, :view

  def render("create.json", %{}) do
    %{
      message: "ok"
    }
  end
end
