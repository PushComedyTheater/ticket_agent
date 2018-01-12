defmodule TicketAgentWeb.ChargeController do
  require Logger
  use TicketAgentWeb, :controller
  alias TicketAgent.{Repo, User}
  alias TicketAgent.Services.Stripe
  alias TicketAgent.State.{ChargeProcessingState, OrderState, TicketState, UserState}
  use Coherence.Config
  plug TicketAgentWeb.LoadListing when action in [:create]
  plug TicketAgentWeb.LoadOrder when action in [:create]

  # logged in user
  def create(conn, %{"token" => token, "pricing" => pricing} = params) do
    description  = "Tickets for #{conn.assigns.listing.title}"
    current_user = Coherence.current_user(conn)
    order        = conn.assigns.order
    token_id     = token["token_id"]
    metadata     = load_metadata(current_user, conn, params)
    Logger.info "current_user = #{current_user.name}"
    Logger.info "order        = #{inspect order.slug}"
    Logger.info "token        = #{inspect token}"

    # set order to processing
    # set tickets to processing
    # get token from user or stripe
    # send to stripe
    # complete order
    # send ticket email

    with {:ok, {updated_order, updated_tickets}} <- ChargeProcessingState.set_order_processing_with_tickets(order),
         {:ok, stripe_customer_id}               <- Stripe.load_stripe_token(current_user, token_id, metadata),
         {:ok, response}                         <- Stripe.create_charge(order, current_user, description, token["client_ip"], metadata),
         {:ok, {updated_order, updated_tickets}} <- ChargeProcessingState.set_order_completed_with_tickets(updated_order),
         {:ok, credit_card}                      <- UserState.store_card_for_order(current_user, order, token["card"]) do
          conn
          |> render("create.json")
    else
      {:error, :missing_tickets} ->
        ChargeProcessingState.cancel_order_and_release_tickets(order)
        render_error(conn, "reset")    
      {:error, :ticket_processing_error} ->     
        Logger.error "charge_controller->create: tickets were not in proper state."
        ChargeProcessingState.cancel_order_and_release_tickets(order)
        render_error(conn, "reset")    
      error ->
        IO.inspect error
        ChargeProcessingState.cancel_order_and_release_tickets(order)
        render_error(conn, "reset")    
    end        
# raise "FUCK"

#     with {:ok, {updated_order, updated_tickets}} <- ChargeProcessingState.set_order_processing_with_tickets(order, ticket_ids),
#          {:ok, stripe_customer_id}               <- Stripe.load_stripe_token(current_user, token_id, metadata),
#          {:ok, _response} <- Stripe.create_charge(stripe_customer_id, order.total_price, description, updated_order, token["client_ip"], current_user, metadata),
#          {:ok, %{purchased_tickets: {^ticket_count, _updated_tickets}, completed_order: {1, _updated_order}}} <- set_order_completed_with_tickets(order, ticket_ids),
#          {:ok, credit_card} <- UserState.store_card_details(current_user, order, token["card"]),
#          {1, _} <- OrderState.set_credit_card_for_order(order, credit_card) do

#         # Task.start(fn ->
#         #   TicketAgent.Emails.OrderEmail.order_email
#         # end)

#     else
#       # # order or tickets couldn't be set properly, let's exit and flip out
#       # {:ok, %{processing_tickets: _, order_processing: _}} ->
#       #   Logger.error "There are no tickets or orders to update, this is bad, resetting"
#       #   cancel_order_and_release_tickets(order, ticket_ids)
#       #   render_error(conn, "reset")
#       # {:ok, %{purchased_tickets: _, completed_order: _}} ->
#       #   Logger.error "This is the end of the world.  We need to tell someone."
#       #   cancel_order_and_release_tickets(order, ticket_ids)
#       #   render_error(conn, "reset")
#       # {:token_error, message} when is_binary(message) ->
#       #   reset_order_and_tickets(order, ticket_ids)
#       #   render_error(conn, "continue", message)
#       error ->
#         Logger.error "Unmatched error "
#         Logger.error "#{inspect error}"
#         # reset_order_and_tickets(order, ticket_ids)
#         render_error(conn, "continue")
#     end
  end

  defp render_error(conn, code, message \\ "There was an error.  Please try again") do
    conn
    |> put_status(422)
    |> render("error.json", %{code: code, reason: message})
  end



  defp reset_order_and_tickets(order, ticket_ids) do
    ticket_ids
    |> TicketState.lock_processing_tickets(order)
    |> Ecto.Multi.append(OrderState.set_order_started(order))
    |> Repo.transaction
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
    %{
      "order_id" => conn.assigns.order.id,
      "order_slug" => conn.assigns.order.slug,
      "email" => current_user.email,
      "ticket_count" => Enum.count(params["tickets"]),
      "listing_id" => conn.assigns.listing.id,
      "name" => current_user.name
    }
  end
end
