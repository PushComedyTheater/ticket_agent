defmodule TicketAgentWeb.Backend.TeacherController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Repo, Teacher}
  plug TicketAgentWeb.Plugs.MenuLoader, %{root: "teachers"}

  def index(conn, _params) do
    teachers = Repo.all(Teacher)

    conn
    |> assign(:teachers, teachers)
    |> render("index.html")
  end

  def new(conn, _params) do
    changeset = Teacher.changeset(%Teacher{}, %{})

    conn
    |> assign(:changeset, changeset)
    |> render("new.html")
  end

  def create(conn, %{"teacher" => teacher_params}) do
    changeset = Teacher.changeset(%Teacher{}, teacher_params)

    case Repo.insert(changeset) do
      {:ok, teacher} ->
        conn
        |> put_flash(:info, "Teacher created successfully.")
        |> redirect(to: admin_teacher_path(conn, :show, teacher))
      {:error, changeset} ->
        conn
        |> assign(:changeset, changeset)
        |> render("new.html")
    end
  end

  def show(conn, %{"id" => id}) do
    teacher = Repo.get!(Teacher, id)

    conn
    |> assign(:teacher, teacher)
    |> render("show.html")
  end

  def edit(conn, %{"id" => id}) do
    teacher = Repo.get!(Teacher, id)
    changeset = Teacher.changeset(teacher, %{})

    conn
    |> assign(:teacher, teacher)
    |> assign(:changeset, changeset)
    |> render("edit.html")
  end

  def update(conn, %{"id" => id, "teacher" => teacher_params}) do
    teacher = Repo.get!(Teacher, id)
    changeset = Teacher.changeset(teacher, teacher_params)

    case Repo.update(changeset) do
      {:ok, teacher} ->
        conn
        |> put_flash(:info, "Teacher updated successfully.")
        |> redirect(to: admin_teacher_path(conn, :show, teacher))
      {:error, changeset} ->
        conn
        |> assign(:teacher, teacher)
        |> assign(:changeset, changeset)
        |> render("edit.html")
    end
  end

  def delete(conn, %{"id" => id}) do
    teacher = Repo.get!(Teacher, id)

    Repo.delete!(teacher)

    conn
    |> put_flash(:info, "Teacher deleted successfully.")
    |> redirect(to: admin_teacher_path(conn, :index))
  end
end
