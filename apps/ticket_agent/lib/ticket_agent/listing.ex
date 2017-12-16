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
    field :start_at, :utc_datetime
    field :end_at, :utc_datetime
    timestamps(type: :utc_datetime)
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
            preload: [:event, :images, :listing_tags, :tickets],
            select: l
    Repo.all(query)
  end

  defimpl Phoenix.Param, for: TicketAgent.Listing do
    def to_param(%{slug: slug, title: title}) do
      "#{slug}-#{TicketAgent.Listing.slugified_title(title)}"
    end
  end

  def slugified_title(title) do
    title
      |> String.downcase
      |> String.replace(~r/[^a-z0-9\s-]/, "")
      |> String.replace(~r/(\s|-)+/, "-")
  end
end
