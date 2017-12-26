use Mix.Config

config :ticket_agent, ecto_repos: [TicketAgent.Repo]

import_config "#{Mix.env}.exs"


{sha, _} = System.cmd("git", ["rev-parse", "HEAD"])
sha = String.trim(sha)
config :ticket_agent, :release, sha

config :sentry,
  dsn: System.get_env("SENTRY_PRIVATE_DSN"),
  environment_name: Mix.env,
  enable_source_code_context: true,
  root_source_code_path: File.cwd!,
  tags: %{
    env: "#{Mix.env}",
    app: "ticket_agent"
  },
  use_error_logger: true,
  included_environments: [:prod],
  # included_environments: [:dev, :prod],
  release: sha

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: TicketAgent.User,
  repo: TicketAgent.Repo,
  module: TicketAgent,
  web_module: TicketAgentWeb,
  router: TicketAgentWeb.Router,
  messages_backend: TicketAgentWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Push Comedy Theater",
  email_from_email: "support@pushcomedytheater.com",
  opts: [:registerable, :authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token]

# config :oauth2, debug: true

# config :coherence, TicketAgentWeb.Coherence.Mailer,
#   adapter: Swoosh.Adapters.Mailgun,
#   api_key: System.get_env("MAILGUN_API_KEY"),
#   domain: "pushcomedytheater.com",
#   email_from_name: "Push Comedy Theater",
#   email_from_email: "support@pushcomedytheater.com"
#
# config :coherence, TicketAgent.Coherence.Mailer,
#   adapter: Swoosh.Adapters.Mailgun,
#   api_key: System.get_env("MAILGUN_API_KEY"),
#   domain: "pushcomedytheater.com",
#   email_from_name: "Push Comedy Theater",
#   email_from_email: "support@pushcomedytheater.com"
#
# config :ticket_agent, TicketAgent.Mailer,
#   adapter: Swoosh.Adapters.Mailgun,
#   api_key: System.get_env("MAILGUN_API_KEY"),
#   domain: "pushcomedytheater.com",
#   email_from_name: "Push Comedy Theater",
#   email_from_email: "support@pushcomedytheater.com"

config :coherence, TicketAgentWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.SMTP,
  relay: "127.0.0.1",
  port: 1025,
  email_from_name: "ticket agent config",
  email_from_email: "support@pushcomedytheater.com"

config :coherence, TicketAgent.Coherence.Mailer,
  adapter: Swoosh.Adapters.SMTP,
  relay: "127.0.0.1",
  port: 1025,
  email_from_name: "ticket agent config",
  email_from_email: "support@pushcomedytheater.com"

config :ticket_agent, TicketAgent.Mailer,
  adapter: Swoosh.Adapters.SMTP,
  relay: "127.0.0.1",
  port: 1025,
  email_from_name: "ticket agent config",
  email_from_email: "support@pushcomedytheater.com"


# config :ticket_agent, TicketAgent.Mailer,
#   adapter: adapter,
#   relay: "127.0.0.1",
#   port: 1025,
#   email_from_name: "ticket agent config",
#   email_from_email: "support@pushcomedytheater.com"

config :cloudinex,
  debug: false,
  base_url: "https://api.cloudinary.com/v1_1/",
  base_image_url: "https://res.cloudinary.com/",
  api_key: System.get_env("CLOUDINEX_API_KEY"),
  secret: System.get_env("CLOUDINEX_SECRET"),
  cloud_name: "push-comedy-theater" #no default

config :oauth2, debug: true

config :ticket_agent, Amazon,
  client_id: System.get_env("AMAZON_CLIENT_ID"),
  client_secret: System.get_env("AMAZON_CLIENT_SECRET"),
  redirect_uri: System.get_env("AMAZON_REDIRECT_URI")

config :ticket_agent, Facebook,
  client_id: System.get_env("FACEBOOK_CLIENT_ID"),
  client_secret: System.get_env("FACEBOOK_CLIENT_SECRET"),
  redirect_uri: System.get_env("FACEBOOK_REDIRECT_URI")

config :ticket_agent, Google,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET"),
  redirect_uri: System.get_env("GOOGLE_REDIRECT_URI")

config :ticket_agent, LinkedIn,
  client_id: System.get_env("LINKEDIN_CLIENT_ID"),
  client_secret: System.get_env("LINKEDIN_CLIENT_SECRET"),
  redirect_uri: System.get_env("LINKEDIN_REDIRECT_URI")

config :ticket_agent, Microsoft,
  client_id: System.get_env("MICROSOFT_CLIENT_ID"),
  client_secret: System.get_env("MICROSOFT_CLIENT_SECRET"),
  redirect_uri: System.get_env("MICROSOFT_REDIRECT_URI")

config :ticket_agent, Twitter,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
  redirect_uri: System.get_env("TWITTER_REDIRECT_URI")

value = case System.get_env("TICKET_LOCK_LENGTH") do
  nil -> 302
  value -> String.to_integer(value)
end
config :ticket_agent, :ticket_lock_length, value

config :ticket_agent, Stripe,
  secret_key: System.get_env("STRIPE_SECRET_KEY"),
  publishable_key: System.get_env("STRIPE_PUBLISHABLE_KEY"),
  api_url: System.get_env("STRIPE_API_URL")
