defmodule TicketAgent.Finders.OrderFinder do
  require Logger
  import Ecto.Query
  alias TicketAgent.{Listing, Order, Random, Repo}

  def find_all_customer_orders(current_user) when not is_nil(current_user) do
    query =
      from(
        o in Order,
        where: o.user_id == ^current_user.id,
        where: o.status != "started",
        where: o.status != "processing",
        where: o.status != "cancelled",
        preload: [:tickets, :listing],
        preload: [listing: :event],
        select: o
      )

    Repo.all(query)
  end

  def has_customer_ordered_event?(user, event_id) when not is_nil(user) do
    count =
      customer_event_orders(user.id, event_id)
      |> Enum.count()

    count > 0
  end

  def customer_event_orders(user_id, event_id) do
    Logger.info("user_id = #{user_id}")
    Logger.info("event_id = #{event_id}")

    query =
      from(
        listing in Listing,
        join: tickets in assoc(listing, :tickets),
        join: orders in assoc(tickets, :order),
        where: listing.event_id == ^event_id,
        where: orders.user_id == ^user_id,
        group_by: orders.id,
        select: orders
      )

    query
    |> Repo.all()
  end

  def find_or_create_order(current_user) when not is_nil(current_user) do
    case find_started_order(current_user) do
      nil ->
        Logger.info("Creating a new order for this user")

        %Order{}
        |> Order.changeset(%{
          slug: Random.generate_slug(),
          user_id: current_user.id,
          subtotal: 0,
          processing_fee: 0,
          total_price: 0,
          status: "started"
        })
        |> Repo.insert!()

      order ->
        Logger.info("Found an existing started order #{inspect(order.id)}")
        order
    end
  end

  def find_started_order(current_user) do
    Logger.info("OrderFinder.find_started_order: current_user: #{current_user.email}")

    query =
      from(
        o in Order,
        where: o.user_id == ^current_user.id,
        where: o.status == "started",
        limit: 1,
        select: o
      )

    Repo.one(query)
  end

  def find_order(order_slug, user_id) do
    Logger.info("OrderFinder.find_order: looking for slug #{order_slug} and user_id #{user_id}")

    query =
      from(
        o in Order,
        where: o.user_id == ^user_id,
        where: o.slug == ^order_slug,
        limit: 1,
        select: o
      )

    Repo.one(query)
  end
end
