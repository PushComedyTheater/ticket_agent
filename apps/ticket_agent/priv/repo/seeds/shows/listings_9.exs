  require Logger
  alias TicketAgent.Random

  Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

  account = SeedHelpers.create_account("Push Comedy Theater")
  user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
  card = SeedHelpers.create_credit_card(user)
  user = SeedHelpers.create_user("concierge@veverka.net", account, "concierge")
  Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="
utc_now = Calendar.NaiveDateTime.to_date_time_utc(DateTime.utc_now())

Logger.info "=========== Writing Event The Improv Riot: The Short Form Improv Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "25RJ0Q",
    title: "The Improv Riot: The Short Form Improv Show",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bdd1ac16-4eaa-4a83-87eb-eb7d4aadbd35",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.
</p>
<p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.
</p>
<p><strong>The Improv Riot: The Short Form Improv Show</strong>
</p>
<p>Friday, November 24th, 8pm
</p>
<p>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the parking lot directly across from the theater.
</p>
<p>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In November of 2014, they opened The Push Comedy Theater, located in the Norfolk Arts District.
</p>
<p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.
</p>
<p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.
</p>
<p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.
</p>
<p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
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
Logger.info "=========== Writing Event Listing The Improv Riot: The Short Form Improv Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "25RJ0Q",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.
</p>
<p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.
</p>
<p><strong>The Improv Riot: The Short Form Improv Show</strong>
</p>
<p>Friday, November 24th, 8pm
</p>
<p>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the parking lot directly across from the theater.
</p>
<p>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In November of 2014, they opened The Push Comedy Theater, located in the Norfolk Arts District.
</p>
<p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.
</p>
<p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.
</p>
<p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.
</p>
<p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
""",
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-11-25 01:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-25 02:30:00Z")
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

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  event_id: event.id,
  tag: "sketch"
})
Logger.info "=========== Wrote tag ==========="


Logger.info "=========== Writing 85 tickets for #{listing.id} ==========="
ticket_name = "Ticket for The Improv Riot: The Short Form Improv Show"
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
Logger.info "=========== END Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="
