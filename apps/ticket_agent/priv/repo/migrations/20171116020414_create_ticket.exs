defmodule TicketAgent.Repo.Migrations.CreateTicketAgent.Ticket do
  use Ecto.Migration

  def change do
    execute(
      "CREATE TYPE ticket_status AS ENUM ('available', 'locked', 'processing', 'purchased', 'emailed', 'checkedin')"
    )

    create table(:tickets, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:slug, :text, null: false)

      add(:listing_id, references(:listings, on_delete: :delete_all, type: :binary_id),
        null: false
      )

      add(:order_id, references(:orders, on_delete: :nothing, type: :binary_id), null: true)

      add(:name, :text, null: false)
      add(:group, :text, null: false)
      add(:status, :ticket_status, default: "available")
      add(:description, :text, null: true)
      add(:price, :integer, null: false)

      add(:guest_name, :text, null: true)
      add(:guest_email, :text, null: true)

      add(:sale_start, :timestamptz, null: true)
      add(:sale_end, :timestamptz, null: true)

      add(:locked_until, :timestamptz, null: true)
      add(:purchased_at, :timestamptz, null: true)
      add(:emailed_at, :timestamptz, null: true)
      add(:checked_in_at, :timestamptz, null: true)
      add(:checked_in_by, references(:users, on_delete: :nothing, type: :binary_id), null: true)
      timestamps(type: :timestamptz)
    end

    create(unique_index(:tickets, [:slug]))
    create(index(:tickets, [:listing_id]))
    create(index(:tickets, [:order_id]))
    create(index(:tickets, [:group]))
    create(index(:tickets, [:status]))
    create(index(:tickets, [:locked_until]))

    execute(
      "CREATE INDEX available_tickets ON tickets (listing_id, sale_start) WHERE (status IN ('available') AND locked_until IS NULL)"
    )

    execute(
      "CREATE INDEX index_locked_tickets_by_locked_until ON tickets (locked_until ASC) WHERE (status IN ('locked'))"
    )
  end
end
