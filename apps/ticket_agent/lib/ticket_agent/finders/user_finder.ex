defmodule TicketAgent.Finders.UserFinder do
  import Ecto.Query
  alias TicketAgent.{Repo, User}

  def find_by_email_stripe_id(email, stripe_customer_id) do
    Repo.get_by(User, email: email, stripe_customer_id: stripe_customer_id)
  end

  def find_guest_by_email(email) do
    query =
      from(user in User,
        where: user.role == "guest",
        where: user.email == ^email,
        select: user
      )

    Repo.one(query)
  end

  def find_guest_by_token(token) do
    threshold = NaiveDateTime.add(NaiveDateTime.utc_now(), -600)

    query =
      from(user in User,
        where: user.role == "guest",
        where: user.one_time_token == ^token,
        where: user.one_time_token_at >= ^threshold,
        select: user
      )

    Repo.one(query)
  end
end
