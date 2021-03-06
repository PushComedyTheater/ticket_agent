defmodule Repo.Migrations.AddVersions do
  use Ecto.Migration

  def change do
    create table(:versions) do
      add :event,        :string, null: false, size: 10
      add :item_type,    :string, null: false
      add :item_id,      :uuid
      add :item_changes, :map, null: false
      add :originator_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :origin,       :string, size: 50
      add :meta,         :map
      timestamps(type: :timestamptz, default: fragment("clock_timestamp()"))
    end

    create index(:versions, [:originator_id])
    create index(:versions, [:item_id, :item_type])
    # Uncomment if you want to add the following indexes to speed up special queries:
    create index(:versions, [:event, :item_type])
    create index(:versions, [:item_type, :inserted_at])
  end
end
