defmodule TicketAgent.ListingTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias TicketAgent.ListingTag

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "listing_tags" do
    belongs_to :listing, Listing
    field :tag, :string
    timestamps()
  end

end
