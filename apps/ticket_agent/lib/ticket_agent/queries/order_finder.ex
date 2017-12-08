defmodule TicketAgent.OrderFinder do
  import Ecto.Query
  alias TicketAgent.{Order, Repo}

  def find_started_order(email_address, total_price) do
    query =
      from(
        o in Order,
        where: o.email_address == ^email_address,
        where: o.total_price == ^total_price,
        where: o.status == "started",
        limit: 1,
        select: o
      )

    Repo.one(query)
  end
end
