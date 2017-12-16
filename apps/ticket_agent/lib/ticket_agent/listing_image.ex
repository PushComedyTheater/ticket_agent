defmodule TicketAgent.ListingImage do
  use TicketAgent.Schema

  @required ~w(url listing_id)a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "listing_images" do
    belongs_to :listing, Listing, references: :id, foreign_key: :listing_id, type: Ecto.UUID
    field :url, :string
    timestamps(type: :utc_datetime)
  end

  def changeset(%ListingImage{} = listing_image, attr \\ %{}) do
    listing_image
    |> cast(attr, @required)
    |> assoc_constraint(:listing)
    |> validate_required(@required)
  end

  def public_id(%ListingImage{url: url}) do
    Regex.run(~r/.*\/(.*)\..*$/, url)
    |> tl
    |> to_string
  end
end
