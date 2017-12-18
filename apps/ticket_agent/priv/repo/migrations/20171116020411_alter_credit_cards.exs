defmodule TicketAgent.Repo.Migrations.AlterCreditCards do
  use Ecto.Migration

  def change do
    alter table(:credit_cards) do
      add :order_id, references(:orders, on_delete: :nothing, type: :binary_id)
    end
    create index(:credit_cards, [:order_id])
  end
end
