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
  
  # guest checkout
  def create(conn, %{"guest_checkout" => true, "total_price" => price, "token" => %{"token_id" => token_id}} = params) do
    Logger.info "Checking out a guest with token #{token_id}.  We only create a charge, no customer"

    process_orders_and_tickets(params["tickets"], conn.assigns.order)
    |> IO.inspect
    raise "fuck"
    metadata = %{
      "order_id" => conn.assigns.order.id,
      "order_slug" => conn.assigns.order.slug,
      "email" => params["email"],
      "ticket_count" => Enum.count(params["tickets"]),
      "listing_id" => conn.assigns.listing.id,
      "name" => params["name"]
    }

    description = "Tickets for #{conn.assigns.listing.title}"

    case Stripe.create_charge_with_token(token_id, price, description, conn.assigns.order.id, metadata) do
      {:ok, stripe_response} ->
        conn
        |> render("create.json", %{stripe_response: stripe_response})        
      {:error, reason} when is_map(reason) ->
        Logger.error "Stripe had an error with structure: #{inspect reason}"
        message = get_in(reason, ["error", "message"])
        conn
        |> put_status(422)
        |> render("error.json", %{reason: message})        
      {:error, reason} ->
        Logger.error "#{inspect reason}"
        conn
        |> put_status(422)
        |> render("error.json", %{reason: "There was an issue communicating with our credit card processor.  Please try again."})
    end
  end

  def create(conn, %{"guest_checkout" => false, "total_price" => price, "token" => %{"token_id" => token_id}} = params) do
    description = "Tickets for #{conn.assigns.listing.title}"
    current_user = Coherence.current_user(conn)

    # update all tickets

    {:ok, details} = process_orders_and_tickets(params["tickets"], conn.assigns.order)

    metadata = %{
      "order_id" => conn.assigns.order.id,
      "order_slug" => conn.assigns.order.slug,
      "email" => current_user.email,
      "ticket_count" => Enum.count(params["tickets"]),
      "listing_id" => conn.assigns.listing.id,
      "name" => current_user.name
    }

    with stripe_customer_id = User.get_stripe_customer_id(current_user),
         {:ok, user} <- Stripe.create_customer(token_id, current_user, stripe_customer_id),
         {:ok, stripe_response} <- Stripe.create_charge_with_customer(user.stripe_customer_id, price, description, conn.assigns.order.id, metadata) do
          Logger.info "stripe_customer_id = #{user.stripe_customer_id}"
          
          {:ok, details} = complete_orders_and_tickets(params["tickets"], conn.assigns.order)
          # update tickets
          # update order status

          conn
          |> render("create.json")    
    else 
      {:error, :stripe_error} ->
        conn
        |> put_status(422)
        |> render("error.json", %{reason: "There was an error with our credit card processor."})        
      anything ->
        IO.puts "ERROR"
        IO.inspect anything
        conn
        |> put_status(422)
        |> render("error.json", %{reason: "There was an error with our credit card processor."})  
    end
    

  end

  defp process_orders_and_tickets(tickets, order) do
    tickets
    |> Enum.map(fn(ticket) -> ticket["id"] end)
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
end
