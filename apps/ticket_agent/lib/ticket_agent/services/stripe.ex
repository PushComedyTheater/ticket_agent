defmodule TicketAgent.Services.Stripe do
  require Logger
  @stripe_api_version "2017-08-15"
  @stripe_user_agent "TicketAgent 1.0"
  alias TicketAgent.{OrderDetail, Repo, User}

  def publishable_key, do: get_env_variable(:publishable_key)

  def create_charge(customer, amount, description, order, client_ip, user, metadata \\ %{}) do
    values = load_charge_values(order, customer, amount, description)

    body =
      metadata
      |> Enum.reduce(values, fn({key, value}, acc) ->
        Map.put(acc, "metadata[#{key}]", value)
      end)
      |> URI.encode_query()

    uri = api_url() <> "/charges"

    {status, response} =
      request(:post, uri, [], body, hackney_opts())
      |> insert_order_details(order.id, client_ip)

    case status do
      :error ->
        Logger.error "There was an error submitting the post"
        message = get_in(response, ["error", "message"])
        if String.match?(message, ~r/^No such customer/i) do
          Logger.error "Customer ID is stale"
          User.update_stripe_customer_id(user, nil)
        end
        {:error, response}
      :ok ->
        Logger.info "Everything is ok"
        {:ok, response}
    end
  end

  def create_customer(token, user, metadata) do
    Logger.info "Creating a customer because we don't have a key"
    values = %{
      "source" => token,
      "email" => user.email,
      "description" => user.name
    }

    values = Enum.reduce(metadata, values, fn({key, value}, acc) ->
      Map.put(acc, "metadata[#{key}]", value)
    end)

    body =
      values
      |> URI.encode_query()

    uri = "#{api_url()}/customers"

    case request(:post, uri, [], body, hackney_opts()) do
      {:ok, %{"id" => stripe_customer_id}} ->
        {:ok, User.update_stripe_customer_id(user, stripe_customer_id)}
      {:error, %{"error" => error}} ->
        Logger.error "Received bad response from Stripe #{inspect error}"
        {:error, error}
      anything ->
        Logger.error "Received unknown bad response from Stripe #{inspect anything}"
        {:error, anything}
    end
  end

  def load_stripe_token(user, token_id, metadata) do
    Logger.info "load_stripe_token -> #{token_id}"

    case User.get_stripe_customer_id(user) do
      nil ->
        case create_customer(token_id, user, metadata) do
          {:error, error} ->
            Logger.error "Could not create customer because: #{inspect error}"
            {:token_error, error["message"]}
          {:ok, user} ->
            {:ok, user.stripe_customer_id}
        end
      stripe_customer_id ->
        Logger.info "Found existing customer id"
        {:ok, stripe_customer_id}
    end
  end  

  defp load_charge_values(order, customer_id, amount, description) do
    %{
      "customer" => customer_id,
      "amount" => amount,
      "description" => description,
      "currency" => "usd",
      "application_fee" => order.processing_fee
    }
  end

  defp insert_order_details({status, response}, order_id, client_ip) do
    parsed_response =
      response
      |> OrderDetail.parse_stripe_response(order_id)
      |> Map.merge(%{client_ip: client_ip})

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
      {"Stripe-Version", @stripe_api_version},
      {"Stripe-Account", "acct_14e3TwHtx4T3dZy7"}
    ]
  end

  defp load_headers(headers, :get) do
    headers ++ [
      {"Accept", "application/json; charset=utf8"},
      {"Accept-Encoding", "gzip"},
      {"Connection", "keep-alive"},
      {"User-Agent", @stripe_user_agent},
      {"Stripe-Version", @stripe_api_version},
      {"Stripe-Account", "acct_14e3TwHtx4T3dZy7"}
    ]
  end

  defp api_url, do: get_env_variable(:api_url)

  defp secret_key, do: get_env_variable(:secret_key)

  defp get_env_variable(key) do
    Application.get_env(:ticket_agent, Stripe)
    |> Keyword.get(key)
  end
end
