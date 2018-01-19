defmodule TicketAgent.Repo.Migrations.CreateEventTag do
  use Ecto.Migration

  def change do
    create table(:event_tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :event_id, references(:events, on_delete: :nothing, type: :binary_id), null: false
      add :tag, :text, null: false
      timestamps(type: :timestamptz)
    end
  end
end
