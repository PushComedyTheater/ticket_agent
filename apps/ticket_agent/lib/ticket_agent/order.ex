defmodule TicketAgent.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias TicketAgent.Order

  schema "orders" do
    belongs_to :user, User, references: :id, foreign_key: :user_id, type: Ecto.UUID
    field :slug, :string
    field :name, :string
    field :email_address, :string
    field :status, :string
    field :total_price, :integer
  end

  @doc false
  def changeset(%Order{} = order, attrs) do
    order
    |> cast(attrs, [])
    |> validate_required([])
  end
end
