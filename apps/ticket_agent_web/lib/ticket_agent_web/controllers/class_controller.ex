defmodule TicketAgentWeb.ClassController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Class, Listing, Repo}
  alias TicketAgent.Finders.ListingFinder
  import Ecto.Query

  def index(conn, _params) do
    query = from c in Class,
            order_by: [c.type, c.menu_order],
            select: c

    classes = query
              |> Repo.all()
              |> Repo.preload(:prerequisite)
              |> Repo.preload(:listings)   
             
    render conn, "index.html", classes: classes
  end

  def class(conn, %{"type" => "currently_offered"}) do
    render conn, "class_list.html", classes: ListingFinder.active_class_listings, type: "Currently Offered"
  end  

  def class(conn, %{"type" => type}) do
    query = from c in Class,
            where: c.type == ^type,
            order_by: c.menu_order,
            select: c
    classes = query
              |> Repo.all()
              |> Repo.preload(:prerequisite)
              |> Repo.preload(:listings)

    render conn, "class_list.html", classes: classes, type: type
  end

  def show(conn, %{"id" => "currently_offered"}) do
    render conn, "show.html"
  end
  def show(conn, params) do
    slug = params["id"]
    query = from c in Class,
            where: c.slug == ^slug,
            select: c
    class = Repo.one(query)
            |> Repo.preload(:prerequisite)
            |> Repo.preload(:listings)
    render conn, "show.html", class: class
  end
end
