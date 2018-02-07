  require Logger
  alias TicketAgent.Random

  Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

  account = SeedHelpers.create_account("Push Comedy Theater")
  user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
  card = SeedHelpers.create_credit_card(user)
  user = SeedHelpers.create_user("concierge@veverka.net", account, "concierge")
  Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event Date Night: With Brad McMurran and Alba Woolard ==========="
utc_now = Calendar.NaiveDateTime.to_date_time_utc(DateTime.utc_now())

Logger.info "=========== Writing Event Date Night: With Brad McMurran and Alba Woolard ==========="
event = SeedHelpers.create_event(
  %{
    slug: "P42DB7",
    title: "Date Night: With Brad McMurran and Alba Woolard",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/7e2ff30f-6b86-488e-8838-cfc9912b6824",
    description: """
    <p><strong>Get ready as we improvise your relationship.</strong>
</p>
<p>It's the most fun you'll ever have on date night!
</p>
<p>Two lucky couples will see their love unfold on stage through the interpretation of 2 of Hampton Roads' wackiest improvisers!
</p>
<p>The couples will be selected at random and interviewed on stage in front of the audience. Using the information they learn, and their imagination, Brad and Alba will show the story of the couples' love.
</p>
<p>For years, The Pushers have been getting to know diverse couples all across Hampton Roads with this signature piece. Normally this is a piece within a larger show. This time, Brad and Alba are out to explore as much as possible by bringing it to you as its own show!
</p>
<p><br>
</p>
<p><strong>Date Night: With Brad and Alba</strong>
</p>
<p>Friday, February 2nd at 8pm
</p>
<p>Tickets are $5
</p>
<p>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For more than 11 years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In November of 2014, they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
</p>
<p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.
</p>
<p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.
</p>
<p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.
</p>
<p>---
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Date Night: With Brad McMurran and Alba Woolard ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "P42DB7",
    title: "Date Night: With Brad McMurran and Alba Woolard",
    description: """
    <p><strong>Get ready as we improvise your relationship.</strong>
</p>
<p>It's the most fun you'll ever have on date night!
</p>
<p>Two lucky couples will see their love unfold on stage through the interpretation of 2 of Hampton Roads' wackiest improvisers!
</p>
<p>The couples will be selected at random and interviewed on stage in front of the audience. Using the information they learn, and their imagination, Brad and Alba will show the story of the couples' love.
</p>
<p>For years, The Pushers have been getting to know diverse couples all across Hampton Roads with this signature piece. Normally this is a piece within a larger show. This time, Brad and Alba are out to explore as much as possible by bringing it to you as its own show!
</p>
<p><br>
</p>
<p><strong>Date Night: With Brad and Alba</strong>
</p>
<p>Friday, February 2nd at 8pm
</p>
<p>Tickets are $5
</p>
<p>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For more than 11 years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In November of 2014, they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
</p>
<p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.
</p>
<p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.
</p>
<p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.
</p>
<p>---
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
""",
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2018-02-03 01:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-02-03 02:30:00Z")
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

# Insert date-night
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  event_id: event.id,
  tag: "date-night"
})
Logger.info "=========== Wrote tag ==========="

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  event_id: event.id,
  tag: "sketch"
})
Logger.info "=========== Wrote tag ==========="

# Insert couples
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  event_id: event.id,
  tag: "couples"
})
Logger.info "=========== Wrote tag ==========="


Logger.info "=========== Writing 85 tickets for #{listing.id} ==========="
ticket_name = "Ticket for Date Night: With Brad McMurran and Alba Woolard"
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
Logger.info "=========== END Processing Universe Event Date Night: With Brad McMurran and Alba Woolard ==========="
