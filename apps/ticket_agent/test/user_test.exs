defmodule TicketAgent.UserTest do
  import TicketAgent.Factory
  use TicketAgent.DataCase
  alias TicketAgent.{Repo, User}

  describe "boom" do
    test "bb" do
      user = insert(:user)

      User.changeset(
        user,
        %{
          password: "123456789"
        },
      :password)
      |> Repo.update()

      admin = insert(:user)
      User.admin_update_user(
        user,
        %{"name" => "Patrick Veverkas", "role" => "admin", "stripe_customer_id" => "cus_Cs85cPRtCyzxKG"},
        admin)

      ticket =
        Repo.all(PaperTrail.Version)
        |> hd
        |> IO.inspect

    end
  end
end
