defmodule TicketAgentWeb.ClassView do
  use TicketAgentWeb, :view
  alias TicketAgent.Repo
  alias TicketAgent.Class
  import Ecto.Query

  def classes_by_type(conn, type) do
    query = from c in Class,
            where: c.type == ^type,
            order_by: c.menu_order,
            select: c
    Repo.all(query)
  end
end
