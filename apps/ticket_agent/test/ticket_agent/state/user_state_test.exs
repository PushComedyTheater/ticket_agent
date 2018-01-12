defmodule TicketAgent.State.UserStateTest do
  import TicketAgent.Factory
  use TicketAgent.DataCase, async: false
  alias TicketAgent.State.UserState
  alias TicketAgent.{CreditCard, Repo}

  setup do
    user = insert(:user)
    {:ok, user: user}
  end

  describe "store_card_for_order" do
    test "inserts card details", %{user: user} do
      assert Enum.count(Repo.all(CreditCard)) == 0
      card = %{
        "card_country" => "US", 
        "card_type" => "Visa", 
        "city" => "Virginia Beach", 
        "country" => "US", 
        "cvc_check" => "unchecked", 
        "exp_month" => 12, 
        "exp_year" => 2022, 
        "funding" => "credit", 
        "id" => "card_1BivrgBwsbTzoyHbaYq6EcsS", 
        "last4" => "4242", 
        "line1" => "824 Moultrie Court", 
        "line1_check" => "unchecked", 
        "line2" => "", 
        "metadata" => %{}, 
        "name" => "Patrick Test", 
        "state" => "VA", 
        "zip" => "23455", 
        "zip_check" => "unchecked"
      }
      order = insert(:order, credit_card: nil)
      assert Enum.count(Repo.all(CreditCard)) == 0
      
      UserState.store_card_for_order(user, order, card)
      
      assert Enum.count(Repo.all(CreditCard)) == 1
      inserted_card = Repo.all(CreditCard) |> hd
      refute is_nil(inserted_card)
      
      inserted_card_address       = Map.get(inserted_card, :address)
      assert card["city"]         == inserted_card_address["city"]
      assert card["card_country"] == inserted_card_address["country"]
      assert card["line1"]        == inserted_card_address["line1"]
      assert card["line2"]        == inserted_card_address["line2"]
      assert card["state"]        == inserted_card_address["state"]
      assert card["zip"]          == inserted_card_address["zip"]

      card_cvc_check          = card["cvc_check"]
      inserted_card_cvc_check = Map.get(inserted_card, :cvc_check)
      assert card_cvc_check   == inserted_card_cvc_check

      card_exp_month          = card["exp_month"]
      inserted_card_exp_month = Map.get(inserted_card, :exp_month)
      assert card_exp_month   == inserted_card_exp_month

      card_exp_year          = card["exp_year"]
      inserted_card_exp_year = Map.get(inserted_card, :exp_year)
      assert card_exp_year   == inserted_card_exp_year

      card_fingerprint          = card["fingerprint"]
      inserted_card_fingerprint = Map.get(inserted_card, :fingerprint)
      assert card_fingerprint == inserted_card_fingerprint

      card_funding          = card["funding"]
      inserted_card_funding = Map.get(inserted_card, :funding)
      assert card_funding == inserted_card_funding

      card_id          = card["id"]
      inserted_card_id = Map.get(inserted_card, :stripe_id)
      assert card_id == inserted_card_id

      card_last_4          = card["last4"]
      inserted_card_last_4 = Map.get(inserted_card, :last_4)
      assert card_last_4 == inserted_card_last_4

      card_line_1_check          = card["line_1_check"]
      inserted_card_line_1_check = Map.get(inserted_card, :line_1_check)
      assert card_line_1_check == inserted_card_line_1_check

      card_metadata          = card["metadata"]
      inserted_card_metadata = Map.get(inserted_card, :metadata)
      assert card_metadata == inserted_card_metadata

      card_name          = card["name"]
      inserted_card_name = Map.get(inserted_card, :name)
      assert card_name == inserted_card_name

      card_type          = card["card_type"]
      inserted_card_type = Map.get(inserted_card, :type)
      assert card_type == inserted_card_type

      card_zip_check          = card["zip_check"]
      inserted_card_zip_check = Map.get(inserted_card, :zip_check)
      assert card_zip_check == inserted_card_zip_check

      order = Repo.reload(order)
      assert order.credit_card_id == inserted_card.id
    end

    test "handles missing ok", %{user: user} do
      assert Enum.count(Repo.all(CreditCard)) == 0
      card = %{
        "card_type" => "Visa", 
        "funding" => "credit", 
        "id" => "card_1BivrgBwsbTzoyHbaYq6EcsS", 
        "last4" => "4242", 
        "line1" => "824 Moultrie Court", 
        "line1_check" => "unchecked", 
        "line2" => "", 
        "metadata" => %{}, 
        "name" => "Patrick Test", 
        "state" => "VA", 
        "zip" => "23455", 
        "zip_check" => "unchecked"
      }
      order = insert(:order, credit_card: nil)
      assert Enum.count(Repo.all(CreditCard)) == 0
      
      UserState.store_card_for_order(user, order, card)
      
      assert Enum.count(Repo.all(CreditCard)) == 1
      inserted_card = Repo.all(CreditCard) |> hd
      refute is_nil(inserted_card)
      
      inserted_card_address       = Map.get(inserted_card, :address)
      assert card["city"]         == inserted_card_address["city"]
      assert card["card_country"] == inserted_card_address["country"]
      assert card["line1"]        == inserted_card_address["line1"]
      assert card["line2"]        == inserted_card_address["line2"]
      assert card["state"]        == inserted_card_address["state"]
      assert card["zip"]          == inserted_card_address["zip"]

      card_cvc_check          = card["cvc_check"]
      inserted_card_cvc_check = Map.get(inserted_card, :cvc_check)
      assert card_cvc_check   == inserted_card_cvc_check

      card_exp_month          = card["exp_month"]
      inserted_card_exp_month = Map.get(inserted_card, :exp_month)
      assert card_exp_month   == inserted_card_exp_month

      card_exp_year          = card["exp_year"]
      inserted_card_exp_year = Map.get(inserted_card, :exp_year)
      assert card_exp_year   == inserted_card_exp_year

      card_fingerprint          = card["fingerprint"]
      inserted_card_fingerprint = Map.get(inserted_card, :fingerprint)
      assert card_fingerprint == inserted_card_fingerprint

      card_funding          = card["funding"]
      inserted_card_funding = Map.get(inserted_card, :funding)
      assert card_funding == inserted_card_funding

      card_id          = card["id"]
      inserted_card_id = Map.get(inserted_card, :stripe_id)
      assert card_id == inserted_card_id

      card_last_4          = card["last4"]
      inserted_card_last_4 = Map.get(inserted_card, :last_4)
      assert card_last_4 == inserted_card_last_4

      card_line_1_check          = card["line_1_check"]
      inserted_card_line_1_check = Map.get(inserted_card, :line_1_check)
      assert card_line_1_check == inserted_card_line_1_check

      card_metadata          = card["metadata"]
      inserted_card_metadata = Map.get(inserted_card, :metadata)
      assert card_metadata == inserted_card_metadata

      card_name          = card["name"]
      inserted_card_name = Map.get(inserted_card, :name)
      assert card_name == inserted_card_name

      card_type          = card["card_type"]
      inserted_card_type = Map.get(inserted_card, :type)
      assert card_type == inserted_card_type

      card_zip_check          = card["zip_check"]
      inserted_card_zip_check = Map.get(inserted_card, :zip_check)
      assert card_zip_check == inserted_card_zip_check
    end    
  end
end
