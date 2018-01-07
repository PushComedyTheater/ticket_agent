defmodule TicketAgent.State.OrderStateTest do
  use TicketAgent.DataCase
  alias TicketAgent.State.OrderState

  describe "calculate_fees" do
    test "calculates price for 1 dollar" do
      price = 100 #1 dollar
      {total, stripe_fee, processing_fee} = OrderState.calculate_fees(price)
      assert total == 186
      assert processing_fee == 50
      assert stripe_fee == 36
    end

    test "calculates price for 100 dollar" do
      price = 10000 #100 dollar
      {total, stripe_fee, processing_fee} = OrderState.calculate_fees(price)
      assert total == 10382
      assert processing_fee == 50
      assert stripe_fee == 332
    end

    test "calculates price for 2100 dollar" do
      price = 210000 #1 dollar
      {total, stripe_fee, processing_fee} = OrderState.calculate_fees(price)
      assert total == 216355
      assert processing_fee == 50
      assert stripe_fee == 6305.0
    end    
  end
end
