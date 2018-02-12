defmodule TicketAgent.Clock.SendOrderEmailsTest do
  import TicketAgent.Factory
  use ExUnit.Case, async: false  
  use TicketAgent.DataCase
  alias TicketAgent.Clock.SendOrderEmails
  alias TicketAgent.Repo
  
  describe "reset_order_and_tickets" do
    test "works for orders that are processing and tickets that are processing" do
      event = insert(:event, image_url: "https://i.imgur.com/AV7itLr.jpg")
      listing = insert(:listing, event: event)
      order = insert(
        :order, 
        status: "completed", 
        completed_at:  NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(1)
      )
      IO.inspect order.completed_at
      ticket = insert(:ticket, status: "purchased", order: order, listing: listing)

      SendOrderEmails.orders_to_be_emailed_transaction()
      |> Repo.transaction

      order = Repo.reload(order)
      IO.inspect order.status
    end    
  end    
end
