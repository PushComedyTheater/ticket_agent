defmodule TicketAgent.EventTag do
  use TicketAgent.Schema
  
  @required ~w(tag event_id)a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "event_tags" do
    belongs_to :event, Event, references: :id, foreign_key: :event_id, type: Ecto.UUID
    field :tag, :string
    timestamps(type: :utc_datetime)
  end

  def changeset(%EventTag{} = event_tag, attr \\ %{}) do
    event_tag
    |> cast(attr, @required)
    |> assoc_constraint(:event)
    |> validate_required(@required)
  end  

end
