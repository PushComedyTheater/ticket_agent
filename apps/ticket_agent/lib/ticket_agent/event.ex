defmodule TicketAgent.Event do
  @derive {Phoenix.Param, key: :slug}
  use TicketAgent.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "events" do
    field :slug, :string
    field :title, :string
    field :description, :string
    field :status, :string

    belongs_to :account, Account, references: :id, foreign_key: :account_id, type: Ecto.UUID
    belongs_to :user, User, references: :id, foreign_key: :user_id, type: Ecto.UUID

    has_many :listings, Listing

    has_many :event_tickets, through: [:listings, :tickets]

    timestamps()
  end

  @doc false
  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [:slug, :title, :description, :status])
    |> cast_assoc(:account)
    |> cast_assoc(:user)
  end  

  def upcoming_events do
    date = NaiveDateTime.utc_now()
    query = from l in Listing,
            where: fragment("? >= NOW()", l.start_at),
            order_by: [asc: :start_at],
            preload: [:images, :listing_tags, :tickets],
            select: l
    Repo.all(query)
  end
end
