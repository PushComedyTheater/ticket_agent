defmodule TicketAgent.Repo.Migrations.CreateWaitlists do
  use Ecto.Migration

  def change do
    create table(:waitlists, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :listing_id, references(:listings, on_delete: :nothing, type: :binary_id), null: false
      add :class_id, references(:classes, on_delete: :nothing, type: :binary_id), null: false
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id), null: true
      add :name, :string
      add :email_address, :string
      add :admin_notified, :boolean
      add :message_sent_at, :timestamptz, null: true
      timestamps(type: :timestamptz)
    end
    create index(:waitlists, [:user_id])
    create index(:waitlists, [:email_address])
    create index(:waitlists, [:listing_id])
    create index(:waitlists, [:class_id])
    create index(:waitlists, [:admin_notified])
    create unique_index(:waitlists, [:listing_id, :email_address], name: :waitlists_listing_id_email_address_index)
    create unique_index(:waitlists, [:listing_id, :user_id], name: :waitlists_listing_id_user_id_index)
    create unique_index(:waitlists, [:class_id, :email_address], name: :waitlists_class_id_email_address_index)
    create unique_index(:waitlists, [:class_id, :user_id], name: :waitlists_class_id_user_id_index)    
  end
end
