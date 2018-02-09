  require Logger
  alias TicketAgent.Random

  Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

  account = SeedHelpers.create_account("Push Comedy Theater")
  user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
  card = SeedHelpers.create_credit_card(user)
  user = SeedHelpers.create_user("concierge@veverka.net", account, "concierge")
  Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event The Pre Madonnas Present: All Groan Up ==========="
utc_now = Calendar.NaiveDateTime.to_date_time_utc(DateTime.utc_now())

Logger.info "=========== Writing Event The Pre Madonnas Present: All Groan Up ==========="
event = SeedHelpers.create_event(
  %{
    slug: "X2DL0R",
    title: "The Pre Madonnas Present: All Groan Up",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8d9b9282-9a23-4993-b5b9-66dd813faf02",
    description: """
    <p>The Pre Madonnas are kicking off the new year at The Push Comedy Theater with a fun-filled night of sketch comedy! Whether you like your comedy dirty or silly, slapstick or satirical, The Pre Madonnas will have something for everyone in their new sketch comedy show "All Groan Up" featuring a touring set of their favorite sketches and all new material written for the new year.
</p>
<p><br>Tickets are $10 and can be bought ahead of time or at the door. We highly recommend buying tickets in advance, and arriving at the theater early to get a great seat!
</p>
<p><br>The Pre Madonnas will also be accepting donations to help fund their travel expenses to Charlotte, NC to be part of the North Carolina Comedy Festival.
</p>
<p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p><br>Contact: thepremadonnas@gmail.com<br>Twitter: @ Pre_Madonnas<br>Instagram: @ thepremadonnas
</p>
<p><br>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="https://l.facebook.com/l.php?u=http%3A%2F%2FPushcomedytheater.com%2F&amp;h=ATMKCtsh4tn6h28aVHkegkm0gNpd6C9_6dgMS2lBiNhuRWuzECQJ7H2VUY51UUXaEJNVDBNznBJ9xN5T0Fhe3HO7NA2f3-PT0vjusOgvikgQDwQrktpsfM3mXCHvx7-6VLr3X5mD62an3enPoyDbRbMhaLvuu55ORPUT-P324UGCKQ" rel="nofollow" target="_blank">Pushcomedytheater.com</a>
</p>
<p><br>About The Push Comedy Theater
</p>
<p><br>
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Pre Madonnas Present: All Groan Up ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "X2DL0R",
    title: "The Pre Madonnas Present: All Groan Up",
    description: """
    <p>The Pre Madonnas are kicking off the new year at The Push Comedy Theater with a fun-filled night of sketch comedy! Whether you like your comedy dirty or silly, slapstick or satirical, The Pre Madonnas will have something for everyone in their new sketch comedy show "All Groan Up" featuring a touring set of their favorite sketches and all new material written for the new year.
</p>
<p><br>Tickets are $10 and can be bought ahead of time or at the door. We highly recommend buying tickets in advance, and arriving at the theater early to get a great seat!
</p>
<p><br>The Pre Madonnas will also be accepting donations to help fund their travel expenses to Charlotte, NC to be part of the North Carolina Comedy Festival.
</p>
<p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p><br>Contact: thepremadonnas@gmail.com<br>Twitter: @ Pre_Madonnas<br>Instagram: @ thepremadonnas
</p>
<p><br>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="https://l.facebook.com/l.php?u=http%3A%2F%2FPushcomedytheater.com%2F&amp;h=ATMKCtsh4tn6h28aVHkegkm0gNpd6C9_6dgMS2lBiNhuRWuzECQJ7H2VUY51UUXaEJNVDBNznBJ9xN5T0Fhe3HO7NA2f3-PT0vjusOgvikgQDwQrktpsfM3mXCHvx7-6VLr3X5mD62an3enPoyDbRbMhaLvuu55ORPUT-P324UGCKQ" rel="nofollow" target="_blank">Pushcomedytheater.com</a>
</p>
<p><br>About The Push Comedy Theater
</p>
<p><br>
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
""",
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2018-01-07 03:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-07 04:30:00Z")
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

# Insert pre-maddonas
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  event_id: event.id,
  tag: "pre-maddonas"
})
Logger.info "=========== Wrote tag ==========="


Logger.info "=========== Writing 85 tickets for #{listing.id} ==========="
ticket_name = "Ticket for The Pre Madonnas Present: All Groan Up"
listing_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800) |> Calendar.NaiveDateTime.to_date_time_utc

sale_start = case DateTime.compare(listing_start, utc_now) do
  :lt ->
    listing_start
  :gt ->
    utc_now
end
rows = []
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES "

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

rows = rows ++ ["(uuid_generate_v4(), substr(replace(CAST(gen_random_uuid() as text), '-', ''), 0, 11), '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', #{10.0 * 100}, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW())"]

sql = sql <> Enum.join(rows, ", ")
{:ok, result} = TicketAgent.Repo.query(sql)
Logger.info "=========== END Processing Universe Event The Pre Madonnas Present: All Groan Up ==========="
