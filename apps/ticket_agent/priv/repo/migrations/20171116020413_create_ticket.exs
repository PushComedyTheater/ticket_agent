defmodule TicketAgent.Repo.Migrations.CreateTicketAgent.Ticket do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE ticket_status AS ENUM ('available', 'locked', 'purchased')"

    create table(:tickets, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :listing_id, references(:listings, on_delete: :delete_all, type: :binary_id), null: false
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id), null: true

      add :name, :text, null: false
      add :status, :ticket_status, default: "available"
      add :description, :text, null: true
      add :price, :integer, null: false
      
      add :sale_start, :naive_datetime, null: true
      add :sale_end, :naive_datetime, null: true

      add :locked_until, :naive_datetime, null: true

      timestamps()
    end
  end
end
