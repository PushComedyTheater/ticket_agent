defmodule TicketAgentWeb.AuthController do
  use TicketAgentWeb, :controller
  use Coherence.Config
  alias TicketAgent.{Repo, User, UserCredential}
  alias TicketAgent.{Facebook, Google, Microsoft, Twitter}

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
          twitter_user.access_token_secret,
          Map.from_struct(twitter_user.user)
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

    Logger.info "provider = #{provider}"

    with {:ok, client} <- get_token!(provider, code),
         {:ok, %{name: name, avatar: avatar, email: email, extra_details: extra_details}} <- get_user(provider, client) do

      user = User.find_or_create_with_credentials(
        name,
        email,
        provider,
        client.token.access_token,
        nil,
        extra_details
      )
      Config.auth_module()
      |> apply(Config.create_login(), [conn, user, [id_key: Config.schema_key()]])
      |> redirect(to: redirect_uri)
    else
      {:error, %{body: %{"error" => message}}} ->
        Logger.error "There was an error loading this OAuth: #{message}"
        redirect(conn, to: session_path(conn, :new))
      {:error, response} ->
        Logger.error "There was an error loading this OAuth: #{inspect response}"
        redirect(conn, to: session_path(conn, :new))
      {:user_error, message} ->
        Logger.error "There was an error loading this OAuth: #{message}"
        redirect(conn, to: session_path(conn, :new))
      other ->
        Logger.info "There was an unmatched error loading this OAuth: #{inspect other}"
        redirect(conn, to: session_path(conn, :new))
    end
  end

  defp authorize_url!("google", params),   do: TicketAgent.Google.authorize_url!(scope: "https://www.googleapis.com/auth/plus.profile.emails.read")
  defp authorize_url!("facebook", params), do: TicketAgent.Facebook.authorize_url!(scope: "user_photos,user_about_me,user_birthday,user_website,user_location,email")
  defp authorize_url!("twitter", params), do: Twitter.authorize_url!(params)
  defp authorize_url!("microsoft", params), do: TicketAgent.Microsoft.authorize_url!(scope: "wl.emails,wl.basic,wl.postal_addresses,wl.phone_numbers")
  defp authorize_url!(_), do: raise "No matching provider available"

  defp get_token!("google", code),   do: TicketAgent.Google.get_token(code: code)
  defp get_token!("facebook", code), do: TicketAgent.Facebook.get_token(code: code)
  defp get_token!("microsoft", code), do: TicketAgent.Microsoft.get_token(code: code)
  defp get_token!(_, _),             do: raise "No matching provider available"

  defp get_user("google", client) do
    with {:ok, %{body: %{"id" => id} = result}} <- OAuth2.Client.get(client, "https://www.googleapis.com/oauth2/v1/userinfo?alt=json"),
         {:ok,
         %{
           body: %{
             "displayName" => displayName,
             "emails" => emails,
             "image" => %{
               "url" => avatar
              },
              "name" => %{
                "familyName" => last_name,
                "givenName" => first_name
              }
            } = details}} = OAuth2.Client.get(client, "https://www.googleapis.com/plus/v1/people/#{id}") do

        extra_details = Map.merge(result, details)
        email = Enum.at(emails, 0)["value"]

        name = cond do
          String.length(displayName) > 0 ->
            displayName
          String.length(first_name) > 0 || String.length(last_name) > 0 ->
            first_name <> " " <> last_name
          true ->
            email
        end
        {:ok, %{name: name, email: email, avatar: avatar, extra_details: extra_details}}
    else
      {:error, response} ->
        message = get_in(response.body, ["error", "message"])
        Logger.error message
        {:user_error, message}
      other ->
        Logger.error "Unmatched error: #{inspect other}"
        {:user_error, "Unknown error, contact support"}
    end
  end

  defp get_user("microsoft", client) do
    with {:ok, %{body: %{"name" => name, "emails" => %{"account" => email}} = body}} <- OAuth2.Client.get(client, "https://apis.live.net/v5.0/me"),
         {:ok, %{headers: headers, status_code: 302}} <- OAuth2.Client.get(client, "https://apis.live.net/v5.0/me/picture"),
         {_, avatar} <- Enum.find(headers, fn({first, last}) -> first == "location" end) do
            {:ok, %{name: name, avatar: avatar, email: email, extra_details: body}}
    else
      {:error, response} ->
        Logger.error "Error: #{inspect response}"
        {:user_error, "Unknown error, contact support"}
      other ->
        Logger.error "Unmatched error: #{inspect other}"
        {:user_error, "Unknown error, contact support"}
    end
  end

  defp get_user("facebook", client) do
    case OAuth2.Client.get(client, "/me?fields=about,id,birthday,devices,email,first_name,gender,is_verified,last_name,location,name,timezone,verified,website") do
      {:ok, %{body: user}} ->
        {:ok, %{name: user["name"], avatar: "https://graph.facebook.com/#{user["id"]}/picture", email: user["email"], extra_details: user}}
      {:error, response} ->
        message = get_in(response.body, ["error", "message"])
        {:user_error, message}
    end
  end
end
