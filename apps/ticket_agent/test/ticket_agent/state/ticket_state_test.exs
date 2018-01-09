defmodule TicketAgent.State.TicketStateTest do
  import TicketAgent.Factory
  use TicketAgent.DataCase, async: false
  alias Ecto.Multi
  alias TicketAgent.State.TicketState

  setup do
    timestamp = NaiveDateTime.utc_now()
    user = insert(:user)
    {:ok, timestamp: timestamp, user: user}
  end

  describe "lock_processing_tickets" do
    test "does not affect available" do
      order = insert(:order)
      ticket = insert(:ticket, status: "available", order: order)
      multi = TicketState.lock_processing_tickets([ticket.id], order.id)

      assert {:ok, %{locked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect locked tickets" do
      order = insert(:order)
      ticket = insert(:ticket, status: "locked", order: order)
      multi = TicketState.lock_processing_tickets([ticket.id], order.id)

      assert {:ok, %{locked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end

    test "affects processing", %{timestamp: timestamp} do
      order = insert(:order)
      ticket = insert(:ticket, status: "processing", order: order)
      multi = TicketState.lock_processing_tickets([ticket.id], order.id, timestamp)

      assert [
        locked_processing_tickets: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == ~s(#Ecto.Query<from t in TicketAgent.Ticket, where: t.id in ^[\"#{ticket.id}\"], where: t.order_id == ^\"#{order.id}\", where: t.status == \"processing\">)
      assert updates == [set: [status: "locked", locked_until: timestamp]]

      {:ok, %{locked_processing_tickets: {1, [updated_ticket]}}} = Repo.transaction(multi)
      assert ticket.id == updated_ticket.id
      assert updated_ticket.status == "locked"

      ticket = Repo.reload(ticket)
      assert ticket.status == "locked"
      refute is_nil(ticket.locked_until)
    end

    test "does not affect purchased" do
      order = insert(:order)
      ticket = insert(:ticket, status: "purchased", order: order)
      multi = TicketState.lock_processing_tickets([ticket.id], order.id)
      assert {:ok, %{locked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect emailed" do
      order = insert(:order)
      ticket = insert(:ticket, status: "emailed", order: order)
      multi = TicketState.lock_processing_tickets([ticket.id], order.id)
      assert {:ok, %{locked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect checkedin" do
      order = insert(:order)
      ticket = insert(:ticket, status: "checkedin", order: order)
      multi = TicketState.lock_processing_tickets([ticket.id], order.id)
      assert {:ok, %{locked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
  end

  describe "unlock_tickets_to_processing" do
    test "does not affect available" do
      order = insert(:order)
      ticket = insert(:ticket, status: "available", order: order)
      multi = TicketState.unlock_tickets_to_processing([ticket.id], order.id)
      assert {:ok, %{unlocked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "affects locked tickets" do
      order = insert(:order)
      ticket = insert(:ticket, status: "locked", order: order)
      multi = TicketState.unlock_tickets_to_processing([ticket.id], order.id)

      assert [
        unlocked_processing_tickets: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == ~s(#Ecto.Query<from t in TicketAgent.Ticket, where: t.id in ^[\"#{ticket.id}\"], where: t.order_id == ^\"#{order.id}\", where: t.status == \"locked\">)
      assert updates == [set: [status: "processing", locked_until: nil]]

      {:ok, %{unlocked_processing_tickets: {1, [updated_ticket]}}} = Repo.transaction(multi)
      assert updated_ticket.id == ticket.id

      ticket = Repo.reload(ticket)
      assert ticket.status == "processing"
      assert is_nil(ticket.locked_until)
    end

    test "does not affect processing" do
      order = insert(:order)
      ticket = insert(:ticket, status: "processing", order: order)
      multi = TicketState.unlock_tickets_to_processing([ticket.id], order.id)
      assert {:ok, %{unlocked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end

    test "does not affect purchased" do
      order = insert(:order)
      ticket = insert(:ticket, status: "purchased", order: order)
      multi = TicketState.unlock_tickets_to_processing([ticket.id], order.id)
      assert {:ok, %{unlocked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect emailed" do
      order = insert(:order)
      ticket = insert(:ticket, status: "emailed", order: order)
      multi = TicketState.unlock_tickets_to_processing([ticket.id], order.id)
      assert {:ok, %{unlocked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect checkedin" do
      order = insert(:order)
      ticket = insert(:ticket, status: "checkedin", order: order)
      multi = TicketState.unlock_tickets_to_processing([ticket.id], order.id)
      assert {:ok, %{unlocked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
  end

  describe "purchase_processing_tickets" do
    test "does not affect available" do
      order = insert(:order)
      ticket = insert(:ticket, status: "available", order: order)
      multi = TicketState.purchase_processing_tickets([ticket.id], order.id)

      assert {:ok, %{purchased_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect locked tickets" do
      order = insert(:order)
      ticket = insert(:ticket, status: "locked", order: order)
      multi = TicketState.purchase_processing_tickets([ticket.id], order.id)

      assert {:ok, %{purchased_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end

    test "affects processing", %{timestamp: timestamp} do
      order = insert(:order)
      ticket = insert(:ticket, status: "processing", order: order)
      multi = TicketState.purchase_processing_tickets([ticket.id], order.id, timestamp)

      assert [
        purchased_processing_tickets: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == ~s(#Ecto.Query<from t in TicketAgent.Ticket, where: t.id in ^[\"#{ticket.id}\"], where: t.order_id == ^\"#{order.id}\", where: t.status == \"processing\">)
      assert updates == [set: [status: "purchased", locked_until: nil, purchased_at: timestamp]]

      {:ok, %{purchased_processing_tickets: {1, [updated_ticket]}}} = Repo.transaction(multi)
      assert ticket.id == updated_ticket.id

      ticket = Repo.reload(ticket)
      assert ticket.status == "purchased"
    end

    test "does not affect purchased" do
      order = insert(:order)
      ticket = insert(:ticket, status: "purchased", order: order)
      multi = TicketState.purchase_processing_tickets([ticket.id], order.id)
      assert {:ok, %{purchased_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect emailed" do
      order = insert(:order)
      ticket = insert(:ticket, status: "emailed", order: order)
      multi = TicketState.purchase_processing_tickets([ticket.id], order.id)
      assert {:ok, %{purchased_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect checkedin" do
      order = insert(:order)
      ticket = insert(:ticket, status: "checkedin", order: order)
      multi = TicketState.purchase_processing_tickets([ticket.id], order.id)
      assert {:ok, %{purchased_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
  end
  
  describe "email_purchased_ticket" do
    test "does not affect available" do
      order = insert(:order)
      ticket = insert(:ticket, status: "available", order: order)
      multi = TicketState.email_purchased_ticket(ticket.id)

      assert {:ok, %{emailed_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect locked tickets" do
      order = insert(:order)
      ticket = insert(:ticket, status: "locked", order: order)
      multi = TicketState.email_purchased_ticket(ticket.id)

      {:ok, %{emailed_tickets: {0, []}}} = Repo.transaction(multi)
    end

    test "does not affect processing tickets" do
      order = insert(:order)
      ticket = insert(:ticket, status: "processing", order: order)
      multi = TicketState.email_purchased_ticket(ticket.id)

      assert {:ok, %{emailed_tickets: {0, []}}} == Repo.transaction(multi)
    end    

    test "affects purchased", %{timestamp: timestamp} do
      order = insert(:order)
      ticket = insert(:ticket, status: "purchased", order: order)
      multi = TicketState.email_purchased_ticket(ticket.id, timestamp)

      assert [
        emailed_tickets: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == ~s(#Ecto.Query<from t in TicketAgent.Ticket, where: t.id == ^\"#{ticket.id}\", where: t.status == \"purchased\">)
      assert updates == [set: [status: "emailed", emailed_at: timestamp]]

      {:ok, %{emailed_tickets: {1, [updated_ticket]}}} = Repo.transaction(multi)
      assert ticket.id == updated_ticket.id

      ticket = Repo.reload(ticket)
      assert ticket.status == "emailed"
      refute is_nil(ticket.emailed_at)
    end

    test "does not affect emailed" do
      order = insert(:order)
      ticket = insert(:ticket, status: "emailed", order: order)
      multi = TicketState.email_purchased_ticket(ticket.id)
      assert {:ok, %{emailed_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect checkedin" do
      order = insert(:order)
      ticket = insert(:ticket, status: "checkedin", order: order)
      multi = TicketState.email_purchased_ticket(ticket.id)
      assert {:ok, %{emailed_tickets: {0, []}}} == Repo.transaction(multi)
    end
  end  

  describe "set_ticket_checkedin" do
    test "does not affect available" do
      order = insert(:order)
      ticket = insert(:ticket, status: "available", order: order)
      multi = TicketState.set_ticket_checkedin(ticket.id, "80847ad5-7fd1-4d8a-bdc3-7fe47661fefd")

      assert {:ok, %{checked_in_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect locked tickets" do
      order = insert(:order)
      ticket = insert(:ticket, status: "locked", order: order)
      multi = TicketState.set_ticket_checkedin(ticket.id, "80847ad5-7fd1-4d8a-bdc3-7fe47661fefd")

      assert {:ok, %{checked_in_tickets: {0, []}}} == Repo.transaction(multi)
    end

    test "does not affect processing tickets" do
      order = insert(:order)
      ticket = insert(:ticket, status: "processing", order: order)
      multi = TicketState.set_ticket_checkedin(ticket.id, "80847ad5-7fd1-4d8a-bdc3-7fe47661fefd")

      assert {:ok, %{checked_in_tickets: {0, []}}} == Repo.transaction(multi)
    end    

    test "affects purchased", %{timestamp: timestamp, user: user} do
      order = insert(:order)
      ticket = insert(:ticket, status: "purchased", order: order)
      multi = TicketState.set_ticket_checkedin(ticket.id, user.id, timestamp)

      assert [
        checked_in_tickets: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == ~s(#Ecto.Query<from t in TicketAgent.Ticket, where: t.id == ^\"#{ticket.id}\", where: t.status in [\"emailed\", \"purchased\"]>)
      assert updates == [set: [status: "checkedin", checked_in_at: timestamp, checked_in_by: user.id]]

      {:ok, %{checked_in_tickets: {1, [updated_ticket]}}} = Repo.transaction(multi)
      assert ticket.id == updated_ticket.id

      ticket = Repo.reload(ticket)
      assert ticket.status == "checkedin"
      refute is_nil(ticket.checked_in_at)      
    end

    test "affects emailed", %{timestamp: timestamp, user: user} do
      order = insert(:order)
      ticket = insert(:ticket, status: "emailed", order: order)
      multi = TicketState.set_ticket_checkedin(ticket.id, user.id, timestamp)

      assert [
        checked_in_tickets: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == ~s(#Ecto.Query<from t in TicketAgent.Ticket, where: t.id == ^\"#{ticket.id}\", where: t.status in [\"emailed\", \"purchased\"]>)
      assert updates == [set: [status: "checkedin", checked_in_at: timestamp, checked_in_by: user.id]]

      {:ok, %{checked_in_tickets: {1, [updated_ticket]}}} = Repo.transaction(multi)
      assert ticket.id == updated_ticket.id

      ticket = Repo.reload(ticket)
      assert ticket.status == "checkedin"
      refute is_nil(ticket.checked_in_at)              
    end

    test "does not affect checkedin" do
      order = insert(:order)
      ticket = insert(:ticket, status: "checkedin", order: order)
      multi = TicketState.set_ticket_checkedin(ticket.id, "80847ad5-7fd1-4d8a-bdc3-7fe47661fefd")
      assert {:ok, %{checked_in_tickets: {0, []}}} == Repo.transaction(multi)
    end
  end    
end
