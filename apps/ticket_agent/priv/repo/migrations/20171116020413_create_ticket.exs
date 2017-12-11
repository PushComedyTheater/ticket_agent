defmodule TicketAgent.Repo.Migrations.CreateTicketAgent.Ticket do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE ticket_status AS ENUM ('available', 'locked', 'purchased', 'processing')"

    create table(:tickets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :slug, :text, null: false

      add :listing_id, references(:listings, on_delete: :delete_all, type: :binary_id), null: false
      add :order_id, references(:orders, on_delete: :nothing, type: :binary_id), null: true

      add :name, :text, null: false
      add :status, :ticket_status, default: "available"
      add :description, :text, null: true
      add :price, :integer, null: false

      add :guest_name, :text, null: true
      add :guest_email, :text, null: true
      
      add :sale_start, :naive_datetime, null: true
      add :sale_end, :naive_datetime, null: true

      add :locked_until, :naive_datetime, null: true

      timestamps()
    end

    create unique_index(:tickets, [:slug])
    create index(:tickets, [:listing_id])
    create index(:tickets, [:order_id])
    create index(:tickets, [:status])
    create index(:tickets, [:locked_until])

    execute "CREATE INDEX available_tickets ON tickets (listing_id, sale_start) WHERE (status IN ('available') AND locked_until IS NULL)"      
    execute "CREATE INDEX index_locked_tickets_by_locked_until ON tickets (locked_until ASC) WHERE (status IN ('locked'))"      
  end
end