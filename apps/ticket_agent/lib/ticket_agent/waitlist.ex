defmodule TicketAgent.Waitlist do
  use TicketAgent.Schema

  @required ~w(listing_id name email_address)a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "waitlists" do
    belongs_to :listing, Listing, references: :id, foreign_key: :listing_id, type: Ecto.UUID
    field :name, :string
    field :email_address, :string
    field :message_sent_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Waitlist{} = waitlist, attrs) do
    waitlist
    |> cast(attrs, @required ++ [:message_sent_at])
    |> validate_required(@required)
  end
end
