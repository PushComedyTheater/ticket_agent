defmodule TicketAgent.Finders.CardFinder do
  import Ecto.Query
  alias TicketAgent.{CreditCard, Repo}

  def find_card(true, order, token) do
    token_card = token["card"]
    card = %{
      stripe_id: token_card["id"],
      order_id: order.id,
      type: token_card["brand"],
      name: token_card["name"],

      line_1_check: token_card["address_line1_check"],
      zip_check: token_card["address_zip_check"],
      cvc_check: token_card["cvc_check"],

      exp_month: token_card["exp_month"],
      exp_year: token_card["exp_year"],
      fingerprint: token_card["fingerprint"],
      funding: token_card["funding"],
      last_4: token_card["last_4"],

      address: %{
        line_1: token_card["address_line1"],
        line_2: token_card["address_line2"],
        city: token_card["address_city"],
        state: token_card["address_state"],
        zip: token_card["address_zip"],
        country: token_card["address_country"]
      },

      metadata: token_card["metadata"]
    }

    IO.inspect card





    Repo.get_by(CreditCard, stripe_id: card.stripe_id)
    |> IO.inspect

    case Repo.get_by(CreditCard, stripe_id: card.stripe_id) do
      {:ok, found_card} ->
        IO.inspect found_card
        found_card
        |> CreditCard.changeset(card)
        |> IO.inspect
        |> Repo.update!
      _ ->
        %CreditCard{}
        |> CreditCard.changeset(card)
        |> Repo.insert!
    end
    


    

    IO.inspect token    
  end

  def find_card(false, _, _) do
    
  end
end