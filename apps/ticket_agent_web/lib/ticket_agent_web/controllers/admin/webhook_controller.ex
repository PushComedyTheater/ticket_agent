defmodule TicketAgentWeb.Admin.WebHookController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Repo, WebhookDetail}
  plug TicketAgentWeb.Plugs.MenuLoader, %{root: "webooks"}

  def index(conn, params) do
    details = Repo.paginate(WebhookDetail, params)

    conn
    |> assign(:details, details)
    |> render("index.html")
  end

  def show(conn, %{"id" => id}) do
    detail = Repo.get!(WebhookDetail, id)

    conn
    |> assign(:detail, detail)
    |> render("show.html")
  end

  # def edit(conn, %{"id" => id}) do
  #   teacher = Repo.get!(Teacher, id)
  #   changeset = Teacher.changeset(teacher, %{})

  #   conn
  #   |> assign(:teacher, teacher)
  #   |> assign(:changeset, changeset)
  #   |> render("edit.html")
  # end

  # def update(conn, %{"id" => id, "teacher" => teacher_params}) do
  #   teacher = Repo.get!(Teacher, id)
  #   changeset = Teacher.changeset(teacher, teacher_params)

  #   case Repo.update(changeset) do
  #     {:ok, teacher} ->
  #       conn
  #       |> put_flash(:info, "Teacher updated successfully.")
  #       |> redirect(to: admin_teacher_path(conn, :show, teacher))
  #     {:error, changeset} ->
  #       conn
  #       |> assign(:teacher, teacher)
  #       |> assign(:changeset, changeset)
  #       |> render("edit.html")
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   teacher = Repo.get!(Teacher, id)

  #   Repo.delete!(teacher)

  #   conn
  #   |> put_flash(:info, "Teacher deleted successfully.")
  #   |> redirect(to: admin_teacher_path(conn, :index))
  # end
end
