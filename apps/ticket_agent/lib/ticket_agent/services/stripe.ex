defmodule TicketAgent.Services.Stripe do
  require Logger
  @stripe_api_version "2018-07-27"
  @stripe_user_agent "TicketAgent 1.0"
  alias TicketAgent.{OrderDetail, Repo, User}
  alias TicketAgent.State.OrderState

  def publishable_key, do: get_env_variable(:publishable_key)

  def load_stripe_token(user, token_id, metadata \\ %{}) when is_map(metadata) do
    case User.get_stripe_customer_id(user) do
      nil ->
        case create_customer(user, token_id, metadata) do
          {:error, error} ->
            {:error, :token_error}

          {:ok, user} ->
            {:ok, user}
        end

      stripe_customer_id ->
        {:ok, Repo.reload(user)}
    end
  end

  def create_customer(user, token, metadata \\ %{}) do
    Logger.info("create_customer->Creating a customer because we don't have a key")

    values = %{
      "source" => token,
      "email" => user.email,
      "description" => user.name
    }

    values =
      Enum.reduce(metadata, values, fn {key, value}, acc ->
        Map.put(acc, "metadata[#{key}]", value)
      end)

    body =
      values
      |> URI.encode_query()

    uri = "#{api_url()}/customers"

    Logger.info("create_customer->Making POST request to #{uri}")

    case request(:post, uri, [], body, hackney_opts()) do
      {:ok, %{"id" => stripe_customer_id}} ->
        Logger.info(
          "create_customer->created stripe customer with stripe id: #{stripe_customer_id}"
        )

        User.update_stripe_customer_id(user, stripe_customer_id)

      error ->
        Logger.error("Received unknown bad response from Stripe #{inspect(error)}")
        {:error, :stripe_error}
    end
  end

  def create_charge(
        order,
        %{stripe_customer_id: stripe_id} = user,
        description,
        client_ip,
        metadata \\ %{}
      )
      when not is_nil(stripe_id) do
    Logger.info("create_charge->creating charge for order ##{order.slug}")
    # just in case
    order = OrderState.calculate_order_cost(order)

    body =
      order
      |> load_charge_values(user, description)
      |> load_body(metadata)

    uri = api_url() <> "/charges"

    Logger.info("create_charge->Making POST request to #{uri}")

    {status, response} =
      request(:post, uri, [], body, hackney_opts())
      |> insert_order_details(order.id, client_ip)

    case status do
      :error ->
        Logger.error("create_charge->There was an error submitting the post #{inspect(response)}")
        message = get_in(response, ["error", "message"])

        if String.match?(message, ~r/^No such customer/i) do
          Logger.error("create_charge->Customer ID is stale")
          User.update_stripe_customer_id(user, nil)
          {:error, :missing_stripe_customer_id}
        else
          {:error, :unknown_error}
        end

      :ok ->
        Logger.info("create_charge->Charge created successfully")
        {:ok, response}
    end
  end

  def customer_details(user) do
    uri = api_url() <> "/customers/" <> user.stripe_customer_id

    Logger.info("uri = #{uri}")

    {status, response} = request(:get, uri, [], "", hackney_opts())

    body =
      user
      |> load_customer_charge_values()
      |> load_body(%{})
      |> IO.inspect()

    uri = api_url() <> "/charges?" <> body

    {status, response} = request(:get, uri, [], "", hackney_opts())

    # {status, response} =
    #   request(:post, uri, [], body, hackney_opts())
    #   |> insert_order_details(order.id, client_ip)
  end

  def refund(order, client_ip, metadata \\ %{}) do
    Logger.info("Processing refund for #{order.slug}")

    order =
      case Ecto.assoc_loaded?(order.details) do
        true -> order
        false -> Repo.preload(order, :details)
      end

    details = Enum.at(order.details, 0)

    body =
      details
      |> load_refund_values()
      |> load_body(metadata)

    uri = api_url() <> "/refunds"

    Logger.info("uri = #{uri}")

    {status, response} =
      request(:post, uri, [], body, hackney_opts())
      |> insert_order_details(order.id, client_ip)

    case status do
      :error ->
        Logger.error("create_charge->There was an error submitting the post #{inspect(response)}")
        message = get_in(response, ["error", "message"])
        {:error, :unknown_error}

      :ok ->
        Logger.info("create_charge->Refund created successfully")
        {:ok, response}
    end
  end

  def insert_order_details({status, response}, order_id, client_ip) do
    parsed_response =
      response
      |> OrderDetail.parse_stripe_response(order_id)
      |> Map.merge(%{client_ip: client_ip})

    %OrderDetail{}
    |> OrderDetail.changeset(parsed_response)
    |> Repo.insert!()

    {status, response}
  end

  defp load_charge_values(order, user, description) do
    %{
      "customer" => user.stripe_customer_id,
      "amount" => order.total_price,
      "description" => description,
      "currency" => "usd",
      "application_fee" => order.processing_fee
    }
  end

  defp load_refund_values(order_details) do
    %{
      "charge" => order_details.charge_id,
      "refund_application_fee" => true
    }
  end

  defp load_customer_charge_values(user) do
    %{
      "customer" => user.stripe_customer_id,
      "limit" => 100
    }
  end

  defp load_body(values, metadata) do
    metadata
    |> Enum.reduce(values, fn {key, value}, acc ->
      Map.put(acc, "metadata[#{key}]", value)
    end)
    |> URI.encode_query()
  end

  defp request(method, url, headers, body, hackney_options) do
    case :hackney.request(method, url, load_headers(headers, method), body, hackney_options) do
      {:ok, status, _headers, _body} when method == :delete and status in [204, 404] ->
        {:ok, nil}

      {:ok, status, _headers, body} when status in [200, 201] ->
        {:ok, Jason.decode!(body)}

      {:ok, _status, _headers, body} ->
        {:error, Jason.decode!(body)}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp hackney_opts do
    [:with_body, basic_auth: {secret_key(), ""}, pool: false]
  end

  defp load_headers(headers, :post) do
    headers ++
      [
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
    headers ++
      [
        {"Accept", "application/json; charset=utf8"},
        {"Accept-Encoding", "gzip"},
        {"Connection", "keep-alive"},
        {"User-Agent", @stripe_user_agent},
        {"Stripe-Version", @stripe_api_version},
        {"Stripe-Account", "acct_14e3TwHtx4T3dZy7"}
      ]
  end

  defp api_url, do: Application.get_env(:ticket_agent, :stripe_api_url)

  defp secret_key, do: get_env_variable(:secret_key)

  defp get_env_variable(key) do
    Application.get_env(:ticket_agent, Stripe)
    |> Keyword.get(key)
  end
end
