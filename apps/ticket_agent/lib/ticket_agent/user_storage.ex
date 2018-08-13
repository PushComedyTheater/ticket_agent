defmodule TicketAgent.UserStorage do
  use Ecto.Schema
  import Ecto.Changeset
  alias TicketAgent.{User, UserStorage}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "user_storages" do
    belongs_to(:user, User, references: :id, foreign_key: :user_id, type: Ecto.UUID)
    field(:details, :map)
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%UserStorage{} = user_storage, attrs) do
    user_storage
    |> cast(attrs, [:user_id, :details])
    |> unique_constraint(:user_id)
  end
end
