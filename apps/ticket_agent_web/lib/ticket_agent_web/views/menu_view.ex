defmodule TicketAgentWeb.MenuView do
  use TicketAgentWeb, :view
  alias TicketAgent.Repo
  alias TicketAgent.Class
  import Ecto.Query

  def is_admin(%{current_user: %{role: "admin"}}), do: true
  def is_admin(_), do: false

  def class_types(conn) do
    query = from c in Class,
            group_by: c.type,
            order_by: c.type,
            select: c.type
    Repo.all(query)
  end

  def classes_by_type(conn, type) do
    query = from c in Class,
            where: c.type == ^type,
            order_by: c.menu_order,
            select: c
    Repo.all(query)
  end

  def menu_class([], "/"), do: "nav-link g-py-7 active g-px-0"
  def menu_class(path_info, path) when hd(path_info) == path, do: "nav-link g-py-7 active g-px-0"
  def menu_class(_, _), do: "nav-link g-py-7 g-px-0"
  def show_breadcrumb(conn) do
    false
  end
end
