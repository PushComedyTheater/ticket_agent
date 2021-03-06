defmodule TicketAgent.Repo.Migrations.AddAccountToUsers do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE user_role AS ENUM ('admin', 'concierge', 'customer', 'oauth_customer', 'guest')"

    alter table(:users) do
      add :account_id, references(:accounts, on_delete: :nothing, type: :binary_id)
      add :role, :user_role, default: "customer"
    end
  end
end
