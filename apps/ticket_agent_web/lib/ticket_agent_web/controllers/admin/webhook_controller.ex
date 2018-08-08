defmodule TicketAgentWeb.Admin.WebHookController do
  use TicketAgentWeb, :controller
  import Ecto.Query
  alias TicketAgent.{Repo, WebhookDetail}

  plug(TicketAgentWeb.Plugs.DatatablesParamParser, %{schema: Listing})
  plug(TicketAgentWeb.Plugs.MenuLoader, %{root: "webhooks"})

  def index(conn, %{"_format" => "json"} = params) do
    records = retrieve_records(conn)

    render(
      conn,
      "index.json",
      records: records,
      page_number: conn.assigns.page_number,
      draw_number: conn.assigns.draw_number
    )
  end

  def index(conn, params) do
    conn
    |> render("index.html")
  end

  def show(conn, %{"id" => id}) do
    detail = Repo.get!(WebhookDetail, id)

    conn
    |> assign(:detail, detail)
    |> render("show.html")
  end

  defp retrieve_records(
         %Plug.Conn{
           assigns: %{
             page_size: page_size,
             page_number: page_number,
             search_term: search_term,
             sort_column: sort_column,
             sort_dir: sort_dir
           }
         } = conn
       ) do
    query =
      from(
        l in WebhookDetail,
        select: l
      )

    Repo.paginate(query, page: page_number, page_size: page_size)
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
