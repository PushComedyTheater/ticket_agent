use Mix.Config

# Configure your database
config :ticket_agent, TicketAgent.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ticket_agent_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox


config :logger, level: :debug
