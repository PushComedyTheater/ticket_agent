defmodule TicketAgent.Finders.UserFinder do
  import Ecto.Query
  alias TicketAgent.{Repo, User}

  def find_by_email_stripe_id(email, stripe_customer_id) do
    Repo.get_by(User, email: email, stripe_customer_id: stripe_customer_id)
  end
end