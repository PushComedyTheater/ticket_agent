defmodule TicketAgent.Order do
  @moduledoc false
  @derive {Phoenix.Param, key: :slug}
  use TicketAgent.Schema

  @required ~w(slug status total_price user_id)a
  @fields ~w(subtotal credit_card_fee processing_fee credit_card_id)a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "orders" do
    belongs_to :user, User, references: :id, foreign_key: :user_id, type: Ecto.UUID
    belongs_to :credit_card, CreditCard, references: :id, foreign_key: :credit_card_id, type: Ecto.UUID
    has_many :tickets, Ticket
    has_many :details, OrderDetail
    has_one :listing, through: [:tickets, :listing]
    field :slug, :string
    field :status, :string
    field :subtotal, :integer
    field :credit_card_fee, :integer
    field :processing_fee, :integer
    field :total_price, :integer
    field :started_at, :utc_datetime
    field :processing_at, :utc_datetime
    field :completed_at, :utc_datetime
    field :emailed_at, :utc_datetime
    field :errored_at, :utc_datetime
    field :cancelled_at, :utc_datetime
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Order{} = order, attrs) do
    order
    |> cast(attrs, @required ++ @fields)
    |> validate_required(@required)
  end

  def list_orders(params) do
    Order
    |> order_by([:status, :inserted_at])
    |> preload([:user, :credit_card])
    |> Repo.paginate(params)
  end

  def get_order!(id), do: Repo.get!(Order, id)
  def get_by_slug!(slug) do
    Order
    |> Repo.get_by!([slug: slug])
    |> Repo.preload([:user, :credit_card, :tickets])
  end

  def update_order(%Order{} = order, attrs, originator) do
    order
    |> Order.changeset(attrs)
    |> PaperTrail.update(originator: originator)
  end

  def change_user(%Order{} = order) do
    Order.changeset(order, %{})
  end

  def additional_ticket_emails(%Order{} = order) do
    order = case Ecto.assoc_loaded?(order.tickets) do
      true -> order
      false -> Repo.preload(order, :tickets)
    end
    order = case Ecto.assoc_loaded?(order.user) do
      true -> order
      false -> Repo.preload(order, :user)
    end

    order.tickets
    |> Enum.filter(fn(ticket) ->
      ticket.status == "purchased" &&
      ticket.guest_email != order.user.email
    end)
    |> Enum.map(fn(ticket) ->
      {ticket.id, ticket.guest_name, ticket.guest_email}
    end)
  end
end
