defmodule TicketAgent.Finders.WaitlistFinder do
  require Logger
  import Ecto.Query
  alias TicketAgent.{Repo, Waitlist}

  def find_by_email_and_listing_id(nil, listing_id), do: nil
  def find_by_email_and_listing_id(email_address, listing_id) do
    query = from(
      w in Waitlist,
      where: w.listing_id == ^listing_id,
      where: w.email_address == ^email_address,
      limit: 1,
      select: w
    )

    Repo.all(query)
  end
end
