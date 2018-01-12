defmodule TicketAgent.State.ChargeProcessingStateTest do
  import TicketAgent.Factory
  use TicketAgent.DataCase
  alias TicketAgent.State.ChargeProcessingState
  alias TicketAgent.Repo

  describe "set_order_processing_with_tickets" do
    test "returns error for order with no tickets" do
      order = insert(:order, status: "started")
      assert {:error, :no_tickets_error} == ChargeProcessingState.set_order_processing_with_tickets(order)
    end

    test "returns error for preloaded order with no tickets" do
      order = 
        insert(:order, status: "started")
        |> Repo.preload(:tickets)
      assert {:error, :no_tickets_error} == ChargeProcessingState.set_order_processing_with_tickets(order)
    end    

    test "does nothing for tickets that are not locked" do
      order = insert(:order, status: "started")
      ticket = insert(:ticket, status: "available", order: order)
      assert {:error, :ticket_processing_error} == ChargeProcessingState.set_order_processing_with_tickets(order)
    end

    test "does nothing for orders that are not started" do
      order = insert(:order, status: "processing")
      ticket = insert(:ticket, status: "locked", order: order)
      assert {:error, :order_processing_error} == ChargeProcessingState.set_order_processing_with_tickets(order)
    end

    test "errors orders that are started and some tickets are not locked and tickets that are locked" do
      order = insert(:order, status: "started")
      insert(:ticket, status: "locked", order: order)
      ticket = insert(:ticket, status: "available", order: order)
      assert {:error, :ticket_processing_error} = ChargeProcessingState.set_order_processing_with_tickets(order)
      order = Repo.reload(order)
      ticket = Repo.reload(ticket)
      assert order.status == "processing"
      assert ticket.status == "available"
    end  

    test "works for orders that are started and tickets that are locked" do
      order = insert(:order, status: "started")
      ticket = insert(:ticket, status: "locked", order: order)
      {:ok, {updated_order, [updated_ticket]}} = ChargeProcessingState.set_order_processing_with_tickets(order)
      order = Repo.reload(order)
      ticket = Repo.reload(ticket)
      assert order.id == updated_order.id
      assert ticket.id == updated_ticket.id
      assert order.status == "processing"
      assert ticket.status == "processing"
    end   
    
    test "works for preloaded orders that are started and tickets that are locked" do
      order = insert(:order, status: "started")  
      ticket = insert(:ticket, status: "locked", order: order)
      order = Repo.preload(order, :tickets)
      {:ok, {updated_order, [updated_ticket]}} = ChargeProcessingState.set_order_processing_with_tickets(order)
      order = Repo.reload(order)
      ticket = Repo.reload(ticket)
      assert order.id == updated_order.id
      assert ticket.id == updated_ticket.id
      assert order.status == "processing"
      assert ticket.status == "processing"
    end       
  end

  describe "set_order_completed_with_tickets" do
    test "does nothing for tickets that are not processing" do
      order = insert(:order, status: "processing")
      ticket = insert(:ticket, status: "locked", order: order)
      assert {:error, :ticket_completing_error} == ChargeProcessingState.set_order_completed_with_tickets(order)
    end

    test "does nothing for orders that are not started" do
      order = insert(:order, status: "started")
      ticket = insert(:ticket, status: "processing", order: order)
      assert {:error, :order_completing_error} == ChargeProcessingState.set_order_completed_with_tickets(order)
    end

    test "works for orders that are processing and tickets that are processing" do
      order = insert(:order, status: "processing")
      ticket = insert(:ticket, status: "processing", order: order)
      {:ok, {updated_order, [updated_ticket]}} = ChargeProcessingState.set_order_completed_with_tickets(order)

      order = Repo.reload(order)
      ticket = Repo.reload(ticket)

      assert order.id == updated_order.id
      assert ticket.id == updated_ticket.id
      assert order.status == "completed"
      assert ticket.status == "purchased"
    end    
  end  

  describe "cancel_order_and_release_tickets" do
    test "works for orders and tickets" do
      order = insert(:order, status: "processing")
      ticket = insert(:ticket, status: "processing", order: order)
      :ok = ChargeProcessingState.cancel_order_and_release_tickets(order)

      order = 
        order
        |> Repo.reload()
        |> Repo.preload(:tickets)

      ticket = Repo.reload(ticket)

      assert order.status == "cancelled"
      assert ticket.status == "available"
      assert Enum.count(order.tickets) == 0
    end  
    
    test "works for orders and no tickets" do
      order = insert(:order, status: "processing")
      :ok = ChargeProcessingState.cancel_order_and_release_tickets(order)

      order = 
        order
        |> Repo.reload()
        |> Repo.preload(:tickets)
        

      assert order.status == "cancelled"
      assert Enum.count(order.tickets) == 0
    end      
  end    
end
