defmodule TicketAgent.Repo.Migrations.CreateTeachers do
  use Ecto.Migration

  def change do
    create table(:teachers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :slug, :string
      add :name, :string
      add :email, :string
      add :biography, :text
      add :social, :map

      timestamps()
    end

  end
end
