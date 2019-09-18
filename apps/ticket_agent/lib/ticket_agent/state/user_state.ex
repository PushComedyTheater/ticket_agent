defmodule TicketAgent.State.UserState do
  require Logger
  alias TicketAgent.{CreditCard, Order, Repo}

  def store_card_for_order(user, order, card) do
    credit_card =
      %CreditCard{}
      |> CreditCard.changeset(%{
        user_id: user.id,
        stripe_id: card["id"],
        type: card["card_type"],
        name: card["name"],
        line_1_check: card["line_1_check"],
        zip_check: card["zip_check"],
        cvc_check: card["cvc_check"],
        exp_month: card["exp_month"],
        exp_year: card["exp_year"],
        funding: card["funding"],
        last_4: card["last4"],
        address: %{
          city: card["city"],
          country: card["card_country"],
          line1: card["line1"],
          line2: card["line2"],
          state: card["state"],
          zip: card["zip"]
        },
        metadata: card["metadata"]
      })
      |> Repo.insert!()

    order =
      order
      |> Order.changeset(%{
        credit_card_id: credit_card.id
      })
      |> Repo.update!()

    {:ok, credit_card}
  end
end
