defmodule TicketAgent.State.OrderState do
  require Logger
  alias Ecto.Multi
  alias TicketAgent.{Order, Repo}
  import Ecto.{Query}
  @stripe_fixed_fee 30
  @stripe_percentage_fee 0.029
  @processing_fixed_fee 50
  
  def calculate_price({order, tickets, locked_until}) do
    order = calculate_order_cost(order)
    {
      order,
      tickets,
      locked_until,
      %{
        subtotal: order.subtotal,
        processing_fee: order.processing_fee + order.credit_card_fee,
        total: order.total_price
      }
    }
  end

  # this loads the order's tickets, adds them up and then calculate the stripe fee
  def calculate_order_cost(order) do
    order = case Ecto.assoc_loaded?(order.tickets) do
      true -> order
      false -> Repo.preload(order, :tickets)
    end
    subtotal = Enum.reduce(order.tickets, 0, fn(ticket, acc) -> acc + ticket.price end)

    {total, credit_card_fee, processing_fee} = calculate_fees(subtotal)

    order
    |> Order.changeset(%{
      subtotal:         subtotal,
      processing_fee:   processing_fee,
      credit_card_fee:  credit_card_fee,
      total_price:      total
    })
    |> Repo.update!()
  end

  def calculate_fees(price) do
    total_with_processing = price + @processing_fixed_fee
    total_to_charge = Float.ceil((total_with_processing + @stripe_fixed_fee) / (1 - @stripe_percentage_fee))
    stripe_fees = total_to_charge - total_with_processing

    Logger.info "calculate_fees->price                     = #{price}"
    Logger.info "calculate_fees->processing_fixed_fee      = #{@processing_fixed_fee}"
    Logger.info "calculate_fees->total_with_processing     = #{total_with_processing}"
    Logger.info "calculate_fees->stripe_percentage_fee     = #{@stripe_percentage_fee}"
    Logger.info "calculate_fees->stripe_fixed_fee          = #{@stripe_fixed_fee}"    
    Logger.info "calculate_fees->total_to_charge           = #{total_to_charge}"
    Logger.info "calculate_fees->stripe_fees               = #{stripe_fees}"

    {round(total_to_charge), round(stripe_fees), @processing_fixed_fee}
  end

  def set_credit_card_for_order(order, credit_card) do
    from(o in Order, where: o.id == ^order.id)
    |> Repo.update_all(set: [credit_card_id: credit_card.id])
  end

  # While orders start by default as 'started', we can also go from processing -> started
  def set_order_started(order, timestamp \\ NaiveDateTime.utc_now()) do
    Logger.info "set_order_started for order #{order.slug}"

    Multi.new()
    |> Multi.update_all(:order_started,
      from(
        o in Order,
        where: o.id == ^order.id,
        where: o.status == "processing"
      ),
      [
        set: [
          status: "started",
          started_at: timestamp
        ]
      ],
      returning: true
    )
  end

  # An order can go from started -> processing
  def set_order_processing(order, timestamp \\ NaiveDateTime.utc_now()) do
    Logger.info "set_order_processing->slug #{order.slug}"

    Multi.new()
    |> Multi.update_all(:order_processing,
      from(
        o in Order,
        where: o.id == ^order.id,
        where: o.status == "started"
      ),
      [
        set: [
          status: "processing",
          processing_at: timestamp
        ]
      ],
      returning: true
    )
  end

  # An order can go from processing -> completed
  def set_order_completed(order, timestamp \\ NaiveDateTime.utc_now()) do
    Logger.info "set_order_completed->slug #{order.slug}"

    Multi.new()
    |> Multi.update_all(:order_completed,
      from(
        o in Order,
        where: o.id == ^order.id,
        where: o.status == "processing"
      ),
      [
        set: [
          status: "completed",
          completed_at: timestamp,
        ]
      ],
      returning: true
    )
  end

  # An order can go from started or processing -> cancelled
  def release_order(order, timestamp \\ NaiveDateTime.utc_now()) do
    Logger.info "release_order for order #{order.slug}"

    Multi.new()
    |> Multi.update_all(:order_released,
      from(
        o in Order,
        where: o.id == ^order.id,
        where: o.status in ["started", "processing"]
      ),
      [
        set: [
          status: "cancelled",
          cancelled_at: timestamp
        ]
      ],
      returning: true
    )
  end
end
