  require Logger
  alias TicketAgent.Random

  Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

  account = SeedHelpers.create_account("Push Comedy Theater")
  user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
  card = SeedHelpers.create_credit_card(user)
  user = SeedHelpers.create_user("concierge@veverka.net", account, "concierge")
  Logger.info "Loading classes"
  improv101 = SeedHelpers.create_class(%{slug: "improv101"})
  improv201 = SeedHelpers.create_class(%{slug: "improv201"})
  improv301 = SeedHelpers.create_class(%{slug: "improv301"})
  improv401 = SeedHelpers.create_class(%{slug: "improv401"})
  improv501 = SeedHelpers.create_class(%{slug: "improv501"})
  kidprov101 = SeedHelpers.create_class(%{slug: "kidprov101"})
  kidprov201 = SeedHelpers.create_class(%{slug: "kidprov201"})
  music_improv101 = SeedHelpers.create_class(%{slug: "music_improv101"})
  music_improv201 = SeedHelpers.create_class(%{slug: "music_improv201"})
  music_improv_studio = SeedHelpers.create_class(%{slug: "music_improv_studio"})
  teen_improv = SeedHelpers.create_class(%{slug: "teen_improv"})
  sketch101 = SeedHelpers.create_class(%{slug: "sketch101"})
  sketch201 = SeedHelpers.create_class(%{slug: "sketch201"})
  standup101 = SeedHelpers.create_class(%{slug: "standup101"})
  acting101 = SeedHelpers.create_class(%{slug: "acting101"})
  Logger.info "Seeding classes"
Logger.info "=========== BEGIN Processing Universe Event Musical Improv 201 ==========="

Logger.info "=========== Writing Class Listing Musical Improv 201 ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv201.id,
    slug: "CWRY6N",
    title: "Musical Improv 201",
    description: """
    <p>Musical Improv 201
</p>
<p>This class is focused on building a long form Musical Harold. It will improve upon the concepts and skills learned in Musical Improv 101, with a focus on finding deeper relationships and themes to bring to life through song.
</p>
<p>Be prepared to play with unique 2nd beats, duets, genres, and movement.
</p>
<p>This course culminates with a graduation show.
</p>
<p>Prerequisites: Musical Improv 101
</p>
<p>This course is 6 weeks long
</p>
<p>Cost $210
</p>
<p><strong>This class is held on Saturday afternoons, 3pm-6pm, November 18th through January 6th.</strong>
</p>
<p><strong></strong>
</p>
<p><strong>***There will be no class on November 25th or December 23rd. There will be class on December 30th***</strong>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-11-18 20:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-06 23:00:00Z"),
    created_at: NaiveDateTime.from_iso8601("2017-09-10T21:07:26.636Z")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing 12 tickets for #{listing.id} ==========="
sql = "INSERT INTO orders (id, user_id, credit_card_id, slug, status, subtotal, credit_card_fee, processing_fee, total_price, started_at, processing_at, completed_at, errored_at, cancelled_at, inserted_at, updated_at) VALUES (uuid_generate_v4(), '#{user.id}', '#{card.id}', '#{TicketAgent.Random.generate_slug()}', 'completed', 5000, 500, 500, 6000, NULL, NULL, NOW(), NULL, NULL, NOW(), NOW()) RETURNING cast(id as text);"

%Postgrex.Result{rows: [[order_id]]} = TicketAgent.Repo.query!(sql)

ticket_name = "Ticket for Musical Improv 201"

sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '0f66a882950ed61def4b', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 2.1e4, 'Monty Funk', 'monty.funk@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'd7ffc3336b9dbce4b941', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 2.1e4, 'Earl Crona', 'earl.crona@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '4bbe527b98881b131864', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 2.1e4, 'Jensen Kling', 'jensen.kling@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'cd87a15561e8d1dd20cd', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 2.1e4, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'b2c0ee31a20432709dbb', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 2.1e4, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '3a388251fb5c6d93f696', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 2.1e4, 'Celia O'Keefe', 'celia.okeefe@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '75d0bf53a5f363de1b19', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 2.1e4, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '7eb64293d3dde872b8b8', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 2.1e4, 'Timmy Boyer', 'timmy.boyer@outlook.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '62b846c40af6b87e7c76', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'purchased', '#{ticket_name}', 2.1e4, 'Lindsay Farrell', 'lindsay.farrell@yahoo.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
{:ok, seconds, _, _} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
purchased_at = NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds))
emailed_at =  (purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500)))

sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'ec3fd0ccb85d7972d17f', '#{listing.id}', '#{order_id}', '#{ticket_name}', 'default', 'emailed', '#{ticket_name}', 2.1e4, 'Isadore Bauch', 'isadore.bauch@gmail.com', '#{sale_start}', NULL, NULL, '#{purchased_at}', '#{emailed_at}', NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), '7dd1faaf498b292d3f81', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 2.1e4, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


sale_start = listing.start_at |> Calendar.NaiveDateTime.subtract!(604800)
sql = "INSERT INTO tickets (id, slug, listing_id, order_id, \"name\", \"group\", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) VALUES (uuid_generate_v4(), 'a4c757acf1deb0c7be15', '#{listing.id}', NULL, '#{ticket_name}', 'default', 'available', '#{ticket_name}', 2.1e4, NULL, NULL, '#{sale_start}', NULL, NULL, NULL, NULL, NULL, NULL, NOW(), NOW());"

TicketAgent.Repo.query(sql)


Logger.info "=========== END Processing Universe Event Musical Improv 201 ==========="
