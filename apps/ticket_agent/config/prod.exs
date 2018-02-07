use Mix.Config

# Configure your database
config :ticket_agent, TicketAgent.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ticket_agent_dev",
  hostname: "localhost",
  pool_size: 10,
  log: true

config :ticket_agent, :ticket_lock_length, 5000
config :ticket_agent, :stripe_key, "${STRIPE_KEY}"
config :ticket_agent, :email_base_url, "https://pushcomedytheater.com"
