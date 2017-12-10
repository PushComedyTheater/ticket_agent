defmodule TicketAgentWeb.AuthController do
  use TicketAgentWeb, :controller
  use Coherence.Config
  alias TicketAgent.{Repo, User, UserCredential}
  alias TicketAgent.{Facebook, Google, Twitter}

  @doc """
  This action is reached via `/auth/:provider` and redirects to the OAuth2 provider
  based on the chosen strategy.
  """
  def index(conn, %{"provider" => provider}) do
    redirect conn, external: authorize_url!(provider)
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
  def callback(conn, %{"provider" => "twitter", "oauth_token" => oauth_token, "oauth_verifier" => oauth_verifier}) do
    access_token = Twitter.get_token!(oauth_token, oauth_verifier)
    user = Twitter.get_user!(access_token)
    user = User.find_or_create_with_credentials(user.name,
                                                user.email,
                                                "twitter",
                                                user.access_token,
                                                user.access_token_secret)
    Config.auth_module()
    |> apply(Config.create_login(), [conn, user, [id_key: Config.schema_key()]])
    |> render_success
  end

  def callback(conn, %{"provider" => provider, "code" => code}) do
    client = get_token!(provider, code)
    user = get_user!(provider, client)

    user = User.find_or_create_with_credentials(user.name,
                                                user.email,
                                                provider,
                                                client.token.access_token,
                                                nil)
    Config.auth_module()
    |> apply(Config.create_login(), [conn, user, [id_key: Config.schema_key()]])
    |> render_success
  end

  defp render_success(conn) do
    refresh = """
      <html>
      <head>
      <script>
        window.onunload = refreshParent;
        function refreshParent() {
          window.opener.login_success();
        }
        window.setTimeout("window.close()", 500);
      </script>
      </head>
      <body>
      <center>
      <img src="https://cdn.pushcomedytheater.com/2.0/lg.fidget-spinner.gif">
      <br />
      Logging you in...
      </center>
      </body>
      </html>
    """

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, refresh)
  end

  defp authorize_url!("google"),   do: Google.authorize_url!(scope: "https://www.googleapis.com/auth/userinfo.email")
  defp authorize_url!("facebook"), do: Facebook.authorize_url!(scope: "user_photos, email")
  defp authorize_url!("twitter"),  do: Twitter.authorize_url!()
  defp authorize_url!(_), do: raise "No matching provider available"

  defp get_token!("google", code),   do: Google.get_token!(code: code)
  defp get_token!("facebook", code), do: Facebook.get_token!(code: code)
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
