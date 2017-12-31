defmodule TicketAgent.Repo.Migrations.CreateTicketAgent.ListingImage do
  use Ecto.Migration

  def change do
    create table(:listing_images, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :listing_id, references(:listings, on_delete: :nothing, type: :binary_id), null: false
      add :url, :text, null: false
      timestamps(type: :timestamptz)
    end

    create index(:listing_images, [:listing_id])
  end
end