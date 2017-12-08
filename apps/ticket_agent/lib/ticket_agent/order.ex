defmodule TicketAgent.Order do
  @moduledoc false
  @derive {Phoenix.Param, key: :slug}
  use TicketAgent.Schema

  @required ~w(slug name email_address status total_price)a
  @optional ~w(user_id)
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "orders" do
    belongs_to :user, User, references: :id, foreign_key: :user_id, type: Ecto.UUID
    field :slug, :string
    field :name, :string
    field :email_address, :string
    field :status, :string
    field :total_price, :integer
    timestamps
  end

  @doc false
  def changeset(%Order{} = order, attrs) do
    order
    |> cast(attrs, @required)
    |> cast(attrs, @optional)
    |> validate_required(@required)
  end 
end
