defmodule TicketAgent.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE event_status AS ENUM ('hidden', 'normal')"

    create table(:events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :slug, :text, null: false
      add :title, :string, null: false
      add :description, :text, null: false
      add :status, :event_status, default: "normal"

      add :account_id, references(:accounts, on_delete: :nothing, type: :binary_id)
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:events, [:account_id])
    create index(:events, [:user_id])
    create unique_index(:events, [:slug])
  end
end
