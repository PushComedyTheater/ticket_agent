require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="

Logger.info "=========== Writing Event The Improv Riot: The Short Form Improv Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "1MQNY9",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.</p><p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.</p><p><strong style="background-color: initial;">The Improv Riot: The Short Form Improv Show</strong></p><p>Friday, May 27th, 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the parking lot directly across from the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "1MQNY9",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.</p><p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.</p><p><strong style="background-color: initial;">The Improv Riot: The Short Form Improv Show</strong></p><p>Friday, May 27th, 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the parking lot directly across from the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-05-27T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-05-27T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bdd1ac16-4eaa-4a83-87eb-eb7d4aadbd35",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bdd1ac16-4eaa-4a83-87eb-eb7d4aadbd35",
  type: "cover"
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
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Improv Riot: The Short Form Improv Show",
    status: "available",
    description: "Ticket for The Improv Riot: The Short Form Improv Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-29T23:40:52.710Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Sketchmageddon ==========="

Logger.info "=========== Writing Event Sketchmageddon ==========="
event = SeedHelpers.create_event(
  %{
    slug: "G3TX94",
    title: "Sketchmageddon",
    description: """
    <p><strong>The Push Comedy Theater's Experimental Sketch Comedy Showcase is back with a vengeance!!!!</strong>
</p>
<p>This is the show where anything goes ... and we do mean anything.
</p>
<p>--
</p>
<p><strong>Get ready for a sketch comedy show like no other!!!</strong>
</p>
<p><strong>SKETCHMAGEDDON</strong> takes 3 groups and forces them to compete in an all-out comedy, death-match!  <br>  Each team will be given 15 minutes to dazzle you with their comedy prowess.
</p>
<p><strong>  It's Saturday Night Live meets Thunderdome!!!! </strong>
</p>
<p> <br>  Unlike it's improvised sister show IMPROVAGEDDON, SKETCHMAGEDDON will feature all written and rehearsed material.  Props, costumes and special effects are all legal in SKETCHMAGEDDON.
</p>
<p> <br><strong>SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition </strong>
</p>
<p>Friday, December 2nd at 10pm
</p>
<p>Tickets are $5
</p>
<p>------------
</p>
<p><strong>The Push Comedy Theater </strong>only has 99 seats, so we recommend you get your tickets in advance.
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
Logger.info "=========== Writing Event Listing Sketchmageddon ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "G3TX94",
    title: "Sketchmageddon",
    description: """
    <p><strong>The Push Comedy Theater's Experimental Sketch Comedy Showcase is back with a vengeance!!!!</strong>
</p>
<p>This is the show where anything goes ... and we do mean anything.
</p>
<p>--
</p>
<p><strong>Get ready for a sketch comedy show like no other!!!</strong>
</p>
<p><strong>SKETCHMAGEDDON</strong> takes 3 groups and forces them to compete in an all-out comedy, death-match!  <br>  Each team will be given 15 minutes to dazzle you with their comedy prowess.
</p>
<p><strong>  It's Saturday Night Live meets Thunderdome!!!! </strong>
</p>
<p> <br>  Unlike it's improvised sister show IMPROVAGEDDON, SKETCHMAGEDDON will feature all written and rehearsed material.  Props, costumes and special effects are all legal in SKETCHMAGEDDON.
</p>
<p> <br><strong>SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition </strong>
</p>
<p>Friday, December 2nd at 10pm
</p>
<p>Tickets are $5
</p>
<p>------------
</p>
<p><strong>The Push Comedy Theater </strong>only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-12-02T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-12-02T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/0b91d75a-407a-40d8-a3eb-ddcd61c4923f",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/0b91d75a-407a-40d8-a3eb-ddcd61c4923f",
  type: "cover"
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
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Sketchmageddon",
    status: "available",
    description: "Ticket for Sketchmageddon",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-16T19:14:32.589Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Sketchmageddon ==========="
Logger.info "=========== BEGIN Processing Universe Event Tales from the Campfire: The Improvised Ghost Story ==========="

Logger.info "=========== Writing Event Tales from the Campfire: The Improvised Ghost Story ==========="
event = SeedHelpers.create_event(
  %{
    slug: "RWZ85H",
    title: "Tales from the Campfire: The Improvised Ghost Story",
    description: """
    <p>The Push presents a frightful night of comedy (or is it a hilarious night of frights).
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
<p>Saturday, July 1st at 8pm
</p>
<p>Tickets are $5
</p>
<p><br>
</p>
<p>I ain't afraid of no ghost!
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
    slug: "RWZ85H",
    title: "Tales from the Campfire: The Improvised Ghost Story",
    description: """
    <p>The Push presents a frightful night of comedy (or is it a hilarious night of frights).
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
<p>Saturday, July 1st at 8pm
</p>
<p>Tickets are $5
</p>
<p><br>
</p>
<p>I ain't afraid of no ghost!
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-07-01T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-01T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/fbca7042-3e12-4e21-9cff-98a451943cdf",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/fbca7042-3e12-4e21-9cff-98a451943cdf",
  type: "cover"
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
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Tales from the Campfire: The Improvised Ghost Story",
    status: "available",
    description: "Ticket for Tales from the Campfire: The Improvised Ghost Story",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-06-19T16:43:36.356Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tales from the Campfire: The Improvised Ghost Story ==========="
Logger.info "=========== BEGIN Processing Universe Event Teacher's Pet ==========="

Logger.info "=========== Writing Event Teacher's Pet ==========="
event = SeedHelpers.create_event(
  %{
    slug: "DL1PFK",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Friday, September 8th, 10pm<br>Tickets are $5
</p>
<p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
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
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.
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
Logger.info "=========== Writing Event Listing Teacher's Pet ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "DL1PFK",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Friday, September 8th, 10pm<br>Tickets are $5
</p>
<p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
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
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-09-08T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-08T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bc96f7b9-01c2-4ac8-9566-5bfdfa7f658d",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bc96f7b9-01c2-4ac8-9566-5bfdfa7f658d",
  type: "cover"
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

# Insert graduation-show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "graduation-show"
})
Logger.info "=========== Wrote tag ==========="

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "sketch"
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
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Teacher's Pet",
    status: "available",
    description: "Ticket for Teacher's Pet",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-01T01:00:29.812Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Teacher's Pet ==========="
Logger.info "=========== BEGIN Processing Universe Event The Dudes - The Royal We ==========="

Logger.info "=========== Writing Event The Dudes - The Royal We ==========="
event = SeedHelpers.create_event(
  %{
    slug: "JMH2KG",
    title: "The Dudes - The Royal We",
    description: """
    <p>Ah, the majestic plural... the editorial... In his Manifesto, confirming the abdication from the throne of Tsesarevich and of the Grand Duke, Emperor Alexander I began, "By the Grace of God, We, Alexander I, Emperor and Autocrat of All the Russias...."
</p>
<p><br><br>"We", The Dudes, have no idea what in God's holy Alex was blathering about, but we dig it, man! "We" are pretty sure he meant that "we", the people... you... and The Dudes, all should have a good time laughing with and at each other, ourselves... us, so that "we" aren't royally pissed all the time. Abide and let us... WE... all have a good time!
</p>
<p><br><br>The Dudes are bunch of guys, often laid back, sometimes high-strung, who do nonsensical improv comedy. They're a resident group at The Push Comedy Theater and have also performed up and down the lower-Atlantic seaboard!
</p>
<p><br><br>The Dudes Improvisational Comedy are:<br>Rafael <br>Adam <br>James <br>Angel<br>Matt <br>Brian <br>Anthony
</p>
<p><br><br>The Dudes present...The Royal "We"<br>Saturday, October 7th at 10pm<br>Tickets are $5
</p>
<p><br><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p><br><br>--
</p>
<p><br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p><br><br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p><br><br>
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
Logger.info "=========== Writing Event Listing The Dudes - The Royal We ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "JMH2KG",
    title: "The Dudes - The Royal We",
    description: """
    <p>Ah, the majestic plural... the editorial... In his Manifesto, confirming the abdication from the throne of Tsesarevich and of the Grand Duke, Emperor Alexander I began, "By the Grace of God, We, Alexander I, Emperor and Autocrat of All the Russias...."
</p>
<p><br><br>"We", The Dudes, have no idea what in God's holy Alex was blathering about, but we dig it, man! "We" are pretty sure he meant that "we", the people... you... and The Dudes, all should have a good time laughing with and at each other, ourselves... us, so that "we" aren't royally pissed all the time. Abide and let us... WE... all have a good time!
</p>
<p><br><br>The Dudes are bunch of guys, often laid back, sometimes high-strung, who do nonsensical improv comedy. They're a resident group at The Push Comedy Theater and have also performed up and down the lower-Atlantic seaboard!
</p>
<p><br><br>The Dudes Improvisational Comedy are:<br>Rafael <br>Adam <br>James <br>Angel<br>Matt <br>Brian <br>Anthony
</p>
<p><br><br>The Dudes present...The Royal "We"<br>Saturday, October 7th at 10pm<br>Tickets are $5
</p>
<p><br><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p><br><br>--
</p>
<p><br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p><br><br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p><br><br>
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-10-07T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-10-07T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1799a70d-f7cc-4ef9-8951-90eabd54deba",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1799a70d-f7cc-4ef9-8951-90eabd54deba",
  type: "cover"
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

# Insert the-dudes
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "the-dudes"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Dudes - The Royal We",
    status: "available",
    description: "Ticket for The Dudes - The Royal We",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-06T17:40:11.722Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Dudes - The Royal We ==========="
Logger.info "=========== BEGIN Processing Universe Event Good Talk: The Brad McMurran Show ==========="

Logger.info "=========== Writing Event Good Talk: The Brad McMurran Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "1XNJ3L",
    title: "Good Talk: The Brad McMurran Show",
    description: """
    <p style="text-align: center;">Get ready for a night of comedy from the Pushers' own Brad McMurran.
</p>
<p style="text-align: center;">Alcohol and Drugs
</p>
<p style="text-align: center;">From the journals and Facebook posts of Brad McMurran, comes Brad's crazy experiences with drugs and alcohol.  And there have been many.  From peace pipes with Native Americans to waking up in the gutter on Colley Avenue... don't miss this alcohol and drug-filled ride. <br>
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><strong>Good Talk: The Brad McMurran Show</strong>
</p>
<p style="text-align: center;">Alcohol and Drugs
</p>
<p style="text-align: center;">Sunday, November 5th at 7pm
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
<p style="text-align: center;">Christmas Talks<br>
</p>
<p style="text-align: center;">New Years Resolutions
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
    slug: "1XNJ3L",
    title: "Good Talk: The Brad McMurran Show",
    description: """
    <p style="text-align: center;">Get ready for a night of comedy from the Pushers' own Brad McMurran.
</p>
<p style="text-align: center;">Alcohol and Drugs
</p>
<p style="text-align: center;">From the journals and Facebook posts of Brad McMurran, comes Brad's crazy experiences with drugs and alcohol.  And there have been many.  From peace pipes with Native Americans to waking up in the gutter on Colley Avenue... don't miss this alcohol and drug-filled ride. <br>
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><strong>Good Talk: The Brad McMurran Show</strong>
</p>
<p style="text-align: center;">Alcohol and Drugs
</p>
<p style="text-align: center;">Sunday, November 5th at 7pm
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
<p style="text-align: center;">Christmas Talks<br>
</p>
<p style="text-align: center;">New Years Resolutions
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
    start_at:  NaiveDateTime.from_iso8601!("2017-11-05T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-05T21:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/de52f7d0-daa6-4b61-b647-322e1c8b9958",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/de52f7d0-daa6-4b61-b647-322e1c8b9958",
  type: "cover"
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

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Good Talk: The Brad McMurran Show",
    status: "available",
    description: "Ticket for Good Talk: The Brad McMurran Show",
    price: 1200,
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-03T17:54:05.363Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Good Talk: The Brad McMurran Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Lip Service - Ultimate Lip Sync Competition: Round 3 ==========="

Logger.info "=========== Writing Event Lip Service - Ultimate Lip Sync Competition: Round 3 ==========="
event = SeedHelpers.create_event(
  %{
    slug: "6WDN3K",
    title: "Lip Service - Ultimate Lip Sync Competition: Round 3",
    description: """
    <p>Are you ready for this?
</p>
<p>The hit show from the Core Theater Ensemble and Push Comedy Theater returns!!!
</p>
<p><br>Nine contestants, four months, one Golden Mic! Core Theatre Ensemble and Push Comedy Theater present the most ultimate Lip Sync Competition in Hampton Roads!
</p>
<p><br><br>Each month three brave contestants will show off their Lip Syncing skills over three different rounds with loud music, sweet dance moves, trash talking, and a few surprises along the way!
</p>
<p><br><br>Round 1: Friday, August 18th @ 10PM<br>Featuring <a href="https://www.facebook.com/ashley.hall.925" rel="nofollow" target="_blank">Ashley Hall</a>, <a href="https://www.facebook.com/joeleone86" rel="nofollow" target="_blank">Joe Leone</a>, <a href="https://www.facebook.com/debmarkham" rel="nofollow" target="_blank">deb markham</a><br>with Special Guest Performance!<br>Tickets: <a href="http://www.pushcomedytheater.com/" rel="nofollow" target="_blank">www.pushcomedytheater.com</a>
</p>
<p><br><br>Round 2: Friday, September 22nd @ 10pm <br>Featuring <a href="https://www.facebook.com/dennis.andrews.144" rel="nofollow" target="_blank">Dennis Andrews</a>, <a href="https://www.facebook.com/actionmatt" rel="nofollow" target="_blank">Matt Moreau</a>, <a href="https://www.facebook.com/ldybugamanda" rel="nofollow" target="_blank">Amanda Steadele</a> <br>with Special Guest Performance!
</p>
<p><br><br>Round 3: Saturday, October 20th @ 10pm <br>Featuring <a href="https://www.facebook.com/grummell" rel="nofollow" target="_blank">Evan Michael</a>, <a href="https://www.facebook.com/scot.rose2" rel="nofollow" target="_blank">Scot Rose</a>, <a href="https://www.facebook.com/andracorinne" rel="nofollow" target="_blank">Andra Rosenberg</a><br>with Special Guest Performance!
</p>
<p><br><br>The winner of each round will then battle it out in our final night:<br>Friday, November 17th @ 10pm. <br>The winner takes home THE GOLDEN MIC!
</p>
<p><br><br>Join <a href="https://www.facebook.com/CORE-Theatre-Ensemble-29981515719/" rel="nofollow" target="_blank">CORE Theatre Ensemble</a> at <a href="https://www.facebook.com/PushComedyTheater/" rel="nofollow" target="_blank">Push Comedy Theater</a> as<br>
</p>
<p><a href="https://www.facebook.com/eddie.castillo.3998" rel="nofollow" target="_blank">Eddie Castillo</a>, <a href="https://www.facebook.com/emele" rel="nofollow" target="_blank">Emel Ertugrul</a>, <a href="https://www.facebook.com/laura.agudelo.946" rel="nofollow" target="_blank">Laura Agudelo</a>, and <a href="https://www.facebook.com/nancy.dickerson.148" rel="nofollow" target="_blank">Nancy Dickerson</a> host the hottest lippers in town!
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Lip Service - Ultimate Lip Sync Competition: Round 3 ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "6WDN3K",
    title: "Lip Service - Ultimate Lip Sync Competition: Round 3",
    description: """
    <p>Are you ready for this?
</p>
<p>The hit show from the Core Theater Ensemble and Push Comedy Theater returns!!!
</p>
<p><br>Nine contestants, four months, one Golden Mic! Core Theatre Ensemble and Push Comedy Theater present the most ultimate Lip Sync Competition in Hampton Roads!
</p>
<p><br><br>Each month three brave contestants will show off their Lip Syncing skills over three different rounds with loud music, sweet dance moves, trash talking, and a few surprises along the way!
</p>
<p><br><br>Round 1: Friday, August 18th @ 10PM<br>Featuring <a href="https://www.facebook.com/ashley.hall.925" rel="nofollow" target="_blank">Ashley Hall</a>, <a href="https://www.facebook.com/joeleone86" rel="nofollow" target="_blank">Joe Leone</a>, <a href="https://www.facebook.com/debmarkham" rel="nofollow" target="_blank">deb markham</a><br>with Special Guest Performance!<br>Tickets: <a href="http://www.pushcomedytheater.com/" rel="nofollow" target="_blank">www.pushcomedytheater.com</a>
</p>
<p><br><br>Round 2: Friday, September 22nd @ 10pm <br>Featuring <a href="https://www.facebook.com/dennis.andrews.144" rel="nofollow" target="_blank">Dennis Andrews</a>, <a href="https://www.facebook.com/actionmatt" rel="nofollow" target="_blank">Matt Moreau</a>, <a href="https://www.facebook.com/ldybugamanda" rel="nofollow" target="_blank">Amanda Steadele</a> <br>with Special Guest Performance!
</p>
<p><br><br>Round 3: Saturday, October 20th @ 10pm <br>Featuring <a href="https://www.facebook.com/grummell" rel="nofollow" target="_blank">Evan Michael</a>, <a href="https://www.facebook.com/scot.rose2" rel="nofollow" target="_blank">Scot Rose</a>, <a href="https://www.facebook.com/andracorinne" rel="nofollow" target="_blank">Andra Rosenberg</a><br>with Special Guest Performance!
</p>
<p><br><br>The winner of each round will then battle it out in our final night:<br>Friday, November 17th @ 10pm. <br>The winner takes home THE GOLDEN MIC!
</p>
<p><br><br>Join <a href="https://www.facebook.com/CORE-Theatre-Ensemble-29981515719/" rel="nofollow" target="_blank">CORE Theatre Ensemble</a> at <a href="https://www.facebook.com/PushComedyTheater/" rel="nofollow" target="_blank">Push Comedy Theater</a> as<br>
</p>
<p><a href="https://www.facebook.com/eddie.castillo.3998" rel="nofollow" target="_blank">Eddie Castillo</a>, <a href="https://www.facebook.com/emele" rel="nofollow" target="_blank">Emel Ertugrul</a>, <a href="https://www.facebook.com/laura.agudelo.946" rel="nofollow" target="_blank">Laura Agudelo</a>, and <a href="https://www.facebook.com/nancy.dickerson.148" rel="nofollow" target="_blank">Nancy Dickerson</a> host the hottest lippers in town!
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-10-20T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-10-20T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/d54fa7f3-96fe-497d-90b4-c20383116110",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/d54fa7f3-96fe-497d-90b4-c20383116110",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "show"
})
Logger.info "=========== Wrote tag ==========="

# Insert lip-sync
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "lip-sync"
})
Logger.info "=========== Wrote tag ==========="

# Insert music
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "music"
})
Logger.info "=========== Wrote tag ==========="

# Insert special
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "special"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Lip Service - Ultimate Lip Sync Competition: Round 3",
    status: "available",
    description: "Ticket for Lip Service - Ultimate Lip Sync Competition: Round 3",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-07T01:02:11.524Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Lip Service - Ultimate Lip Sync Competition: Round 3 ==========="
Logger.info "=========== BEGIN Processing Universe Event The 666 Project: A Horror Anthology Show ==========="

Logger.info "=========== Writing Event The 666 Project: A Horror Anthology Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "K914S7",
    title: "The 666 Project: A Horror Anthology Show",
    description: """
    <p style="text-align: center;">In the grand tradition of The Twilight Zone and Tales from the Crypt comes <strong>The 666 Project</strong>.  The Push Comedy Theater has gathered six writers, six directors and six actors to bring you six rib-tickling, tales of terror.
</p>
<p style="text-align: center;"><strong>The 666 Project</strong>
</p>
<p style="text-align: center;">directed by:
</p>
<p style="text-align: center;">Garney Johnson, The Core Theatre Ensemble, Jill Sweetland, Brant Powell, Christopher Bernhardt, Alba Woolard, and Kerry Kruk.
</p>
<p style="text-align: center;">written by:
</p>
<p style="text-align: center;">Evan Grummell and Evan Hartley, Brant Powell, Lauren Hurston, Brian Garraty, Michael Khandelwal and Brad McMurran
</p>
<p style="text-align: center;">starring:
</p>
<p style="text-align: center;">Scot Rose, Hilary Stallings, Matt Cole, Jordan Romero, Chelsea Pittman and Hayley Daniels
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><strong>The Push Comedy Theater is proud to present The 666 Project: A Horror Anthology Show!</strong>
</p>
<p style="text-align: center;">October 21, 22, 27, 28, 29 and 30 at The Push Comedy Theater
</p>
<p style="text-align: center;">The show starts at 8pm.
</p>
<p style="text-align: center;">Tickets are $15
</p>
<p style="text-align: center;">The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p style="text-align: center;">Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p style="text-align: center;">---
</p>
<p style="text-align: center;">The Pushers are Virginia's premiere sketch and improv comedy group. For over a decade they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
</p>
<p style="text-align: center;">In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.
</p>
<p style="text-align: center;">The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.
</p>
<p style="text-align: center;">Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.
</p>
<p style="text-align: center;">--
</p>
<p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p style="text-align: center;">The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.
</p>
<p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The 666 Project: A Horror Anthology Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "K914S7",
    title: "The 666 Project: A Horror Anthology Show",
    description: """
    <p style="text-align: center;">In the grand tradition of The Twilight Zone and Tales from the Crypt comes <strong>The 666 Project</strong>.  The Push Comedy Theater has gathered six writers, six directors and six actors to bring you six rib-tickling, tales of terror.
</p>
<p style="text-align: center;"><strong>The 666 Project</strong>
</p>
<p style="text-align: center;">directed by:
</p>
<p style="text-align: center;">Garney Johnson, The Core Theatre Ensemble, Jill Sweetland, Brant Powell, Christopher Bernhardt, Alba Woolard, and Kerry Kruk.
</p>
<p style="text-align: center;">written by:
</p>
<p style="text-align: center;">Evan Grummell and Evan Hartley, Brant Powell, Lauren Hurston, Brian Garraty, Michael Khandelwal and Brad McMurran
</p>
<p style="text-align: center;">starring:
</p>
<p style="text-align: center;">Scot Rose, Hilary Stallings, Matt Cole, Jordan Romero, Chelsea Pittman and Hayley Daniels
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><strong>The Push Comedy Theater is proud to present The 666 Project: A Horror Anthology Show!</strong>
</p>
<p style="text-align: center;">October 21, 22, 27, 28, 29 and 30 at The Push Comedy Theater
</p>
<p style="text-align: center;">The show starts at 8pm.
</p>
<p style="text-align: center;">Tickets are $15
</p>
<p style="text-align: center;">The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p style="text-align: center;">Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p style="text-align: center;">---
</p>
<p style="text-align: center;">The Pushers are Virginia's premiere sketch and improv comedy group. For over a decade they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
</p>
<p style="text-align: center;">In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.
</p>
<p style="text-align: center;">The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.
</p>
<p style="text-align: center;">Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.
</p>
<p style="text-align: center;">--
</p>
<p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p style="text-align: center;">The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.
</p>
<p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-10-21T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-10-21T22:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b1674e54-8a74-478b-bf43-b6cb1327390d",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b1674e54-8a74-478b-bf43-b6cb1327390d",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "show"
})
Logger.info "=========== Wrote tag ==========="

# Insert 666
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "666"
})
Logger.info "=========== Wrote tag ==========="

# Insert project
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "project"
})
Logger.info "=========== Wrote tag ==========="

# Insert halloween
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "halloween"
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
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The 666 Project: A Horror Anthology Show",
    status: "available",
    description: "Ticket for The 666 Project: A Horror Anthology Show",
    price: 1500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-09-22T01:47:45.432Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The 666 Project: A Horror Anthology Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More Storytelling ==========="

Logger.info "=========== Writing Event Tell Me More Storytelling ==========="
event = SeedHelpers.create_event(
  %{
    slug: "GSYNJZ",
    title: "Tell Me More Storytelling",
    description: """
    <p>Your family is gathering. Your friends are in town. Certainly, there’s some kindness to go around. Something you can share during our November storytelling night.
</p>
<p><br><br>NOVEMBER STORYTELLING NIGHT THEME<br>Theme: Kindness<br>Song: “Imagine,” John Lennon<br>Possibly inspiring: Stories about generosity for others or ourselves.
</p>
<p><br><br>FEATURED STORYTELLERS<br>Storytellers to be announced soon. If you’re interested in telling a story, tell us about it, (757) 785-5590.
</p>
<p><br><br>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, Nov. 20, 2016<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>
</p>
<p>Admission: $5
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Tell Me More Storytelling ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "GSYNJZ",
    title: "Tell Me More Storytelling",
    description: """
    <p>Your family is gathering. Your friends are in town. Certainly, there’s some kindness to go around. Something you can share during our November storytelling night.
</p>
<p><br><br>NOVEMBER STORYTELLING NIGHT THEME<br>Theme: Kindness<br>Song: “Imagine,” John Lennon<br>Possibly inspiring: Stories about generosity for others or ourselves.
</p>
<p><br><br>FEATURED STORYTELLERS<br>Storytellers to be announced soon. If you’re interested in telling a story, tell us about it, (757) 785-5590.
</p>
<p><br><br>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, Nov. 20, 2016<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>
</p>
<p>Admission: $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-11-20T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-11-20T20:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/f6cd390c-1c54-45a3-b5d6-34755257ce82",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/f6cd390c-1c54-45a3-b5d6-34755257ce82",
  type: "cover"
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

# Insert tell-me-more
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "tell-me-more"
})
Logger.info "=========== Wrote tag ==========="

# Insert storytelling
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "storytelling"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Tell Me More Storytelling",
    status: "available",
    description: "Ticket for Tell Me More Storytelling",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-16T04:39:18.368Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More Storytelling ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More Storytelling ==========="

Logger.info "=========== Writing Event Tell Me More Storytelling ==========="
event = SeedHelpers.create_event(
  %{
    slug: "BRG16J",
    title: "Tell Me More Storytelling",
    description: """
    <p>Five regular people have volunteered to tell personal tales inspired by the theme, "Dread." Come hear their tales 7 p.m. Sunday, Oct. 16 at The Push Comedy Theater, Norfolk.
</p>
<p><br><br>DETAILS<br>Theme: Dread<br>Song: “Don’t Fear the Reaper,” Blue Öyster Cult
</p>
<p><br><br>Possibly inspiring: Stories about being afraid of possible outcomes that happen… or maybe not.
</p>
<p><br><br>FEATURED STORYTELLERS<br>Ashley Hall, Harvest Bellante, Tommy Neeson, Melissa Baumann and Patrick C. Taylor.
</p>
<p><br><br>HOST<br>Brendan Kennedy, is a comedian, storyteller and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”
</p>
<p><br><br>ADMISSION<br>
</p>
<p>$5.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Tell Me More Storytelling ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "BRG16J",
    title: "Tell Me More Storytelling",
    description: """
    <p>Five regular people have volunteered to tell personal tales inspired by the theme, "Dread." Come hear their tales 7 p.m. Sunday, Oct. 16 at The Push Comedy Theater, Norfolk.
</p>
<p><br><br>DETAILS<br>Theme: Dread<br>Song: “Don’t Fear the Reaper,” Blue Öyster Cult
</p>
<p><br><br>Possibly inspiring: Stories about being afraid of possible outcomes that happen… or maybe not.
</p>
<p><br><br>FEATURED STORYTELLERS<br>Ashley Hall, Harvest Bellante, Tommy Neeson, Melissa Baumann and Patrick C. Taylor.
</p>
<p><br><br>HOST<br>Brendan Kennedy, is a comedian, storyteller and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”
</p>
<p><br><br>ADMISSION<br>
</p>
<p>$5.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-11-20T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-11-20T20:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/e58745fa-2b7e-4814-85d4-858f17e339cb",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/e58745fa-2b7e-4814-85d4-858f17e339cb",
  type: "cover"
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

# Insert tell-me-more
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "tell-me-more"
})
Logger.info "=========== Wrote tag ==========="

# Insert storytelling
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "storytelling"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Tell Me More Storytelling",
    status: "available",
    description: "Ticket for Tell Me More Storytelling",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-16T04:40:46.560Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More Storytelling ==========="
Logger.info "=========== BEGIN Processing Universe Event Second Saturday Stand-Up ==========="

Logger.info "=========== Writing Event Second Saturday Stand-Up ==========="
event = SeedHelpers.create_event(
  %{
    slug: "KTPY3V",
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
<p>Tim Young
</p>
<p>Averell Carter
</p>
<p>Rob Reibold
</p>
<p>Donna Lewis
</p>
<p>Von Michael
</p>
<p><strong></strong>
</p>
<p>Kristen Sivills
</p>
<p><strong><br></strong>
</p>
<p><strong>Second Saturday Stand-Up</strong>
</p>
<p>Saturday, September 9th at 10pm
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
    slug: "KTPY3V",
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
<p>Tim Young
</p>
<p>Averell Carter
</p>
<p>Rob Reibold
</p>
<p>Donna Lewis
</p>
<p>Von Michael
</p>
<p><strong></strong>
</p>
<p>Kristen Sivills
</p>
<p><strong><br></strong>
</p>
<p><strong>Second Saturday Stand-Up</strong>
</p>
<p>Saturday, September 9th at 10pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-09-09T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-09T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9bd8303c-a46b-4654-8fc9-c7eb6b68a587",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9bd8303c-a46b-4654-8fc9-c7eb6b68a587",
  type: "cover"
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
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Second Saturday Stand-Up",
    status: "available",
    description: "Ticket for Second Saturday Stand-Up",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-01T01:15:38.939Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Second Saturday Stand-Up ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More Storytelling ==========="

Logger.info "=========== Writing Event Tell Me More Storytelling ==========="
event = SeedHelpers.create_event(
  %{
    slug: "WCY7SZ",
    title: "Tell Me More Storytelling",
    description: """
    <p>Your family is gathering. Your friends are in town. Certainly, there’s some kindness to go around. Something you can share during our November storytelling night.
</p>
<p><br><br>NOVEMBER STORYTELLING NIGHT THEME<br>Theme: Kindness<br>Song: “Imagine,” John Lennon<br>Possibly inspiring: Stories about generosity for others or ourselves.
</p>
<p><br><br>FEATURED STORYTELLERS<br>Storytellers to be announced soon. If you’re interested in telling a story, tell us about it, (757) 785-5590.
</p>
<p><br><br>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, Nov. 20, 2016<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>
</p>
<p>Admission: $5
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Tell Me More Storytelling ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "WCY7SZ",
    title: "Tell Me More Storytelling",
    description: """
    <p>Your family is gathering. Your friends are in town. Certainly, there’s some kindness to go around. Something you can share during our November storytelling night.
</p>
<p><br><br>NOVEMBER STORYTELLING NIGHT THEME<br>Theme: Kindness<br>Song: “Imagine,” John Lennon<br>Possibly inspiring: Stories about generosity for others or ourselves.
</p>
<p><br><br>FEATURED STORYTELLERS<br>Storytellers to be announced soon. If you’re interested in telling a story, tell us about it, (757) 785-5590.
</p>
<p><br><br>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, Nov. 20, 2016<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>
</p>
<p>Admission: $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-12-18T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-12-18T20:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/f6cd390c-1c54-45a3-b5d6-34755257ce82",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/f6cd390c-1c54-45a3-b5d6-34755257ce82",
  type: "cover"
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

# Insert tell-me-more
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "tell-me-more"
})
Logger.info "=========== Wrote tag ==========="

# Insert storytelling
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "storytelling"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Tell Me More Storytelling",
    status: "available",
    description: "Ticket for Tell Me More Storytelling",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-16T04:56:07.390Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More Storytelling ==========="
Logger.info "=========== BEGIN Processing Universe Event Storytelling Night: Cheated ==========="

Logger.info "=========== Writing Event Storytelling Night: Cheated ==========="
event = SeedHelpers.create_event(
  %{
    slug: "X960NZ",
    title: "Storytelling Night: Cheated",
    description: """
    <p><strong>What you thought was true was only a mirage. Join us 7 p.m. July 17 for stories of being cheated.</strong>
</p>
<p>Theme: Liberation
</p>
<p>Possibly inspiring stories of being tricked or fooled or just coming up short.
</p>
<p>Featured Storytellers
</p>
<p>Storytellers to be announced soon. If you’re interested in telling a story, tell us about it, (757) 785-5590.
</p>
<p>Time: 7 p.m.
</p>
<p>Date: Sunday, July 17, 2016
</p>
<p>Location: Push Comedy Theater, 763 Granby Street, Norfolk
</p>
<p>Admission: $5
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Storytelling Night: Cheated ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "X960NZ",
    title: "Storytelling Night: Cheated",
    description: """
    <p><strong>What you thought was true was only a mirage. Join us 7 p.m. July 17 for stories of being cheated.</strong>
</p>
<p>Theme: Liberation
</p>
<p>Possibly inspiring stories of being tricked or fooled or just coming up short.
</p>
<p>Featured Storytellers
</p>
<p>Storytellers to be announced soon. If you’re interested in telling a story, tell us about it, (757) 785-5590.
</p>
<p>Time: 7 p.m.
</p>
<p>Date: Sunday, July 17, 2016
</p>
<p>Location: Push Comedy Theater, 763 Granby Street, Norfolk
</p>
<p>Admission: $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-07-17T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-17T20:45:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/0f2eda2d-f380-489d-a10a-a95276582cc3",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/0f2eda2d-f380-489d-a10a-a95276582cc3",
  type: "cover"
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

# Insert tell-me-more
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "tell-me-more"
})
Logger.info "=========== Wrote tag ==========="

# Insert storytelling
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "storytelling"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Storytelling Night: Cheated",
    status: "available",
    description: "Ticket for Storytelling Night: Cheated",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-04T04:38:08.944Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Storytelling Night: Cheated ==========="
Logger.info "=========== BEGIN Processing Universe Event Teacher's Pet ==========="

Logger.info "=========== Writing Event Teacher's Pet ==========="
event = SeedHelpers.create_event(
  %{
    slug: "LJS7QM",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Saturday, September 30th, 10pm<br>Tickets are $5
</p>
<p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
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
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.
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
Logger.info "=========== Writing Event Listing Teacher's Pet ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "LJS7QM",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Saturday, September 30th, 10pm<br>Tickets are $5
</p>
<p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
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
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-30T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-30T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bc96f7b9-01c2-4ac8-9566-5bfdfa7f658d",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bc96f7b9-01c2-4ac8-9566-5bfdfa7f658d",
  type: "cover"
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

# Insert graduation-show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "graduation-show"
})
Logger.info "=========== Wrote tag ==========="

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "sketch"
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
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Teacher's Pet",
    status: "available",
    description: "Ticket for Teacher's Pet",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-09-19T23:12:21.110Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Teacher's Pet ==========="
Logger.info "=========== BEGIN Processing Universe Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="

Logger.info "=========== Writing Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "GT2C83",
    title: "TOO FAR: The Dirty, Inappropriate Comedy Show",
    description: """
    <p><strong></strong><strong>Are you ready to get dirty!?!</strong>
</p>
<p>Brad and Sean of the Pushers have assembled a twisted team of writers and actors to bring you the dirtiest, most offensive show Hampton Roads has ever seen.
</p>
<p>It's a show we're calling Too Far.
</p>
<p>WARNING: This show isn't for everyone. If you're not a fan of foul, sophomoric, potty humor... then this is not the show for you.
</p>
<p>Join The Pushers and the Too Far crew... and let's get dirty!!!
</p>
<p><strong>TOO FAR: The Dirtiest, Most Inappropriate Comedy Show... EVER!</strong><br>Saturday, June 17th <br>Tickets are $10, Show starts at 10:00pm
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
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
Logger.info "=========== Writing Event Listing TOO FAR: The Dirty, Inappropriate Comedy Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "GT2C83",
    title: "TOO FAR: The Dirty, Inappropriate Comedy Show",
    description: """
    <p><strong></strong><strong>Are you ready to get dirty!?!</strong>
</p>
<p>Brad and Sean of the Pushers have assembled a twisted team of writers and actors to bring you the dirtiest, most offensive show Hampton Roads has ever seen.
</p>
<p>It's a show we're calling Too Far.
</p>
<p>WARNING: This show isn't for everyone. If you're not a fan of foul, sophomoric, potty humor... then this is not the show for you.
</p>
<p>Join The Pushers and the Too Far crew... and let's get dirty!!!
</p>
<p><strong>TOO FAR: The Dirtiest, Most Inappropriate Comedy Show... EVER!</strong><br>Saturday, June 17th <br>Tickets are $10, Show starts at 10:00pm
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
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
    start_at:  NaiveDateTime.from_iso8601!("2017-06-17T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-06-17T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b7859a45-0317-4f90-8f27-146deca5bd64",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b7859a45-0317-4f90-8f27-146deca5bd64",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "show"
})
Logger.info "=========== Wrote tag ==========="

# Insert too-far
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "too-far"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for TOO FAR: The Dirty, Inappropriate Comedy Show",
    status: "available",
    description: "Ticket for TOO FAR: The Dirty, Inappropriate Comedy Show",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-06-08T20:29:52.875Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Teacher's Pet ==========="

Logger.info "=========== Writing Event Teacher's Pet ==========="
event = SeedHelpers.create_event(
  %{
    slug: "C9M01X",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Friday, June 9th, 10pm<br>Tickets are $5
</p>
<p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
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
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.
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
Logger.info "=========== Writing Event Listing Teacher's Pet ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "C9M01X",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Friday, June 9th, 10pm<br>Tickets are $5
</p>
<p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
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
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-06-09T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-06-09T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bc96f7b9-01c2-4ac8-9566-5bfdfa7f658d",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bc96f7b9-01c2-4ac8-9566-5bfdfa7f658d",
  type: "cover"
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

# Insert graduation-show
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "graduation-show"
})
Logger.info "=========== Wrote tag ==========="

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "sketch"
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
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Teacher's Pet",
    status: "available",
    description: "Ticket for Teacher's Pet",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-06-06T05:43:07.470Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Teacher's Pet ==========="
Logger.info "=========== BEGIN Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="

Logger.info "=========== Writing Event Who Dunnit? ...The Improvised Murder Mystery ==========="
event = SeedHelpers.create_event(
  %{
    slug: "1Y9DBT",
    title: "Who Dunnit? ...The Improvised Murder Mystery",
    description: """
    <p><strong></strong><strong>Get ready for a spine tingling murder mystery!!!</strong></p><p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.</p><p>...And it will all be made up on the spot!!!</p><p>Don't miss this exciting mystery, all based off the audience's suggestion.</p><p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, November 7th at the Push Comedy Theater<br>The show starts at 8, tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Who Dunnit? ...The Improvised Murder Mystery ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "1Y9DBT",
    title: "Who Dunnit? ...The Improvised Murder Mystery",
    description: """
    <p><strong></strong><strong>Get ready for a spine tingling murder mystery!!!</strong></p><p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.</p><p>...And it will all be made up on the spot!!!</p><p>Don't miss this exciting mystery, all based off the audience's suggestion.</p><p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, November 7th at the Push Comedy Theater<br>The show starts at 8, tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-11-07T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-11-07T22:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/52ad7ea0-a0ae-477f-a2f4-3054b107ac0a",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/52ad7ea0-a0ae-477f-a2f4-3054b107ac0a",
  type: "cover"
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
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Who Dunnit? ...The Improvised Murder Mystery",
    status: "available",
    description: "Ticket for Who Dunnit? ...The Improvised Murder Mystery",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2015-10-30T03:45:11.536Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="
Logger.info "=========== BEGIN Processing Universe Event The Pre Madonnas Present: Escape Goats (A Sketch Comedy Show) ==========="

Logger.info "=========== Writing Event The Pre Madonnas Present: Escape Goats (A Sketch Comedy Show) ==========="
event = SeedHelpers.create_event(
  %{
    slug: "C1KDFT",
    title: "The Pre Madonnas Present: Escape Goats (A Sketch Comedy Show)",
    description: """
    <p><strong>Get ready for a fun-filled night of sketch comedy!</strong><br>The Pre Madonnas are back at the Push Comedy Theater with more fun than ever. Whether you like your comedy dirty or silly, slapstick or satirical, The Pre Madonnas will have something for everyone in their new sketch comedy show "Escape Goats."
</p>
<p><br>Opening Act: <a href="https://www.facebook.com/The-Gay-Agenda-718281304989317/" rel="nofollow" target="_blank">The Gay Agenda</a>
</p>
<p><br><strong>The Pre Madonnas:</strong><br>Nate Fender (the old man)<br>Evan Grummell (the brain)<br>Evan Hartley (the hair)<br>Bobby Mercer (the gun show)<br>Amber Nettles (the sass)<br>Brittany Shearer (the cat lady)<br>Barrett Sigmon (the bro)
</p>
<p><br><br>Contact: thepremadonnas@gmail.com<br>Twitter: @ Pre_Madonnas<br>Instagram: @ thepremadonnas
</p>
<p><br>Tickets are $10 and can be bought ahead of time or at the door. We highly recommend buying tickets in advance, and arriving at the theater early to get a great seat!.
</p>
<p><br>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">Pushcomedytheater.com</a>
</p>
<p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Pre Madonnas Present: Escape Goats (A Sketch Comedy Show) ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "C1KDFT",
    title: "The Pre Madonnas Present: Escape Goats (A Sketch Comedy Show)",
    description: """
    <p><strong>Get ready for a fun-filled night of sketch comedy!</strong><br>The Pre Madonnas are back at the Push Comedy Theater with more fun than ever. Whether you like your comedy dirty or silly, slapstick or satirical, The Pre Madonnas will have something for everyone in their new sketch comedy show "Escape Goats."
</p>
<p><br>Opening Act: <a href="https://www.facebook.com/The-Gay-Agenda-718281304989317/" rel="nofollow" target="_blank">The Gay Agenda</a>
</p>
<p><br><strong>The Pre Madonnas:</strong><br>Nate Fender (the old man)<br>Evan Grummell (the brain)<br>Evan Hartley (the hair)<br>Bobby Mercer (the gun show)<br>Amber Nettles (the sass)<br>Brittany Shearer (the cat lady)<br>Barrett Sigmon (the bro)
</p>
<p><br><br>Contact: thepremadonnas@gmail.com<br>Twitter: @ Pre_Madonnas<br>Instagram: @ thepremadonnas
</p>
<p><br>Tickets are $10 and can be bought ahead of time or at the door. We highly recommend buying tickets in advance, and arriving at the theater early to get a great seat!.
</p>
<p><br>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">Pushcomedytheater.com</a>
</p>
<p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-03-04T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-04T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/dd3bab19-1e2e-4e9d-8b1e-d5bfbd4c3f6b",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/dd3bab19-1e2e-4e9d-8b1e-d5bfbd4c3f6b",
  type: "cover"
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
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Pre Madonnas Present: Escape Goats (A Sketch Comedy Show)",
    status: "available",
    description: "Ticket for The Pre Madonnas Present: Escape Goats (A Sketch Comedy Show)",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-02-23T00:07:52.844Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Pre Madonnas Present: Escape Goats (A Sketch Comedy Show) ==========="
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="

Logger.info "=========== Writing Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
event = SeedHelpers.create_event(
  %{
    slug: "MF7YLK",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, October 28th
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
    slug: "MF7YLK",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, October 28th
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
    start_at:  NaiveDateTime.from_iso8601!("2017-10-28T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-10-28T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/6a654ad0-cfee-43a6-9c35-dc86dfd97340",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/6a654ad0-cfee-43a6-9c35-dc86dfd97340",
  type: "cover"
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

# Insert improvageddon
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "improvageddon"
})
Logger.info "=========== Wrote tag ==========="

# Insert contest
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "contest"
})
Logger.info "=========== Wrote tag ==========="

# Insert final
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "final"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION",
    status: "available",
    description: "Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-17T15:04:10.201Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
Logger.info "=========== BEGIN Processing Universe Event Family Hour! All-Ages Bright Side Comedy Show ==========="

Logger.info "=========== Writing Event Family Hour! All-Ages Bright Side Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "8PX59K",
    title: "Family Hour! All-Ages Bright Side Comedy Show",
    description: """
    <p>Family Hour! with The Bright Side is an all-ages show featuring high energy, hilarious sketch comedy suitable for the whole family (ages 8 and up)!!! Only $5!!!
</p>
<p><a href="https://www.facebook.com/thebrightsidecomedy/" rel="nofollow" target="_blank">The Bright Side Sketch &amp; Improv Comedy</a> is a comedy group formed in 2015 out of the Push Comedy Theater in Norfolk, VA. Their particular brand of comedy is a celebration of the absurdity of the mundane world. Audiences at a Bright Side show can expect to see smart, polished comedy that reflects the group’s optimistic perspectives. Look on The Bright Side!
</p>
<p>Come out to see and support one of Hampton Road's very own sketch comedy groups at the intimate Push Comedy Theater in the heart of the new Norfolk Arts District!
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
Logger.info "=========== Writing Event Listing Family Hour! All-Ages Bright Side Comedy Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "8PX59K",
    title: "Family Hour! All-Ages Bright Side Comedy Show",
    description: """
    <p>Family Hour! with The Bright Side is an all-ages show featuring high energy, hilarious sketch comedy suitable for the whole family (ages 8 and up)!!! Only $5!!!
</p>
<p><a href="https://www.facebook.com/thebrightsidecomedy/" rel="nofollow" target="_blank">The Bright Side Sketch &amp; Improv Comedy</a> is a comedy group formed in 2015 out of the Push Comedy Theater in Norfolk, VA. Their particular brand of comedy is a celebration of the absurdity of the mundane world. Audiences at a Bright Side show can expect to see smart, polished comedy that reflects the group’s optimistic perspectives. Look on The Bright Side!
</p>
<p>Come out to see and support one of Hampton Road's very own sketch comedy groups at the intimate Push Comedy Theater in the heart of the new Norfolk Arts District!
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-11-26T12:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-26T13:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/a6b284aa-61ff-46eb-b8d9-275995d92d44",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/a6b284aa-61ff-46eb-b8d9-275995d92d44",
  type: "cover"
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

# Insert bright-side
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "bright-side"
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
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Family Hour! All-Ages Bright Side Comedy Show",
    status: "available",
    description: "Ticket for Family Hour! All-Ages Bright Side Comedy Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-14T19:48:28.351Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Family Hour! All-Ages Bright Side Comedy Show ==========="
