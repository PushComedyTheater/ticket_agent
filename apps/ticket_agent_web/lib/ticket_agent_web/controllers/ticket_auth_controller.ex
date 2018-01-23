defmodule TicketAgentWeb.TicketAuthController do
  use TicketAgentWeb, :controller
  use Coherence.Config
  alias Coherence.ControllerHelpers, as: Helpers
  alias Coherence.Schemas
  alias TicketAgent.{Repo, User}
  alias TicketAgent.Mailer
  alias TicketAgent.Emails.OneTimeLogin
  alias TicketAgent.Finders.UserFinder
  plug TicketAgentWeb.Plugs.TicketInfoLoader when action in [:new]
  # plug TicketAgentWeb.Plugs.ShowLoader when action in [:new]

  def new(conn, %{"listing_id" => listing_id}) do
    if Coherence.logged_in?(conn) do
      conn
      |> redirect(to: ticket_path(conn, :new, %{listing_id: listing_id}))
    else
      message = """
        In order to complete your purchase, please login to (or create) your Push Comedy Theater account for the best experience.
        <br />
        <br />
        No account?  No problem!  You can always choose to checkout as a guest.
      """
      conn
      |> assign(:message, message)
      |> assign(:user_return_to, ticket_path(conn, :new, listing_id: listing_id))
      |> put_session("user_return_to", ticket_path(conn, :new, listing_id: listing_id))
      |> render(:new, email: "")
    end
  end

  def show(conn, %{"listing_id" => listing_id, "token" => token} = params) do
    case UserFinder.find_guest_by_token(token) do
      nil ->
        conn
        |> put_flash(:error, "There was an error with your submission.  Your link has expired.  Please try again or contact support@pushcomedytheater.com.")
        |> redirect(to: "/ticket_auth?listing_id=#{listing_id}")
        |> halt()
      user ->
        user =
          user
          |> User.changeset(%{one_time_token: nil, one_time_token_at: nil})
          |> Repo.update!

        conn
        |> Helpers.login_user(user, params)
        |> redirect(to: "/tickets/new?listing_id=#{listing_id}")
    end
  end

  def create(conn, %{"registration" => registration_params, "listing_id" => listing_id} = params) do
    case UserFinder.find_guest_by_email(registration_params["email"]) do
      nil ->
        conn
        |> register_user(params)
      user ->
        token = Helpers.random_string(48)

        user =
          user
          |> User.changeset(%{one_time_token: token, one_time_token_at: NaiveDateTime.utc_now})
          |> Repo.update!

        url = "https://#{conn.host}/ticket_auth/#{token}?listing_id=#{listing_id}"

        OneTimeLogin.one_time_login(user, listing_id)
        |> Mailer.deliver!

        conn
        |> put_flash(:error, "Please check your email for information on how to continue your guest checkout.")
        |> redirect(to: "/ticket_auth?listing_id=#{listing_id}")
        |> halt()end
  end

  defp register_user(conn, %{"registration" => registration_params} = params) do
    registration_params = Map.put(registration_params, "role", "guest")
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
      {:error, _} ->
        conn
        |> put_flash(:error, "There was an error with your submission.  Please try again or contact support@pushcomedytheater.com.")
        |> redirect(to: "/ticket_auth?listing_id=" <> params["listing_id"])
        |> halt()
    end
  end
end
