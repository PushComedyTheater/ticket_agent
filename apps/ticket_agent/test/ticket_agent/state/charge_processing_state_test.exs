defmodule TicketAgent.State.ChargeProcessingStateTest do
  import TicketAgent.Factory
  use TicketAgent.DataCase
  alias TicketAgent.State.ChargeProcessingState

  describe "set_order_and_tickets_processing" do
    test "does nothing for tickets that are not locked" do
      order = insert(:order, status: "started")
      ticket = insert(:ticket, status: "available", order: order)
      assert {:error, "Tickets were not captured"} == ChargeProcessingState.set_order_and_tickets_processing(order, [ticket.id])
    end

    test "does nothing for orders that are not started" do
      order = insert(:order, status: "processing")
      ticket = insert(:ticket, status: "locked", order: order)
      assert {:error, "Order was not captured"} == ChargeProcessingState.set_order_and_tickets_processing(order, [ticket.id])
    end

    test "works for orders that are started and tickets that are locked" do
      order = insert(:order, status: "started")
      ticket = insert(:ticket, status: "locked", order: order)
      {:ok, {updated_order, [updated_ticket]}} = ChargeProcessingState.set_order_and_tickets_processing(order, [ticket.id])
      order = Repo.reload(order)
      ticket = Repo.reload(ticket)
      assert order.id == updated_order.id
      assert ticket.id == updated_ticket.id
      assert order.status == "processing"
      assert ticket.status == "processing"
    end    
  end
end
