defmodule TicketAgent.Repo.Migrations.CreateWebhookDetails do
  use Ecto.Migration

  def change do
    create table(:webhook_details, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :source, :text, null: true
      add :request, :map
      timestamps(type: :timestamptz)
    end
    create index(:webhook_details, [:source])
  end
end
