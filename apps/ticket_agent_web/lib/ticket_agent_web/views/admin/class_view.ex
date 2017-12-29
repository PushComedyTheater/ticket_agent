defmodule TicketAgentWeb.Admin.ClassView do
  alias TicketAgent.{Listing, Repo}
  import Ecto.Query
  use TicketAgentWeb, :view

  def current_class_listing(%{id: class_id} = class) do
    query = from listing in Listing,
            where: listing.class_id == ^class_id,
            where: fragment("? >= NOW()", listing.start_at),
            limit: 1,
            select: listing

    Repo.one(query)
  end
end
