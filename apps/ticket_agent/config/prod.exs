use Mix.Config

# Configure your database
config :ticket_agent, TicketAgent.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "pushers",
  password: "p@ssw0rd!",
  database: "ticket_agent_prod",
  hostname: "localhost",
  pool_size: 10,
  log: true

config :ticket_agent, :ticket_lock_length, 5000
config :ticket_agent, :stripe_key, "${STRIPE_KEY}"
config :ticket_agent, :email_base_url, "https://new.pushcomedytheater.com"
config :ticket_agent, :pdf_generator, TicketAgent.PdfGenerator.Generator

config :pdf_generator,
  wkhtml_path: "/usr/local/bin/wkhtmltopdf"
