defmodule TicketAgent.UserCredential do
  @moduledoc false
  use TicketAgent.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "user_credentials" do
    belongs_to(:user, User)
    field(:provider, :string)
    field(:token, :string)
    field(:secret, :string)
    field(:extra_details, :map)
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%UserCredential{} = user_credential, attrs) do
    user_credential
    |> cast(attrs, [:user_id, :provider, :token, :secret, :extra_details])
    |> validate_required([:user_id, :provider, :token])
  end
end
