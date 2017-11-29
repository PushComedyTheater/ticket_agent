require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="

Logger.info "=========== Writing Event The Improv Riot: The Short Form Improv Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "Q0P4VB",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.
</p>
<p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.
</p>
<p><strong style="background-color: initial;">The Improv Riot: The Short Form Improv Show</strong>
</p>
<p>Friday, July 29th, 8pm
</p>
<p>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the parking lot directly across from the theater.
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
    slug: "Q0P4VB",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.
</p>
<p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.
</p>
<p><strong style="background-color: initial;">The Improv Riot: The Short Form Improv Show</strong>
</p>
<p>Friday, July 29th, 8pm
</p>
<p>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the parking lot directly across from the theater.
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
<p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-07-29T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-29T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-05T03:50:29.915Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Anti Social Network's Free For All ==========="

Logger.info "=========== Writing Event The Anti Social Network's Free For All ==========="
event = SeedHelpers.create_event(
  %{
    slug: "KYCJ4B",
    title: "The Anti Social Network's Free For All",
    description: """
    <p>They wowed audiences at Improvageddon and during the 3 on 3 Competition... now join The Anti-Social Network and friends for<strong> The Anti Social Network's Free For All!!</strong>
</p>
<p>The Anti-Social Network and some of the Push Comedy Theater's funniest improvisers for a night of free improv.
</p>
<p><strong>The Anti-Social Network: </strong>Accused by their peers of being anti-social, the Anti-Social Network is a 9-member, high-energy improv and sketch comedy group that embraces social awkwardness and being an outcast. Armed with hangover angst of their teenage years, their comedy frequently includes inspiration from technology, pop culture, social struggles, and the absurd.
</p>
<p><strong>Free Show: Anti-Social Network Free For All</strong>
</p>
<p>Friday, June 17th at 10pm
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Anti Social Network's Free For All ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "KYCJ4B",
    title: "The Anti Social Network's Free For All",
    description: """
    <p>They wowed audiences at Improvageddon and during the 3 on 3 Competition... now join The Anti-Social Network and friends for<strong> The Anti Social Network's Free For All!!</strong>
</p>
<p>The Anti-Social Network and some of the Push Comedy Theater's funniest improvisers for a night of free improv.
</p>
<p><strong>The Anti-Social Network: </strong>Accused by their peers of being anti-social, the Anti-Social Network is a 9-member, high-energy improv and sketch comedy group that embraces social awkwardness and being an outcast. Armed with hangover angst of their teenage years, their comedy frequently includes inspiration from technology, pop culture, social struggles, and the absurd.
</p>
<p><strong>Free Show: Anti-Social Network Free For All</strong>
</p>
<p>Friday, June 17th at 10pm
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-17T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-17T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/f7317da4-6322-49d4-bb26-14d3085b8071",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/f7317da4-6322-49d4-bb26-14d3085b8071",
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

# Insert free
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "free"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Anti Social Network's Free For All",
    status: "available",
    description: "Ticket for The Anti Social Network's Free For All",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2016-06-16T04:55:36.576Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Anti Social Network's Free For All ==========="
Logger.info "=========== BEGIN Processing Universe Event Teacher's Pet ==========="

Logger.info "=========== Writing Event Teacher's Pet ==========="
event = SeedHelpers.create_event(
  %{
    slug: "HM2YRF",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Saturday, December 10th, 10pm<br>Tickets are $5
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
    slug: "HM2YRF",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Saturday, December 10th, 10pm<br>Tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2016-12-10T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-12-10T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-12-02T16:47:31.805Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Teacher's Pet ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improvised Movie - 2 Day Workshop​ ==========="

Logger.info "=========== Writing Event The Improvised Movie - 2 Day Workshop​ ==========="
event = SeedHelpers.create_event(
  %{
    slug: "LFXJS7",
    title: "The Improvised Movie - 2 Day Workshop​",
    description: """
    <p><strong></strong><strong>Lights! Camera! Improv!</strong>
</p>
<p>Learn how to perform the Improvised Movie, and be the envy of all your friends.
</p>
<p>This is a 2 day workshop, followed by a graduation show.  You'll learn the improv form, The Movie.  Upon completion of the class, students will be eligible to audition for the Double Feature movie team.
</p>
<p>The class is open to those who've completed 301 and above.
</p>
<p>Tuition is $60
</p>
<p><br>
</p>
<p><strong>The Improvised Movie - 2 Day Workshop</strong><strong></strong>
</p>
<p>Thursday, May 25th at 6:30pm
</p>
<p>Sunday, May 28th at 3pm
</p>
<p>Graduation Show: Sunday, May 28th at 8pm
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Improvised Movie - 2 Day Workshop​ ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "LFXJS7",
    title: "The Improvised Movie - 2 Day Workshop​",
    description: """
    <p><strong></strong><strong>Lights! Camera! Improv!</strong>
</p>
<p>Learn how to perform the Improvised Movie, and be the envy of all your friends.
</p>
<p>This is a 2 day workshop, followed by a graduation show.  You'll learn the improv form, The Movie.  Upon completion of the class, students will be eligible to audition for the Double Feature movie team.
</p>
<p>The class is open to those who've completed 301 and above.
</p>
<p>Tuition is $60
</p>
<p><br>
</p>
<p><strong>The Improvised Movie - 2 Day Workshop</strong><strong></strong>
</p>
<p>Thursday, May 25th at 6:30pm
</p>
<p>Sunday, May 28th at 3pm
</p>
<p>Graduation Show: Sunday, May 28th at 8pm
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-05-25T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-28T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/7692d8b2-3793-4f3e-9933-ee933ecd6583",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/7692d8b2-3793-4f3e-9933-ee933ecd6583",
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

# Insert movie
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "movie"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Improvised Movie - 2 Day Workshop​",
    status: "available",
    description: "Ticket for The Improvised Movie - 2 Day Workshop​",
    price: 6000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-01T17:11:16.249Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improvised Movie - 2 Day Workshop​ ==========="
Logger.info "=========== BEGIN Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="

Logger.info "=========== Writing Event Who Dunnit? ...The Improvised Murder Mystery ==========="
event = SeedHelpers.create_event(
  %{
    slug: "7FLXBM",
    title: "Who Dunnit? ...The Improvised Murder Mystery",
    description: """
    <p><strong></strong><strong>Get ready for a spine tingling murder mystery!!!</strong></p><p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.</p><p>...And it will all be made up on the spot!!!</p><p>Don't miss this exciting mystery, all based off the audience's suggestion.</p><p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, March 12th at the Push Comedy Theater<br>The show starts at 8, tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "7FLXBM",
    title: "Who Dunnit? ...The Improvised Murder Mystery",
    description: """
    <p><strong></strong><strong>Get ready for a spine tingling murder mystery!!!</strong></p><p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.</p><p>...And it will all be made up on the spot!!!</p><p>Don't miss this exciting mystery, all based off the audience's suggestion.</p><p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, March 12th at the Push Comedy Theater<br>The show starts at 8, tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-03-12T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-03-12T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/7d572d4b-55ee-4ddc-a041-0e9f94cd8ba6",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/7d572d4b-55ee-4ddc-a041-0e9f94cd8ba6",
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-02-25T04:58:00.833Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="
Logger.info "=========== BEGIN Processing Universe Event The Musical Improv Studio Midterm Show ==========="

Logger.info "=========== Writing Event The Musical Improv Studio Midterm Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "F0VHGJ",
    title: "The Musical Improv Studio Midterm Show",
    description: """
    <p>Check out the Musical Improv Studio Class as they create 2 full length musicals right before your very eyes!
</p>
<p>These are the upper classmen of Musical Improv, and they are ready to show off their melodic and masterful skills!
</p>
<p>Come out and see what happens when Music and Improv collide!!!
</p>
<p>The Musical Improv Studio Midterm Show
</p>
<p>Thursday, November 9th at 7pm
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
Logger.info "=========== Writing Event Listing The Musical Improv Studio Midterm Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "F0VHGJ",
    title: "The Musical Improv Studio Midterm Show",
    description: """
    <p>Check out the Musical Improv Studio Class as they create 2 full length musicals right before your very eyes!
</p>
<p>These are the upper classmen of Musical Improv, and they are ready to show off their melodic and masterful skills!
</p>
<p>Come out and see what happens when Music and Improv collide!!!
</p>
<p>The Musical Improv Studio Midterm Show
</p>
<p>Thursday, November 9th at 7pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-11-09T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-09T20:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b04b05c0-95bd-401c-b55a-87812d9ab7cd",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b04b05c0-95bd-401c-b55a-87812d9ab7cd",
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

# Insert musical
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "musical"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Musical Improv Studio Midterm Show",
    status: "available",
    description: "Ticket for The Musical Improv Studio Midterm Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-05T15:35:53.726Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Musical Improv Studio Midterm Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="

Logger.info "=========== Writing Event Who Dunnit? ...The Improvised Murder Mystery ==========="
event = SeedHelpers.create_event(
  %{
    slug: "Y6190D",
    title: "Who Dunnit? ...The Improvised Murder Mystery",
    description: """
    <p><strong>Murder at Harborfest!!!</strong><br>There's a killer lurking at Town Point Park. Will he be caught before he strikes again?!?</p><p>Don't miss the hilarious hijinks in Murder at Harborfest: An Improvised Murder Mystery.</p><p>(The Murder Mystery has sold out 8 months in a row. Get your tickets now!)<br><strong>_____________________</strong></p><p><strong style="background-color: initial;">Get ready for a spine tingling murder mystery!!!</strong></p><p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.</p><p>...And it will all be made up on the spot!!!</p><p>Don't miss this exciting mystery, all based off the audience's suggestion.</p><p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, June 11th at the Push Comedy Theater<br>The show starts at 8, tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "Y6190D",
    title: "Who Dunnit? ...The Improvised Murder Mystery",
    description: """
    <p><strong>Murder at Harborfest!!!</strong><br>There's a killer lurking at Town Point Park. Will he be caught before he strikes again?!?</p><p>Don't miss the hilarious hijinks in Murder at Harborfest: An Improvised Murder Mystery.</p><p>(The Murder Mystery has sold out 8 months in a row. Get your tickets now!)<br><strong>_____________________</strong></p><p><strong style="background-color: initial;">Get ready for a spine tingling murder mystery!!!</strong></p><p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.</p><p>...And it will all be made up on the spot!!!</p><p>Don't miss this exciting mystery, all based off the audience's suggestion.</p><p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, June 11th at the Push Comedy Theater<br>The show starts at 8, tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-11T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-11T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/7d572d4b-55ee-4ddc-a041-0e9f94cd8ba6",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/7d572d4b-55ee-4ddc-a041-0e9f94cd8ba6",
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

# Insert murder
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "murder"
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-20T21:02:58.299Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="
Logger.info "=========== BEGIN Processing Universe Event New Harold Night ==========="

Logger.info "=========== Writing Event New Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "VNSC3F",
    title: "New Harold Night",
    description: """
    <p><strong>It's New Harold Night at the Push Comedy Theater!</strong></p><p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p>This month don't miss house teams <strong>*69</strong> and <strong>Third Choice</strong></p><p><strong>New Harold Night</strong> </p><p>Friday, April 22nd at 10:00pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing New Harold Night ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "VNSC3F",
    title: "New Harold Night",
    description: """
    <p><strong>It's New Harold Night at the Push Comedy Theater!</strong></p><p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p>This month don't miss house teams <strong>*69</strong> and <strong>Third Choice</strong></p><p><strong>New Harold Night</strong> </p><p>Friday, April 22nd at 10:00pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-22T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-22T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/6b3f3352-7942-44cf-b985-f0769f7b558d",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/6b3f3352-7942-44cf-b985-f0769f7b558d",
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

# Insert harold
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "harold"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for New Harold Night",
    status: "available",
    description: "Ticket for New Harold Night",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-29T02:48:31.373Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event New Harold Night ==========="
Logger.info "=========== BEGIN Processing Universe Event The Pullers! Pre-teen Murder Mystery Graduation Show ==========="

Logger.info "=========== Writing Event The Pullers! Pre-teen Murder Mystery Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "QNX08W",
    title: "The Pullers! Pre-teen Murder Mystery Graduation Show",
    description: """
    <p>You've heard of Generation X and iGen. Now get ready for the funniest, silliest, cutest generation of them all as The Pushers bring to you... The Pre-Teen Improvised Murder Mystery Superstars!!!
</p>
<p>Don't miss this group of talented tween-boppers as they put on a funny and fast paced Murder Mystery Show!
</p>
<p><br>The group is coached by local comedy couple, Jim and Mary Veverka, and local comedy giants, The Pushers.
</p>
<p><br><strong>The Pushers present The Pullers! Pre-teen Murder Mystery Graduation Show</strong>
</p>
<p><br><br>Friday, July 28th.<br>The show starts at 4pm.<br><strong>This is a free show!!!!</strong><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p><br><br>--
</p>
<p><br><br>Push Comedy Theater<br>763 Granby Street<br>Norfolk, VA
</p>
<p><br><br>757-333-7442<br>
</p>
<p><a href="https://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=ATMnzh9ilNfrPsg7deQhydCZ042_0efYB8Hq_Kli4d_dMvTbpmjVRlfvDo4_MN6lGp2UJsbTJKP23x9koCI_8CaytKEC2minx-sc29OgVTDPwowyvoAQZFwQZc_XDTBpYvbfQC4e5A&amp;enc=AZPpl2wM_Qvlj6iaQ0-As21nUXiDwrb6w1OReuUzGFY7RhIhuJzGY7QoSThMZ0Taw5s&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Pullers! Pre-teen Murder Mystery Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "QNX08W",
    title: "The Pullers! Pre-teen Murder Mystery Graduation Show",
    description: """
    <p>You've heard of Generation X and iGen. Now get ready for the funniest, silliest, cutest generation of them all as The Pushers bring to you... The Pre-Teen Improvised Murder Mystery Superstars!!!
</p>
<p>Don't miss this group of talented tween-boppers as they put on a funny and fast paced Murder Mystery Show!
</p>
<p><br>The group is coached by local comedy couple, Jim and Mary Veverka, and local comedy giants, The Pushers.
</p>
<p><br><strong>The Pushers present The Pullers! Pre-teen Murder Mystery Graduation Show</strong>
</p>
<p><br><br>Friday, July 28th.<br>The show starts at 4pm.<br><strong>This is a free show!!!!</strong><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p><br><br>--
</p>
<p><br><br>Push Comedy Theater<br>763 Granby Street<br>Norfolk, VA
</p>
<p><br><br>757-333-7442<br>
</p>
<p><a href="https://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=ATMnzh9ilNfrPsg7deQhydCZ042_0efYB8Hq_Kli4d_dMvTbpmjVRlfvDo4_MN6lGp2UJsbTJKP23x9koCI_8CaytKEC2minx-sc29OgVTDPwowyvoAQZFwQZc_XDTBpYvbfQC4e5A&amp;enc=AZPpl2wM_Qvlj6iaQ0-As21nUXiDwrb6w1OReuUzGFY7RhIhuJzGY7QoSThMZ0Taw5s&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-07-28T16:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-28T17:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bc026387-0fc7-4a5b-85ca-df84c16c9689",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bc026387-0fc7-4a5b-85ca-df84c16c9689",
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

# Insert free
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "free"
})
Logger.info "=========== Wrote tag ==========="

# Insert pullers
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "pullers"
})
Logger.info "=========== Wrote tag ==========="

# Insert pre-teen
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "pre-teen"
})
Logger.info "=========== Wrote tag ==========="

# Insert kids
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "kids"
})
Logger.info "=========== Wrote tag ==========="

# Insert murder
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "murder"
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
    name: "Ticket for The Pullers! Pre-teen Murder Mystery Graduation Show",
    status: "available",
    description: "Ticket for The Pullers! Pre-teen Murder Mystery Graduation Show",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-25T16:24:58.701Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Pullers! Pre-teen Murder Mystery Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Pre Madonnas Present: Civil Ware ==========="

Logger.info "=========== Writing Event The Pre Madonnas Present: Civil Ware ==========="
event = SeedHelpers.create_event(
  %{
    slug: "Z61TL8",
    title: "The Pre Madonnas Present: Civil Ware",
    description: """
    <p>Get ready for a fun-filled night of sketch comedy!
</p>
<p>The Pre Madonnas are back at the Push Comedy Theater with more fun than ever. Whether you like your comedy dirty or silly, slapstick or satirical, The Pre Madonnas will have something for everyone in their new sketch comedy show "Civil Ware!"
</p>
<p>Contact: thepremadonnas@gmail.com
</p>
<p>Twitter: @ Pre_Madonnas
</p>
<p>Instagram: @ thepremadonnas
</p>
<p>Tickets are $10 and can be bought ahead of time or at the door. We highly recommend buying tickets in advance, and arriving at the theater early to get a great seat!
</p>
<p>Push Comedy Theater
</p>
<p>763 Granby Street
</p>
<p>Norfolk, VA
</p>
<p>757-333-7442
</p>
<p>Pushcomedytheater.com
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
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
Logger.info "=========== Writing Event Listing The Pre Madonnas Present: Civil Ware ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "Z61TL8",
    title: "The Pre Madonnas Present: Civil Ware",
    description: """
    <p>Get ready for a fun-filled night of sketch comedy!
</p>
<p>The Pre Madonnas are back at the Push Comedy Theater with more fun than ever. Whether you like your comedy dirty or silly, slapstick or satirical, The Pre Madonnas will have something for everyone in their new sketch comedy show "Civil Ware!"
</p>
<p>Contact: thepremadonnas@gmail.com
</p>
<p>Twitter: @ Pre_Madonnas
</p>
<p>Instagram: @ thepremadonnas
</p>
<p>Tickets are $10 and can be bought ahead of time or at the door. We highly recommend buying tickets in advance, and arriving at the theater early to get a great seat!
</p>
<p>Push Comedy Theater
</p>
<p>763 Granby Street
</p>
<p>Norfolk, VA
</p>
<p>757-333-7442
</p>
<p>Pushcomedytheater.com
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-08-05T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-08-05T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/0ea09f6f-0022-4ba0-97ab-a1b2074c2be6",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/0ea09f6f-0022-4ba0-97ab-a1b2074c2be6",
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
    name: "Ticket for The Pre Madonnas Present: Civil Ware",
    status: "available",
    description: "Ticket for The Pre Madonnas Present: Civil Ware",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-08T01:19:12.504Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Pre Madonnas Present: Civil Ware ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Musical Improv 101 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Musical Improv 101 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "3ZFND0",
    title: "Class Dismissed: The Musical Improv 101 Graduation Show",
    description: """
    <p>Come cheer on Push Comedy Theater’s Musical Improv Class as they take the stage for their graduation show!
</p>
<p>This talented band of improvisers has been working incredibly hard for 6 weeks - singing, rapping, and even dancing - so let’s support them as they show us their brand new skills.
</p>
<p>Get ready as singing and improv collide!!!
</p>
<p><strong>Class Dismissed: The Musical Improv 101 Graduation Show</strong>
</p>
<p>Thursday, November 16th at 7pm
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
Logger.info "=========== Writing Event Listing Class Dismissed: The Musical Improv 101 Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "3ZFND0",
    title: "Class Dismissed: The Musical Improv 101 Graduation Show",
    description: """
    <p>Come cheer on Push Comedy Theater’s Musical Improv Class as they take the stage for their graduation show!
</p>
<p>This talented band of improvisers has been working incredibly hard for 6 weeks - singing, rapping, and even dancing - so let’s support them as they show us their brand new skills.
</p>
<p>Get ready as singing and improv collide!!!
</p>
<p><strong>Class Dismissed: The Musical Improv 101 Graduation Show</strong>
</p>
<p>Thursday, November 16th at 7pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-11-16T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-16T20:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/376331a7-12e6-4099-aa80-cee9908af7dd",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/376331a7-12e6-4099-aa80-cee9908af7dd",
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
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Class Dismissed: The Musical Improv 101 Graduation Show",
    status: "available",
    description: "Ticket for Class Dismissed: The Musical Improv 101 Graduation Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-09T01:41:48.016Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Musical Improv 101 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Pre Madonnas and The Bright Side ==========="

Logger.info "=========== Writing Event The Pre Madonnas and The Bright Side ==========="
event = SeedHelpers.create_event(
  %{
    slug: "DMF8N1",
    title: "The Pre Madonnas and The Bright Side",
    description: """
    <p>Ready for a FREE hilarious night of sketch comedy? Join The Pre Madonnas and The Bright Side for an outrageous, laugh-out-loud funny sketch comedy showcase bringing together members from both sketch comedy groups!
</p>
<p><br><br>Whether you like your comedy dirty or silly, slapstick or satire, this show will have something for you!
</p>
<p><br><br>The groups that previously brought you breakdancing anarchist squirrels, the crazy antics of Jaspurr the cat, karaoke mishaps, and a one-man Muppet Theater, are joining forces to create a show that should not be missed!
</p>
<p><br><br>Come out to see and support two of Hampton Road's own sketch comedy groups at the intimate Push Comedy Theater in the heart of Norfolk's new Neon Arts District.
</p>
<p><br><br>Tickets are FREE and can be reserved ahead of time or at the door. We highly recommend reserving tickets in advance, and arriving at the theater early to get a great seat!
</p>
<p><br><br>The Bright Side:<br>In early 2015, Andrea Bourguignon, Matt Cole, Brian Garraty, and Drew Richard decided to join forces and The Bright Side was born! The group describes their particular brand of comedy as a celebration of the absurd world in which we all exist. Audiences at a Bright Side show can expect to see polished and smart comedy that reflects the group members’ personal life experiences.
</p>
<p><br><br>The Pre Madonnas:<br>Way, way back, in a time before the flood, a group of students now known as The Pre Madonnas met through improv and sketch comedy classes at the Push Comedy Theater. It didn't take long before they realized their undeniable comedic (and sexual) chemistry and set out to form a comedy supergroup. In August 2015, the group formed over cheap, delicious tacos and a shared sense of narcissism.
</p>
<p><br><br>Nate Fender (the old man)<br>Evan Grummell (the brain)<br>Evan Hartley (the hair)<br>Bobby Mercer (the gun show)<br>Amber Nettles (the sass)<br>Brittany Shearer (the cat lady)<br>Barrett Sigmon (the bro)
</p>
<p><br><br>The Pre Madonnas and The Bright Side Present: Make Sketch Great Again<br>Friday, August 19, 10 PM<br>FREE SHOW
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p><br><br>--
</p>
<p><br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy.
</p>
<p><br><br>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Pre Madonnas and The Bright Side ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "DMF8N1",
    title: "The Pre Madonnas and The Bright Side",
    description: """
    <p>Ready for a FREE hilarious night of sketch comedy? Join The Pre Madonnas and The Bright Side for an outrageous, laugh-out-loud funny sketch comedy showcase bringing together members from both sketch comedy groups!
</p>
<p><br><br>Whether you like your comedy dirty or silly, slapstick or satire, this show will have something for you!
</p>
<p><br><br>The groups that previously brought you breakdancing anarchist squirrels, the crazy antics of Jaspurr the cat, karaoke mishaps, and a one-man Muppet Theater, are joining forces to create a show that should not be missed!
</p>
<p><br><br>Come out to see and support two of Hampton Road's own sketch comedy groups at the intimate Push Comedy Theater in the heart of Norfolk's new Neon Arts District.
</p>
<p><br><br>Tickets are FREE and can be reserved ahead of time or at the door. We highly recommend reserving tickets in advance, and arriving at the theater early to get a great seat!
</p>
<p><br><br>The Bright Side:<br>In early 2015, Andrea Bourguignon, Matt Cole, Brian Garraty, and Drew Richard decided to join forces and The Bright Side was born! The group describes their particular brand of comedy as a celebration of the absurd world in which we all exist. Audiences at a Bright Side show can expect to see polished and smart comedy that reflects the group members’ personal life experiences.
</p>
<p><br><br>The Pre Madonnas:<br>Way, way back, in a time before the flood, a group of students now known as The Pre Madonnas met through improv and sketch comedy classes at the Push Comedy Theater. It didn't take long before they realized their undeniable comedic (and sexual) chemistry and set out to form a comedy supergroup. In August 2015, the group formed over cheap, delicious tacos and a shared sense of narcissism.
</p>
<p><br><br>Nate Fender (the old man)<br>Evan Grummell (the brain)<br>Evan Hartley (the hair)<br>Bobby Mercer (the gun show)<br>Amber Nettles (the sass)<br>Brittany Shearer (the cat lady)<br>Barrett Sigmon (the bro)
</p>
<p><br><br>The Pre Madonnas and The Bright Side Present: Make Sketch Great Again<br>Friday, August 19, 10 PM<br>FREE SHOW
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p><br><br>--
</p>
<p><br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy.
</p>
<p><br><br>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-08-19T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-19T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b8397f86-efeb-48af-8366-100353d04b4c",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b8397f86-efeb-48af-8366-100353d04b4c",
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

# Insert free
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "free"
})
Logger.info "=========== Wrote tag ==========="

# Insert bright-side
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "bright-side"
})
Logger.info "=========== Wrote tag ==========="

# Insert pre-maddonas
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "pre-maddonas"
})
Logger.info "=========== Wrote tag ==========="

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "sketch"
})
Logger.info "=========== Wrote tag ==========="

# Insert groups
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "groups"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Pre Madonnas and The Bright Side",
    status: "available",
    description: "Ticket for The Pre Madonnas and The Bright Side",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-09T05:15:36.803Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Pre Madonnas and The Bright Side ==========="
Logger.info "=========== BEGIN Processing Universe Event CANCELLED Workshop: Acting and Singing with Archetypes ==========="

Logger.info "=========== Writing Event CANCELLED Workshop: Acting and Singing with Archetypes ==========="
event = SeedHelpers.create_event(
  %{
    slug: "DS8QGR",
    title: "CANCELLED Workshop: Acting and Singing with Archetypes",
    description: """
    <p><strong><br></strong>
</p>
<p><strong>CANC</strong>
</p>
<p><strong><br></strong>
</p>
<p><strong>Workshop: Acting and Singing with Archetypes</strong>
</p>
<p>Looking for help in creating dynamic and memorable characters?
</p>
<p>This workshop will combine the exploration of 5 Archetypes using singing, physical movement and psychological methods. Acting and Singing with Archetypes is a workshop that assists the performer with creating dynamic characters for their vocal or performative use.
</p>
<p>This workshop is also open and available to directors and people who are not performers. They can glean vital information from exploring each Archetype and bring it into their own work.
</p>
<p>Here is a list of the archetypes we will be exploring:
</p>
<p><strong>The Trickster</strong>
</p>
<p><strong>The Lover</strong>
</p>
<p><strong>The Innocent Child</strong>
</p>
<p><strong>The Hero's Journey</strong>
</p>
<p><strong>The Devil</strong>
</p>
<p>Please come with clothes you can move in. Bring something to write with/on along with a piece of memorised text.  It can me a monologue, poem, song lyric, nursery rhyme, etc.  Anything that can be recited easily and effortlessly.
</p>
<p><strong>Workshop: Acting and Singing with Archetypes</strong>
</p>
<p>Saturday, November 5th.
</p>
<p>12 to 4pm at the Push Comedy Theater, followed by a performance at 5pm.
</p>
<p>Instructor: Elyse Jolley
</p>
<p>Cost: $50
</p>
<p><strong>Elyse Jolley </strong>graduated from Virginia Commonwealth University with a B.F.A. in Theatre Performance. Elyse has travelled the world performing theatre and studied with the DAH Teatar in Belgrade, Serbia. They created an original devised theatre piece that was performed all through Greece. This process was also a part of a PBS Documentary,'Soldiers and Sacrifice.'
</p>
<p>Other notable theatre collaborations have been with Janet Rodgers using the Archetypes work to create an original devised theatre piece, 'The 60's Project.' She has written and performed her own one-woman show, 313, debuting at Richmond Triangle Players. Elyse was an artist-in-residence with the theatre company, Hand2Mouth on their La Mama production of 'Something's Got a Hold of My Heart.' Elyse has studied with Fay Simpson in her work, 'The Lucid Body,' and Janet Rodgers and Frankie Armstrong's work, 'Acting &amp; Singing with Archetypes.'
</p>
<p>Elyse is a repertory &amp; company member of 'The Conciliation Project' a social justice theatre company in Richmond, Va. where she was not only performing with the company but was Project Manager of a grant called the C.A.R.E. Initiative.
</p>
<p>Elyse has taught theatre to young adults through ART 180 in Richmond, Va, Three Legged Chair in NYC. She lives and works in NYC where she continues to teach theatre and work collaboratively with other performance artists.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing CANCELLED Workshop: Acting and Singing with Archetypes ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "DS8QGR",
    title: "CANCELLED Workshop: Acting and Singing with Archetypes",
    description: """
    <p><strong><br></strong>
</p>
<p><strong>CANC</strong>
</p>
<p><strong><br></strong>
</p>
<p><strong>Workshop: Acting and Singing with Archetypes</strong>
</p>
<p>Looking for help in creating dynamic and memorable characters?
</p>
<p>This workshop will combine the exploration of 5 Archetypes using singing, physical movement and psychological methods. Acting and Singing with Archetypes is a workshop that assists the performer with creating dynamic characters for their vocal or performative use.
</p>
<p>This workshop is also open and available to directors and people who are not performers. They can glean vital information from exploring each Archetype and bring it into their own work.
</p>
<p>Here is a list of the archetypes we will be exploring:
</p>
<p><strong>The Trickster</strong>
</p>
<p><strong>The Lover</strong>
</p>
<p><strong>The Innocent Child</strong>
</p>
<p><strong>The Hero's Journey</strong>
</p>
<p><strong>The Devil</strong>
</p>
<p>Please come with clothes you can move in. Bring something to write with/on along with a piece of memorised text.  It can me a monologue, poem, song lyric, nursery rhyme, etc.  Anything that can be recited easily and effortlessly.
</p>
<p><strong>Workshop: Acting and Singing with Archetypes</strong>
</p>
<p>Saturday, November 5th.
</p>
<p>12 to 4pm at the Push Comedy Theater, followed by a performance at 5pm.
</p>
<p>Instructor: Elyse Jolley
</p>
<p>Cost: $50
</p>
<p><strong>Elyse Jolley </strong>graduated from Virginia Commonwealth University with a B.F.A. in Theatre Performance. Elyse has travelled the world performing theatre and studied with the DAH Teatar in Belgrade, Serbia. They created an original devised theatre piece that was performed all through Greece. This process was also a part of a PBS Documentary,'Soldiers and Sacrifice.'
</p>
<p>Other notable theatre collaborations have been with Janet Rodgers using the Archetypes work to create an original devised theatre piece, 'The 60's Project.' She has written and performed her own one-woman show, 313, debuting at Richmond Triangle Players. Elyse was an artist-in-residence with the theatre company, Hand2Mouth on their La Mama production of 'Something's Got a Hold of My Heart.' Elyse has studied with Fay Simpson in her work, 'The Lucid Body,' and Janet Rodgers and Frankie Armstrong's work, 'Acting &amp; Singing with Archetypes.'
</p>
<p>Elyse is a repertory &amp; company member of 'The Conciliation Project' a social justice theatre company in Richmond, Va. where she was not only performing with the company but was Project Manager of a grant called the C.A.R.E. Initiative.
</p>
<p>Elyse has taught theatre to young adults through ART 180 in Richmond, Va, Three Legged Chair in NYC. She lives and works in NYC where she continues to teach theatre and work collaboratively with other performance artists.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-11-05T13:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-11-05T16:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/d389c2ac-ec0a-4977-96cc-315229aaab7f",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/d389c2ac-ec0a-4977-96cc-315229aaab7f",
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

# Insert workshop
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "workshop"
})
Logger.info "=========== Wrote tag ==========="

# Insert singing
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "singing"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for CANCELLED Workshop: Acting and Singing with Archetypes",
    status: "available",
    description: "Ticket for CANCELLED Workshop: Acting and Singing with Archetypes",
    price: 5000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-10-18T23:34:03.969Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event CANCELLED Workshop: Acting and Singing with Archetypes ==========="
Logger.info "=========== BEGIN Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="

Logger.info "=========== Writing Event Girl-Prov: The Girls' Night of Improv ==========="
event = SeedHelpers.create_event(
  %{
    slug: "7VWD0K",
    title: "Girl-Prov: The Girls' Night of Improv",
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
<p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, November 11th at the Push Comedy Theater<br>The show starts at 10, tickets are $5
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
Logger.info "=========== Writing Event Listing Girl-Prov: The Girls' Night of Improv ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "7VWD0K",
    title: "Girl-Prov: The Girls' Night of Improv",
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
<p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, November 11th at the Push Comedy Theater<br>The show starts at 10, tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2016-11-11T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-11-11T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/2818bca8-8162-47b8-999f-625527ad42d0",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/2818bca8-8162-47b8-999f-625527ad42d0",
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
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Girl-Prov: The Girls' Night of Improv",
    status: "available",
    description: "Ticket for Girl-Prov: The Girls' Night of Improv",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-10-26T20:48:26.185Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="
Logger.info "=========== BEGIN Processing Universe Event The First Timers Club: A Sketch Comedy Show ==========="

Logger.info "=========== Writing Event The First Timers Club: A Sketch Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "LDX5K9",
    title: "The First Timers Club: A Sketch Comedy Show",
    description: """
    <p><strong>Get ready to laugh your butts off!!!</strong>
</p>
<p>It's <strong>The First Timers Club: A Brand New Comedy Show</strong> from the minds of the Push Comedy Theater's Sketch Comedy Writing Class.
</p>
<p>The writers of our Sketch 101 Writing Class have been slaving away for months (under our expert and somewhat drunken tutelage)... and they've come up with a kick ass show full of Walmart shoppers, Caribbean witch doctors, furries (or are they plushies), bathroom etiquette, vapes for kids, aunt Flo, Billy Jack and more!!!<br>
</p>
<p><br>
</p>
<p>Don't miss this hilarious show from some amazing first time writers...
</p>
<p><strong>The First Timers Club: A Sketch Comedy Show</strong>
</p>
<p>Sunday, March 19th
</p>
<p>The show starts at 7pm
</p>
<p>Tickets are $5
</p>
<p><br>
</p>
<p>Push Comedy Theater
</p>
<p>763 Granby Street
</p>
<p>Norfolk, VA
</p>
<p>757-333-7442
</p>
<p>pushcomedytheater.com
</p>
<p>The Pushers are very proud of this show. The students of our Sketch 101 writing class have been working their comedy butts off and we can’t wait for you to see their work. It’s some really funny stuff. Don’t miss it!!!
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The First Timers Club: A Sketch Comedy Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "LDX5K9",
    title: "The First Timers Club: A Sketch Comedy Show",
    description: """
    <p><strong>Get ready to laugh your butts off!!!</strong>
</p>
<p>It's <strong>The First Timers Club: A Brand New Comedy Show</strong> from the minds of the Push Comedy Theater's Sketch Comedy Writing Class.
</p>
<p>The writers of our Sketch 101 Writing Class have been slaving away for months (under our expert and somewhat drunken tutelage)... and they've come up with a kick ass show full of Walmart shoppers, Caribbean witch doctors, furries (or are they plushies), bathroom etiquette, vapes for kids, aunt Flo, Billy Jack and more!!!<br>
</p>
<p><br>
</p>
<p>Don't miss this hilarious show from some amazing first time writers...
</p>
<p><strong>The First Timers Club: A Sketch Comedy Show</strong>
</p>
<p>Sunday, March 19th
</p>
<p>The show starts at 7pm
</p>
<p>Tickets are $5
</p>
<p><br>
</p>
<p>Push Comedy Theater
</p>
<p>763 Granby Street
</p>
<p>Norfolk, VA
</p>
<p>757-333-7442
</p>
<p>pushcomedytheater.com
</p>
<p>The Pushers are very proud of this show. The students of our Sketch 101 writing class have been working their comedy butts off and we can’t wait for you to see their work. It’s some really funny stuff. Don’t miss it!!!
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-03-26T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-26T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/d36bfd75-221e-45b3-b325-c73eb3ce9c08",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/d36bfd75-221e-45b3-b325-c73eb3ce9c08",
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

# Insert class
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "class"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The First Timers Club: A Sketch Comedy Show",
    status: "available",
    description: "Ticket for The First Timers Club: A Sketch Comedy Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-18T19:23:09.526Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The First Timers Club: A Sketch Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Musical Improv Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Musical Improv Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "JKL5T3",
    title: "Class Dismissed: The Musical Improv Graduation Show",
    description: """
    <p>Come cheer on Push Comedy Theater’s Musical Improv Class as they take the stage for their graduation show!
</p>
<p>This talented band of improvisers has been working incredibly hard for 6 weeks - singing, rapping, and even dancing - so let’s support them as they show us their brand new skills.
</p>
<p>Get ready as singing and improv collide!!!
</p>
<p><strong>Class Dismissed: The Musical Improv Graduation Show</strong>
</p>
<p>Tuesday, May 16th at 7pm
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
Logger.info "=========== Writing Event Listing Class Dismissed: The Musical Improv Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "JKL5T3",
    title: "Class Dismissed: The Musical Improv Graduation Show",
    description: """
    <p>Come cheer on Push Comedy Theater’s Musical Improv Class as they take the stage for their graduation show!
</p>
<p>This talented band of improvisers has been working incredibly hard for 6 weeks - singing, rapping, and even dancing - so let’s support them as they show us their brand new skills.
</p>
<p>Get ready as singing and improv collide!!!
</p>
<p><strong>Class Dismissed: The Musical Improv Graduation Show</strong>
</p>
<p>Tuesday, May 16th at 7pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-05-16T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-16T20:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/376331a7-12e6-4099-aa80-cee9908af7dd",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/376331a7-12e6-4099-aa80-cee9908af7dd",
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
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Class Dismissed: The Musical Improv Graduation Show",
    status: "available",
    description: "Ticket for Class Dismissed: The Musical Improv Graduation Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-11T02:50:20.054Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Musical Improv Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Ptown Jokers ==========="

Logger.info "=========== Writing Event The Ptown Jokers ==========="
event = SeedHelpers.create_event(
  %{
    slug: "JRPGS6",
    title: "The Ptown Jokers",
    description: """
    <p><strong></strong><strong>It's a Portsmouth Invasion!!!</strong></p><p>  Portsmouth comes to Norfolk as Ptwon's funniest sons and daughters take over the Push Comedy Theater.  It will be a night of stand-up comedy and improv. </p><p> <br>  <strong>Hosted by </strong>Hatton Jordan </p><p>  <strong>Featuring</strong> Chas Hartley, Lamont Ferguson, Dustin Noack, Jounte Ferguson and Tim Loulies. </p><p>  <strong>Improv by</strong> Brad McMurran and the Push's Portsmouth Natives. </p><p><strong style="background-color: initial;">The Ptown Jokers</strong></p><p><strong style="background-color: initial;"></strong> Saturday, May 7th at 10pm </p><p>Tickets are $10<strong><br></strong></p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Ptown Jokers ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "JRPGS6",
    title: "The Ptown Jokers",
    description: """
    <p><strong></strong><strong>It's a Portsmouth Invasion!!!</strong></p><p>  Portsmouth comes to Norfolk as Ptwon's funniest sons and daughters take over the Push Comedy Theater.  It will be a night of stand-up comedy and improv. </p><p> <br>  <strong>Hosted by </strong>Hatton Jordan </p><p>  <strong>Featuring</strong> Chas Hartley, Lamont Ferguson, Dustin Noack, Jounte Ferguson and Tim Loulies. </p><p>  <strong>Improv by</strong> Brad McMurran and the Push's Portsmouth Natives. </p><p><strong style="background-color: initial;">The Ptown Jokers</strong></p><p><strong style="background-color: initial;"></strong> Saturday, May 7th at 10pm </p><p>Tickets are $10<strong><br></strong></p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-05-07T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-05-07T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/400fd11f-c914-4c94-914b-833511d7d74b",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/400fd11f-c914-4c94-914b-833511d7d74b",
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

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Ptown Jokers",
    status: "available",
    description: "Ticket for The Ptown Jokers",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-20T03:46:44.588Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Ptown Jokers ==========="
Logger.info "=========== BEGIN Processing Universe Event Getting to Know the Couple: with Brad and Alba ==========="

Logger.info "=========== Writing Event Getting to Know the Couple: with Brad and Alba ==========="
event = SeedHelpers.create_event(
  %{
    slug: "X9ZGH1",
    title: "Getting to Know the Couple: with Brad and Alba",
    description: """
    <p>Two lucky couples will see their love unfold on stage through the interpretation of 2 of Hampton Roads' wackiest improvisers!
</p>
<p>The couples will be selected at random and interviewed on stage in front of the audience. Using the information they learn, and their immagination, Brad and Alba will show the story of the couples' love.
</p>
<p>For years, The Pushers have been getting to know diverse couples all across Hampton Roads with this signature piece. Normally this is a piece within a larger show. This time, Brad and Alba are out to explore as much as possible by bringing it to you as its own show!
</p>
<p>Getting to Know the Couple: With Brad and Alba
</p>
<p>Friday, January 13th at 8pm
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
Logger.info "=========== Writing Event Listing Getting to Know the Couple: with Brad and Alba ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "X9ZGH1",
    title: "Getting to Know the Couple: with Brad and Alba",
    description: """
    <p>Two lucky couples will see their love unfold on stage through the interpretation of 2 of Hampton Roads' wackiest improvisers!
</p>
<p>The couples will be selected at random and interviewed on stage in front of the audience. Using the information they learn, and their immagination, Brad and Alba will show the story of the couples' love.
</p>
<p>For years, The Pushers have been getting to know diverse couples all across Hampton Roads with this signature piece. Normally this is a piece within a larger show. This time, Brad and Alba are out to explore as much as possible by bringing it to you as its own show!
</p>
<p>Getting to Know the Couple: With Brad and Alba
</p>
<p>Friday, January 13th at 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-01-13T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-01-13T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/759b4d0a-c53d-4a5e-b794-e3aeeae488ff",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/759b4d0a-c53d-4a5e-b794-e3aeeae488ff",
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

# Insert couples
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "couples"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Getting to Know the Couple: with Brad and Alba",
    status: "available",
    description: "Ticket for Getting to Know the Couple: with Brad and Alba",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-01-02T20:18:16.627Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Getting to Know the Couple: with Brad and Alba ==========="
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="

Logger.info "=========== Writing Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "FDHN12",
    title: "IMPROVAGEDDON: The Ultimate Improv Competition!",
    description: """
    <p><strong>Prepare for Glory!</strong>
</p>
<p>Prepare for <strong>IMPROVAGEDDON: The Ultimate Improv Competition!!!</strong>
</p>
<p>We stand before the dawn of a new world!!!
</p>
<p>Last month, The Party Crashers earned their second championship! Now they will defend their title against two hungry challenging teams!
</p>
<p>Can the Party Crashers hang on to become the 2nd ever 3x Champions? Will another brand new team emerge to take them down?  Will a team of Improvageddon vets re-enter the fray?
</p>
<p>Who will raise the Hammer of Lowell in final victory?
</p>
<p>You'll have to come to this month's show to find out!<br>
</p>
<p>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory.
</p>
<p>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet!
</p>
<p><br>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest.
</p>
<p>Gimmicks will be displayed! <br>Trash will be talked! <br>Feats of comedic strength will be performed!
</p>
<p>Let the final war for comedic supremacy begin!
</p>
<p><strong>IMPROVAGEDDON: The Ultimate Improv Competition!</strong><br>Saturday, July 30th
</p>
<p>The show starts at 10pm
</p>
<p>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing IMPROVAGEDDON: The Ultimate Improv Competition! ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "FDHN12",
    title: "IMPROVAGEDDON: The Ultimate Improv Competition!",
    description: """
    <p><strong>Prepare for Glory!</strong>
</p>
<p>Prepare for <strong>IMPROVAGEDDON: The Ultimate Improv Competition!!!</strong>
</p>
<p>We stand before the dawn of a new world!!!
</p>
<p>Last month, The Party Crashers earned their second championship! Now they will defend their title against two hungry challenging teams!
</p>
<p>Can the Party Crashers hang on to become the 2nd ever 3x Champions? Will another brand new team emerge to take them down?  Will a team of Improvageddon vets re-enter the fray?
</p>
<p>Who will raise the Hammer of Lowell in final victory?
</p>
<p>You'll have to come to this month's show to find out!<br>
</p>
<p>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory.
</p>
<p>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet!
</p>
<p><br>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest.
</p>
<p>Gimmicks will be displayed! <br>Trash will be talked! <br>Feats of comedic strength will be performed!
</p>
<p>Let the final war for comedic supremacy begin!
</p>
<p><strong>IMPROVAGEDDON: The Ultimate Improv Competition!</strong><br>Saturday, July 30th
</p>
<p>The show starts at 10pm
</p>
<p>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-07-30T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-30T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/eac7e3da-57ce-4803-88b9-36916a893485",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/eac7e3da-57ce-4803-88b9-36916a893485",
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
    name: "Ticket for IMPROVAGEDDON: The Ultimate Improv Competition!",
    status: "available",
    description: "Ticket for IMPROVAGEDDON: The Ultimate Improv Competition!",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-05T04:16:19.247Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="
Logger.info "=========== BEGIN Processing Universe Event Date Night ==========="

Logger.info "=========== Writing Event Date Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "2JSGBR",
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
<p>Friday, October 6th at 8pm
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
    slug: "2JSGBR",
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
<p>Friday, October 6th at 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-10-06T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-10-06T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/7e2ff30f-6b86-488e-8838-cfc9912b6824",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/7e2ff30f-6b86-488e-8838-cfc9912b6824",
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
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Date Night",
    status: "available",
    description: "Ticket for Date Night",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-02T14:54:11.835Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Date Night ==========="
