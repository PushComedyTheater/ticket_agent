defmodule TicketAgent.Waitlist do
  use TicketAgent.Schema

  @required ~w(name email_address)a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "waitlists" do
    belongs_to :class, Class, references: :id, foreign_key: :class_id, type: Ecto.UUID
    belongs_to :listing, Listing, references: :id, foreign_key: :listing_id, type: Ecto.UUID
    belongs_to :user, User, references: :id, foreign_key: :user_id, type: Ecto.UUID
    field :name, :string
    field :email_address, :string
    field :message_sent_at, :utc_datetime
    field :admin_notified, :boolean

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Waitlist{} = waitlist, attrs) do
    waitlist
    |> cast(attrs, @required ++ [:message_sent_at, :user_id, :admin_notified])
    |> validate_required(@required)
    |> unique_constraint(:email_address_and_listing_id, name: :waitlists_listing_id_email_address_index)
    |> unique_constraint(:user_id_and_listing_id, name: :waitlists_listing_id_user_id_index)
    |> unique_constraint(:email_address_and_class_id, name: :waitlists_class_id_email_address_index)
    |> unique_constraint(:user_id_and_class_id, name: :waitlists_class_id_user_id_index)    
  end
end
