defmodule TicketAgent.Repo.Migrations.CreateTicketRegistrations do
  use Ecto.Migration

  def change do
    create table(:ticket_registrations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :last_name, :string
      add :email, :string

      add :ticket_id, references(:tickets, on_delete: :delete_all, type: :binary_id), null: false
      timestamps()
    end

  end
end
