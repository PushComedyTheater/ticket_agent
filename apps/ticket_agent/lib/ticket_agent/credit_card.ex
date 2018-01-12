defmodule TicketAgent.CreditCard do
  use TicketAgent.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @fields ~w(user_id stripe_id type name line_1_check
             zip_check cvc_check exp_month exp_year funding last_4 address metadata)a

  schema "credit_cards" do
    belongs_to :user, User, references: :id, foreign_key: :user_id, type: Ecto.UUID
    field :stripe_id, :string
    field :type, :string
   
    field :name, :string
    field :line_1_check, :string
    field :zip_check, :string
    field :cvc_check, :string
    field :exp_month, :integer
    field :exp_year, :integer
    field :fingerprint, :string
    field :funding, :string
    field :last_4, :string

    field :address, :map
    field :metadata, :map

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%CreditCard{} = credit_card, attrs) do
    credit_card
    |> cast(attrs, @fields)
    
  end
end
