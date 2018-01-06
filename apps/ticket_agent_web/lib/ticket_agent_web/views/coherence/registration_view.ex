defmodule TicketAgentWeb.Coherence.RegistrationView do
  use TicketAgentWeb.Coherence, :view

  def load_redirect_url(%{"redirect_url" => redirect_url}) do
    case String.match?(redirect_url, ~r/\?/) do
       false ->
        redirect_url <> "?guest_checkout=true"
       true ->
        redirect_url <> "&guest_checkout=true"
    end
  end

  def load_redirect_url(_), do: "?guest_checkout=true"
end
