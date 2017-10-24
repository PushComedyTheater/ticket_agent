defmodule TicketAgent.Teacher do
  @moduledoc false
  use TicketAgent.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "teachers" do
    field :slug, :string
    field :biography, :string
    field :email, :string
    field :name, :string
    field :social, :map
    timestamps()
  end

  @doc false
  def changeset(%Teacher{} = class, attrs) do
    slug = String.split(attrs[:name], " ") |> hd |> String.downcase
    attrs = Map.put(attrs, :slug, slug)
    class
    |> cast(attrs, [:slug, :biography, :email, :name, :social])
    |> validate_required([:name, :email])
  end
end
