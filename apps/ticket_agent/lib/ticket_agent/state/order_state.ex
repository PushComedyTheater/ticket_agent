defmodule TicketAgent.State.OrderState do
  require Logger
  alias Ecto.Multi
  alias TicketAgent.{Order, Repo}
  import Ecto.{Query}
  @stripe_fixed_fee 30
  @stripe_percentage_fee 0.029
  @processing_fixed_fee 50
  
  def calculate_price({order, tickets, locked_until}) do
    subtotal =
      tickets
      |> Enum.reduce(0, fn(ticket, acc) ->
        acc + ticket.price
      end)

    {total, credit_card_fee, processing_fee} = calculate_fees(subtotal)

    order
    |> Order.changeset(%{
      subtotal: subtotal,
      processing_fee: processing_fee,
      credit_card_fee: credit_card_fee,
      total_price: total
    })
    |> Repo.update!

    {
      order,
      tickets,
      locked_until,
      %{
        subtotal: subtotal,
        processing_fee: @processing_fixed_fee + credit_card_fee,
        total: total
      }
    }
  end

  def set_credit_card_for_order(order, credit_card) do
    from(o in Order, where: o.id == ^order.id)
    |> Repo.update_all(set: [credit_card_id: credit_card.id])
  end

  def set_order_processing_transaction(order) do
    Logger.info "set_order_processing_transaction->slug #{order.slug}"

    Multi.new()
    |> Multi.update_all(:order_processing,
      from(
        o in Order,
        where: o.id == ^order.id,
        where: o.status == "started"
      ),
      [
        set: [
          status: "processing"
        ]
      ],
      returning: true
    )
  end

  def set_order_completed_transaction(order) do
    Logger.info "set_order_completed_transaction->slug #{order.slug}"

    Multi.new()
    |> Multi.update_all(:completed_order,
      from(
        o in Order,
        where: o.id == ^order.id,
        where: o.status == "processing"
      ),
      [
        set: [
          status: "completed",
          completed_at: NaiveDateTime.utc_now(),
        ]
      ],
      returning: true
    )
  end

  def set_order_started_transaction(order) do
    Logger.info "set_order_started_transaction for order #{order.slug}"

    Multi.new()
    |> Multi.update_all(:processing_order,
      from(
        o in Order,
        where: o.id == ^order.id,
        where: o.status == "processing"
      ),
      [
        set: [
          status: "started"
        ]
      ],
      returning: true
    )
  end

  def release_order(order) do
    Logger.info "release_order for order #{order.slug}"

    Multi.new()
    |> Multi.update_all(:release_oser,
      from(
        o in Order,
        where: o.id == ^order.id,
        where: o.status in ["started", "processing"]
      ),
      [
        set: [
          status: "cancelled"
        ]
      ],
      returning: true
    )
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

end
