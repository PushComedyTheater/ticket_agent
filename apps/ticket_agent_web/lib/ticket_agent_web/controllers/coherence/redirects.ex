defmodule Coherence.Redirects do
  @moduledoc """
  Define controller action redirection functions.

  This module contains default redirect functions for each of the controller
  actions that perform redirects. By using this Module you get the following
  functions:

  * session_create/2
  * session_delete/2
  * password_create/2
  * password_update/2,
  * unlock_create_not_locked/2
  * unlock_create_invalid/2
  * unlock_create/2
  * unlock_edit_not_locked/2
  * unlock_edit/2
  * unlock_edit_invalid/2
  * registration_create/2
  * invitation_create/2
  * confirmation_create/2
  * confirmation_edit_invalid/2
  * confirmation_edit_expired/2
  * confirmation_edit/2
  * confirmation_edit_error/2

  You can override any of the functions to customize the redirect path. Each
  function is passed the `conn` and `params` arguments from the controller.

  ## Examples

      import TicketAgentWeb.Router.Helpers

      # override the log out action back to the log in page
      def session_delete(conn, _), do: redirect(conn, to: session_path(conn, :new))

      # redirect the user to the login page after registering
      def registration_create(conn, _), do: redirect(conn, to: session_path(conn, :new))

      # disable the user_return_to feature on login
      def session_create(conn, _), do: redirect(conn, to: landing_path(conn, :index))

  """
  use Redirects
  # Uncomment the import below if adding overrides
  import TicketAgentWeb.Router.Helpers

  # Add function overrides below

  # Example usage
  # Uncomment the following line to return the user to the login form after logging out
  # def session_delete(conn, _), do: redirect(conn, to: session_path(conn, :new))
  def session_create(%{assigns: %{current_user: current_user}} = conn, _) do
    %Timber.Contexts.UserContext{
      id: current_user.id,
      name: current_user.name,
      email: current_user.email
    }
    |> Timber.add_context()

    url =
      case get_session(conn, "user_return_to") do
        nil -> "/dashboard"
        value -> value
      end

    conn
    |> put_session("user_return_to", nil)
    |> redirect(to: url)
  end

  # override the log out action back to the log in page
  # def session_delete(conn, _), do: redirect(conn, to: session_path(conn, :new))

  # redirect the user to the login page after registering
  def registration_create(conn, _), do: redirect(conn, to: session_path(conn, :new))

  def confirmation_edit(conn, _), do: redirect(conn, to: session_path(conn, :new))
end
