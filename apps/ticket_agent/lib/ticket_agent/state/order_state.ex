defmodule TicketAgent.State.OrderState do
  require Logger
  alias Ecto.Multi
  alias TicketAgent.{Listing, Order, Repo, Ticket}
  alias TicketAgent.Finders.TicketFinder
  import Ecto.{Changeset, Query}
  @stripe_fixed_fee 30
  @processing_fixed_fee 50
  @percentage_fee 0.029

  def calculate_price({order, tickets, locked_until}) do
    subtotal =
      tickets
      |> Enum.reduce(0, fn(ticket, acc) ->
        acc = acc + ticket.price
      end)

    credit_card_fee = calculate_credit_card_fees(subtotal)

    total = subtotal + credit_card_fee + @processing_fixed_fee

    order
    |> Order.changeset(%{
      subtotal: subtotal,
      processing_fee: @processing_fixed_fee,
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

  defp calculate_credit_card_fees(price) do
    Logger.info "calculate_credit_card_fees->price = #{price}"
    Logger.info "calculate_credit_card_fees->percentage_fee = #{@percentage_fee}"
    Logger.info "calculate_credit_card_fees->fixed_fee = #{@stripe_fixed_fee}"
    value = Float.ceil(price * @percentage_fee) + @stripe_fixed_fee
    Logger.info "calculate_credit_card_fees->value = #{value}"
    round(value)
  end

end
