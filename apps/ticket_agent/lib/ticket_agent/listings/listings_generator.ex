defmodule TicketAgent.ListingsGenerator do
  require Logger
  alias Ecto.Multi
  alias TicketAgent.{Class, Listing, Repo, Ticket}

  def create_from_class(%{"user" => user, "class_id" => class_id, "title" => title, "description" => description, "listings" => listings} = params) do
    Logger.info "ListingsGenerator.create_from_class->class_id: #{class_id}"
    Logger.info "ListingsGenerator.create_from_class->title:    #{title}"

    listings
    |> Enum.each(fn(listing) ->
      Logger.info "ListingsGenerator.create_from_class->processing listing #{inspect listing}"
      listing_start_at = load_time(listing["start_time"])
      listing_end_at = load_time(listing["end_time"])

      Logger.info "listing_end_at = #{listing_end_at}"

      tickets =
        listing["tickets"]
        |> Enum.flat_map(fn(ticket) ->
          Logger.info "ListingsGenerator.create_from_class->processing ticket #{inspect ticket}"
          ticket_start_at = case ticket["sale_start"] do
            nil -> NaiveDateTime.utc_now
            "" -> NaiveDateTime.utc_now
            anything -> load_time(anything)
          end

          ticket_end_at = load_time(ticket["sale_end"])

          Enum.map(1..ticket["quantity"], fn(x) ->
            %{
              slug: TicketAgent.Random.generate_slug(),
              name: ticket["name"],
              group: ticket["group"],
              status: "available",
              price: ticket["price"],
              sale_start: ticket_start_at,
              sale_end: ticket_end_at,
              pass_fees_to_buyer: ticket["pass_fees"]
            }
          end)
        end)

      Logger.info "ListingsGenerator.create_from_class->setting up transaction"

      transaction =
        Multi.new
        |> Multi.insert(
          :listing,
          Listing.changeset(
            %Listing{},
            %{
              slug: TicketAgent.Random.generate_slug(),
              title: title,
              class_id: class_id,
              type: "class",
              description: description,
              status: "unpublished",
              start_at: listing_start_at,
              end_at: listing_end_at,
              tickets: tickets,
              user_id: user.id
            }
          )
        )
        |> Multi.run(:update, fn(%{listing: listing}) ->
          Listing.changeset(
            listing,
            %{
              status: "active"
            }
          )
          |> Repo.update
        end)
      Repo.transaction(transaction)
    end)
  end

  def load_time(nil), do: nil
  def load_time(""), do: nil
  def load_time(value) do
    {:ok, start_at, _offset} = DateTime.from_iso8601(value)
    start_at
  end
end
