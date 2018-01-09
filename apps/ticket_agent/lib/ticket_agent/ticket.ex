defmodule TicketAgent.Ticket do
  @moduledoc false
  use TicketAgent.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "tickets" do
    belongs_to :listing, Listing, references: :id, foreign_key: :listing_id, type: Ecto.UUID
    belongs_to :order, Order, references: :id, foreign_key: :order_id, type: Ecto.UUID
    belongs_to :concierge, User, references: :id, foreign_key: :checked_in_by, type: Ecto.UUID
    field :slug, :string
    field :name, :string
    field :status, :string
    field :description, :string
    field :price, :integer
    field :guest_name, :string
    field :guest_email, :string
    field :sale_start, :utc_datetime
    field :sale_end, :utc_datetime
    field :locked_until, :utc_datetime
    field :purchased_at, :utc_datetime
    field :emailed_at, :utc_datetime
    field :checked_in_at, :utc_datetime
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Ticket{} = ticket, attrs) do
    ticket
    |> cast(attrs, [])
    |> validate_required([])
  end
end
