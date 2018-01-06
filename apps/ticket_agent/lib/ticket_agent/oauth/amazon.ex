defmodule TicketAgent.Amazon do
  @moduledoc """
  An OAuth2 strategy for Amazon.
  """
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode
# https://login.live.com/oauth20_authorize.srf?client_id=073ce2f8-e2ef-4408-b830-500bee19cdad&scope=wl.emails,wl.basic&response_type=code&redirect_uri=https://veverka.ngrok.io/auth/microsoft/callback
  defp config do
    [strategy: TicketAgent.Amazon,
     site: "",
     authorize_url: "https://www.amazon.com/ap/oa",
     token_url: "https://api.amazon.com/auth/o2/token"]
  end

  # Public API
  def client do
    :ticket_agent
    |> Application.get_env(Amazon)
    |> Keyword.merge(config())
    |> OAuth2.Client.new()
  end

  def authorize_url!(params \\ []) do
    OAuth2.Client.authorize_url!(client(), params)
  end

  def get_token!(params \\ [], _) do
    OAuth2.Client.get_token!(client(), params)
  end

  def get_token(params \\ [], _) do
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
