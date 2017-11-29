defmodule TicketAgent.Repo.Migrations.CreateTicketAgent.ListingImage do
  use Ecto.Migration

  def change do
  	execute "CREATE TYPE listing_image_type AS ENUM ('cover', 'social', 'additional')"
    
    create table(:listing_images, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :listing_id, references(:listings, on_delete: :nothing, type: :binary_id), null: false
      add :url, :text, null: false
      add :type, :listing_image_type, null: false
      timestamps()
    end

    create index(:listing_images, [:listing_id])
  end
end
