defmodule TicketAgent.Repo.Migrations.CreateTicketAgent.Listing do
  use Ecto.Migration

  def change do
    execute(
      "CREATE TYPE listing_status AS ENUM ('unpublished', 'active', 'completed', 'canceled', 'deleted')"
    )

    execute("CREATE TYPE listing_type AS ENUM ('class', 'show', 'camp')")

    create table(:listings, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:slug, :text, null: false)
      add(:title, :text, null: false)
      add(:description, :text, null: false)
      add(:status, :listing_status, default: "unpublished")
      add(:type, :listing_type, default: "show")
      add(:start_at, :timestamptz, default: fragment("now()"))
      add(:end_at, :timestamptz, null: true)
      add(:user_id, references(:users, on_delete: :nothing, type: :binary_id))
      add(:event_id, references(:events, on_delete: :nothing, type: :binary_id))
      add(:class_id, references(:classes, on_delete: :nothing, type: :binary_id))

      add(:pass_fees_to_buyer, :boolean, default: true)

      timestamps(type: :timestamptz)
    end

    create(unique_index(:listings, [:slug]))

    create(index(:listings, [:user_id]))
    create(index(:listings, [:event_id]))
    create(index(:listings, [:class_id]))

    create(index(:listings, [:start_at]))
    create(index(:listings, [:end_at]))
  end
end
