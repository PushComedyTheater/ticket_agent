defmodule TicketAgent.Listing do
  require Logger
  use TicketAgent.Schema

  @required ~w(slug title description status start_at)a
  @fields ~w(pass_fees_to_buyer end_at class_id user_id)a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "listings" do
    belongs_to :user, User, references: :id, foreign_key: :user_id, type: Ecto.UUID
    belongs_to :event, Event, references: :id, foreign_key: :event_id, type: Ecto.UUID
    belongs_to :class, Class, references: :id, foreign_key: :class_id, type: Ecto.UUID

    has_many :tickets, Ticket

    field :slug, :string
    field :title, :string
    field :description, :string
    field :status, :string
    field :pass_fees_to_buyer, :boolean
    field :start_at, :utc_datetime
    field :end_at, :utc_datetime
    timestamps(type: :utc_datetime)
  end

  def changeset(%Listing{} = listing, attr \\ %{}) do
    listing
    |> cast(attr, @required ++ @fields)
    |> validate_required(@required)
    |> validate_inclusion(:status, ~w(unpublished active canceled deleted))
    |> cast_assoc(:event)
    |> cast_assoc(:user)
    |> cast_assoc(:tickets)
    |> unique_constraint(:slug)
  end

  def listing_image_with_dimensions(%Listing{event_id: nil, class_id: class_id} = listing, width, height) do
    listing = case Ecto.assoc_loaded?(listing.class) do
      true -> listing
      false -> Repo.preload(listing, :class)
    end
    listing.class.image_url
    |> get_cloudinary(width, height)
  end

  def listing_image_with_dimensions(%Listing{event_id: event_id, class_id: nil} = listing, width, height) do
    listing = case Ecto.assoc_loaded?(listing.event) do
      true -> listing
      false -> Repo.preload(listing, :event)
    end
    listing.event.image_url
    |> get_cloudinary(width, height)
  end

  def get_cloudinary(image_url, width, height) do
    public_id = get_public_id(image_url)

    Cloudinex.Url.for(public_id, %{
      width: width,
      height: height,
      gravity: "north",
      crop: "fill",
      flags: 'progressive'
    })
  end

  def get_public_id("https://res.cloudinary.com/push-comedy-theater/image/upload/covers/" <> item) do
    "covers/" <> String.replace(item, ".jpg", "")
  end

  def get_public_id("https://res.cloudinary.com/push-comedy-theater/image/upload/" <> item) do
    String.replace(item, ".jpg", "")
  end

  def current_class_listing(%{id: class_id} = class) do
    utc_now =
      DateTime.utc_now()
      |> Calendar.NaiveDateTime.to_date_time_utc

    class = case Ecto.assoc_loaded?(class.listings) do
      true -> class
      false ->
        Repo.preload(class, :listings)
    end

    Enum.filter(class.listings, fn(listing) ->
      end_at = convert_to_date_time_utc(listing.end_at)
      date_after(utc_now, end_at)
    end)
    |> Enum.sort(fn(x,y) ->
      DateTime.compare(
        Calendar.NaiveDateTime.to_date_time_utc(x.start_at),
        Calendar.NaiveDateTime.to_date_time_utc(y.start_at)
      ) == :lt
    end)
  end

  def convert_to_date_time_utc(nil), do: nil
  def convert_to_date_time_utc(date), do: Calendar.NaiveDateTime.to_date_time_utc(date)

  def date_after(_, nil), do: false
  def date_after(date, end_at), do: (DateTime.compare(end_at, date) == :gt)

  def list_listings(params) do
    Listing
    |> order_by(asc: :start_at)
    |> Repo.paginate(params)
  end
  def get_listing!(id), do: Repo.get!(Listing, id)

  def create_listing(attrs \\ %{}) do
    %Listing{}
    |> Listing.changeset(attrs)
    |> Repo.insert()
  end

  def update_listing(%Listing{} = listing, attrs, originator) do
    listing
    |> Listing.changeset(attrs)
    |> PaperTrail.update(originator: originator)
  end

  def delete_listing(%Listing{} = listing) do
    Repo.delete(listing)
  end

  def change_listing(%Listing{} = listing) do
    Listing.changeset(listing, %{})
  end

  def from_class(current_user, %Class{} = class) do
    %Listing{}
    |> changeset(%{
      slug: Random.generate_slug(),
      title: class.title,
      description: class.description,
      status: "unpublished",
      user_id: current_user.id,
      class_id: class.id,
      start_time: NaiveDateTime.utc_now(),
      end_time: NaiveDateTime.utc_now(),
    })
  end

  def to_ical(listing) do
    events = [
      %ICalendar.Event{
        summary: listing.title,
        dtstart: listing.start_at,
        dtend:   listing.end_at,
        description: Curtail.truncate(HtmlSanitizeEx.strip_tags(listing.description), length: 400),
        location: "Push Comedy Theater, 763 Granby St, Norfolk, VA 23510, USA",
        url: "http://pushcomedytheater.com/events/#{listing.slug}-#{Listing.slugified_title(listing.title)}"
      }
    ]
    %ICalendar{ events: events }
    |> ICalendar.to_ics
  end

  def upcoming_shows do
    query = from l in Listing,
            where: fragment("? >= NOW()", l.start_at),
            where: not is_nil(l.event_id),
            order_by: [asc: :start_at],
            preload: [:event, :tickets],
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
