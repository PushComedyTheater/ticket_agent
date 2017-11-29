defmodule TicketAgent.TicketRegistration do
  use TicketAgent.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "ticket_registrations" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    belongs_to :ticket, Ticket, references: :id, foreign_key: :ticket_id, type: Ecto.UUID
    timestamps()
  end

  @doc false
  def changeset(%TicketRegistration{} = ticket_registration, attrs) do
    ticket_registration
    |> cast(attrs, [:first_name, :last_name, :email])
    |> validate_required([:first_name, :last_name, :email])
  end
end
