# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ticket_agent_web,
  namespace: TicketAgentWeb,
  ecto_repos: [TicketAgent.Repo]

config :paper_trail, repo: TicketAgent.Repo,
                     item_type: Ecto.UUID,
                     originator_type: Ecto.UUID,
                     originator: [name: :user, model: TicketAgent.User]

config :oauth2, debug: true

config :scrivener_html,
  routes_helper: TicketAgentWeb.Router.Helpers,
  # If you use a single view style everywhere, you can configure it here. See View Styles below for more info.
  view_style: :bootstrap_v4

# Configures the endpoint
config :ticket_agent_web, TicketAgentWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VXLaK4UAXL/fr9Js3OvDm1rpqEM/WW2yUOg38TSja1NscvZMOUnfeaB1bC34eXlU",
  render_errors: [view: TicketAgentWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TicketAgentWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ticket_agent_web, :generators,
  context_app: :ticket_agent

{sha, _} = System.cmd("git", ["rev-parse", "HEAD"])
sha = String.trim(sha)
config :ticket_agent_web, :release, sha

# config :sentry,
#   dsn: System.get_env("SENTRY_PRIVATE_DSN"),
#   environment_name: Mix.env,
#   enable_source_code_context: true,
#   root_source_code_path: File.cwd!,
#   use_error_logger: true,
#   tags: %{
#     env: "#{Mix.env}",
#     app: "ticket_agent_web"
#   },
#   # included_environments: [:prod],
#   included_environments: [:dev, :prod],
#   release: sha

config :coherence,
  user_token: true

  # config :coherence, TicketAgentWeb.Coherence.Mailer,
  #   adapter: Swoosh.Adapters.Mailgun,
  #   api_key: System.get_env("MAILGUN_API_KEY"),
  #   domain: "mail.pushcomedytheater.com",
  #   email_from_name: "Push Comedy Theater",
  #   email_from_email: "support@pushcomedytheater.com"
  #
  # config :coherence, TicketAgent.Coherence.Mailer,
  #   adapter: Swoosh.Adapters.Mailgun,
  #   api_key: System.get_env("MAILGUN_API_KEY"),
  #   domain: "mail.pushcomedytheater.com",
  #   email_from_name: "Push Comedy Theater",
  #   email_from_email: "support@pushcomedytheater.com"
  #
  # config :ticket_agent, TicketAgent.Mailer,
  #   adapter: Swoosh.Adapters.Mailgun,
  #   api_key: System.get_env("MAILGUN_API_KEY"),
  #   domain: "mail.pushcomedytheater.com",
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


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
