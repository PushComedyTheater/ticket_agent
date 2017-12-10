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


config :coherence,
  email_from_name: "Push Comedy Theater",
  email_from_email: "support@pushcomedytheater.com"


config :coherence, TicketAgent.Coherence.Mailer,
  adapter: Swoosh.Adapters.Mailgun,
  api_key: System.get_env("MAILGUN_API_KEY"),
  domain: "pushcomedytheater.com"


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
