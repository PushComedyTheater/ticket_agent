defmodule TicketAgent.UserTest do
  use TicketAgent.DataCase
  alias TicketAgent.{Repo, User}

  describe "find_or_create_with_credentials" do
    test "find_or_create_with_credentials" do
      count = Enum.count(Repo.all(User))
      assert count == 0

      User.find_or_create_with_credentials(
        "Patrick Veverka",
        "patrick@veverka.net",
        "twitter",
        "blah",
        "blah"
      )

      count = Enum.count(Repo.all(User))
      assert count == 1
    end
  end
end
