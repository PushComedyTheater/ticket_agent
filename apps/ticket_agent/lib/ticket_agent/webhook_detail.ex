defmodule TicketAgent.WebhookDetail do
  @moduledoc false
  use TicketAgent.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "webhook_details" do
    field :request, :map
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%WebhookDetail{} = webhook_detail, attrs) do
    webhook_detail
    |> cast(attrs, [:request])
  end
end
