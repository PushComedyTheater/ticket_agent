defmodule TicketAgentWeb.Admin.ClassController do
  alias TicketAgent.Repo
  alias TicketAgent.Class
  import Ecto.Query
  use TicketAgentWeb, :controller

  def index(conn, _params) do

    query = from c in Class,
            order_by: c.type,
            select: c

    classes = Repo.all(query)

    render conn, "index.html", classes: classes
  end
end
