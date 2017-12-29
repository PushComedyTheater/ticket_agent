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

  def show(conn, %{"id" => id}) do
    class = load_class(id)
    render(conn, "show.html", class: class)
  end

  def edit(conn, %{"id" => id}) do
    class = load_class(id)
    render(conn, "edit.html", load_form_details(class))
  end

  def update(conn, %{"id" => id, "class" => class_params}) do
    class = load_class(id)
    changeset = Class.changeset(class, class_params)

    case Repo.update(changeset) do
      {:ok, class} ->
        conn
        |> put_flash(:info, "Class updated successfully.")
        |> redirect(to: admin_class_path(conn, :show, class))
      {:error, changeset} ->
        render(conn, "edit.html", load_form_details(class))
    end
  end

  def load_form_details(class) do
    classes = Repo.all(Class)
              |> Enum.map(&{&1.title, &1.id})

    class_types = [
      "Improv": "improvisation",
      "Sketch": "sketch",
      "Standup": "standup",
      "Acting": "acting"
    ]
    changeset = Class.changeset(class, %{})

    [
      class: class,
      classes: classes,
      class_types: class_types,
      changeset: changeset
    ]
  end

  def load_class(id) do
    Repo.get_by!(Class, [slug: id])
    |> Repo.preload(:prerequisite)
  end
end
