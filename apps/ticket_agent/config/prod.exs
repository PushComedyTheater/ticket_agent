use Mix.Config

# Configure your database
config :ticket_agent, TicketAgent.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

config :ticket_agent, :ticket_lock_length, 5000
config :ticket_agent, :stripe_key, Application.get_env("STRIPE_KEY")
