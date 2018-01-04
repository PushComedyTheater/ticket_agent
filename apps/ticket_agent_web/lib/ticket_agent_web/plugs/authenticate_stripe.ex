defmodule TicketAgentWeb.AuthenticateStripe do
  require Logger
  import Plug.Conn
  def init(opts), do: opts

  def call(conn, _) do
    Logger.info "Authenticating Stripe Webhook"
    {:ok, payload, conn} = Plug.Conn.read_body(conn)
    [signature] = get_req_header(conn, "stripe-signature")
    ["t=" <> timestamp, "v1=" <> version, _] = String.split(signature, ",")

    IO.inspect secret_key() == "sk_test_uA30CFkkcclu9iuBWzdedW5h"
    construct_event(payload, signature, secret_key())
    |> IO.inspect

    conn
  end

  @default_tolerance 300
  @expected_scheme "v1"

  def construct_event(payload, signature_header, secret, tolerance \\ @default_tolerance) do
    case verify_header(payload, signature_header, secret, tolerance) do
      :ok ->
        {:ok, convert_to_event!(payload)}

      error ->
        error
    end
  end

  defp verify_header(payload, signature_header, secret, tolerance) do
    case get_timestamp_and_signatures(signature_header, @expected_scheme) do
      {nil, _} ->
        {:error, "Unable to extract timestamp and signatures from header"}

      {_, []} ->
        {:error, "No signatures found with expected scheme #{@expected_scheme}"}

      {timestamp, signatures} ->
        with {:ok, timestamp} <- check_timestamp(timestamp, tolerance),
             {:ok, _signatures} <- check_signatures(signatures, timestamp, payload, secret) do
          :ok
        else
          {:error, error} -> {:error, error}
        end
    end
  end

  defp get_timestamp_and_signatures(signature_header, scheme) do
    signature_header
    |> String.split(",")
    |> Enum.map(&String.split(&1, "="))
    |> Enum.reduce({nil, []}, fn
         ["t", timestamp], {nil, signatures} ->
          IO.inspect timestamp
           {to_integer(timestamp), signatures}

         [^scheme, signature], {timestamp, signatures} ->
           {timestamp, [signature | signatures]}

         _, acc ->
           acc
       end)
       |> IO.inspect
  end

  defp to_integer(timestamp) do
    case Integer.parse(timestamp) do
      {timestamp, _} ->
        timestamp

      :error ->
        nil
    end
  end

  defp check_timestamp(timestamp, tolerance) do
    now = System.system_time(:seconds)
    tolerance_zone = now - tolerance

    if timestamp < tolerance_zone do
      {:error, "Timestamp outside the tolerance zone (#{now})"}
    else
      {:ok, timestamp}
    end
  end

  defp check_signatures(signatures, timestamp, payload, secret) do
    signed_payload = "#{timestamp}.#{payload}"
    expected_signature = compute_signature(signed_payload, secret)

    IO.inspect expected_signature
    if Enum.any?(signatures, &secure_equals?(&1, expected_signature)) do
      {:ok, signatures}
    else
      {:error, "No signatures found matching the expected signature for payload"}
    end
  end

  defp compute_signature(payload, secret) do
    :crypto.hmac(:sha256, secret, payload)
    |> Base.encode16(case: :lower)
  end

  defp secure_equals?(input, expected) when byte_size(input) == byte_size(expected) do
    input = String.to_charlist(input)
    expected = String.to_charlist(expected)
    secure_compare(input, expected)
  end

  defp secure_equals?(_, _), do: false

  defp secure_compare(acc \\ 0, input, expected)
  defp secure_compare(acc, [], []), do: acc == 0

  defp secure_compare(acc, [input_codepoint | input], [expected_codepoint | expected]) do
    import Bitwise

    acc
    |> bor(input_codepoint ^^^ expected_codepoint)
    |> secure_compare(input, expected)
  end

  def convert_to_event!(payload) do
    payload
    |> Poison.decode!()
    |> Stripe.Converter.convert_result()
  end

  def convert_result(json) do
    
  end

  defp compute_signature(payload, secret) do
    :crypto.hmac(:sha256, secret, payload)
    |> Base.encode16(case: :lower)
  end  

  defp secret_key, do: get_env_variable(:secret_key)

  defp get_env_variable(key) do
    Application.get_env(:ticket_agent, Stripe)
    |> Keyword.get(key)
  end   
end
