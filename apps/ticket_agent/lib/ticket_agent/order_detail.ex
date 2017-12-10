defmodule TicketAgent.OrderDetail do
  use TicketAgent.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "order_details" do
    belongs_to :order, Order, references: :id, foreign_key: :order_id, type: Ecto.UUID
    field :charge_id, :string
    field :balance_transaction, :string
    field :client_ip, :string
    field :status, :string
    field :failure_code, :string
    field :failure_message, :string
    field :amount, :string
    field :network_status, :string
    field :risk_level, :string
    field :response, :map

    timestamps()
  end

  @doc false
  def changeset(%OrderDetail{} = order_detail, attrs) do
    order_detail
    |> cast(attrs, [:client_ip])
    |> validate_required([:client_ip])
  end
end
