defmodule TicketAgentWeb.AuthController do
  use TicketAgentWeb, :controller
  use Coherence.Config
  alias TicketAgent.{Repo, User, UserCredential}
  alias TicketAgent.{Facebook, Google, Twitter}

  @doc """
  This action is reached via `/auth/:provider` and redirects to the OAuth2 provider
  based on the chosen strategy.
  """
  def index(conn, %{"provider" => provider} = params) do
    redirect conn, external: authorize_url!(provider, %{redirect_uri: params["redirect_uri"]})
  end

  def callback(conn, %{"provider" => provider, "denied" => denied}) do
    redirect(conn, to: "/")
  end

  @doc """
  This action is reached via `/auth/:provider/callback` is the the callback URL that
  the OAuth2 provider will redirect the user back to with a `code` that will
  be used to request an access token. The access token will then be used to
  access protected resources on behalf of the user.
  """
  def callback(conn, %{"provider" => "twitter", "oauth_token" => oauth_token, "oauth_verifier" => oauth_verifier} = params) do
    redirect_uri = case get_session(conn, "user_return_to") do
      nil ->
        "/dashboard"
      uri ->
        uri
    end
    
    twitter_user =
      oauth_token
      |> Twitter.get_token!(oauth_verifier)
      |> Twitter.get_user!()
    
      if twitter_user do
        user = User.find_or_create_with_credentials(
          twitter_user.name,
          twitter_user.email,
          "twitter",
          twitter_user.access_token,
          twitter_user.access_token_secret
        )

        Config.auth_module()
        |> apply(Config.create_login(), [conn, user, [id_key: Config.schema_key()]])
        |> delete_session("user_return_to")
        |> redirect(to: redirect_uri)
      else 
        conn
        |> put_flash(:error, "There was an issue signing into Twitter. Please try again.")
        |> redirect(to: session_path(conn, :new))
      end
  end

  def callback(conn, %{"provider" => provider, "code" => code} = params) do
    redirect_uri = case get_session(conn, "user_return_to") do
      nil ->
        "/dashboard"
      uri ->
        uri
    end

    client = get_token!(provider, code)
    user = get_user!(provider, client)

    user = User.find_or_create_with_credentials(user.name,
                                                user.email,
                                                provider,
                                                client.token.access_token,
                                                nil)
    Config.auth_module()
    |> apply(Config.create_login(), [conn, user, [id_key: Config.schema_key()]])
    |> redirect(to: redirect_uri)
  end

  # defp authorize_url!("google"),   do: TicketAgent.Google.authorize_url!(scope: "https://www.googleapis.com/auth/userinfo.email")
  defp authorize_url!("facebook", params) do
    IO.puts "authorize_url! "
    IO.inspect params
    TicketAgent.Facebook.authorize_url!(scope: "user_photos, email", turtle: "bing")
  end
  defp authorize_url!("twitter", params), do: Twitter.authorize_url!(params)
  defp authorize_url!(_), do: raise "No matching provider available"

  defp get_token!("google", code),   do: TicketAgent.Google.get_token!(code: code)
  defp get_token!("facebook", code), do: TicketAgent.Facebook.get_token!(code: code)
  defp get_token!(_, _), do: raise "No matching provider available"

  defp get_user!("google", client) do
    %{body: user} = OAuth2.Client.get!(client, "https://www.googleapis.com/plus/v1/people/me/openIdConnect")
    %{name: user["name"], avatar: user["picture"], email: user["email"]}
  end
  defp get_user!("facebook", client) do
    %{body: user} = OAuth2.Client.get!(client, "/me?fields=id,name,email")
    %{name: user["name"], avatar: "https://graph.facebook.com/#{user["id"]}/picture", email: user["email"]}
  end
end
