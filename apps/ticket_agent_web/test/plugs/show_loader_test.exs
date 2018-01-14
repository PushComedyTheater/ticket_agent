defmodule TicketAgentWeb.Plugs.ShowLoaderTest do
  use TicketAgentWeb.ConnCase, async: true
  import TicketAgent.Factory
  alias TicketAgentWeb.Plugs.ShowLoader

  setup %{conn: conn} do
    user = insert(:user)
    
    conn =
      conn
      |> assign(:current_user, user)

    {:ok, %{conn: conn}}
  end

  describe "call/2" do
    test "returns conn without listing" do
      conn =
        build_conn()
        |> Map.put(:params, %{"show_id" => "abc123"})
        |> ShowLoader.call([])
        
      assert html_response(conn, 404) =~ "Page&nbsp;Not&nbsp;Found"
    end

    test "returns conn with listing" do
      listing = insert(:listing, title: "apple")

      conn =
        build_conn()
        |> Map.put(:params, %{"show_id" => listing.slug})
        |> ShowLoader.call([])    
        
      assigns = conn.assigns

      refute assigns.has_purchased_tickets
      assert assigns.ticket_price == 0
      assert assigns.past_date
      assert assigns.page_title == "apple at Push Comedy Theater"
      assert assigns.page_description == "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam quis leo eu mauris tincidunt aliquam quis sed sapien. Donec tristique malesuada diam ut venenatis. Quisque bibendum scelerisque massa. Suspendisse potenti. Pellentesque odio lacus, cursus ut venenatis id, posuere vitae ligula. Morbi ..."
      assert is_nil(assigns.page_image)
      assert assigns.listing.id == listing.id
      assert is_nil(assigns.purchase_order)
      assert assigns.available_ticket_count == 0
    end

    test "returns conn with listing when params" do
      start_at = 
        NaiveDateTime.utc_now() 
        |> Calendar.NaiveDateTime.add!(1000)

      sale_start = 
        NaiveDateTime.utc_now() 
        |> Calendar.NaiveDateTime.subtract!(1000)

      listing = insert(
        :listing, 
        start_at: start_at, 
        title: "apple", 
        description: "boom"
      )
      ticket = insert(
        :ticket, 
        status: "available", 
        listing: listing,
        locked_until: nil,
        sale_start: sale_start,
        price: 500
      )

      assert ticket.listing == listing
      
      conn =
        build_conn()
        |> Map.put(:params, %{"show_id" => listing.slug})
        |> ShowLoader.call([])    
        
      assigns = conn.assigns

      refute assigns.has_purchased_tickets
      assert assigns.ticket_price == 500
      refute assigns.past_date
      assert assigns.page_title == "apple at Push Comedy Theater"
      assert assigns.page_description == "boom"
      assert is_nil(assigns.page_image)
      assert assigns.listing.id == listing.id
      assert is_nil(assigns.purchase_order)
      assert assigns.available_ticket_count == 1
    end    

    test "returns conn with user with listing when params and order", %{conn: conn} do
      start_at = 
        NaiveDateTime.utc_now() 
        |> Calendar.NaiveDateTime.add!(1000)

      sale_start = 
        NaiveDateTime.utc_now() 
        |> Calendar.NaiveDateTime.subtract!(1000)

      listing = insert(
        :listing, 
        start_at: start_at, 
        title: "apple", 
        description: "boom"
      )

      order = insert(
        :order,
        user: conn.assigns.current_user
      )

      insert(
        :ticket, 
        status: "purchased", 
        listing: listing,
        locked_until: nil,
        sale_start: sale_start,
        order: order,
        price: 500
      )

      ticket = insert(
        :ticket, 
        status: "available", 
        listing: listing,
        locked_until: nil,
        sale_start: sale_start,
        price: 500
      )      
      assert ticket.listing == listing
      
      conn =
        conn
        |> Map.put(:params, %{"show_id" => listing.slug})
        |> ShowLoader.call([])    
        
      assigns = conn.assigns

      assert assigns.has_purchased_tickets
      assert assigns.ticket_price == 500
      refute assigns.past_date
      assert assigns.page_title == "apple at Push Comedy Theater"
      assert assigns.page_description == "boom"
      assert is_nil(assigns.page_image)
      assert assigns.listing.id == listing.id
      refute is_nil(assigns.purchase_order)
      assert order.id == assigns.purchase_order.id
      assert assigns.available_ticket_count == 1
    end        

    test "returns conn with user with listing when params and multiple order", %{conn: conn} do
      start_at = 
        NaiveDateTime.utc_now() 
        |> Calendar.NaiveDateTime.add!(1000)

      sale_start = 
        NaiveDateTime.utc_now() 
        |> Calendar.NaiveDateTime.subtract!(1000)

      listing = insert(
        :listing, 
        start_at: start_at, 
        title: "apple", 
        description: "boom"
      )

      order = insert(
        :order,
        user: conn.assigns.current_user
      )

      insert(
        :ticket, 
        status: "purchased", 
        listing: listing,
        locked_until: nil,
        sale_start: sale_start,
        order: order,
        price: 500
      )

      order = insert(
        :order,
        user: conn.assigns.current_user
      )      

      insert(
        :ticket, 
        status: "purchased", 
        listing: listing,
        locked_until: nil,
        sale_start: sale_start,
        order: order,
        price: 500
      )      

      ticket = insert(
        :ticket, 
        status: "available", 
        listing: listing,
        locked_until: nil,
        sale_start: sale_start,
        price: 500
      )      
      assert ticket.listing == listing
      
      conn =
        conn
        |> Map.put(:params, %{"show_id" => listing.slug})
        |> ShowLoader.call([])    
        
      assigns = conn.assigns

      assert assigns.has_purchased_tickets
      assert assigns.ticket_price == 500
      refute assigns.past_date
      assert assigns.page_title == "apple at Push Comedy Theater"
      assert assigns.page_description == "boom"
      assert is_nil(assigns.page_image)
      assert assigns.listing.id == listing.id
      refute is_nil(assigns.purchase_order)
      assert assigns.available_ticket_count == 1
    end            
  end
end
