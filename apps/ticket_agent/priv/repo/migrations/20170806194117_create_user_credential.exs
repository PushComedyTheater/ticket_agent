defmodule TicketAgent.Repo.Migrations.CreateTicketAgent.UserCredential do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE user_credential_provider AS ENUM ('facebook', 'google', 'twitter')"

    create table(:user_credentials, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id), null: false
      add :provider, :user_credential_provider, null: false
      add :token, :text, null: false
      add :secret, :text, null: true

      timestamps()
    end

  end
end
