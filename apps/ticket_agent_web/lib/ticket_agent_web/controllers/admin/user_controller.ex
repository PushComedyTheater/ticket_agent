defmodule TicketAgentWeb.Admin.UserController do
  require Logger
  use TicketAgentWeb, :controller
  alias TicketAgent.User
  plug(TicketAgentWeb.Plugs.MenuLoader, %{root: "teachers"})

  def index(conn, params) do
    page = User.list_users(params)

    render(
      conn,
      "index.html",
      users: page
    )
  end

  def new(conn, _params) do
    changeset = User.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    user_params =
      Map.merge(user_params, %{
        "password" => "supersecret",
        "password_confirmation" => "supersecret"
      })

    case User.create_user(user_params) do
      {:ok, %{model: user}} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: admin_user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = User.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = User.get_user!(id)
    changeset = User.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = User.get_user!(id)

    if user.role != user_params["role"] do
      Logger.warn(
        "Role for user #{user.id} is changing from #{user.role} to #{user_params["role"]}"
      )
    end

    case User.update_user(user, user_params, Coherence.current_user(conn)) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: admin_user_path(conn, :show, user.model.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = User.get_user!(id)
    {:ok, _user} = User.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: admin_user_path(conn, :index))
  end
end
