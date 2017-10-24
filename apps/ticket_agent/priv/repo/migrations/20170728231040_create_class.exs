defmodule TicketAgent.Repo.Migrations.CreateTicketAgent.Class do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE class_type AS ENUM ('improvisation', 'sketch', 'standup', 'acting');"

    create table(:classes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :class_type, null: false
      add :title, :text, null: false
      add :slug, :text, null: false
      add :description, :text, null: false
      add :menu_order, :integer
      add :prerequisite_id, references(:classes, type: :binary_id)
      add :cover_photo_url, :text
      add :social_photo_url, :text
      timestamps()
    end
    create unique_index(:classes, [:slug])
  end
end
