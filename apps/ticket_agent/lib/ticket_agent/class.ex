defmodule TicketAgent.Class do
  @moduledoc false
  use TicketAgent.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :slug}

  schema "classes" do
    field :type, :string
    field :title, :string
    field :slug, :string
    field :description, :string
    field :menu_order, :integer
    belongs_to :prerequisite, Class
    field :cover_photo_url, :string
    field :social_photo_url, :string
    has_many :listings, Listing
    timestamps()
  end

  @doc false
  def changeset(%Class{} = class, attrs) do
    class
    |> cast(attrs, [:type, :title, :description, :prerequisite_id, :slug, :menu_order, :cover_photo_url, :social_photo_url])
    |> cast_assoc(:prerequisite)
    |> validate_required([:type, :title])
  end
end
