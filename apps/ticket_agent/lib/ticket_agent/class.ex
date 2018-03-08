defmodule TicketAgent.Class do
  @moduledoc false
  @derive {Phoenix.Param, key: :slug}
  use TicketAgent.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "classes" do
    field :type, :string
    field :title, :string
    field :slug, :string
    field :description, :string
    field :menu_order, :integer
    field :image_url, :string

    belongs_to :account, Account, references: :id, foreign_key: :account_id, type: Ecto.UUID
    belongs_to :prerequisite, Class, references: :id, foreign_key: :prerequisite_id, type: Ecto.UUID

    has_many :listings, Listing
    has_many :class_tickets, through: [:listings, :tickets]
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Class{} = class, attrs) do
    class
    |> cast(attrs, [:type, :title, :description, :prerequisite_id, :slug, :menu_order, :image_url])
    |> cast_assoc(:prerequisite)
    |> validate_required([:type, :title])
  end

  def get_class!(id), do: Repo.get!(Class, id)
end
