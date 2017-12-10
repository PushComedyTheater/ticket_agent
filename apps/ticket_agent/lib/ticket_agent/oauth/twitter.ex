defmodule TicketAgent.Twitter do
  @moduledoc false
  def authorize_url!(params \\ []) do
    config = Application.get_env(:ticket_agent, Twitter)

    ExTwitter.configure(:process, config)
    
    token = ExTwitter.request_token(config[:redirect_uri])
    
    {:ok, authenticate_url} = ExTwitter.authorize_url(token.oauth_token)
    
    authenticate_url
  end

  def get_token!(oauth_token, oauth_verifier) do
    config = Application.get_env(:ticket_agent, Twitter)

    ExTwitter.configure(:process, config)
    
    {:ok, access_token} = ExTwitter.access_token(oauth_verifier, oauth_token)
    
    access_token
  end

  def get_user!(%{oauth_token: oauth_token, oauth_token_secret: oauth_token_secret}) do
    config = Application.get_env(:ticket_agent, Twitter)

    config = config
             |> Keyword.merge([access_token: oauth_token,
                               access_token_secret: oauth_token_secret])
    
    ExTwitter.configure(:process, config)

    user = ExTwitter.verify_credentials(include_email: true)
    
    %{user: user, email: user.email, name: user.name, access_token: oauth_token,
      access_token_secret: oauth_token_secret}
  end
end
