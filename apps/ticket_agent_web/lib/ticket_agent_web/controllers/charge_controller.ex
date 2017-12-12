defmodule TicketAgentWeb.ChargeController do
  require Logger
  use TicketAgentWeb, :controller
  alias TicketAgent.{Listing, Order, Repo, User}
  alias TicketAgent.Finders.CardFinder
  alias TicketAgent.Services.Stripe
  alias TicketAgent.State.{OrderState, TicketState}
  use Coherence.Config
  import Ecto.Query
  plug TicketAgentWeb.LoadListing when action in [:create]
  plug TicketAgentWeb.LoadOrder when action in [:create]
  
  # # guest checkout
  # def create(conn, %{"guest_checkout" => true, "total_price" => price, "token" => %{"token_id" => token_id}} = params) do
  #   Logger.info "Checking out a guest with token #{token_id}.  We only create a charge, no customer"

  #   process_orders_and_tickets(params["tickets"], conn.assigns.order)
  #   |> IO.inspect
  #   raise "fuck"
  #   metadata = load_metadata(nil, conn, params)

  #   description = "Tickets for #{conn.assigns.listing.title}"

  #   case Stripe.create_charge_with_token(token_id, price, description, conn.assigns.order.id, metadata) do
  #     {:ok, stripe_response} ->
  #       conn
  #       |> render("create.json", %{stripe_response: stripe_response})        
  #     {:error, reason} when is_map(reason) ->
  #       Logger.error "Stripe had an error with structure: #{inspect reason}"
  #       message = get_in(reason, ["error", "message"])
  #       conn
  #       |> put_status(422)
  #       |> render("error.json", %{reason: message})        
  #     {:error, reason} ->
  #       Logger.error "#{inspect reason}"
  #       conn
  #       |> put_status(422)
  #       |> render("error.json", %{reason: "There was an issue communicating with our credit card processor.  Please try again."})
  #   end
  # end

  # logged in user
  def create(conn, %{"total_price" => price, "tickets" => tickets, "listing_id" => listing_id, "token" => %{"token_id" => token_id}} = params) do
    description = "Tickets for #{conn.assigns.listing.title}"
    current_user = Coherence.current_user(conn)
    ticket_count = Enum.count(tickets)
    ticket_ids = Enum.map(tickets, fn(ticket) -> ticket["id"] end)
    
    Logger.info "current_user = #{inspect current_user}"
    order = conn.assigns.order

    case process_orders_and_tickets(ticket_ids, order) do
      {:ok, %{available_tickets: {^ticket_count, _}, processing_order: {1, _}}} -> 
        metadata = load_metadata(current_user, conn, params)

        current_user
        |> load_stripe_token(token_id, metadata)
        |> send_to_stripe(price, description, order.id, metadata)
        |> complete_orders_and_tickets(ticket_ids, order)

        conn
        |> render("create.json")    

      {:ok, anything} ->
        Logger.error "Didn't receive the correct response from the set processing transaction #{inspect anything}"
        release_tickets(tickets, listing_id, order)
        conn
        |> put_status(422)
        |> render("error.json", %{code: "refresh", reason: "There was an error.  Please try again"}) 
    end
  end

  defp complete_orders_and_tickets({:ok, details}, ticket_ids, order) do
    Logger.info "complete_orders_and_tickets"

    ticket_ids
    |> TicketState.set_tickets_purchased_transaction()
    |> Ecto.Multi.append(OrderState.set_order_completed_transaction(order))
    |> Repo.transaction
  end

  defp send_to_stripe({:customer, stripe_customer_id}, price, description, order_id, metadata) do
    Stripe.create_charge_with_customer(
      stripe_customer_id, 
      price, 
      description, 
      order_id, 
      metadata
    )    
  end

  defp send_to_stripe({:token, token_id}, price, description, order_id, metadata) do
    Stripe.create_charge_with_token(
      token_id, 
      price, 
      description, 
      order_id, 
      metadata
    )    
  end

  defp process_orders_and_tickets(ticket_ids, order) do
    Logger.info "process_orders_and_tickets"
    
    ticket_ids
    |> TicketState.set_tickets_processing_transaction()
    |> Ecto.Multi.append(OrderState.set_order_processing_transaction(order))
    |> Repo.transaction    
  end

  defp complete_orders_and_tickets(tickets, order) do
    tickets
    |> Enum.map(fn(ticket) -> ticket["id"] end)
    |> TicketState.set_tickets_purchased_transaction()
    |> Ecto.Multi.append(OrderState.set_order_completed_transaction(order))
    |> Repo.transaction    
  end

  defp release_tickets(tickets, listing_id, order) do
    order
    |> OrderState.release_order_tickets(listing_id, tickets)
  end

  defp load_metadata(nil, conn, params) do
    Logger.info "load_metadata for no current user"
    %{
      "order_id" => conn.assigns.order.id,
      "order_slug" => conn.assigns.order.slug,
      "email" => params["email"],
      "ticket_count" => Enum.count(params["tickets"]),
      "listing_id" => conn.assigns.listing.id,
      "name" => params["name"]
    }
    
  end

  defp load_metadata(current_user, conn, params) do
    Logger.info "load_metadata for current user"
    %{
      "order_id" => conn.assigns.order.id,
      "order_slug" => conn.assigns.order.slug,
      "email" => current_user.email,
      "ticket_count" => Enum.count(params["tickets"]),
      "listing_id" => conn.assigns.listing.id,
      "name" => current_user.name
    }    
  end

  defp load_stripe_token(nil, token_id, metadata), do: {:token, token_id}
  defp load_stripe_token(user, token_id, metadata) do
    case User.get_stripe_customer_id(user) do
      nil ->
        {:ok, user} = Stripe.create_customer(token_id, user, metadata)
        {:customer, user.stripe_customer_id}
      stripe_customer_id ->
        {:customer, stripe_customer_id}
    end
  end
end
