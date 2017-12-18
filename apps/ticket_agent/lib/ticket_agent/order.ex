defmodule TicketAgent.Order do
  @moduledoc false
  @derive {Phoenix.Param, key: :slug}
  use TicketAgent.Schema

  @required ~w(slug status total_price user_id)a
  @fields ~w(subtotal credit_card_fee processing_fee)a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "orders" do
    belongs_to :user, User, references: :id, foreign_key: :user_id, type: Ecto.UUID
    has_one :credit_card, CreditCard
    has_many :tickets, Ticket
    has_one :listing, through: [:tickets, :listing]
    field :slug, :string
    field :status, :string
    field :subtotal, :integer
    field :credit_card_fee, :integer
    field :processing_fee, :integer
    field :total_price, :integer
    field :completed_at, :utc_datetime
    timestamps
  end

  @doc false
  def changeset(%Order{} = order, attrs) do
    order
    |> cast(attrs, @required ++ @fields)
    |> validate_required(@required)
  end

  def listing_image(order, width \\ 1050) do
    ticket = Enum.at(order.tickets, 0)

    listing =
      ticket.listing
      |> TicketAgent.Repo.preload(:images)

    image =
      listing.images
      |> hd

    public_id =
      image.url
      |> String.split("/")
      |> List.last()
      |> String.split(".")
      |> List.first()

    Cloudinex.Url.for(public_id, %{
      width: width,
      height: 400,
      gravity: "north",
      crop: "fill",
      flags: 'progressive'
    })
  end

  #
  # window.totalAsking = function(amount, percent, fixedfee) {
  #     var totalAsks = amount + window.totalFees(amount, percent, fixedfee);
  #     if(amount <= 0 || totalAsks < 0) {
  #       totalAsks = 0;
  #     }
  #     return totalAsks;
  # };

end
