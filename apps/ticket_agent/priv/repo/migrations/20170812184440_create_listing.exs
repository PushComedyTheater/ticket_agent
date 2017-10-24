defmodule TicketAgent.Repo.Migrations.CreateTicketAgent.Listing do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE listing_status AS ENUM ('unpublished', 'active', 'canceled', 'deleted')"
    execute "CREATE TYPE listing_type AS ENUM ('class', 'show', 'workshop')"
    create table(:listings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :account_id, references(:accounts, on_delete: :nothing, type: :binary_id)
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :class_id, references(:classes, type: :binary_id), null: true
      add :type, :listing_type, null: false
      add :slug, :text, null: false
      add :title, :text, null: false
      add :description, :text, null: false
      add :status, :listing_status, default: "unpublished"
      add :start_time, :naive_datetime, default: fragment("now()")
      add :end_time, :naive_datetime, default: fragment("now()")
      timestamps()
    end

    create index(:listings, [:account_id])
    create index(:listings, [:user_id])
    create index(:listings, [:class_id])
    create unique_index(:listings, [:slug])
  end
end
