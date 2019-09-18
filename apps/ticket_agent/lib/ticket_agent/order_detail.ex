defmodule TicketAgent.OrderDetail do
  use TicketAgent.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @attrs ~w(order_id charge_id balance_transaction status failure_code failure_message
            amount network_status risk_level response client_ip)a

  schema "order_details" do
    belongs_to(:order, Order, references: :id, foreign_key: :order_id, type: Ecto.UUID)
    field(:charge_id, :string)
    field(:balance_transaction, :string)
    field(:client_ip, :string)
    field(:status, :string)
    field(:failure_code, :string)
    field(:failure_message, :string)
    field(:amount, :string)
    field(:network_status, :string)
    field(:risk_level, :string)
    field(:response, :map)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%OrderDetail{} = order_detail, attrs) do
    order_detail
    |> cast(attrs, @attrs)
    |> assoc_constraint(:order)
    |> validate_required([:response])
  end

  def parse_stripe_response(%{"error" => error} = response, order_id) do
    %{
      order_id: order_id,
      charge_id: error["charge"],
      balance_transaction: nil,
      status: error["code"],
      failure_code: error["decline_code"],
      failure_message: error["message"],
      amount: nil,
      network_status: nil,
      risk_level: nil,
      response: response
    }
  end

  def parse_stripe_response(response, order_id) do
    outcome = response["outcome"]
    amount = response["amount"]

    %{
      order_id: order_id,
      charge_id: response["id"],
      balance_transaction: response["balance_transaction"],
      status: response["status"],
      failure_code: response["failure_code"],
      failure_message: response["failure_message"],
      amount: "#{amount}",
      network_status: outcome["network_status"],
      risk_level: outcome["risk_level"],
      response: response
    }
  end
end
