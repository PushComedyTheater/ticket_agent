defmodule TicketAgent.Listing do
  use TicketAgent.Schema

  @required ~w(slug title description status start_at end_at)a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "listings" do
    belongs_to :user, User, references: :id, foreign_key: :user_id, type: Ecto.UUID
    belongs_to :event, Event, references: :id, foreign_key: :event_id, type: Ecto.UUID
    belongs_to :class, Class, references: :id, foreign_key: :class_id, type: Ecto.UUID

    has_many :images, ListingImage
    has_many :tickets, Ticket
    has_many :listing_tags, ListingTag

    field :slug, :string
    field :title, :string
    field :description, :string
    field :status, :string
    field :start_at, :naive_datetime
    field :end_at, :naive_datetime
    timestamps()
  end

  def changeset(%Listing{} = listing, attr \\ %{}) do
    listing
    |> cast(attr, @required)
    |> validate_required(@required)
    |> validate_inclusion(:status, ~w(unpublished active canceled deleted))
    |> cast_assoc(:event)
    |> cast_assoc(:user)
    |> unique_constraint(:slug)
  end

  def from_class(current_user, %Class{} = class) do
    listing_image = %ListingImage{url: class.photo_url}

    %Listing{images: [listing_image]}
    |> changeset(%{
      type: "class",
      slug: Random.generate_slug(),
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
    query = from l in Listing,
            where: fragment("? >= NOW()", l.start_at),
            where: not is_nil(l.event_id),
            order_by: [asc: :start_at],
            preload: [:event, :images, :listing_tags],
            select: l
    Repo.all(query)
  end

  def upcoming_classes do
    query = from [listings, tickets] in listings_with_ticket_count(),
            where: fragment("? >= NOW()", listings.start_at),
            where: not is_nil(listings.class_id),
            order_by: [asc: :start_at],
            preload: [:images],
            select: [listings, tickets.count]

    Repo.all(query)
  end

  def listing_with_ticket_count(slug) do
    query = from listing in Listing,
            join: tickets in fragment("(SELECT count(*) as count, listing_id FROM tickets WHERE status = 'available' AND locked_until IS NULL AND sale_start <= NOW() GROUP BY listing_id)"),
            on: listing.id == tickets.listing_id,
            where: listing.slug == ^slug,
            preload: [:images, :tickets, :listing_tags],
            select: [listing, tickets.count]

    Repo.one(query)
  end

  def listing_image(show, width \\ 1050) do
    social_image =
      show.images
      |> hd

    public_id =
      social_image.url
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

  def listings_with_ticket_count do
    from listing in Listing,
    join: tickets in fragment("(SELECT count(*) as count, listing_id FROM tickets WHERE status = 'available' AND locked_until IS NULL AND sale_start <= NOW() GROUP BY listing_id)"),
    on: listing.id == tickets.listing_id
  end

  def slugified_title(title) do
    title
      |> String.downcase
      |> String.replace(~r/[^a-z0-9\s-]/, "")
      |> String.replace(~r/(\s|-)+/, "-")
  end

  def available_ticket_count(show) do
    query = from t in Ticket,
            where: t.listing_id == ^show.id,
            where: t.status == "available",
            where: is_nil(t.locked_until),
            where: fragment("? <= NOW()", t.sale_start),
            select: count(t.id)
    Repo.one(query)
  end

  def ticket_cost(show) do
    query = from t in Ticket,
            where: t.listing_id == ^show.id,
            where: t.status == "available",
            where: is_nil(t.locked_until),
            where: fragment("? <= NOW()", t.sale_start),
            select: [min(t.price), max(t.price)]

    [min, max] = Repo.one(query)

    cost = if min == max do
      (min / 100)
      |> :erlang.float_to_binary(decimals: 2)
    else
      lower =   
        (min / 100)
        |> :erlang.float_to_binary(decimals: 2)

      upper =   
        (max / 100)
        |> :erlang.float_to_binary(decimals: 2)
        
      [lower, upper]
    end
  end

  def ticket_cost_number(show) do
    query = from t in Ticket,
            where: t.listing_id == ^show.id,
            where: t.status == "available",
            where: is_nil(t.locked_until),
            where: fragment("? <= NOW()", t.sale_start),
            select: max(t.price)

    Repo.one(query)
  end  

  defimpl Phoenix.Param, for: TicketAgent.Listing do
    def to_param(%{slug: slug, title: title}) do
      "#{slug}-#{TicketAgent.Listing.slugified_title(title)}"
    end
  end
end
