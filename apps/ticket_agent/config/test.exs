use Mix.Config

# Configure your database
config :ticket_agent, TicketAgent.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ticket_agent_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  log: false

config :logger, level: :warn
config :ticket_agent, :ticket_lock_length, 0
config :ticket_agent, :pdf_generator, TicketAgent.PdfGenerator.Mock
config :pdf_generator, raise_on_missing_wkhtmltopdf_binary: false
