defmodule TicketAgent.Repo.Migrations.CreateCreditCards do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE credit_card_type AS ENUM ('Visa', 'American Express', 'MasterCard', 'Discover', 'JCB', 'Diners Club', 'Unknown');"

    create table(:credit_cards, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :order_id, references(:orders, on_delete: :nothing, type: :binary_id)
      
      add :type, :credit_card_type
      add :stripe_id, :text

      add :name, :text
      add :line_1_check, :text
      add :zip_check, :text
      add :cvc_check, :text

      add :exp_month, :integer
      add :exp_year, :integer
      add :fingerprint, :text
      add :funding, :text
      add :last_4, :text

      add :address, :map
      add :metadata, :map

      timestamps()
    end

    create index(:credit_cards, [:user_id])
    create index(:credit_cards, [:order_id])
    create index(:credit_cards, [:type])

  end
end
