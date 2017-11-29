defmodule TicketAgent.Repo.Migrations.CreateTicketAgent.Listing do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE listing_status AS ENUM ('unpublished', 'active', 'canceled', 'deleted')"

    create table(:listings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :slug, :text, null: false
      add :title, :text, null: false
      add :description, :text, null: false
      add :status, :listing_status, default: "unpublished"
      add :start_at, :naive_datetime, default: fragment("now()")
      add :end_at, :naive_datetime, default: fragment("now()")

      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :event_id, references(:events, on_delete: :nothing, type: :binary_id)
      add :class_id, references(:classes, on_delete: :nothing, type: :binary_id)
      timestamps()
    end

    create index(:listings, [:user_id])
    create index(:listings, [:event_id])
    create index(:listings, [:class_id])

    create index(:listings, [:start_at])
    create index(:listings, [:end_at])

    create unique_index(:listings, [:slug])
  end
end
