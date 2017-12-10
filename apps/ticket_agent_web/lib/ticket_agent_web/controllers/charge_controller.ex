defmodule TicketAgentWeb.ChargeController do
  require Logger
  use TicketAgentWeb, :controller
  alias TicketAgent.{Listing, Order, Repo}
  alias TicketAgent.Finders.CardFinder
  alias TicketAgent.Services.Stripe
  import Ecto.Query
  plug TicketAgentWeb.LoadListing when action in [:create]
  plug TicketAgentWeb.LoadOrder when action in [:create]
  
  # guest checkout
  def create(conn, %{"guest_checkout" => true, "total_price" => price, "token" => %{"token_id" => token_id}} = params) do
    Logger.info "Checking out a guest with token #{token_id}.  We only create a charge, no customer"

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

  def create(conn, %{"guest_checkout" => false} = params) do

# user = TicketAgent.Repo.all(TicketAgent.User) |> hd
# TicketAgent.Coherence.UserEmail.confirmation(user, "http://google.com")
    price = params["total_price"]
    token = params["token"]
    token_id = token["token_id"]
    order_id = params["order_id"]
    guest_checkout = params["guest_checkout"]

    listing = Repo.get(Listing, params["listing_id"])
    order = Repo.get_by!(Order, slug: order_id)
    ticket_count = Enum.count(params["tickets"])

    description = "Tickets for #{listing.title}"
    IO.inspect description
    IO.inspect price
    IO.inspect token_id
    # IO.inspect listing
    # IO.inspect order
    IO.inspect ticket_count
    {:ok, response} = Stripe.create_customer(token_id, params["name"], params["email"])
    IO.inspect response

    customer_id = response["id"]
    metadata = %{"order_id" => order_id}
    
    
    result = Stripe.create_charge_with_customer(customer_id, price, description, metadata)
    IO.inspect result
  #   %{
  #     "email" => "jim@veverka.net", 
  #     "guest_checkout" => true,
  #     "listing_id" => "91981cee-936c-4402-9f1c-fa5b438e9e01",
  #     "method_name" => "basic-card", "name" => "Patrick Veverka",
  # "order_id" => "f24fc96e704b", "payer_email" => "patrick.veverka@gmail.com",
  # "payer_name" => "Patrick Veverka", "payer_phone" => "+17577453485",
  # "shippingOption" => nil, "shipping_address" => nil,
  # "tickets" => [%{"email" => "patrick1@veverka.net",
  #    "id" => "8d5f829c-178b-467f-be39-e54b87e445af",
  #    "locked_until" => "2017-12-10T01:38:36.284440",
  #    "name" => "Patrick1 Veverka", "status" => "locked"}],
  # "token" => %{"card" => %{"card_country" => "US", "card_type" => "Visa",
  #     "city" => "Virginia Beach", "country" => "US", "cvc_check" => "unchecked",
  #     "exp_month" => 12, "exp_year" => 2022, "funding" => "credit",
  #     "id" => "card_1BXJHXHtx4T3dZy7BWeRfNYD", "last4" => "4242",
  #     "line1" => "824 Moultrie Court", "line1_check" => "unchecked",
  #     "line2" => "", "metadata" => %{}, "name" => "Patrick Test",
  #     "state" => "VA", "zip" => "23455", "zip_check" => "unchecked"},
  #   "client_ip" => "71.120.237.161", "created" => 1512868023,
  #   "email" => "patrick.veverka@gmail.com", "livemode" => false,
  #   "token_id" => "tok_1BXJHXHtx4T3dZy7BAtpRFeF", "used" => false},
  # "total_price" => 1000}

    conn
    |> render("create.json")    
  end

  # def create(conn, %{"order_id" => order_slug, "token" => token} = params) do
  #   order = Repo.get_by!(Order, slug: order_slug)
  #   conn
  #   |> render("create.json")
  # end
end
