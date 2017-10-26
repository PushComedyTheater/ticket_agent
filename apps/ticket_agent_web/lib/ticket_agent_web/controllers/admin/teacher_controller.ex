defmodule TicketAgentWeb.Admin.TeacherController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Teacher, TeacherContext}

  def index(conn, _params) do
    teachers = TeacherContext.list_teachers()
    render(conn, "index.html", teachers: teachers)
  end

  # def new(conn, _params) do
  #   changeset = Teachers.change_context(%Context{})
  #   render(conn, "new.html", changeset: changeset)
  # end
  #
  # def create(conn, %{"context" => context_params}) do
  #   case Teachers.create_context(context_params) do
  #     {:ok, context} ->
  #       conn
  #       |> put_flash(:info, "Context created successfully.")
  #       |> redirect(to: context_path(conn, :show, context))
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end
  #
  # def show(conn, %{"id" => id}) do
  #   context = Teachers.get_context!(id)
  #   render(conn, "show.html", context: context)
  # end
  #
  # def edit(conn, %{"id" => id}) do
  #   context = Teachers.get_context!(id)
  #   changeset = Teachers.change_context(context)
  #   render(conn, "edit.html", context: context, changeset: changeset)
  # end
  #
  # def update(conn, %{"id" => id, "context" => context_params}) do
  #   context = Teachers.get_context!(id)
  #
  #   case Teachers.update_context(context, context_params) do
  #     {:ok, context} ->
  #       conn
  #       |> put_flash(:info, "Context updated successfully.")
  #       |> redirect(to: context_path(conn, :show, context))
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", context: context, changeset: changeset)
  #   end
  # end
  #
  # def delete(conn, %{"id" => id}) do
  #   context = Teachers.get_context!(id)
  #   {:ok, _context} = Teachers.delete_context(context)
  #
  #   conn
  #   |> put_flash(:info, "Context deleted successfully.")
  #   |> redirect(to: context_path(conn, :index))
  # end
end
