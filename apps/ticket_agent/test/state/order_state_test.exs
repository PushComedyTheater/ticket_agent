defmodule TicketAgent.State.OrderStateTest do
  import TicketAgent.Factory
  use TicketAgent.DataCase
  alias Ecto.Multi
  alias TicketAgent.State.OrderState

  setup do
    timestamp = NaiveDateTime.utc_now()
    {:ok, timestamp: timestamp}
  end

  describe "calculate_price" do
    test "calculates single ticket price" do
      order = insert(:order)
      ticket = insert(:ticket, price: 500, order: order)
      timestamp = NaiveDateTime.utc_now()

      {order, tickets, locked_until, pricing} = OrderState.calculate_price({order, [ticket], timestamp})

      assert Enum.count(tickets) == 1
      assert locked_until == timestamp

      assert order.subtotal        == 500
      assert order.credit_card_fee == 48
      assert order.processing_fee  == 55
      assert order.total_price     == 603

      assert pricing.subtotal == 500
      assert pricing.processing_fee == 103
      assert pricing.total == 603
    end

    test "calculates single ticket price absorbing fees" do
      order = insert(:order)
      listing = insert(:listing, pass_fees_to_buyer: false)
      ticket = insert(:ticket, order: order, listing: listing, price: 500, order: order)

      timestamp = NaiveDateTime.utc_now()

      order = Repo.reload(order)

      {order, tickets, locked_until, pricing} = OrderState.calculate_price({order, [ticket], timestamp})
      assert Enum.count(tickets) == 1
      assert locked_until == timestamp

      assert order.subtotal        == 500
      assert order.credit_card_fee == 0
      assert order.processing_fee  == 55
      assert order.total_price     == 500

      assert pricing.subtotal == 500
      assert pricing.processing_fee == 55
      assert pricing.total == 500
    end

    test "calculates single free ticket price absorbing fees" do
      order = insert(:order)
      listing = insert(:listing, pass_fees_to_buyer: false)
      ticket = insert(:ticket, order: order, listing: listing, price: 0, order: order)

      timestamp = NaiveDateTime.utc_now()

      order = Repo.reload(order)

      {order, tickets, locked_until, pricing} = OrderState.calculate_price({order, [ticket], timestamp})
      assert Enum.count(tickets) == 1
      assert locked_until == timestamp

      assert order.subtotal        == 0
      assert order.credit_card_fee == 0
      assert order.processing_fee  == 0
      assert order.total_price     == 0

      assert pricing.subtotal == 0
      assert pricing.processing_fee == 0
      assert pricing.total == 0
    end
  end

  describe "calculate_order_cost" do
    test "calculates single ticket price" do
      order = insert(:order)
      insert(:ticket, price: 500, order: order)

      order = OrderState.calculate_order_cost(order)

      assert order.subtotal        == 500
      assert order.credit_card_fee == 48
      assert order.processing_fee  == 55
      assert order.total_price     == 603
    end

    test "calculates 5 ticket price" do
      order = insert(:order)
      insert(:ticket, price: 500, order: order)
      insert(:ticket, price: 500, order: order)
      insert(:ticket, price: 500, order: order)
      insert(:ticket, price: 500, order: order)
      insert(:ticket, price: 400, order: order)

      order = OrderState.calculate_order_cost(order)

      assert order.subtotal        == 2400
      assert order.credit_card_fee == 105
      assert order.processing_fee  == 74
      assert order.total_price     == 2579
    end
  end

  describe "calculate_fees passing fees to buyer" do
    test "calculates price for 0 dollar" do
      listing = insert(:listing, pass_fees_to_buyer: true)
      price = 0 #1 dollar
      {total, stripe_fee, processing_fee} = OrderState.calculate_fees(price, listing)
      assert total == 0
      assert processing_fee == 0
      assert stripe_fee == 0
    end

    test "calculates price for 1 dollar" do
      listing = insert(:listing, pass_fees_to_buyer: true)
      price = 100 #1 dollar
      {total, stripe_fee, processing_fee} = OrderState.calculate_fees(price, listing)
      assert total == 187
      assert processing_fee == 51
      assert stripe_fee == 36
    end

    test "calculates price for 100 dollar" do
      listing = insert(:listing, pass_fees_to_buyer: true)
      price = 10000 #100 dollar
      {total, stripe_fee, processing_fee} = OrderState.calculate_fees(price, listing)
      assert total == 10485
      assert processing_fee == 150
      assert stripe_fee == 335
    end

    test "calculates price for 2100 dollar" do
      listing = insert(:listing, pass_fees_to_buyer: true)
      price = 210000 #1 dollar
      {total, stripe_fee, processing_fee} = OrderState.calculate_fees(price, listing)
      assert total == 218517
      assert processing_fee == 2150
      assert stripe_fee == 6367
    end
  end

  describe "calculate_fees absorbing fees" do
    test "calculates price for 0 dollar" do
      listing = insert(:listing, pass_fees_to_buyer: false)
      price = 0 #1 dollar
      {total, stripe_fee, processing_fee} = OrderState.calculate_fees(price, listing)
      assert total == 0
      assert processing_fee == 0
      assert stripe_fee == 0
    end

    test "calculates price for 1 dollar" do
      listing = insert(:listing, pass_fees_to_buyer: false)
      price = 100 #1 dollar
      {total, stripe_fee, processing_fee} = OrderState.calculate_fees(price, listing)
      assert total == 100
      assert processing_fee == 51
      assert stripe_fee == 0
    end

    test "calculates price for 100 dollar" do
      listing = insert(:listing, pass_fees_to_buyer: false)
      price = 10000 #100 dollar
      {total, stripe_fee, processing_fee} = OrderState.calculate_fees(price, listing)
      assert total == 10000
      assert processing_fee == 150
      assert stripe_fee == 0
    end

    test "calculates price for 2100 dollar" do
      listing = insert(:listing, pass_fees_to_buyer: false)
      price = 210000 #1 dollar
      {total, stripe_fee, processing_fee} = OrderState.calculate_fees(price, listing)
      assert total == 210000
      assert processing_fee == 2150
      assert stripe_fee == 0
    end
  end

  describe "set_order_started" do
    test "affects processing", %{timestamp: timestamp} do
      order = insert(:order, status: "processing")
      multi = OrderState.set_order_started(order, timestamp)

      assert [
        order_started: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == ~s(#Ecto.Query<from o in TicketAgent.Order, where: o.id == ^\"#{order.id}\", where: o.status == \"processing\">)
      assert updates == [set: [status: "started", started_at: timestamp]]

      {:ok, %{order_started: {1, [updated_order]}}} = Repo.transaction(multi)
      assert order.id == updated_order.id
      assert updated_order.status == "started"

      order = Repo.reload(order)
      assert order.status == "started"
      refute is_nil(order.started_at)
    end

    test "does not affect others" do
      Enum.each(~w(started completed errored cancelled), fn(status) ->
        order = insert(:order, status: status)
        {:ok, %{order_started: {0, _}}} =
          order
          |> OrderState.set_order_started()
          |> Repo.transaction

        order = Repo.reload(order)
        assert order.status == status
      end)
    end
  end

  describe "set_order_processing" do
    test "affects started", %{timestamp: timestamp} do
      order = insert(:order, status: "started")
      multi = OrderState.set_order_processing(order, timestamp)

      assert [
        order_processing: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == ~s(#Ecto.Query<from o in TicketAgent.Order, where: o.id == ^\"#{order.id}\", where: o.status == \"started\">)
      assert updates == [set: [status: "processing", processing_at: timestamp]]

      {:ok, %{order_processing: {1, [updated_order]}}} = Repo.transaction(multi)
      assert order.id == updated_order.id
      assert updated_order.status == "processing"

      order = Repo.reload(order)
      assert order.status == "processing"
      refute is_nil(order.processing_at)
    end

    test "does not affect others" do
      Enum.each(~w(processing completed errored cancelled), fn(status) ->
        order = insert(:order, status: status)
        {:ok, %{order_processing: {0, _}}} =
          order
          |> OrderState.set_order_processing()
          |> Repo.transaction

        order = Repo.reload(order)
        assert order.status == status
      end)
    end
  end

  describe "set_order_completed" do
    test "affects started", %{timestamp: timestamp} do
      order = insert(:order, status: "started")
      multi = OrderState.set_order_completed(order, timestamp)

      assert [
        order_completed: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == ~s(#Ecto.Query<from o in TicketAgent.Order, where: o.id == ^\"#{order.id}\", where: o.status in [\"started\", \"processing\"]>)
      assert updates == [set: [status: "completed", completed_at: timestamp]]

      {:ok, %{order_completed: {1, [updated_order]}}} = Repo.transaction(multi)
      assert order.id == updated_order.id
      assert updated_order.status == "completed"

      order = Repo.reload(order)
      assert order.status == "completed"
      refute is_nil(order.completed_at)
    end

    test "affects processing", %{timestamp: timestamp} do
      order = insert(:order, status: "processing")
      multi = OrderState.set_order_completed(order, timestamp)

      assert [
        order_completed: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == ~s(#Ecto.Query<from o in TicketAgent.Order, where: o.id == ^\"#{order.id}\", where: o.status in [\"started\", \"processing\"]>)
      assert updates == [set: [status: "completed", completed_at: timestamp]]

      {:ok, %{order_completed: {1, [updated_order]}}} = Repo.transaction(multi)
      assert order.id == updated_order.id
      assert updated_order.status == "completed"

      order = Repo.reload(order)
      assert order.status == "completed"
      refute is_nil(order.completed_at)
    end

    test "does not affect others" do
      Enum.each(~w(errored cancelled), fn(status) ->
        order = insert(:order, status: status)
        {:ok, %{order_completed: {0, _}}} =
          order
          |> OrderState.set_order_completed()
          |> Repo.transaction

        order = Repo.reload(order)
        assert order.status == status
      end)
    end
  end

  describe "release_order" do
    test "affects started", %{timestamp: timestamp} do
      order = insert(:order, status: "started")
      multi = OrderState.release_order(order, timestamp)

      assert [
        order_released: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == ~s(#Ecto.Query<from o in TicketAgent.Order, where: o.id == ^\"#{order.id}\", where: o.status in [\"started\", \"processing\"]>)
      assert updates == [set: [status: "cancelled",cancelled_at: timestamp]]

      {:ok, %{order_released: {1, [updated_order]}}} = Repo.transaction(multi)
      assert order.id == updated_order.id
      assert updated_order.status == "cancelled"

      order = Repo.reload(order)
      assert order.status == "cancelled"
      refute is_nil(order.cancelled_at)
    end

    test "affects processing", %{timestamp: timestamp} do
      order = insert(:order, status: "processing")
      multi = OrderState.release_order(order, timestamp)

      assert [
        order_released: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == ~s(#Ecto.Query<from o in TicketAgent.Order, where: o.id == ^\"#{order.id}\", where: o.status in [\"started\", \"processing\"]>)
      assert updates == [set: [status: "cancelled", cancelled_at: timestamp]]

      {:ok, %{order_released: {1, [updated_order]}}} = Repo.transaction(multi)
      assert order.id == updated_order.id
      assert updated_order.status == "cancelled"

      order = Repo.reload(order)
      assert order.status == "cancelled"
      refute is_nil(order.cancelled_at)
    end

    test "does not affect others" do
      Enum.each(~w(completed errored cancelled), fn(status) ->
        order = insert(:order, status: status)
        {:ok, %{order_released: {0, _}}} =
          order
          |> OrderState.release_order()
          |> Repo.transaction

        order = Repo.reload(order)
        assert order.status == status
      end)
    end
  end
end
