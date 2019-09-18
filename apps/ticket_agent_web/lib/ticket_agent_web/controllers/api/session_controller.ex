defmodule TicketAgentWeb.Api.SessionController do
  alias TicketAgent.User
  use Coherence.Config
  alias Coherence.ControllerHelpers, as: Helpers
  alias Coherence.{Messages, Schemas}
  use TicketAgentWeb, :controller

  def index(conn, _params) do
    render(conn, "index.json",
      logged_in: Coherence.logged_in?(conn),
      user: Coherence.current_user(conn)
    )
  end

  def create(conn, params) do
    email_address = get_in(params, ["session", "email"])
    password = get_in(params, ["session", "password"])

    {user, conn} =
      email_address
      |> Coherence.Schemas.get_user_by_email()
      |> check_login(password, conn)

    if user do
      conn
      |> put_status(200)
      |> render("user.json", user: user)
    else
      message = Map.get(conn.private, :api_error_message, "Error")

      conn
      |> put_status(422)
      |> put_view(TicketAgentWeb.ErrorView)
      |> render("error.json", message: message)
    end
  end

  defp check_login(conn, nil, _) do
    conn
  end

  defp check_login(nil, _, conn) do
    conn =
      conn
      |> put_private(
        :api_error_message,
        Messages.backend().incorrect_login_or_password(login_field: Config.login_field())
      )

    {nil, conn}
  end

  defp check_login(user, password, conn) do
    case User.checkpw(password, user.password_hash) do
      true ->
        locked = User.lockable?() and User.locked?(user)

        if locked do
          Helpers.unlock!(user)
        end

        conn =
          Config.auth_module()
          |> apply(Config.create_login(), [conn, user, [id_key: Config.schema_key()]])

        {user, conn}

      _ ->
        conn =
          conn
          |> failed_login(user, User.lockable?())
          |> put_private(
            :api_error_message,
            Messages.backend().incorrect_login_or_password(login_field: Config.login_field())
          )

        {nil, conn}
    end
  end

  defp failed_login(conn, %{} = user, true) do
    attempts = user.failed_attempts + 1

    {conn, flash, params} =
      if attempts >= Config.max_failed_login_attempts() do
        new_conn =
          conn
          |> assign(:locked, true)

        {new_conn, Messages.backend().maximum_login_attempts_exceeded(),
         %{locked_at: Ecto.DateTime.utc()}}
      else
        {conn, Messages.backend().incorrect_login_or_password(login_field: Config.login_field()),
         %{}}
      end

    :session
    |> Helpers.changeset(user.__struct__, user, Map.put(params, :failed_attempts, attempts))
    |> Schemas.update()

    put_private(conn, :api_error_message, flash)
  end

  defp failed_login(conn, _user, _),
    do:
      put_flash(
        conn,
        :error,
        Messages.backend().incorrect_login_or_password(login_field: Config.login_field())
      )
end
