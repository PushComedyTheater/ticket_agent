defmodule TicketAgent.Ticket do
  @moduledoc false
  use TicketAgent.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "tickets" do
    belongs_to :listing, Listing, references: :id, foreign_key: :listing_id, type: Ecto.UUID
    field :slug, :string
    field :name, :string
    field :status, :string
    field :description, :string
    field :price, :integer
    field :sale_start, :naive_datetime
    field :sale_end, :naive_datetime
    field :locked_until, :naive_datetime
    timestamps()
  end

  @doc false
  def changeset(%Ticket{} = ticket, attrs) do
    ticket
    |> cast(attrs, [])
    |> validate_required([])
  end
end
