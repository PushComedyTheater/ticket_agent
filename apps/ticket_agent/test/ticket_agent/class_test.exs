defmodule TicketAgent.ClassTest do
  use TicketAgent.DataCase
  alias TicketAgent.Class
  import TicketAgent.Factory

  describe "currently offered" do
    test "currently_offered? true" do
      class = insert(:class)
      insert(:listing, class: class, type: "class")
      assert Class.currently_offered?(class)
    end

    test "currently_offered? false" do
      class = insert(:class)

      refute Class.currently_offered?(class)
    end
  end

  # test "changeset with valid attributes" do
  #   changeset = Account.changeset(%Account{}, @valid_attrs)
  #   assert changeset.valid?
  # end
  #
  # test "changeset with invalid attributes" do
  #   changeset = Account.changeset(%Account{}, @invalid_attrs)
  #   refute changeset.valid?
  # end
end
