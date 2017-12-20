defmodule TicketAgent.Repo.Migrations.CreateTicketAgent.UserCredential do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE user_credential_provider AS ENUM ('facebook', 'google', 'linkedin', 'twitter', 'microsoft', 'amazon')"

    create table(:user_credentials, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id), null: false
      add :provider, :user_credential_provider, null: false
      add :token, :text, null: false
      add :secret, :text, null: true
      add :extra_details, :map
      timestamps(type: :timestamptz)
    end

    create index(:user_credentials, [:user_id])
    create index(:user_credentials, [:provider])
  end
end
