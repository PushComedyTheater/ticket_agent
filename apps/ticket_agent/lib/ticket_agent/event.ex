defmodule TicketAgent.Event do
  @derive {Phoenix.Param, key: :slug}
  use TicketAgent.Schema

  @derive {Phoenix.Param, key: :slug}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "events" do
    field :slug, :string
    field :title, :string
    field :description, :string
    field :status, :string
    field :image_url, :string

    belongs_to :account, Account, references: :id, foreign_key: :account_id, type: Ecto.UUID
    belongs_to :user, User, references: :id, foreign_key: :user_id, type: Ecto.UUID

    has_many :listings, Listing

    has_many :event_tickets, through: [:listings, :tickets]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [:slug, :title, :description, :status])
    |> cast_assoc(:account)
    |> cast_assoc(:user)
  end  

  defimpl Phoenix.Param, for: TicketAgent.Event do
    def to_param(%{slug: slug, title: title}) do
      "#{slug}-#{TicketAgent.Event.slugified_title(title)}"
    end
  end

  def slugified_title(title) do
    title
      |> String.downcase
      |> String.replace(~r/[^a-z0-9\s-]/, "")
      |> String.replace(~r/(\s|-)+/, "-")
  end  
end
