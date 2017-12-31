require Logger

Code.load_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
user = SeedHelpers.create_user("concierge@veverka.net", account, "concierge")
