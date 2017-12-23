defmodule TicketAgentWeb.ErrorView do
  use TicketAgentWeb, :view

  def render("error.json", %{message: message}) do
    %{message: message}
  end

  def render("500.html", _assigns) do
    "Internal server error"
  end
end
