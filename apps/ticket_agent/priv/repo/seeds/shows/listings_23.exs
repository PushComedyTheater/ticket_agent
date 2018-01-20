  require Logger
  alias TicketAgent.Random

  Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

  account = SeedHelpers.create_account("Push Comedy Theater")
  user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
  card = SeedHelpers.create_credit_card(user)
  user = SeedHelpers.create_user("concierge@veverka.net", account, "concierge")
  Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event Girl-Prov Presents: Here Kitty Kitty! ==========="

Logger.info "=========== Writing Event Girl-Prov Presents: Here Kitty Kitty! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "QVC5G6",
    title: "Girl-Prov Presents: Here Kitty Kitty!",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/2818bca8-8162-47b8-999f-625527ad42d0",
    description: """
    <p><strong></strong><strong>GET READY FOR GIRL'S NIGHT!</strong>
</p>
<p>Move over, gentleman! <br>The ladies are taking over for a girls' night!
</p>
<p>GirlProv is an all-female improv show, making audiences lose it with laughter at the Push Comedy Theater.
</p>
<p>It's slumber party meets night out on the town meet sorority house party!
</p>
<p>Don't miss this night of comedy- all made up on the spot from the audience's suggestion!
</p>
<p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, January 12th at the Push Comedy Theater<br>The show starts at 8, tickets are $5
</p>
<p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">pushcomedytheater.com</a>
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
</p>
<p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.
</p>
<p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.
</p>
<p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.
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
Logger.info "=========== Writing Event Listing Girl-Prov Presents: Here Kitty Kitty! ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "QVC5G6",
    title: "Girl-Prov Presents: Here Kitty Kitty!",
    description: """
    <p><strong></strong><strong>GET READY FOR GIRL'S NIGHT!</strong>
</p>
<p>Move over, gentleman! <br>The ladies are taking over for a girls' night!
</p>
<p>GirlProv is an all-female improv show, making audiences lose it with laughter at the Push Comedy Theater.
</p>
<p>It's slumber party meets night out on the town meet sorority house party!
</p>
<p>Don't miss this night of comedy- all made up on the spot from the audience's suggestion!
</p>
<p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, January 12th at the Push Comedy Theater<br>The show starts at 8, tickets are $5
</p>
<p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">pushcomedytheater.com</a>
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
</p>
<p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.
</p>
<p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.
</p>
<p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2018-01-13 01:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-13 02:30:00Z")
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

# Insert girl-prov
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  event_id: event.id,
  tag: "girl-prov"
})
Logger.info "=========== Wrote tag ==========="

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  event_id: event.id,
  tag: "sketch"
})
Logger.info "=========== Wrote tag ==========="


Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
sql = "INSERT INTO orders (id, user_id, credit_card_id, slug, status, subtotal, credit_card_fee, processing_fee, total_price, started_at, processing_at, completed_at, errored_at, cancelled_at, inserted_at, updated_at) VALUES (uuid_generate_v4(), '#{user.id}', '#{card.id}', '#{TicketAgent.Random.generate_slug()}', 'completed', 5000, 500, 500, 6000, NULL, NULL, NOW(), NULL, NULL, NOW(), NOW()) RETURNING cast(id as text);"

%Postgrex.Result{rows: [[order_id]]} = TicketAgent.Repo.query!(sql)

ticket_name = "Ticket for Girl-Prov Presents: Here Kitty Kitty!"

sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '9262f0fee216df30309b', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'cbc20a8a9f2da5c9a124', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'b147c087ea71aca17fe7', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Wilma Senger', 'wilma.senger@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '09bd179de5acb4f0c2b8', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'c8ac45e313ffc905e614', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Zula McCullough', 'zula.mccullough@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '58db9cb02f006298c9b2', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'cb6d65998443c857db44', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Mercedes Stiedemann', 'mercedes.stiedemann@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '9269aeafdc2de95db9a0', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Nels Schulist', 'nels.schulist@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '24280151585820d095b3', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Kellen Howell', 'kellen.howell@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'f01e699d0eab61d85f94', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Leopoldo Schuppe', 'leopoldo.schuppe@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '97a967fe85cfec98ff61', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Rashad Hessel', 'rashad.hessel@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '603821ab0e63cef02e8e', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'dbceb3ed6a627e6c1441', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '6d4bdaaf951792944a75', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Sarai Shanahan', 'sarai.shanahan@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'ac438c33c69977eb5ae1', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'f7101babe95461b5425c', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Myrtle Kuhn', 'myrtle.kuhn@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '80eec16bc6aa58319d6f', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Emmie Raynor', 'emmie.raynor@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '415a3727d61fef0da8f1', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '262fbacd452217836186', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Zechariah Von', 'zechariah.von@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '7adf6aaea6f8f64a3a2e', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Diego Schaefer', 'diego.schaefer@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '753d738ef8c66f41052f', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Jess Kshlerin', 'jess.kshlerin@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'c844cf92e4e520b01a5c', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Candelario Gerlach', 'candelario.gerlach@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'cd76c71f2a7555f75739', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '36049726684a738ced88', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'b1ee9ad1db997874b956', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Leslie Kerluke', 'leslie.kerluke@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '9bb8fbab46581e83d1e3', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Margie Brown', 'margie.brown@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'a7465c3b102eb9545270', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '90cb106d074650216dc5', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '2f62e916eb967d34ef93', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Rossie Hudson', 'rossie.hudson@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '2b702f8490fcdf15a359', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Rylan Morissette', 'rylan.morissette@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '0a788378440a12660e7a', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Mallory Zemlak', 'mallory.zemlak@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '70eca79e33cb289c7ce8', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Darren Eichmann', 'darren.eichmann@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '459decfda33dd2ff6514', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Lorena Baumbach', 'lorena.baumbach@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'e8bada6ac315e0ca49a6', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Omari Legros', 'omari.legros@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '046e291fe14694fa6a15', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'fff16d6b640b292142c6', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '8a996d19f257df37c802', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Rosie Little', 'rosie.little@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '7af898e3e42d8c962825', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Montana Howe', 'montana.howe@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '85d66016b506dc6a7572', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'b8a2621510359283a827', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '20c7c7532af473e6d9b5', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '498a4b1e28e0ac95e409', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Tyrel Champlin', 'tyrel.champlin@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'a2deef3d1c3cb02df6d2', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Jordon McCullough', 'jordon.mccullough@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '772355b1c6a1a3d58a58', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Claud Rice', 'claud.rice@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '3dbc85f81f5b67945c54', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Keanu Bahringer', 'keanu.bahringer@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '85e801ec70c1fad2c4e8', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'ea2db22b603974a70190', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Rosendo Hilpert', 'rosendo.hilpert@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '8f93573ae5acb75bd16a', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Yadira Koepp', 'yadira.koepp@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '8710518aa0fb0566a4f7', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Ernest Balistreri', 'ernest.balistreri@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '41d53ee5301a9c13b6bb', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '2ced2c940a3c3a1fb264', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Rory Lemke', 'rory.lemke@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '84a6fd2d6db2e508d938', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Claude Gleason', 'claude.gleason@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '091cbe0aac7b235cba58', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '1230953b1e92bb1b3a31', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Libby Dibbert', 'libby.dibbert@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'c9707fb0e6f1fc560ecb', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Carol Connelly', 'carol.connelly@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'ffbae626b0068ed347e5', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Millie Sanford', 'millie.sanford@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '27a99a582f593aab5635', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'e13450fc2dd92bb23e64', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Jarred Reynolds', 'jarred.reynolds@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'caa0e370c0032f40f2d6', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Kay Wiegand', 'kay.wiegand@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '3ba0d01d5648a40715d4', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Felipe Cronin', 'felipe.cronin@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '7ffb74b60ec2ff580bf3', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'afc418c57f8e3351fb0c', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Aiden Lemke', 'aiden.lemke@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '4cb78b42c4746be60f8f', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Joy Bauch', 'joy.bauch@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '24d177f7cbc36cef46b9', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Ed Weber', 'ed.weber@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'e965f604bc73e17b30da', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Destiney Wilderman', 'destiney.wilderman@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '0e44ff22fb0d6e38155f', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'a766ce5d1838dad682a7', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Verda Stehr', 'verda.stehr@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '70ea63b08725cb71b6ba', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Kathryn Maggio', 'kathryn.maggio@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '7947c71a2c08e4265036', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Yoshiko Kassulke', 'yoshiko.kassulke@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '06c8aff72651e4ab7c0b', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Kacey Reichel', 'kacey.reichel@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '2c0e7aea1ebd43b2c4af', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'c0cbddf01e26be286ec4', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Jarvis Quigley', 'jarvis.quigley@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'c2f1576ac0f9a1a504b3', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '85456c41627d0148d77b', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Alize McDermott', 'alize.mcdermott@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '062c35ee4e3f6aa22044', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Lilly Ritchie', 'lilly.ritchie@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '8b7e9a750e892a2295a1', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Nils Pagac', 'nils.pagac@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '9395da74b773ff048f08', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Norwood Hettinger', 'norwood.hettinger@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'e11023a52876adb92086', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'emailed', '#{ticket_name}', 500.0, 'Alessandro Johnson', 'alessandro.johnson@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '63990e782219404ede4e', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'purchased', '#{ticket_name}', 500.0, 'Domenico Flatley', 'domenico.flatley@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, name, status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'a66aaac49a6184b2079c', '#{listing.id}', NULL, '#{ticket_name}', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


Logger.info "=========== END Processing Universe Event Girl-Prov Presents: Here Kitty Kitty! ==========="
