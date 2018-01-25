  require Logger
  alias TicketAgent.Random

  Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

  account = SeedHelpers.create_account("Push Comedy Theater")
  user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
  card = SeedHelpers.create_credit_card(user)
  user = SeedHelpers.create_user("concierge@veverka.net", account, "concierge")
  Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event Harold Night ==========="

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


Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
sql = "INSERT INTO orders (id, user_id, credit_card_id, slug, status, subtotal, credit_card_fee, processing_fee, total_price, started_at, processing_at, completed_at, errored_at, cancelled_at, inserted_at, updated_at) VALUES (uuid_generate_v4(), '#{user.id}', '#{card.id}', '#{TicketAgent.Random.generate_slug()}', 'completed', 5000, 500, 500, 6000, NULL, NULL, NOW(), NULL, NULL, NOW(), NOW()) RETURNING cast(id as text);"

%Postgrex.Result{rows: [[order_id]]} = TicketAgent.Repo.query!(sql)

ticket_name = "Ticket for Harold Night"

sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '3fd9b141f311a2450261', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'dd357c2f73d29b0fbfc6', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Berneice Kihn', 'berneice.kihn@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'e4d37e5a24fce70deb5b', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Roy Dooley', 'roy.dooley@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'e0c9c60edc64c2f69ad9', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '0238e3f426523d5166ac', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Alanna Greenholt', 'alanna.greenholt@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'ce98b700726c0f9d82dd', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Madison Cummings', 'madison.cummings@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'd14fef67cd58ce2d9212', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '8cb3eb7bc6078d80517c', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Elwin Spencer', 'elwin.spencer@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '8cc7988d5ef5f26b71df', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Ignatius Green', 'ignatius.green@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '4bd9a51416dfe985c0d8', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '985ed57b924c02463b9e', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Nico Johnston', 'nico.johnston@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'b11d50b5bc85593dcc28', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'd4928502ca67e0a8cda9', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Dessie Toy', 'dessie.toy@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '302d04538c3c07b2ca15', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '5af3bc51b16d548165d9', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Maiya Jacobi', 'maiya.jacobi@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'ca42104629bfc473c062', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Federico Ryan', 'federico.ryan@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'c8173a76f11e311c8596', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '1efbf075a9d745f843d7', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Ashton Powlowski', 'ashton.powlowski@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '22b2addf12992e701c2b', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'e3172b820c26462ec57c', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Flossie Buckridge', 'flossie.buckridge@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '38ec6eeaafe2a8c78b36', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '5ba2fa161b35bc354eab', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Amina VonRueden', 'amina.vonrueden@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '99b34e478f2929ac274d', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '87662e7920774e509b38', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Kaden Greenholt', 'kaden.greenholt@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'e7471ef9859f850161fc', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Shyanne Green', 'shyanne.green@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'e0caf735c46438329516', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Pink Marks', 'pink.marks@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'aac9f358d1638d89c196', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Elfrieda Barton', 'elfrieda.barton@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '7499f75a2b560d901c91', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Ralph Greenholt', 'ralph.greenholt@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '4ff62a42b840d978d55e', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Audrey Ziemann', 'audrey.ziemann@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'dec214a56cb71dd6f4cb', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Keanu Larson', 'keanu.larson@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '4ab5fb7975d98768f2c6', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '71342b9950caab18ff0c', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '593e5099b3a38792f75a', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Matilda Rath', 'matilda.rath@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'd1fbe1b02aadd6f27acc', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '7db065000ccbb7ee0b04', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Ena Schulist', 'ena.schulist@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '3292ebf4d731396b0a08', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '34ec073e98329a012f77', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '6aa29ae906429ad3cb58', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '3294fbbb3aeaaac59e9b', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'f19c700c2ef50aa28334', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '8c36c6b91c910f845521', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Cedrick Nienow', 'cedrick.nienow@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '20fb92661161087755d9', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Zelda Sanford', 'zelda.sanford@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '531f2d0766d20f8ab067', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Kamren Jones', 'kamren.jones@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'ff4a8ab0ffc1f9e34f6a', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Joannie Jerde', 'joannie.jerde@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '9e8ea971247417ebddac', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'c35c4b23864e2b9fd495', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Delfina Parisian', 'delfina.parisian@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '1a18b98b6b47ecc1f936', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '7e80f5b65fcb9c2b0170', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Merl Hartmann', 'merl.hartmann@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '6819e6c2b74431de0044', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Lionel Goodwin', 'lionel.goodwin@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'b6badc23bd02d2bcf201', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Zachariah Predovic', 'zachariah.predovic@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '619354688e98172a11c4', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Moises Braun', 'moises.braun@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '7e5e73407b3366751f60', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Vivian Murray', 'vivian.murray@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '570501a333c7f0d32694', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Bradley Baumbach', 'bradley.baumbach@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'd73882d23421acbd5faf', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Osvaldo Hessel', 'osvaldo.hessel@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '9f3611dd65f344c1fd3e', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '88ee18b3bf397a937570', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Teresa Hodkiewicz', 'teresa.hodkiewicz@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '65591d7807d18e27d75a', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Leon Harber', 'leon.harber@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '56394172a3506ceedbf4', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Amira Rogahn', 'amira.rogahn@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '214230673ff20d13be6e', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Arnoldo Littel', 'arnoldo.littel@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '3c225cfa6b4ba49087bb', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'a611d0634af421c1e3ee', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Amina Rutherford', 'amina.rutherford@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'db2ceeecd0c31a20a471', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Noemy Doyle', 'noemy.doyle@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '6432c3f36b6bdb229447', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Cierra Schimmel', 'cierra.schimmel@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'a404505716654b62c74b', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Eryn Muller', 'eryn.muller@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'ebdb1a4c4ae173b7a6a4', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '58936a4e563549452d23', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'edab4bd8497257aec420', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '976bcd411b56c48a08f5', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Americo Von', 'americo.von@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'cbb2bf56613e955f0df2', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '05bea47ba40e39ce9d10', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '5584c6388218c3f2774d', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'b19c816e9099046f23d8', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Camila Cummings', 'camila.cummings@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '4448e32bf2ee7b12f5a0', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 500.0, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '1d6c894ee3e1c14d873e', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Mohammed Bradtke', 'mohammed.bradtke@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'e830a9296eb9e7375aa0', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Stacey Bednar', 'stacey.bednar@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '1da751cc72e65839392f', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Jeanie Abernathy', 'jeanie.abernathy@hotmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '9507e5de4392905dad2c', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 500.0, 'Lance Kuhn', 'lance.kuhn@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '81222b522aee966e75a1', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Preston Lindgren', 'preston.lindgren@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '2a31555bc23690746118', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Myrl Barton', 'myrl.barton@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'befd5029b4b55f4976e1', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 500.0, 'Myrtice Kozey', 'myrtice.kozey@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


Logger.info "=========== END Processing Universe Event Harold Night ==========="
