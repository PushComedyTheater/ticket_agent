defmodule TicketAgent.ListingTag do
  use TicketAgent.Schema
  
  @required ~w(tag listing_id)a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "listing_tags" do
    belongs_to :listing, Listing, references: :id, foreign_key: :listing_id, type: Ecto.UUID
    field :tag, :string
    timestamps(type: :utc_datetime)
  end

  def changeset(%ListingTag{} = listing_tag, attr \\ %{}) do
    listing_tag
    |> cast(attr, @required)
    |> assoc_constraint(:listing)
    |> validate_required(@required)
  end  

end
