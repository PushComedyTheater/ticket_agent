defmodule TicketAgent.Account do
  @moduledoc false
  use TicketAgent.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "accounts" do
    field :name, :string
    field :description, :string
    field :url, :string
    field :enabled, :boolean
    field :logo, :string
    belongs_to :creator, User, references: :id, foreign_key: :creator_id, type: Ecto.UUID

    has_many :classes, Class
    has_many :events, Event

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :url, :enabled, :creator_id])
    |> validate_required([:name])
  end
end
