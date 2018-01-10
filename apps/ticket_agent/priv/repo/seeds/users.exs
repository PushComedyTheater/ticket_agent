require Logger

Code.load_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
card = SeedHelpers.create_credit_card(user)
user = SeedHelpers.create_user("concierge@veverka.net", account, "concierge")

Enum.each(1..50, fn(x) ->
  user = SeedHelpers.create_user(
    "user#{x}@veverka.net", 
    account, 
    TicketAgent.Random.sample(
      ["customer", "oauth_customer", "guest"]
    )
  )
end)