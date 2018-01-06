defmodule TicketAgent.State.UserState do
  require Logger
  alias TicketAgent.{CreditCard, Repo}

  def store_card_details(user, order, card) do
    %CreditCard{}
    |> CreditCard.changeset(%{
      user_id: user.id,
      order_id: order.id,
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
    |> Repo.insert
  end
end
