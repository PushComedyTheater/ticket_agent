defmodule TicketAgentWeb.ChargeController do
  require Logger
  use TicketAgentWeb, :controller
  alias TicketAgent.{Listing, Order, Repo, User}
  alias TicketAgent.Finders.CardFinder
  alias TicketAgent.Services.Stripe
  alias TicketAgent.State.{OrderState, TicketState, UserState}
  use Coherence.Config
  import Ecto.Query
  plug TicketAgentWeb.LoadListing when action in [:create]
  plug TicketAgentWeb.LoadOrder when action in [:create]

  # logged in user
  def create(conn, %{"tickets" => tickets, "token" => token, "pricing" => pricing} = params) do
    description  = "Tickets for #{conn.assigns.listing.title}"
    current_user = Coherence.current_user(conn)
    ticket_count = Enum.count(tickets)
    ticket_ids   = Enum.map(tickets, fn(ticket) -> ticket["id"] end)
    order        = conn.assigns.order
    price        = pricing["total"]
    token_id     = token["token_id"]
    metadata     = load_metadata(current_user, conn, params)

    Logger.info "ticket_ids   = #{inspect ticket_ids}"
    Logger.info "current_user = #{current_user.name}"
    Logger.info "order        = #{inspect order}"
    Logger.info "token        = #{inspect token}"

    # set order to processing
    # set tickets to processing
    # get token from user or stripe
    # send to stripe
    # complete order

    with {:ok, %{processing_tickets: {^ticket_count, updated_tickets}, order_processing: {1, updated_order}}} <- set_order_and_tickets_processing(order, ticket_ids),
         {:ok, stripe_customer_id} <- load_stripe_token(current_user, token_id, metadata),
         {:ok, response} <- Stripe.create_charge(stripe_customer_id, price, description, order.id, token["client_ip"], metadata),
         {:ok, %{purchased_tickets: {^ticket_count, updated_tickets}, completed_order: {1, updated_order}}} <- set_order_and_tickets_completed(order, ticket_ids),
         {:ok, credit_card} <- UserState.store_card_details(current_user, order, token["card"]),
         {1, _} <- OrderState.set_credit_card_for_order(order, credit_card) do

        conn
        |> render("create.json")
    else
      # order or tickets couldn't be set properly, let's exit and flip out
      {:ok, %{processing_tickets: _, order_processing: _}} ->
        Logger.error "There are no tickets or orders to update, this is bad, resetting"
        release_order_and_tickets(order, ticket_ids)
        render_error(conn, "reset")
      {:ok, %{purchased_tickets: _, completed_order: _}} ->
        Logger.error "This is the end of the world.  We need to tell someone."
        release_order_and_tickets(order, ticket_ids)
        render_error(conn, "reset")
      {:token_error, message} when is_binary(message) ->
        reset_order_and_tickets(order, ticket_ids)
        render_error(conn, "continue", message)
      error ->
        Logger.error "Unmatched error "
        Logger.error "#{inspect error}"
        reset_order_and_tickets(order, ticket_ids)
        render_error(conn, "continue")
    end
  end

  defp render_error(conn, code, message \\ "There was an error.  Please try again") do
    conn
    |> put_status(422)
    |> render("error.json", %{code: code, reason: message})
  end

  defp set_order_and_tickets_processing(order, ticket_ids) do
    ticket_ids
    |> TicketState.set_tickets_processing_transaction(order.id)
    |> Ecto.Multi.append(OrderState.set_order_processing_transaction(order))
    |> Repo.transaction
  end

  defp set_order_and_tickets_completed(order, ticket_ids) do
    ticket_ids
    |> TicketState.set_tickets_purchased_transaction(order.id)
    |> Ecto.Multi.append(OrderState.set_order_completed_transaction(order))
    |> Repo.transaction
  end

  defp release_order_and_tickets(order, ticket_ids) do
    order
    |> TicketState.release_tickets(ticket_ids)
    |> Ecto.Multi.append(OrderState.release_order(order))
    |> Repo.transaction
  end

  defp reset_order_and_tickets(order, ticket_ids) do
    ticket_ids
    |> TicketState.set_tickets_locked_transaction(order.id)
    |> Ecto.Multi.append(OrderState.set_order_started_transaction(order))
    |> Repo.transaction
  end





  defp load_stripe_token(user, token_id, metadata) do
    Logger.info "load_stripe_token -> #{token_id}"

    case User.get_stripe_customer_id(user) do
      nil ->
        case Stripe.create_customer(token_id, user, metadata) do
          {:error, error} ->
            Logger.error "Could not create customer because: #{inspect error}"
            {:token_error, error["message"]}
          {:ok, user} ->
            {:ok, user.stripe_customer_id}
        end
      stripe_customer_id ->
        Logger.info "Found existing customer id"
        {:ok, stripe_customer_id}
    end
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
