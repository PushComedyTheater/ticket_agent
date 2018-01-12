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
      multi = TicketState.lock_processing_tickets(order)

      assert {:ok, %{locked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect locked tickets" do
      order = insert(:order)
      ticket = insert(:ticket, status: "locked", order: order)
      multi = TicketState.lock_processing_tickets(order)

      assert {:ok, %{locked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end

    test "affects processing", %{timestamp: timestamp} do
      order = insert(:order)
      ticket = insert(:ticket, status: "processing", order: order)
      multi = TicketState.lock_processing_tickets(order, timestamp)

      assert [
        locked_processing_tickets: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == ~s(#Ecto.Query<from t in TicketAgent.Ticket, where: t.order_id == ^\"#{order.id}\", where: t.status == \"processing\">)
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
      multi = TicketState.lock_processing_tickets(order)
      assert {:ok, %{locked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect emailed" do
      order = insert(:order)
      ticket = insert(:ticket, status: "emailed", order: order)
      multi = TicketState.lock_processing_tickets(order)
      assert {:ok, %{locked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect checkedin" do
      order = insert(:order)
      ticket = insert(:ticket, status: "checkedin", order: order)
      multi = TicketState.lock_processing_tickets(order)
      assert {:ok, %{locked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
  end

  describe "unlock_tickets_to_processing_for_order" do
    test "does not affect tickets for other orders" do
      first_order = insert(:order)
      order = insert(:order)
      ticket = insert(:ticket, status: "locked", order: first_order)
      multi = TicketState.unlock_tickets_to_processing_for_order(order)
      assert {:ok, %{unlocked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end

    test "does not affect available" do
      order = insert(:order)
      ticket = insert(:ticket, status: "available", order: order)
      multi = TicketState.unlock_tickets_to_processing_for_order(order)
      assert {:ok, %{unlocked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "affects locked tickets" do
      order = insert(:order)
      ticket = insert(:ticket, status: "locked", order: order)
      multi = TicketState.unlock_tickets_to_processing_for_order(order)

      assert [
        unlocked_processing_tickets: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == ~s(#Ecto.Query<from t in TicketAgent.Ticket, where: t.order_id == ^\"#{order.id}\", where: t.status == \"locked\">)
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
      multi = TicketState.unlock_tickets_to_processing_for_order(order)
      assert {:ok, %{unlocked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end

    test "does not affect purchased" do
      order = insert(:order)
      ticket = insert(:ticket, status: "purchased", order: order)
      multi = TicketState.unlock_tickets_to_processing_for_order(order)
      assert {:ok, %{unlocked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect emailed" do
      order = insert(:order)
      ticket = insert(:ticket, status: "emailed", order: order)
      multi = TicketState.unlock_tickets_to_processing_for_order(order)
      assert {:ok, %{unlocked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect checkedin" do
      order = insert(:order)
      ticket = insert(:ticket, status: "checkedin", order: order)
      multi = TicketState.unlock_tickets_to_processing_for_order(order)
      assert {:ok, %{unlocked_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
  end

  describe "purchase_processing_tickets_for_order" do
    test "does not affect available" do
      order = insert(:order)
      ticket = insert(:ticket, status: "available", order: order)
      multi = TicketState.purchase_processing_tickets_for_order(order)

      assert {:ok, %{purchased_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect locked tickets" do
      order = insert(:order)
      ticket = insert(:ticket, status: "locked", order: order)
      multi = TicketState.purchase_processing_tickets_for_order(order)

      assert {:ok, %{purchased_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end

    test "affects processing", %{timestamp: timestamp} do
      order = insert(:order)
      ticket = insert(:ticket, status: "processing", order: order)
      multi = TicketState.purchase_processing_tickets_for_order(order, timestamp)

      assert [
        purchased_processing_tickets: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == ~s(#Ecto.Query<from t in TicketAgent.Ticket, where: t.order_id == ^\"#{order.id}\", where: t.status == \"processing\">)
      assert updates == [set: [status: "purchased", locked_until: nil, purchased_at: timestamp]]

      {:ok, %{purchased_processing_tickets: {1, [updated_ticket]}}} = Repo.transaction(multi)
      assert ticket.id == updated_ticket.id

      ticket = Repo.reload(ticket)
      assert ticket.status == "purchased"
    end

    test "does not affect purchased" do
      order = insert(:order)
      ticket = insert(:ticket, status: "purchased", order: order)
      multi = TicketState.purchase_processing_tickets_for_order(order)
      assert {:ok, %{purchased_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect emailed" do
      order = insert(:order)
      ticket = insert(:ticket, status: "emailed", order: order)
      multi = TicketState.purchase_processing_tickets_for_order(order)
      assert {:ok, %{purchased_processing_tickets: {0, []}}} == Repo.transaction(multi)
    end
    
    test "does not affect checkedin" do
      order = insert(:order)
      ticket = insert(:ticket, status: "checkedin", order: order)
      multi = TicketState.purchase_processing_tickets_for_order(order)
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

  describe "lock_tickets" do
    test "it makes sure they are all updated", %{timestamp: timestamp} do
      order = insert(:order)
      listing = insert(:listing)
      tickets = Enum.map(1..5, fn(_) -> 
        insert(
          :ticket, 
          status: "available",
          locked_until: nil,
          order: nil,
          listing: listing,
          guest_name: nil,
          guest_email: nil
        ) 
      end)
      multi = TicketState.lock_tickets(listing.id, order.id, 5, timestamp)

      assert [
        lock_tickets: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == "#Ecto.Query<from t0 in TicketAgent.Ticket, join: t1 in subquery(from t in TicketAgent.Ticket,\n  where: t.listing_id == ^\"#{listing.id}\",\n  where: t.status == \"available\",\n  where: is_nil(t.locked_until),\n  where: is_nil(t.order_id),\n  where: is_nil(t.guest_name),\n  where: is_nil(t.guest_email),\n  limit: ^5), on: t1.id == t0.id>"

      assert updates == [set: [status: "locked", order_id: order.id, locked_until: timestamp]]

      {:ok, %{lock_tickets: {5, updated_tickets}}} = Repo.transaction(multi)
      Enum.each(tickets, fn(ticket) ->
        assert Enum.find(updated_tickets, fn(updated_ticket) -> updated_ticket.id == ticket.id end)
      end)
    end

    test "it locks the correct number", %{timestamp: timestamp} do
      order = insert(:order)
      listing = insert(:listing)
      tickets = Enum.map(1..5, fn(_) -> 
        insert(
          :ticket, 
          status: "available",
          locked_until: nil,
          order: nil,
          listing: listing,
          guest_name: nil,
          guest_email: nil
        ) 
      end)
      multi = TicketState.lock_tickets(listing.id, order.id, 3, timestamp)

      assert [
        lock_tickets: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == "#Ecto.Query<from t0 in TicketAgent.Ticket, join: t1 in subquery(from t in TicketAgent.Ticket,\n  where: t.listing_id == ^\"#{listing.id}\",\n  where: t.status == \"available\",\n  where: is_nil(t.locked_until),\n  where: is_nil(t.order_id),\n  where: is_nil(t.guest_name),\n  where: is_nil(t.guest_email),\n  limit: ^3), on: t1.id == t0.id>"

      assert updates == [set: [status: "locked", order_id: order.id, locked_until: timestamp]]

      {:ok, %{lock_tickets: {3, _}}} = Repo.transaction(multi)

      assert 3 == Enum.count(tickets, fn(ticket) ->
        ticket = Repo.reload(ticket)
        ticket.status == "locked"
      end)
      assert 2 == Enum.count(tickets, fn(ticket) ->
        ticket = Repo.reload(ticket)
        ticket.status == "available"
      end)      
      # Enum.each(tickets, fn(ticket) ->
      #   assert Enum.find(updated_tickets, fn(updated_ticket) -> updated_ticket.id == ticket.id end)
      # end)
    end  
    
    test "it maxes out", %{timestamp: timestamp} do
      order = insert(:order)
      listing = insert(:listing)
      tickets = Enum.map(1..5, fn(_) -> 
        insert(
          :ticket, 
          status: "available",
          locked_until: nil,
          order: nil,
          listing: listing,
          guest_name: nil,
          guest_email: nil
        ) 
      end)
      multi = TicketState.lock_tickets(listing.id, order.id, 15, timestamp)

      assert [
        lock_tickets: {:update_all, query, updates, [returning: true]}
      ] = Multi.to_list(multi)

      assert inspect(query) == "#Ecto.Query<from t0 in TicketAgent.Ticket, join: t1 in subquery(from t in TicketAgent.Ticket,\n  where: t.listing_id == ^\"#{listing.id}\",\n  where: t.status == \"available\",\n  where: is_nil(t.locked_until),\n  where: is_nil(t.order_id),\n  where: is_nil(t.guest_name),\n  where: is_nil(t.guest_email),\n  limit: ^15), on: t1.id == t0.id>"

      assert updates == [set: [status: "locked", order_id: order.id, locked_until: timestamp]]

      {:ok, %{lock_tickets: {5, updated_tickets}}} = Repo.transaction(multi)
      Enum.each(tickets, fn(ticket) ->
        assert Enum.find(updated_tickets, fn(updated_ticket) -> updated_ticket.id == ticket.id end)
      end)
    end    
  end

  describe "filter_created_tickets" do
    test "filters if they are all there" do
      listing = insert(:listing)
      order = insert(:order)
      
      ticket = insert(
        :ticket, 
        guest_name: "patrick",
        guest_email: "patrick@veverka.net",
        status: "locked", 
        listing: listing, 
        order: order
      )
      
      tickets = [%{"listing_id" => listing.id, "name" => ticket.guest_name, "email" => ticket.guest_email}]
      count = 
        TicketState.filter_created_tickets(order, listing.id, tickets)
        |> Enum.count
      
      assert count == 0
    end

    test "gets one to create" do
      listing = insert(:listing)
      order = insert(:order)
      
      ticket = insert(
        :ticket, 
        guest_name: "patrick",
        guest_email: "patrick@veverka.net",
        status: "locked", 
        listing: listing, 
        order: order
      )
      
      tickets = [
        %{
          "listing_id" => listing.id, 
          "name" => ticket.guest_name, 
          "email" => ticket.guest_email
        },
        %{
          "listing_id" => listing.id, 
          "name" => "James", 
          "email" => "james@pushcomedytheater.com"
        }        
      ]
      count = 
        TicketState.filter_created_tickets(order, listing.id, tickets)
        |> Enum.count
      
      assert count == 1
    end  

    test "gets 10 to create" do
      listing = insert(:listing)
      order = insert(:order)
      
      ticket = insert(
        :ticket, 
        guest_name: "patrick",
        guest_email: "patrick@veverka.net",
        status: "locked", 
        listing: listing, 
        order: order
      )
      
      tickets = [
        %{
          "listing_id" => listing.id, 
          "name" => ticket.guest_name, 
          "email" => ticket.guest_email
        }      
      ]

      tickets = Enum.reduce(1..10, tickets, fn(counter, acc) ->
        acc ++ [%{"listing_id" => listing.id, "name" => "James#{counter}", "email" => "james#{counter}@pushcomedytheater.com"}]
      end)
      count = 
        TicketState.filter_created_tickets(order, listing.id, tickets)
        |> Enum.count
      
      assert count == 10
    end      
  end

  describe "create_new_tickets" do
    test "doesn't create for empty tickets" do
      assert [] == TicketState.create_new_tickets([], nil, nil)
    end

    test "creates when none exist" do
      listing = insert(:listing)
      order = insert(:order)
      
      first = insert(
        :ticket,
        status: "available", 
        listing: listing,
        order: nil,
        locked_until: nil,
        guest_name: nil,
        guest_email: nil
      )

      ticket = insert(
        :ticket, 
        guest_name: "patrick",
        guest_email: "patrick@veverka.net",
        status: "locked", 
        listing: listing, 
        order: order
      )
      
      tickets = [
        %{
          "listing_id" => listing.id, 
          "name" => ticket.guest_name, 
          "email" => ticket.guest_email
        },
        %{
          "listing_id" => listing.id, 
          "name" => "James", 
          "email" => "james@pushcomedytheater.com"
        }        
      ]
      
      response = TicketState.create_new_tickets(tickets, listing.id, order.id)
      assert Enum.count(response) == 2

      first = Repo.reload(first)
      assert first.status == "locked"
    end
  end

  describe "reserve_tickets" do
    test "doesn't reserve anything if they are all reserved" do
      listing = insert(:listing)
      order = insert(:order)
      
      ticket = insert(
        :ticket, 
        guest_name: "patrick",
        guest_email: "patrick@veverka.net",
        status: "locked", 
        listing: listing, 
        order: order
      )
      
      tickets = [%{"listing_id" => listing.id, "name" => ticket.guest_name, "email" => ticket.guest_email}]
      {updated_order, updated_tickets, _} = TicketState.reserve_tickets(order, tickets)
      assert order == updated_order
      assert Enum.count(updated_tickets) == 1
    end
  end

  describe "load_minimum_locked_until" do
    test "gets the minimum" do
      timestamp = NaiveDateTime.utc_now()

      listing = insert(:listing)
      order = insert(:order)
      
      insert(
        :ticket, 
        status: "locked",
        listing: listing, 
        order: order,
        locked_until: timestamp
      )

      old_ticket = insert(
        :ticket, 
        status: "locked",
        listing: listing, 
        order: order,
        locked_until: (timestamp |> Calendar.NaiveDateTime.add!(300))
      )      
      
      {updated_order, tickets, locked_until} = TicketState.load_minimum_locked_until(order, listing.id)
      assert updated_order == order
      assert DateTime.to_iso8601(locked_until) == (NaiveDateTime.to_iso8601(timestamp) <> "Z")
      refute locked_until == old_ticket.locked_until
      refute DateTime.to_iso8601(locked_until) == (NaiveDateTime.to_iso8601(old_ticket.locked_until) <> "Z")
      assert Enum.count(tickets) == 2
    end
  end
end
