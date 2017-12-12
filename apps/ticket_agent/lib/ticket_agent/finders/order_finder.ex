defmodule TicketAgent.Finders.OrderFinder do
  require Logger
  import Ecto.Query
  alias TicketAgent.{Order, Random, Repo}

  def find_or_create_order(%{"order_id" => "", "name" => name, "email" => email, "total_price" => total_price} = params) do
    # create order since it's not
    Logger.info "OrderFinder.find_or_create_order: No order id was passed from the template (params: #{inspect params}"

    case find_started_order(email, total_price) do
      nil ->
        Logger.info "Creating a new order for this user"
        %Order{}
        |> Order.changeset(%{
          slug: Random.generate_slug(),
          name: name,
          email_address: email,
          total_price: total_price,
          status: "started"
        })
        |> Repo.insert!
      order ->
        Logger.info "Found an existing started order #{inspect order}"
        order
    end
  end

  def find_or_create_order(%{"order_id" => order_id, "name" => name, "email" => email, "total_price" => total_price} = params) do
    # create order since it's not
    Logger.info "OrderFinder.find_or_create_order: Order ID #{order_id} was passed from the template (params: #{inspect params}"
    order = Repo.get_by!(Order, slug: order_id)

    order
    |> Order.changeset(%{
      name: name,
      email_address: email,
      total_price: total_price
    })
    |> Repo.update!    
  end 
  
  def find_started_order(email_address, total_price) do
    Logger.info "OrderFinder.find_started_order: looking for email #{email_address} and total_price #{total_price}" 
    query =
      from(
        o in Order,
        where: o.email_address == ^email_address,
        where: o.total_price == ^total_price,
        where: o.status == "started",
        limit: 1,
        select: o
      )

    Repo.one(query)
  end

  def find_order(order_slug, user_id) do
    Logger.info "OrderFinder.find_order: looking for slug #{order_slug} and user_id #{user_id}" 
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
