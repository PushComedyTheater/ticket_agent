defmodule TicketAgent.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE order_status AS ENUM ('started', 'completed', 'failed', 'errored', 'cancelled')"
    
    create table(:orders, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :slug, :text, null: false
      add :name, :text, null: false
      add :email_address, :text, null: false
      add :status, :order_status, default: "started"
      add :total_price, :integer, null: false
      timestamps()
    end

    create unique_index(:orders, [:slug])

  end
end
