require Logger
alias TicketAgent.Random

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
card = SeedHelpers.create_credit_card(user)
user = SeedHelpers.create_user("concierge@veverka.net", account, "concierge")
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event Tales from the Campfire: The Improvised Ghost Story ==========="

Logger.info "=========== Writing Event Tales from the Campfire: The Improvised Ghost Story ==========="
event = SeedHelpers.create_event(
  %{
    slug: "9M3XN0",
    title: "Tales from the Campfire: The Improvised Ghost Story",
    description: """
    <p>I ain't afraid of no ghost!<br>
</p>
<p>The Push presents a frightful night of comedy (or is it a hilarious night of frights).<br>
</p>
<p><strong>Tales from the Campfire is quickly becoming one of the Push's biggest hits.</strong>
</p>
<p><strong><br></strong>
</p>
<p>With an audience suggestion, this talented group of improvisers will make up a series of gut-busting ghost story right before your eyes.<br>
</p>
<p><br>
</p>
<p><strong>Tales from the Campfire: The Improvised Ghost Story</strong>
</p>
<p>Saturday, January 6th at 8pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Tales from the Campfire: The Improvised Ghost Story ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "9M3XN0",
    title: "Tales from the Campfire: The Improvised Ghost Story",
    description: """
    <p>I ain't afraid of no ghost!<br>
</p>
<p>The Push presents a frightful night of comedy (or is it a hilarious night of frights).<br>
</p>
<p><strong>Tales from the Campfire is quickly becoming one of the Push's biggest hits.</strong>
</p>
<p><strong><br></strong>
</p>
<p>With an audience suggestion, this talented group of improvisers will make up a series of gut-busting ghost story right before your eyes.<br>
</p>
<p><br>
</p>
<p><strong>Tales from the Campfire: The Improvised Ghost Story</strong>
</p>
<p>Saturday, January 6th at 8pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2018-01-07 01:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-07 02:30:00Z")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/fbca7042-3e12-4e21-9cff-98a451943cdf"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "show"
})
Logger.info "=========== Wrote tag ==========="

# Insert deal
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "deal"
})
Logger.info "=========== Wrote tag ==========="

# Insert ghost
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "ghost"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..80, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Tales from the Campfire: The Improvised Ghost Story",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for Tales from the Campfire: The Improvised Ghost Story",
        price: 500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-28T23:26:03.768Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Tales from the Campfire: The Improvised Ghost Story",
        status: "available",
        description: "Ticket for Tales from the Campfire: The Improvised Ghost Story",
        price: 500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-28T23:26:03.768Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="

Logger.info "=========== END Processing Universe Event Tales from the Campfire: The Improvised Ghost Story ==========="
Logger.info "=========== BEGIN Processing Universe Event Date Night ==========="

Logger.info "=========== Writing Event Date Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "W4SZ35",
    title: "Date Night",
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
<p>Friday, January 5th at 8pm
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
Logger.info "=========== Writing Event Listing Date Night ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "W4SZ35",
    title: "Date Night",
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
<p>Friday, January 5th at 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2018-01-06 01:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-06 02:30:00Z")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/7e2ff30f-6b86-488e-8838-cfc9912b6824"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "show"
})
Logger.info "=========== Wrote tag ==========="

# Insert deal
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "deal"
})
Logger.info "=========== Wrote tag ==========="

# Insert date-night
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "date-night"
})
Logger.info "=========== Wrote tag ==========="

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "sketch"
})
Logger.info "=========== Wrote tag ==========="

# Insert couples
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "couples"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..80, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Date Night",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for Date Night",
        price: 500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-28T22:59:44.452Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Date Night",
        status: "available",
        description: "Ticket for Date Night",
        price: 500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-28T22:59:44.452Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="

Logger.info "=========== END Processing Universe Event Date Night ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="

Logger.info "=========== Writing Event The Improv Riot: The Short Form Improv Show ==========="
event = SeedHelpers.create_event(
  %{
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

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bdd1ac16-4eaa-4a83-87eb-eb7d4aadbd35"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "show"
})
Logger.info "=========== Wrote tag ==========="

# Insert deal
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "deal"
})
Logger.info "=========== Wrote tag ==========="

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "sketch"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..80, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for The Improv Riot: The Short Form Improv Show",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for The Improv Riot: The Short Form Improv Show",
        price: 500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-11-20T23:40:40.339Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for The Improv Riot: The Short Form Improv Show",
        status: "available",
        description: "Ticket for The Improv Riot: The Short Form Improv Show",
        price: 500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-11-20T23:40:40.339Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="

Logger.info "=========== END Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Musical Improv 201 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Musical Improv 201 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "GCJS74",
    title: "Class Dismissed: The Musical Improv 201 Graduation Show",
    description: """
    <p>Check out the Musical Improv 201 Class as they create 2 full length musicals right before your very eyes!
</p>
<p>These melodic and masterful improvisers have been honing their skills for 6 weeks in the arts of song, rap, and even dance! So come out and see what happens when Music and Improv collide!!!
</p>
<p>Class Dismissed: The Musical Improv 201 Graduation Show
</p>
<p>Sunday, January 14th at 4pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Class Dismissed: The Musical Improv 201 Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "GCJS74",
    title: "Class Dismissed: The Musical Improv 201 Graduation Show",
    description: """
    <p>Check out the Musical Improv 201 Class as they create 2 full length musicals right before your very eyes!
</p>
<p>These melodic and masterful improvisers have been honing their skills for 6 weeks in the arts of song, rap, and even dance! So come out and see what happens when Music and Improv collide!!!
</p>
<p>Class Dismissed: The Musical Improv 201 Graduation Show
</p>
<p>Sunday, January 14th at 4pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2018-01-14 21:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-14 22:30:00Z")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b04b05c0-95bd-401c-b55a-87812d9ab7cd"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "show"
})
Logger.info "=========== Wrote tag ==========="

# Insert deal
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "deal"
})
Logger.info "=========== Wrote tag ==========="

# Insert graduation
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "graduation"
})
Logger.info "=========== Wrote tag ==========="

# Insert students
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "students"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..80, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Class Dismissed: The Musical Improv 201 Graduation Show",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for Class Dismissed: The Musical Improv 201 Graduation Show",
        price: 500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-22T19:12:24.370Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Class Dismissed: The Musical Improv 201 Graduation Show",
        status: "available",
        description: "Ticket for Class Dismissed: The Musical Improv 201 Graduation Show",
        price: 500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-22T19:12:24.370Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="

Logger.info "=========== END Processing Universe Event Class Dismissed: The Musical Improv 201 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery (January) ==========="

Logger.info "=========== Writing Event Who Dunnit? ...The Improvised Murder Mystery (January) ==========="
event = SeedHelpers.create_event(
  %{
    slug: "RQGK97",
    title: "Who Dunnit? ...The Improvised Murder Mystery (January)",
    description: """
    <p><strong>Get ready for a spine tingling murder mystery!!!</strong><br>
</p>
<p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.
</p>
<p>...And it will all be made up on the spot!!!
</p>
<p>Don't miss this exciting mystery, all based off the audience's suggestion.
</p>
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, January 13th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $15
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
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
Logger.info "=========== Writing Event Listing Who Dunnit? ...The Improvised Murder Mystery (January) ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "RQGK97",
    title: "Who Dunnit? ...The Improvised Murder Mystery (January)",
    description: """
    <p><strong>Get ready for a spine tingling murder mystery!!!</strong><br>
</p>
<p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.
</p>
<p>...And it will all be made up on the spot!!!
</p>
<p>Don't miss this exciting mystery, all based off the audience's suggestion.
</p>
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, January 13th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $15
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
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
    start_at:  NaiveDateTime.from_iso8601!("2018-01-14 01:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-14 02:30:00Z")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/e736e2a2-4950-4b7c-b606-f0ce63e26dff"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "show"
})
Logger.info "=========== Wrote tag ==========="

# Insert murder-mystery
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "murder-mystery"
})
Logger.info "=========== Wrote tag ==========="

# Insert mystery
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "mystery"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..80, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Who Dunnit? ...The Improvised Murder Mystery (January)",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for Who Dunnit? ...The Improvised Murder Mystery (January)",
        price: 1500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-11-13T17:21:30.743Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Who Dunnit? ...The Improvised Murder Mystery (January)",
        status: "available",
        description: "Ticket for Who Dunnit? ...The Improvised Murder Mystery (January)",
        price: 1500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-11-13T17:21:30.743Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="

Logger.info "=========== END Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery (January) ==========="
Logger.info "=========== BEGIN Processing Universe Event Second Saturday Stand-Up ==========="

Logger.info "=========== Writing Event Second Saturday Stand-Up ==========="
event = SeedHelpers.create_event(
  %{
    slug: "S6PH8X",
    title: "Second Saturday Stand-Up",
    description: """
    <p><strong>Second Saturday Stand-Up</strong>
</p>
<p>This once-a-month show is brought to you by almost-jaded veteran comic, <strong>Hatton Jordan </strong>who sets the lineup with proven comedians delivering road-tested jokes while they squeeze in new material.
</p>
<p>This is NOT a "open mic" .....it's selected talent working on their craft. Every month is a new seasoned lineup.
</p>
<p><br>
</p>
<p>Host: Hatton Jordan
</p>
<p>Line-Up TBA
</p>
<p><strong><br></strong>
</p>
<p><strong>Second Saturday Stand-Up</strong>
</p>
<p>Saturday, January 13th at 10pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Second Saturday Stand-Up ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "S6PH8X",
    title: "Second Saturday Stand-Up",
    description: """
    <p><strong>Second Saturday Stand-Up</strong>
</p>
<p>This once-a-month show is brought to you by almost-jaded veteran comic, <strong>Hatton Jordan </strong>who sets the lineup with proven comedians delivering road-tested jokes while they squeeze in new material.
</p>
<p>This is NOT a "open mic" .....it's selected talent working on their craft. Every month is a new seasoned lineup.
</p>
<p><br>
</p>
<p>Host: Hatton Jordan
</p>
<p>Line-Up TBA
</p>
<p><strong><br></strong>
</p>
<p><strong>Second Saturday Stand-Up</strong>
</p>
<p>Saturday, January 13th at 10pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2018-01-14 03:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-14 04:30:00Z")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9bd8303c-a46b-4654-8fc9-c7eb6b68a587"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "show"
})
Logger.info "=========== Wrote tag ==========="

# Insert deal
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "deal"
})
Logger.info "=========== Wrote tag ==========="

# Insert standup
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "standup"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..80, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Second Saturday Stand-Up",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for Second Saturday Stand-Up",
        price: 500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-28T23:33:46.012Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Second Saturday Stand-Up",
        status: "available",
        description: "Ticket for Second Saturday Stand-Up",
        price: 500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-28T23:33:46.012Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="

Logger.info "=========== END Processing Universe Event Second Saturday Stand-Up ==========="
Logger.info "=========== BEGIN Processing Universe Event The Pre Madonnas Present: All Groan Up ==========="

Logger.info "=========== Writing Event The Pre Madonnas Present: All Groan Up ==========="
event = SeedHelpers.create_event(
  %{
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

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8d9b9282-9a23-4993-b5b9-66dd813faf02"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "show"
})
Logger.info "=========== Wrote tag ==========="

# Insert pre-maddonas
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "pre-maddonas"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..80, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for The Pre Madonnas Present: All Groan Up",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for The Pre Madonnas Present: All Groan Up",
        price: 1000,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-28T19:58:15.164Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for The Pre Madonnas Present: All Groan Up",
        status: "available",
        description: "Ticket for The Pre Madonnas Present: All Groan Up",
        price: 1000,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-28T19:58:15.164Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="

Logger.info "=========== END Processing Universe Event The Pre Madonnas Present: All Groan Up ==========="
Logger.info "=========== BEGIN Processing Universe Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="

Logger.info "=========== Writing Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
event = SeedHelpers.create_event(
  %{
    slug: "N0VHXG",
    title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    description: """
    <p><strong>Don't miss this epic sketch comedy showdown, where truly anything can happen.</strong><br>
</p>
<p>And we do mean anything!!!  Sometimes it's funny, sometimes it's weird, it's always entertaining.
</p>
<p>SKETCHMAGEDDON
</p>
<p><br>
</p>
<p>--
</p>
<p>Get ready for a sketch comedy show like no other!!!
</p>
<p><strong>SKETCHMAGEDDON</strong> takes three groups and forces them to compete in an all-out comedy deathmatch!
</p>
<p>Each team will be given 15 minutes to dazzle you with their comedy prowess. It's Saturday Night Live meets Thunderdome!!!!
</p>
<p>Unlike its improvised sister show IMPROVAGEDDON, SKETCHMAGEDDON features all written and rehearsed material.  Props, costumes, and special effects are all legal in SKETCHMAGEDDON.
</p>
<p>This is a completely experimental show.  You never know what you are going to see.
</p>
<p><strong>SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition</strong>
</p>
<p>Friday, January 5th at 10pm
</p>
<p>Tickets are $5
</p>
<p>------------
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "N0VHXG",
    title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    description: """
    <p><strong>Don't miss this epic sketch comedy showdown, where truly anything can happen.</strong><br>
</p>
<p>And we do mean anything!!!  Sometimes it's funny, sometimes it's weird, it's always entertaining.
</p>
<p>SKETCHMAGEDDON
</p>
<p><br>
</p>
<p>--
</p>
<p>Get ready for a sketch comedy show like no other!!!
</p>
<p><strong>SKETCHMAGEDDON</strong> takes three groups and forces them to compete in an all-out comedy deathmatch!
</p>
<p>Each team will be given 15 minutes to dazzle you with their comedy prowess. It's Saturday Night Live meets Thunderdome!!!!
</p>
<p>Unlike its improvised sister show IMPROVAGEDDON, SKETCHMAGEDDON features all written and rehearsed material.  Props, costumes, and special effects are all legal in SKETCHMAGEDDON.
</p>
<p>This is a completely experimental show.  You never know what you are going to see.
</p>
<p><strong>SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition</strong>
</p>
<p>Friday, January 5th at 10pm
</p>
<p>Tickets are $5
</p>
<p>------------
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2018-01-06 03:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-06 04:30:00Z")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/83a0c1e9-fd2e-4b82-9e5b-a1edaf6416c9"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "show"
})
Logger.info "=========== Wrote tag ==========="

# Insert deal
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "deal"
})
Logger.info "=========== Wrote tag ==========="

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "sketch"
})
Logger.info "=========== Wrote tag ==========="

# Insert sketchmageddon
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "sketchmageddon"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..80, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
        price: 500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-28T23:17:47.622Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
        status: "available",
        description: "Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
        price: 500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-28T23:17:47.622Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="

Logger.info "=========== END Processing Universe Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
Logger.info "=========== BEGIN Processing Universe Event Good Talk: The Brad McMurran Show ==========="

Logger.info "=========== Writing Event Good Talk: The Brad McMurran Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "JN8VR3",
    title: "Good Talk: The Brad McMurran Show",
    description: """
    <p style="text-align: center;">Get ready for a night of comedy from the Pushers' own Brad McMurran.
</p>
<p style="text-align: center;">New Years Resolutions and Regrets
</p>
<p style="text-align: center;">This month's show is all about growth, regret, change, remorse, reinvention, and most importantly, New Years Resolutions... or at least attempts at those things.
</p>
<p style="text-align: center;">Brad has made repeated efforts to change into a new man, and year after year, he finds himself meeting regret with a commitment to self-evolution. And year after year, it's a wild ride!
</p>
<p style="text-align: center;"><strong>Good Talk: The Brad McMurran Show</strong>
</p>
<p style="text-align: center;">New Years Resolutions and Regrets
</p>
<p style="text-align: center;">Sunday, January 7th at 7pm
</p>
<p style="text-align: center;">Tickets are $12
</p>
<p style="text-align: center;">Good Talk is a one-man show starring Brad McMurran and focusing on McMurran's wildly popular Facebook posts.
</p>
<p style="text-align: center;">Each month, Good Talk looks at the life and experiences of a sketch and improv comedian.  Through storytelling, improv and mixed media, Brad will bring his Good Talk Facebook posts to life.
</p>
<p style="text-align: center;">You'll see is struggles with bill collectors, relationships, alcohol, parents, opening a theater and just trying to act like an adult.
</p>
<p style="text-align: center;">The show is going to be an unpredictable, wild and borderline-insane ride... just like Brad's life.
</p>
<p style="text-align: center;">Upcoming episodes of Good Talk: The Brad McMurran Show will include -
</p>
<p style="text-align: center;">Crazy for Love
</p>
<p style="text-align: center;">My Life in Comedy
</p>
<p style="text-align: center;">The College Years
</p>
<p style="text-align: center;">The New York Years
</p>
<p style="text-align: center;">Life and Death
</p>
<p style="text-align: center;">Failure
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Good Talk: The Brad McMurran Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "JN8VR3",
    title: "Good Talk: The Brad McMurran Show",
    description: """
    <p style="text-align: center;">Get ready for a night of comedy from the Pushers' own Brad McMurran.
</p>
<p style="text-align: center;">New Years Resolutions and Regrets
</p>
<p style="text-align: center;">This month's show is all about growth, regret, change, remorse, reinvention, and most importantly, New Years Resolutions... or at least attempts at those things.
</p>
<p style="text-align: center;">Brad has made repeated efforts to change into a new man, and year after year, he finds himself meeting regret with a commitment to self-evolution. And year after year, it's a wild ride!
</p>
<p style="text-align: center;"><strong>Good Talk: The Brad McMurran Show</strong>
</p>
<p style="text-align: center;">New Years Resolutions and Regrets
</p>
<p style="text-align: center;">Sunday, January 7th at 7pm
</p>
<p style="text-align: center;">Tickets are $12
</p>
<p style="text-align: center;">Good Talk is a one-man show starring Brad McMurran and focusing on McMurran's wildly popular Facebook posts.
</p>
<p style="text-align: center;">Each month, Good Talk looks at the life and experiences of a sketch and improv comedian.  Through storytelling, improv and mixed media, Brad will bring his Good Talk Facebook posts to life.
</p>
<p style="text-align: center;">You'll see is struggles with bill collectors, relationships, alcohol, parents, opening a theater and just trying to act like an adult.
</p>
<p style="text-align: center;">The show is going to be an unpredictable, wild and borderline-insane ride... just like Brad's life.
</p>
<p style="text-align: center;">Upcoming episodes of Good Talk: The Brad McMurran Show will include -
</p>
<p style="text-align: center;">Crazy for Love
</p>
<p style="text-align: center;">My Life in Comedy
</p>
<p style="text-align: center;">The College Years
</p>
<p style="text-align: center;">The New York Years
</p>
<p style="text-align: center;">Life and Death
</p>
<p style="text-align: center;">Failure
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2018-01-08 00:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-08 01:30:00Z")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/de52f7d0-daa6-4b61-b647-322e1c8b9958"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "show"
})
Logger.info "=========== Wrote tag ==========="

# Insert good-talk
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "good-talk"
})
Logger.info "=========== Wrote tag ==========="

# Insert resolutions
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "resolutions"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..80, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Good Talk: The Brad McMurran Show",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for Good Talk: The Brad McMurran Show",
        price: 1200,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-05T23:12:14.017Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Good Talk: The Brad McMurran Show",
        status: "available",
        description: "Ticket for Good Talk: The Brad McMurran Show",
        price: 1200,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-05T23:12:14.017Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="

Logger.info "=========== END Processing Universe Event Good Talk: The Brad McMurran Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Girl-Prov Presents: Here Kitty Kitty! ==========="

Logger.info "=========== Writing Event Girl-Prov Presents: Here Kitty Kitty! ==========="
event = SeedHelpers.create_event(
  %{
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

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/2818bca8-8162-47b8-999f-625527ad42d0"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "show"
})
Logger.info "=========== Wrote tag ==========="

# Insert deal
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "deal"
})
Logger.info "=========== Wrote tag ==========="

# Insert girl-prov
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "girl-prov"
})
Logger.info "=========== Wrote tag ==========="

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "sketch"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..80, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Girl-Prov Presents: Here Kitty Kitty!",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for Girl-Prov Presents: Here Kitty Kitty!",
        price: 500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-28T23:47:35.710Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Girl-Prov Presents: Here Kitty Kitty!",
        status: "available",
        description: "Ticket for Girl-Prov Presents: Here Kitty Kitty!",
        price: 500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-28T23:47:35.710Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="

Logger.info "=========== END Processing Universe Event Girl-Prov Presents: Here Kitty Kitty! ==========="
Logger.info "=========== BEGIN Processing Universe Event Harold Night ==========="

Logger.info "=========== Writing Event Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "RPB6JG",
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
<p>Friday, November 24th at 10:00pm
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
    slug: "RPB6JG",
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
<p>Friday, November 24th at 10:00pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-11-25 03:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-25 04:30:00Z")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/49cb7b83-12f7-40fe-a963-5ad538df05a4"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "show"
})
Logger.info "=========== Wrote tag ==========="

# Insert deal
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "deal"
})
Logger.info "=========== Wrote tag ==========="

# Insert harold
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "harold"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..80, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Harold Night",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for Harold Night",
        price: 500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-11-20T23:37:53.219Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Harold Night",
        status: "available",
        description: "Ticket for Harold Night",
        price: 500,
        sale_start:  NaiveDateTime.from_iso8601!("2017-11-20T23:37:53.219Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="

Logger.info "=========== END Processing Universe Event Harold Night ==========="
