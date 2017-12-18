defmodule TicketAgent.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE order_status AS ENUM ('started', 'processing', 'completed', 'failed', 'errored', 'cancelled')"

    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :credit_card_id, references(:credit_cards, on_delete: :nothing, type: :binary_id)
      add :slug, :text, null: false
      add :status, :order_status, default: "started"
      add :subtotal, :integer, null: false
      add :credit_card_fee, :integer, default: 0
      add :processing_fee, :integer, default: 0
      add :total_price, :integer, default: 0
      add :completed_at, :timestamptz, default: nil
      timestamps(type: :timestamptz)
    end

    create unique_index(:orders, [:slug])
    create index(:orders, [:user_id])
    create index(:orders, [:credit_card_id])
    create index(:orders, [:status])
  end
end
