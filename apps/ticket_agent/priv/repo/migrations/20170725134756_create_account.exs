defmodule TicketAgent.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :text
      add :description, :text
      add :url, :text
      add :enabled, :boolean
      add :logo, :text
      add :creator_id, references(:users, type: :binary_id)
      timestamps(type: :timestamptz)
    end
    create unique_index(:accounts, [:name])
  end
end
