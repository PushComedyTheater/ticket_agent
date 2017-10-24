defmodule TicketAgent.ListingImage do
  @moduledoc false
  use TicketAgent.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "listing_images" do
    belongs_to :listing, Listing, references: :id, foreign_key: :listing_id, type: Ecto.UUID
    field :url, :string
    field :type, :string
    timestamps()
  end

  def public_id(%ListingImage{url: url}) do
    Regex.run(~r/.*\/(.*)\..*$/, url)
    |> tl
    |> to_string
  end
end
