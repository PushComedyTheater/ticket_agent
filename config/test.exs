use Mix.Config

# Print only warnings and errors during test
config :logger, level: :debug
config :porcelain, goon_warn_if_missing: false
config :ticket_agent, :ticket_lock_length, 0