  require Logger
  alias TicketAgent.Random

  Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

  account = SeedHelpers.create_account("Push Comedy Theater")
  user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
  card = SeedHelpers.create_credit_card(user)
  user = SeedHelpers.create_user("concierge@veverka.net", account, "concierge")
  Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event Harold Night ==========="
utc_now = Calendar.NaiveDateTime.to_date_time_utc(DateTime.utc_now())

Logger.info "=========== Writing Event Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "C9KMXL",
    title: "Harold Night",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/49cb7b83-12f7-40fe-a963-5ad538df05a4",
    description: """
    <p>It's Harold Night at the Push Comedy Theater!
</p>
<p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?
</p>
<p>The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.
</p>
<p>Harold Night
</p>
<p>Friday, January 26th at 10:00pm
</p>
<p>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting.
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
Logger.info "=========== Writing Event Listing Harold Night ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "C9KMXL",
    title: "Harold Night",
    description: """
    <p>It's Harold Night at the Push Comedy Theater!
</p>
<p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?
</p>
<p>The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.
</p>
<p>Harold Night
</p>
<p>Friday, January 26th at 10:00pm
</p>
<p>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
""",
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2018-01-27 03:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-27 04:30:00Z")
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

# Insert harold
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  event_id: event.id,
  tag: "harold"
})
Logger.info "=========== Wrote tag ==========="


Logger.info "=========== Writing 85 tickets for #{listing.id} ==========="
ticket_name = "Ticket for Harold Night"
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
Logger.info "=========== END Processing Universe Event Harold Night ==========="
