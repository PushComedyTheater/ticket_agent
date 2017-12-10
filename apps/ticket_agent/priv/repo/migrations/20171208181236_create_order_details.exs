defmodule TicketAgent.Repo.Migrations.CreateOrderDetails do
  use Ecto.Migration

  def change do
    create table(:order_details, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :order_id, references(:orders, on_delete: :nothing, type: :binary_id)      

      # stripe specific
      add :charge_id, :text
      add :balance_transaction, :text
      add :client_ip, :text
      add :status, :text
      add :failure_code, :text
      add :failure_message, :text
      add :amount, :text
      add :network_status, :text
      add :risk_level, :text

      add :response, :map

      timestamps()
    end

    create index(:order_details, [:order_id])
    create index(:order_details, [:charge_id])
    create index(:order_details, [:status])    

  end
end
