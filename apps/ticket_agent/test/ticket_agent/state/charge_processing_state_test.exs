defmodule TicketAgent.State.ChargeProcessingStateTest do
  import TicketAgent.Factory
  use TicketAgent.DataCase
  alias TicketAgent.State.ChargeProcessingState



  describe "set_order_and_tickets_processing" do
    test "sets a ticket to thing" do
      order = insert(:order)
      ticket = insert(:ticket, order: order)
      ChargeProcessingState.set_order_and_tickets_processing(order, [ticket.id])
    end
  end
end
