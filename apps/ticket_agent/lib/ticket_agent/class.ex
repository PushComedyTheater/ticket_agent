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
    field :photo_url, :string

    belongs_to :account, Account, references: :id, foreign_key: :account_id, type: Ecto.UUID
    belongs_to :prerequisite, Class, references: :id, foreign_key: :prerequisite_id, type: Ecto.UUID

    has_many :listings, Listing
    has_many :class_tickets, through: [:listings, :tickets]
    timestamps()
  end

  @doc false
  def changeset(%Class{} = class, attrs) do
    class
    |> cast(attrs, [:type, :title, :description, :prerequisite_id, :slug, :menu_order, :photo_url])
    |> cast_assoc(:prerequisite)
    |> validate_required([:type, :title])
  end

  def currently_offered?(%Class{id: class_id} = class) do
    date = NaiveDateTime.utc_now()
    # query = from l in Listing,
    #         where: fragment("? >= NOW()", l.start_at),
    #         where: l.type == "class",
    #         where: l.class_id == ^class_id,
    #         order_by: [asc: :start_at],
    #         select: l.id

    query = from e in Event,
            where: e.type == "class",
            where: e.class_id == ^class_id,
            select: e.id

    Repo.aggregate(query, :count, :id) > 0
  end
end
