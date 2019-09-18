defmodule TicketAgent.Microsoft do
  @moduledoc """
  An OAuth2 strategy for Microsoft.
  """
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode

  defp config do
    [
      strategy: TicketAgent.Microsoft,
      site: "https://login.live.com",
      authorize_url: "/oauth20_authorize.srf",
      token_url: "/oauth20_token.srf"
    ]
  end

  # Public API
  def client do
    :ticket_agent
    |> Application.get_env(Microsoft)
    |> Keyword.merge(config())
    |> OAuth2.Client.new()
  end

  def authorize_url!(params \\ []) do
    OAuth2.Client.authorize_url!(client(), params)
  end

  def get_token!(params \\ [], headers \\ []) do
    OAuth2.Client.get_token!(client(), params)
  end

  def get_token(params \\ [], headers \\ []) do
    OAuth2.Client.get_token(client(), params)
  end

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_param(:client_secret, client.client_secret)
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end
