defmodule TicketAgent.Repo.Migrations.CreateTicketRegistrations do
  use Ecto.Migration

  def change do
    create table(:ticket_registrations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :last_name, :string
      add :email, :string

      timestamps()
    end

  end
end
