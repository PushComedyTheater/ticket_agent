require Logger
import Ecto.Query

defmodule Seeds do
  def base_account do
    query = from a in TicketAgent.Account,
            limit: 1,
            select: a.id

    case TicketAgent.Repo.one(query) do
      nil ->
        Logger.info "SeedHelpers->base_account: Creating account"
        account =
          %TicketAgent.Account{
            name: "Push Comedy Theater",
            description: "Push Comedy Theater",
            url: "https://pushcomedytheater.com",
            enabled: true
          }
          |> TicketAgent.Repo.insert!()
        account.id
      account_id -> account_id
    end
  end

  def create_user(email, account_id, role \\ "admin") do
    query = from u in TicketAgent.User,
            where: u.email == ^email,
            select: u

    case TicketAgent.Repo.one(query) do
      nil ->
        Logger.info "SeedHelpers->create_user:  Creating user"

        changes = %{
          name: "Patrick Veverka",
          email: email,
          password: "supersecret",
          password_confirmation: "supersecret",
          account_id: account_id,
          role: role
        }

        user =
          %TicketAgent.User{}
          |> TicketAgent.User.changeset(changes)
          |> TicketAgent.Repo.insert!
        user.id
      user -> user.id
    end
  end
end

account = Seeds.base_account
user = Seeds.create_user("patrick@pushcomedytheater.com", account)
user = Seeds.create_user("concierge@veverka.net", account, "concierge")
