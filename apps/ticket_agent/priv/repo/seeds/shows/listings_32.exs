  require Logger
  alias TicketAgent.Random

  Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

  account = SeedHelpers.create_account("Push Comedy Theater")
  user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
  card = SeedHelpers.create_credit_card(user)
  user = SeedHelpers.create_user("concierge@veverka.net", account, "concierge")
  Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
utc_now = Calendar.NaiveDateTime.to_date_time_utc(DateTime.utc_now())

Logger.info "=========== Writing Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
event = SeedHelpers.create_event(
  %{
    slug: "K3CQGB",
    title: "IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/6a654ad0-cfee-43a6-9c35-dc86dfd97340",
    description: """
    <p>Prepare for Glory!!
</p>
<p><br>Prepare for IMPROVAGEDDON: The Ultimate Improv Competition!!!
</p>
<p>Who will raise the Hammer of Lowell in final victory? <br><br>You'll have to come to this month's show to find out!
</p>
<p><br><br>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory.
</p>
<p><br>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet!
</p>
<p><br><br>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest.
</p>
<p><br>Gimmicks will be displayed! <br>Trash will be talked! <br>Feats of comedic strength will be performed!
</p>
<p><br>Let the final war for comedic supremacy begin!
</p>
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, December 30th
</p>
<p>The show starts at 10pm
</p>
<p>Tickets are $5
</p>
<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "K3CQGB",
    title: "IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION",
    description: """
    <p>Prepare for Glory!!
</p>
<p><br>Prepare for IMPROVAGEDDON: The Ultimate Improv Competition!!!
</p>
<p>Who will raise the Hammer of Lowell in final victory? <br><br>You'll have to come to this month's show to find out!
</p>
<p><br><br>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory.
</p>
<p><br>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet!
</p>
<p><br><br>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest.
</p>
<p><br>Gimmicks will be displayed! <br>Trash will be talked! <br>Feats of comedic strength will be performed!
</p>
<p><br>Let the final war for comedic supremacy begin!
</p>
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, December 30th
</p>
<p>The show starts at 10pm
</p>
<p>Tickets are $5
</p>
<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.
</p>
""",
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2018-01-21 03:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-21 04:30:00Z")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

# Insert show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  event_id: event.id,
  tag: "show"
})
Logger.info "=========== Wrote tag ==========="

# Insert deal
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  event_id: event.id,
  tag: "deal"
})
Logger.info "=========== Wrote tag ==========="

# Insert improvageddon
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  event_id: event.id,
  tag: "improvageddon"
})
Logger.info "=========== Wrote tag ==========="

# Insert contest
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  event_id: event.id,
  tag: "contest"
})
Logger.info "=========== Wrote tag ==========="

# Insert final
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  event_id: event.id,
  tag: "final"
})
Logger.info "=========== Wrote tag ==========="


Logger.info "=========== Writing 85 tickets for #{listing.id} ==========="
ticket_name = "Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION"
listing_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800) |> Calendar.NaiveDateTime.to_date_time_utc

sale_start = case DateTime.compare(listing_start, utc_now) do
  :lt ->
    listing_start
  :gt ->
    utc_now
end
rows = []
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES "

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{5.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

sql = sql <> Enum.join(rows, ", ")
{:ok, result} = TicketAgent.Repo.query(sql)
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
