defmodule TicketAgent.Listing do
  @moduledoc false
  import Ecto.Query
  use TicketAgent.Schema

  @required ~w(type slug title description status start_time end_time)a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "listings" do
    belongs_to :account, Account
    belongs_to :user, User
    belongs_to :class, Class
    has_many :images, ListingImage
    has_many :listing_tags, ListingTag
    has_many :tickets, Ticket
    field :type, :string
    field :slug, :string
    field :title, :string
    field :description, :string
    field :status, :string
    field :start_time, :naive_datetime
    field :end_time, :naive_datetime
    timestamps()
  end

  def changeset(%Listing{} = listing, attr \\ %{}) do
    listing
    |> cast(attr, @required)
    |> validate_required(@required)
    |> validate_inclusion(:type, ~w(class show workshop))
    |> validate_inclusion(:status, ~w(unpublished active canceled deleted))
    |> assoc_constraint(:account)
    |> assoc_constraint(:user)
    |> unique_constraint(:slug)
  end

  def generate_slug() do
    # credo:disable-for-lines:3
    :crypto.strong_rand_bytes(6)
    |> Base.encode16(case: :lower)
  end

  def from_class(current_user, %Class{} = class) do
    cover_image = %ListingImage{url: class.cover_photo_url, type: "cover"}
    social_image = %ListingImage{url: class.social_photo_url, type: "social"}

    %Listing{images: [cover_image, social_image]}
    |> changeset(%{
      type: "class",
      slug: generate_slug(),
      account_id: current_user.account_id,
      user_id: current_user.id,
      title: class.title,
      description: class.description,
      status: "unpublished",
      start_time: NaiveDateTime.utc_now(),
      end_time: NaiveDateTime.utc_now(),
    })
  end

  def upcoming_shows do
    date = NaiveDateTime.utc_now()
    query = from l in Listing,
            where: fragment("? >= NOW()", l.start_time),
            where: l.type == "show",
            order_by: [asc: :start_time],
            preload: [:images, :listing_tags, :tickets],
            select: l
    Repo.all(query)
  end

  def current_classes do
    date = NaiveDateTime.utc_now()
    query = from l in Listing,
            where: l.end_time >= ^date,
            where: l.type == "class",
            order_by: [desc: :title],
            preload: [:images],
            select: l

    Repo.all(query)
  end

  def slugified_title(title) do
    title
      |> String.downcase
      |> String.replace(~r/[^a-z0-9\s-]/, "")
      |> String.replace(~r/(\s|-)+/, "-")
  end

  def available_tickets(show) do
    query = from t in Ticket,
            where: t.listing_id == ^show.id,
            where: t.status == "available",
            where: fragment("? < NOW()", t.sale_start),
            select: t
    Repo.all(query)
  end

  def ticket_cost(show) do
    Enum.at(show.tickets, 0).price / 100
    # query = from t in Ticket,
    #         where: t.listing_id == ^show.id,
    #         where: t.status == "available",
    #         where: fragment("? < NOW()", t.sale_start),
    #         order_by: [asc: :price],
    #         limit: 1,
    #         select: t
    # price = Repo.one(query)
    #         |> Map.get(:price)
    # price / 100
  end

  defimpl Phoenix.Param, for: TicketAgent.Listing do
    def to_param(%{slug: slug, title: title}) do
      "#{slug}-#{TicketAgent.Listing.slugified_title(title)}"
    end
  end
end
