defmodule TicketAgentWeb.ChargeController do
  require Logger
  use TicketAgentWeb, :controller
  alias TicketAgent.Services.Stripe
  alias TicketAgent.State.{ChargeProcessingState, UserState}
  alias TicketAgent.Emails.OrderEmail
  alias TicketAgent.Mailer
  alias TicketAgentWeb.ExceptionSender
  use Coherence.Config
  plug TicketAgentWeb.Plugs.LoadOrder when action in [:create]
  plug TicketAgentWeb.Plugs.LoadListing when action in [:create]

  def create(conn, %{"pricing" => %{"total" => 0}}) do
    Logger.info "THIS IS FREE"

    description  = "Tickets for #{conn.assigns.listing.title}"
    current_user = Coherence.current_user(conn)
    order        = conn.assigns.order
    token_id     = "FAKETOKEN"
    metadata     = load_metadata(conn)

    Logger.info "current_user = #{current_user.name}"
    Logger.info "order        = #{inspect order.slug}"
    Logger.info "metadata     = #{inspect metadata}"

    {:ok, {updated_order, _}} = ChargeProcessingState.set_order_processing_with_tickets(order)
    {:ok, {_, _}} = ChargeProcessingState.set_order_completed_with_tickets(updated_order)

    Task.start(fn ->
      Logger.info "Sending order receipt email #{order.id}"
      OrderEmail.order_receipt_email(order.id)
      |> Mailer.deliver!

      Logger.info "Sending admin email #{order.id}"
      OrderEmail.admin_order_receipt_email(order.id)
      |> Mailer.deliver!
    end)

    conn
    |> render("create.json")
  end

  # logged in user
  def create(conn, %{"token" => token}) do
    description  = "Tickets for #{conn.assigns.listing.title}"
    current_user = Coherence.current_user(conn)
    order        = conn.assigns.order
    token_id     = token["token_id"]
    metadata     = load_metadata(conn)

    Logger.info "current_user = #{current_user.name}"
    Logger.info "order        = #{inspect order.slug}"
    Logger.info "token        = #{inspect token}"
    Logger.info "metadata     = #{inspect metadata}"

    # set order to processing
    # set tickets to processing
    # get token from user or stripe
    # send to stripe
    # complete order
    # send ticket email

    with {:ok, {updated_order, _updated_tickets}}  <- ChargeProcessingState.set_order_processing_with_tickets(order),
         {:ok, updated_user}                       <- Stripe.load_stripe_token(current_user, token_id, metadata),
         {:ok, _response}                          <- Stripe.create_charge(order, updated_user, description, token["client_ip"], metadata),
         {:ok, {_updated_order, _updated_tickets}} <- ChargeProcessingState.set_order_completed_with_tickets(updated_order),
         {:ok, _credit_card}                       <- UserState.store_card_for_order(updated_user, order, token["card"]) do

          Task.start(fn ->
            Logger.info "Sending order receipt email #{order.id}"
            OrderEmail.order_receipt_email(order.id)
            |> Mailer.deliver!

            Logger.info "Sending admin email #{order.id}"
            OrderEmail.admin_order_receipt_email(order.id)
            |> Mailer.deliver!
          end)

          conn
          |> render("create.json")
    else
      error ->
        conn
        |> handle_error(error, order)
    end
  end

  def handle_error(conn, {:error, type}, order) when type in [:missing_tickets, :ticket_processing_error, :order_processing_error] do
    details =
      conn.params
      |> Map.merge(load_metadata(conn))
      |> Map.merge(%{error_type: type})

    type
    |> ExceptionSender.message()
    |> ExceptionSender.send(type, details)

    ChargeProcessingState.cancel_order_and_release_tickets(order)
    render_error(conn, "reset")
  end

  def handle_error(conn, {:error, type}, order) when type in [:token_error, :missing_stripe_customer_id] do
    details =
      conn.params
      |> Map.merge(load_metadata(conn))
      |> Map.merge(%{error_type: type})

    type
    |> ExceptionSender.message()
    |> ExceptionSender.send(type, details)

    ChargeProcessingState.reset_order_and_tickets(order)
    render_error(conn, "continue")
  end

  defp render_error(conn, code, message \\ "There was an error.  Please try again.") do
    conn
    |> put_status(422)
    |> render("error.json", %{code: code, reason: message})
  end

  defp load_metadata(conn) do
    user    = conn.assigns[:current_user]
    order   = conn.assigns.order
    listing = conn.assigns.listing

    %{
      "order_id"            => order.id,
      "order_slug"          => order.slug,
      "email"               => user.email,
      "params_ticket_count" => Enum.count(conn.params["tickets"]),
      "order_ticket_count"  => Enum.count(order.tickets),
      "listing_id"          => listing.id,
      "name"                => user.name,
      "user_id"             => user.id
    }
  end
end
