defmodule TicketAgent.Repo.Migrations.CreateListingTag do
  use Ecto.Migration

  def change do
    create table(:listing_tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :listing_id, references(:listings, on_delete: :nothing, type: :binary_id), null: false
      add :tag, :text, null: false
      timestamps(type: :timestamptz)
    end
  end
end
