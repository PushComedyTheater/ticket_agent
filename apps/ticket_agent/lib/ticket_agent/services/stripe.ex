defmodule TicketAgent.Services.Stripe do
  @stripe_api_version "2017-08-15"
  @stripe_user_agent "TicketAgent 1.0"

  def publishable_key, do: get_env_variable(:publishable_key)

  def charge(token, amount, description) do
    body = %{
      "source" => token, 
      "amount" => amount, 
      "description" => description,
      "currency" => "usd"
    }
    |> URI.encode_query()

    uri = api_url() <> "/charges"

    request(:post, uri, [], body, hackney_opts())
  end

  defp request(method, url, headers, body, hackney_options) do
    case :hackney.request(method, url, load_headers(headers, method), body, hackney_options) do
      {:ok, status, _headers, _body} when method == :delete and status in [204, 404] ->
        {:ok, nil}
      {:ok, status, _headers, body} when status in [200, 201] ->
        {:ok, Poison.decode!(body)}
      {:ok, _status, _headers, body} ->
        {:error, Poison.decode!(body)}
      {:error, reason} ->
        {:error, reason}
    end
  end

  defp hackney_opts do
    [:with_body, basic_auth: {secret_key(), ""}, pool: false]
  end   

  defp load_headers(headers, :post) do
    headers ++ [
      {"Accept", "application/json; charset=utf8"},
      {"content-type", "application/x-www-form-urlencoded"},
      {"Accept-Encoding", "gzip"},
      {"Connection", "keep-alive"},
      {"User-Agent", @stripe_user_agent},
      {"Stripe-Version", @stripe_api_version}   
    ] 
  end

  defp load_headers(headers, :get) do
    headers ++ [
      {"Accept", "application/json; charset=utf8"},
      {"Accept-Encoding", "gzip"},
      {"Connection", "keep-alive"},
      {"User-Agent", @stripe_user_agent},
      {"Stripe-Version", @stripe_api_version}   
    ]     
  end

  defp api_url, do: get_env_variable(:api_url)
  
  defp secret_key, do: get_env_variable(:secret_key)

  defp get_env_variable(key) do
    Application.get_env(:ticket_agent, Stripe)
    |> Keyword.get(key)
  end  
end