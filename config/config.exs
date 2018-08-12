# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# By default, the umbrella project as well as each child
# application will require this configuration file, ensuring
# they all use the same configuration. While one could
# configure all applications here, we prefer to delegate
# back to each application for organization purposes.
import_config "../apps/*/config/config.exs"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# config :coherence, TicketAgentWeb.Coherence.Mailer,
#   adapter: Swoosh.Adapters.Local,
#   email_from_name: "Push Comedy Theater",
#   email_from_email: "support@pushcomedytheater.com"

# config :coherence, TicketAgentWeb.Coherence.Mailer,
#   adapter: Swoosh.Adapters.Mailgun,
#   api_key: System.get_env("MAILGUN_API_KEY"),
#   domain: "pushcomedytheater.com",
#   email_from_name: "Push Comedy Theater",
#   email_from_email: "support@pushcomedytheater.com"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
config :tesla, :adapter, Tesla.Adapter.Hackney
import_config "#{Mix.env()}.exs"

# Import Timber, structured logging
import_config "timber.exs"
