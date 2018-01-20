  require Logger
  alias TicketAgent.Random

  Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

  account = SeedHelpers.create_account("Push Comedy Theater")
  user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
  card = SeedHelpers.create_credit_card(user)
  user = SeedHelpers.create_user("concierge@veverka.net", account, "concierge")
  Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 101 Grad Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 101 Grad Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "KZCMX1",
    title: "Class Dismissed: The Improv 101 Grad Show",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/87dc866e-46e3-4d6e-9494-46cc076c3e6d",
    description: """
    <p>Dust off those caps and gowns... because it's graduation time at the Push.
</p>
<p>Check out the Push Comedy Theater's Improv 101 class as they show off their comedy chops.
</p>
<p>You won't believe what these improv newcomers have in store for you!!!
</p>
<p>Class Dismissed: The Improv 101 Graduation Show<br>Tuesday, January 16th at 7pm<br>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts will host live sketch and improv comedy on Friday and Saturday nights. During the week classes are offered in sketch writing, improv comedy and acting.
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
Logger.info "=========== Writing Event Listing Class Dismissed: The Improv 101 Grad Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "KZCMX1",
    title: "Class Dismissed: The Improv 101 Grad Show",
    description: """
    <p>Dust off those caps and gowns... because it's graduation time at the Push.
</p>
<p>Check out the Push Comedy Theater's Improv 101 class as they show off their comedy chops.
</p>
<p>You won't believe what these improv newcomers have in store for you!!!
</p>
<p>Class Dismissed: The Improv 101 Graduation Show<br>Tuesday, January 16th at 7pm<br>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts will host live sketch and improv comedy on Friday and Saturday nights. During the week classes are offered in sketch writing, improv comedy and acting.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2018-01-17 00:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-17 01:30:00Z")
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

# Insert graduation
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  event_id: event.id,
  tag: "graduation"
})
Logger.info "=========== Wrote tag ==========="

# Insert students
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  event_id: event.id,
  tag: "students"
})
Logger.info "=========== Wrote tag ==========="


Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
sql = "INSERT INTO orders (id, user_id, credit_card_id, slug, status, subtotal, credit_card_fee, processing_fee, total_price, started_at, processing_at, completed_at, errored_at, cancelled_at, inserted_at, updated_at) VALUES (uuid_generate_v4(), '#{user.id}', '#{card.id}', '#{TicketAgent.Random.generate_slug()}', 'completed', 5000, 500, 500, 6000, NULL, NULL, NOW(), NULL, NULL, NOW(), NOW()) RETURNING cast(id as text);"

%Postgrex.Result{rows: [[order_id]]} = TicketAgent.Repo.query!(sql)

ticket_name = "Ticket for Class Dismissed: The Improv 101 Grad Show"

sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '903a15ea5901809f6ff4', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'a24467fbbe857eaad1a2', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Hyman Rice', 'hyman.rice@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '4955d2060151c10bb78d', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Kaci Dickens', 'kaci.dickens@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '3683d7dbd4698aa66d36', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'ee1a56a2780fe71685d3', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Kathleen Weissnat', 'kathleen.weissnat@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'b41b7318cfffb8d8261c', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Tabitha Auer', 'tabitha.auer@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'b594dc611fb96515fe34', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Berneice Fisher', 'berneice.fisher@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '50ba935794cc71567b05', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Angel Heidenreich', 'angel.heidenreich@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'eeeac128d7de40398df4', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Hosea Muller', 'hosea.muller@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'feccee06946fd7bf6b8f', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'ced0ed5c1afefae38809', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '69bb7a4311dfe445f3b7', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '7bb8760d0164e4edd889', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Annetta Koelpin', 'annetta.koelpin@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'd92e37dee6a3bfb5ede2', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Sydni Funk', 'sydni.funk@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '1f09b8304900dd6d32a8', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'c5730309609c7c1e6586', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Sherman Bahringer', 'sherman.bahringer@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'd8c39020c349cd1d52fb', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Leland Cole', 'leland.cole@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '160c59453ed0bf67688b', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Eli Paucek', 'eli.paucek@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'fb6af18cd357a3b9492a', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '3a09c7c35f7092aa364f', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Finn Zieme', 'finn.zieme@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '6c04ca2b3ff0c426486a', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'e23c951e7fd400096a75', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'c9dd78a0ef3122e95c16', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Trey Maggio', 'trey.maggio@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '1faf62f65ea05b07b5ea', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Ibrahim Hickle', 'ibrahim.hickle@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '546e3ebc7760e004ea8f', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Evalyn Schneider', 'evalyn.schneider@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'be3cceabcb682b9335b6', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Maureen Rodriguez', 'maureen.rodriguez@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '6bebc6bf28216761fbb4', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Margret Rempel', 'margret.rempel@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '56dc288c4b18a518e4c7', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'c6821c5647d686be6c41', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '65324d8d2d10dca64eed', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '85855ccac9263fb7a807', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Rachelle Hermann', 'rachelle.hermann@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'bf33e75e1220a7396973', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'f2ee5c0bb629dc13c9a1', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'b9343cd84ad0873a8f74', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Amparo Volkman', 'amparo.volkman@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '0cb4e5414be3b6343bd2', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Bettye Gibson', 'bettye.gibson@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'b23fe8468a015481bbd2', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Chanelle Gerhold', 'chanelle.gerhold@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'f9ade8fe8c57241069da', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '2bf36a14ffb9d7354b48', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'a62362b31053ebb30c9e', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Franz Labadie', 'franz.labadie@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '686ffa427d00c6104cd6', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Foster Block', 'foster.block@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '3aec07c213da20f6dc31', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '1cb4b75cfeff1ae88314', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '7633a838fd3fd3198366', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Margret Emmerich', 'margret.emmerich@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '0b0495ba110d547d432d', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'ebc841a6c26e261f413e', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Elmira Beahan', 'elmira.beahan@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '4426503ee4b845b51127', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Velma Bechtelar', 'velma.bechtelar@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '4e56bfac6e49df92b9df', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Taurean Kuvalis', 'taurean.kuvalis@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '2568c6671196f457d297', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'eefe41ac0b60be24b4bb', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Brenden Ebert', 'brenden.ebert@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '2a68afb5b1c5a6195dea', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Gertrude Doyle', 'gertrude.doyle@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '012b3c1e9ac553fc412a', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'b883cf08cf47c7f455f7', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '08e8817260b4a3337dcc', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '0e7898ef84a410ff8386', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Perry Towne', 'perry.towne@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'a77399dc5326022adbde', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Grady Weimann', 'grady.weimann@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '29010a1be7c5898a7850', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Brianne O'Conner', 'brianne.oconner@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'f34cadd5555a7ca2e44e', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Bernardo Schumm', 'bernardo.schumm@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'b318cffaba7c7006a632', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Emmet Green', 'emmet.green@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'cb96e19d626b25363837', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Marge Ledner', 'marge.ledner@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '965d5f71f5d4e809ccd3', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Wilmer Murray', 'wilmer.murray@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'be999c25605216b0d6f4', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '91c9ac258b1cb2e86718', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Icie Oberbrunner', 'icie.oberbrunner@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'ee52456e487f0ea5af96', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Jordane Gottlieb', 'jordane.gottlieb@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '7b7bd7d9b3682960b924', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'e32581dc8286d1a47894', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '2d377240203bfd916dba', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Carmella Schaden', 'carmella.schaden@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '59b8755912477594ac14', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Gail Conn', 'gail.conn@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '8650b4b78fc38a71fadd', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Laila Schmeler', 'laila.schmeler@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '2a449eacd6fc376851dd', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Nicholas Quitzon', 'nicholas.quitzon@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '9e0285d6e1213379207e', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Reece MacGyver', 'reece.macgyver@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '1f38c51f62d5cef18065', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Aniya Kessler', 'aniya.kessler@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '1b4f219c33b1ccf587c9', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Vince Hamill', 'vince.hamill@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'd70b6dba4362b5fa6f75', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Kaycee Schiller', 'kaycee.schiller@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'a6d78601deabaa4f25d0', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Abby Okuneva', 'abby.okuneva@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'c9532681679c16f068fc', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Kira Bashirian', 'kira.bashirian@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'ab3d4069b248c495030c', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Kasey Cremin', 'kasey.cremin@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '5c5e4f0f72098dbda1ad', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'e670fac43a3e772141db', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '2751f41007697eac0927', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Nick Parker', 'nick.parker@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'd016e4941edc4cb20694', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Peggie Koss', 'peggie.koss@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 101 Grad Show ==========="
