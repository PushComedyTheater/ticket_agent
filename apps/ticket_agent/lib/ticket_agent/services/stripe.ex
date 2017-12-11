defmodule TicketAgent.Services.Stripe do
  require Logger
  @stripe_api_version "2017-08-15"
  @stripe_user_agent "TicketAgent 1.0"
  alias TicketAgent.{OrderDetail, Repo, User}

  def publishable_key, do: get_env_variable(:publishable_key)

  def create_charge_with_customer(customer, amount, description, order_id, metadata \\ %{}) do
    create_charge(nil, customer, amount, description, metadata)
    |> insert_order_details(order_id)
  end

  def create_charge_with_token(token, amount, description, order_id, metadata \\ %{}) do
    create_charge(token, nil, amount, description, metadata)
    |> insert_order_details(order_id)
  end  
   
  def create_customer(token, user, stripe_customer_id, metadata \\ %{})
  def create_customer(token, user, nil, metadata) do
    Logger.info "Creating a customer because we don't have a key"
    values = %{
      "source" => token, 
      "email" => user.email, 
      "description" => user.name
    }
    
    values = Enum.reduce(metadata, values, fn({key, value}, acc) ->
      acc = Map.put(acc, "metadata[#{key}]", value)
    end)
    
    body = 
      values
      |> URI.encode_query()

    uri = "#{api_url()}/customers"

    case request(:post, uri, [], body, hackney_opts()) do
      {:ok, %{"id" => stripe_customer_id} = response} ->
        {:ok, User.update_stripe_customer_id(user, stripe_customer_id)}
      anything ->
        Logger.error "Received bad response from Stripe"
        {:error, anything}
    end
  end

  def create_customer(token, user, stripe_customer_id, metadata) when not is_nil(stripe_customer_id) do
    uri = "#{api_url()}/customers/#{stripe_customer_id}"
    Logger.info "Getting a customer because we have a key from #{uri}"
    
    case request(:get, uri, [], "", hackney_opts()) do
      {:ok, %{"id" => stripe_customer_id} = response} ->
        {:ok, User.update_stripe_customer_id(user, stripe_customer_id)}
      {:error, error} ->
        Logger.error "Received bad response from Stripe #{inspect error}"
        {:error, :stripe_error}        
    end
  end

  defp create_charge(token, customer, amount, description, metadata) do
    values = load_charge_values(token, customer, amount, description, metadata)
    values = Enum.reduce(metadata, values, fn({key, value}, acc) ->
      acc = Map.put(acc, "metadata[#{key}]", value)
    end) 

    body = 
      values
      |> URI.encode_query()

    uri = api_url() <> "/charges"

    request(:post, uri, [], body, hackney_opts())
  end

  defp load_charge_values(token, nil, amount, description, metadata) do
    values = %{
      "source" => token, 
      "amount" => amount, 
      "description" => description,
      "currency" => "usd"
    }   
  end

  defp load_charge_values(nil, customer_id, amount, description, metadata) do
    values = %{
      "customer" => customer_id, 
      "amount" => amount, 
      "description" => description,
      "currency" => "usd"
    }   
  end  

  defp insert_order_details({status, response}, order_id) do
    parsed_response = OrderDetail.parse_stripe_response(response, order_id)

    %OrderDetail{}
    |> OrderDetail.changeset(parsed_response)
    |> Repo.insert!

    {status, response}
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