defmodule TicketAgent.Repo.Migrations.CreateUserStorages do
  use Ecto.Migration

  def change do
    create table(:user_storages, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:user_id, references(:users, on_delete: :nothing, type: :binary_id), null: true)
      add(:details, :map)
      timestamps(type: :timestamptz, default: fragment("clock_timestamp()"))
    end

    create(unique_index(:user_storages, [:user_id]))
  end
end
