defmodule TicketAgentWeb.TicketAuthController do
  use TicketAgentWeb, :controller
  use Coherence.Config
  alias Coherence.ControllerHelpers, as: Helpers
  alias Coherence.{Messages, Schemas}  
  plug TicketAgentWeb.Plugs.ShowLoader when action in [:new]

  def create(conn, %{"registration" => registration_params} = params) do
    user_schema = Config.user_schema
    :registration
    |> Helpers.changeset(user_schema, user_schema.__struct__, registration_params)
    |> Schemas.create
    |> case do
      {:ok, user} ->
        conn
        |> Helpers.send_confirmation(user, user_schema)
        |> Helpers.login_user(user, params)
        |> Helpers.redirect_to(:session_create, params)        
      {:error, changeset} ->
        conn
        |> put_flash(:error, "There was an error with your submission.")
        |> redirect(to: "/ticket_auth?show_id=" <> params["show_id"])
        |> halt()
    end
  end

  def new(conn, params) do
    message = """
      In order to complete your purchase, please login to (or create) your Push Comedy Theater account for the best experience.
      <br />
      <br />
      No account?  No problem!  You can always choose to checkout as a guest.
    """
    conn
    |> assign(:message, message)
    |> assign(:user_return_to, ticket_path(conn, :new, show_id: params["show_id"]))
    |> put_session("user_return_to", ticket_path(conn, :new, show_id: params["show_id"]))
    |> render(:new, email: "")
  end
end