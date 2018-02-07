defmodule TicketAgent.Repo.Migrations.CreateCoherenceUser do
  use Ecto.Migration
  def change do
    execute "CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;"
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\" WITH SCHEMA public;"
  end
end
