defmodule TicketAgent.Repo.Migrations.CreateWaitlists do
  use Ecto.Migration

  def change do
    create table(:waitlists, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :listing_id, references(:listings, on_delete: :nothing, type: :binary_id), null: false
      add :name, :string
      add :email_address, :string
      add :message_sent_at, :timestamptz, null: true
      timestamps()
    end

  end
end
