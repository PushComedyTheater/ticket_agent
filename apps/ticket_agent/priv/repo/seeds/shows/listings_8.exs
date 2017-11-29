require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="

Logger.info "=========== Writing Event The Improv Riot: The Short Form Improv Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "LWN18Z",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.
</p>
<p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.
</p>
<p><strong>The Improv Riot: The Short Form Improv Show</strong>
</p>
<p>Friday, January 27th, 8pm
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
    slug: "LWN18Z",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.
</p>
<p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.
</p>
<p><strong>The Improv Riot: The Short Form Improv Show</strong>
</p>
<p>Friday, January 27th, 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-01-27T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-01-27T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-01-20T16:10:51.189Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="
Logger.info "=========== BEGIN Processing Universe Event 3 on 3 Improv Tournament - The Final Four ==========="

Logger.info "=========== Writing Event 3 on 3 Improv Tournament - The Final Four ==========="
event = SeedHelpers.create_event(
  %{
    slug: "MYG69J",
    title: "3 on 3 Improv Tournament - The Final Four",
    description: """
    <p><strong></strong><strong>IT'S MARCH MADNESS AT THE PUSH!!!</strong>
</p>
<p>We're proud to announce the return of the Push Comedy Theater 3 on 3 Improv Tournament.
</p>
<p>We started with 16 teams... 12 left in defeat and shame.
</p>
<p>Only 4 remain!!!
</p>
<p>Don't miss this elimination style competition for 3 on 3 improv supremacy! Will one of the improv powerhouses be crowned champion, or will a Cinderella story take it all?
</p>
<p>For the Final Four, each team will be given just 15 minutes to dazzle both the audience and our secret panel of judges with their improv skills.
</p>
<p>Don't miss these great match ups:
</p>
<p><br>
</p>
<p>3 on 3 Improv Tournament - The Final Four
</p>
<p>Friday, March 24th, 8pm at the Push Comedy Theater
</p>
<p>Tickets are $5
</p>
<p>This event is going to be huge, so get your tickets now.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing 3 on 3 Improv Tournament - The Final Four ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "MYG69J",
    title: "3 on 3 Improv Tournament - The Final Four",
    description: """
    <p><strong></strong><strong>IT'S MARCH MADNESS AT THE PUSH!!!</strong>
</p>
<p>We're proud to announce the return of the Push Comedy Theater 3 on 3 Improv Tournament.
</p>
<p>We started with 16 teams... 12 left in defeat and shame.
</p>
<p>Only 4 remain!!!
</p>
<p>Don't miss this elimination style competition for 3 on 3 improv supremacy! Will one of the improv powerhouses be crowned champion, or will a Cinderella story take it all?
</p>
<p>For the Final Four, each team will be given just 15 minutes to dazzle both the audience and our secret panel of judges with their improv skills.
</p>
<p>Don't miss these great match ups:
</p>
<p><br>
</p>
<p>3 on 3 Improv Tournament - The Final Four
</p>
<p>Friday, March 24th, 8pm at the Push Comedy Theater
</p>
<p>Tickets are $5
</p>
<p>This event is going to be huge, so get your tickets now.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-03-24T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-24T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/f6587806-4768-4fca-8e34-86f2ffe8fecb",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/f6587806-4768-4fca-8e34-86f2ffe8fecb",
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

# Insert tournament
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "tournament"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for 3 on 3 Improv Tournament - The Final Four",
    status: "available",
    description: "Ticket for 3 on 3 Improv Tournament - The Final Four",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-04T18:32:53.984Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event 3 on 3 Improv Tournament - The Final Four ==========="
Logger.info "=========== BEGIN Processing Universe Event Double Feature: The Made Up Movie ==========="

Logger.info "=========== Writing Event Double Feature: The Made Up Movie ==========="
event = SeedHelpers.create_event(
  %{
    slug: "NXGDKM",
    title: "Double Feature: The Made Up Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong></p><p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.</p><p><strong>Double Feature: The Totally Improvised Movie</strong><br>Friday, April 15th, 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.</p><p><br>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Double Feature: The Made Up Movie ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "NXGDKM",
    title: "Double Feature: The Made Up Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong></p><p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.</p><p><strong>Double Feature: The Totally Improvised Movie</strong><br>Friday, April 15th, 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.</p><p><br>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-15T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-15T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/a00fb4fd-29f2-4b67-b327-642f0a8b2f4a",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/a00fb4fd-29f2-4b67-b327-642f0a8b2f4a",
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

# Insert double-feature
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "double-feature"
})
Logger.info "=========== Wrote tag ==========="

# Insert movie
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "movie"
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
    name: "Ticket for Double Feature: The Made Up Movie",
    status: "available",
    description: "Ticket for Double Feature: The Made Up Movie",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-10T00:00:28.137Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Double Feature: The Made Up Movie ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The 401 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The 401 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "LGW710",
    title: "Class Dismissed: The 401 Graduation Show",
    description: """
    <p><strong></strong><strong>Dust off those caps and gowns... It's Harold Graduation Time!!!</strong>
</p>
<p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?
</p>
<p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.
</p>
<p>The Push Comedy Theater's 401 students take the Harold head on! Don't miss it
</p>
<p><strong>Class Dismissed: The 401 Graduation Show</strong><br>Wednesday, October 11th at 8pm<br>Tickets are $5
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
Logger.info "=========== Writing Event Listing Class Dismissed: The 401 Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "LGW710",
    title: "Class Dismissed: The 401 Graduation Show",
    description: """
    <p><strong></strong><strong>Dust off those caps and gowns... It's Harold Graduation Time!!!</strong>
</p>
<p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?
</p>
<p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.
</p>
<p>The Push Comedy Theater's 401 students take the Harold head on! Don't miss it
</p>
<p><strong>Class Dismissed: The 401 Graduation Show</strong><br>Wednesday, October 11th at 8pm<br>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-10-11T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-10-11T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/529dca51-f727-4f35-86a3-7ca0e030a5b6",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/529dca51-f727-4f35-86a3-7ca0e030a5b6",
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
    name: "Ticket for Class Dismissed: The 401 Graduation Show",
    status: "available",
    description: "Ticket for Class Dismissed: The 401 Graduation Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-28T02:54:55.697Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The 401 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The 666 Project: A Horror Anthology Show (Oct 30) ==========="

Logger.info "=========== Writing Event The 666 Project: A Horror Anthology Show (Oct 30) ==========="
event = SeedHelpers.create_event(
  %{
    slug: "SD0BG5",
    title: "The 666 Project: A Horror Anthology Show (Oct 30)",
    description: """
    <p style="text-align: center;">In the grand tradition of The Twilight Zone and Tales from the Crypt comes The 666 Project. The Push Comedy Theater has gathered six writers, six directors and six actors to bring you six rib-tickling, tales of terror. i</p><p style="text-align: center;">The Push Comedy Theater is proud to present <strong>The 666 Project: A Horror Anthology Show!</strong></p><p style="text-align: center;">October 17, 22, 23, 24, 30 and 31 at The Push Comedy Theater</p><p style="text-align: center;">The show starts at 8pm.</p><p style="text-align: center;">Tickets are $15 and are available at the links below or at pushcomedytheater.com</p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-oct-17-tickets-norfolk-71PMGS" rel="nofollow" target="_blank">Saturday, October 17</a></p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-oct-22-tickets-norfolk-2KFD07" rel="nofollow" target="_blank">Thursday, October 22</a></p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-tickets-norfolk-J8XPYZ" rel="nofollow" target="_blank">Friday, October 23</a></p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-oct-24-tickets-norfolk-GFP4M5" rel="nofollow" target="_blank">Saturday, October 24</a></p><p style="text-align: center;">Friday, October 30</p><p style="text-align: center;">Saturday, October 31</p><p style="text-align: center;">The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p><a href="https://www.facebook.com/events/862223163884514/" rel="nofollow" target="_blank"><img src="https://s3.amazonaws.com/uniiverse_production/attachments/43c3d62c11efcf26daa282c90c0d7692-Push%20Halloween%20Project%20White%20Poster.jpg" alt="" style="display: block; margin: auto;"></a></p><p style="text-align: center;">Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p style="text-align: center;">---</p><p style="text-align: center;">The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p style="text-align: center;">In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p style="text-align: center;">The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p style="text-align: center;">Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p style="text-align: center;">--</p><p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p style="text-align: center;">The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The 666 Project: A Horror Anthology Show (Oct 30) ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "SD0BG5",
    title: "The 666 Project: A Horror Anthology Show (Oct 30)",
    description: """
    <p style="text-align: center;">In the grand tradition of The Twilight Zone and Tales from the Crypt comes The 666 Project. The Push Comedy Theater has gathered six writers, six directors and six actors to bring you six rib-tickling, tales of terror. i</p><p style="text-align: center;">The Push Comedy Theater is proud to present <strong>The 666 Project: A Horror Anthology Show!</strong></p><p style="text-align: center;">October 17, 22, 23, 24, 30 and 31 at The Push Comedy Theater</p><p style="text-align: center;">The show starts at 8pm.</p><p style="text-align: center;">Tickets are $15 and are available at the links below or at pushcomedytheater.com</p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-oct-17-tickets-norfolk-71PMGS" rel="nofollow" target="_blank">Saturday, October 17</a></p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-oct-22-tickets-norfolk-2KFD07" rel="nofollow" target="_blank">Thursday, October 22</a></p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-tickets-norfolk-J8XPYZ" rel="nofollow" target="_blank">Friday, October 23</a></p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-oct-24-tickets-norfolk-GFP4M5" rel="nofollow" target="_blank">Saturday, October 24</a></p><p style="text-align: center;">Friday, October 30</p><p style="text-align: center;">Saturday, October 31</p><p style="text-align: center;">The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p><a href="https://www.facebook.com/events/862223163884514/" rel="nofollow" target="_blank"><img src="https://s3.amazonaws.com/uniiverse_production/attachments/43c3d62c11efcf26daa282c90c0d7692-Push%20Halloween%20Project%20White%20Poster.jpg" alt="" style="display: block; margin: auto;"></a></p><p style="text-align: center;">Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p style="text-align: center;">---</p><p style="text-align: center;">The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p style="text-align: center;">In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p style="text-align: center;">The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p style="text-align: center;">Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p style="text-align: center;">--</p><p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p style="text-align: center;">The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-10-30T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-10-30T22:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8198608e-1caa-445e-863f-c5c22a5b4d0e",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8198608e-1caa-445e-863f-c5c22a5b4d0e",
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
    name: "Ticket for The 666 Project: A Horror Anthology Show (Oct 30)",
    status: "available",
    description: "Ticket for The 666 Project: A Horror Anthology Show (Oct 30)",
    price: 1500,
    sale_start:  NaiveDateTime.from_iso8601!("2015-09-30T17:10:33.509Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The 666 Project: A Horror Anthology Show (Oct 30) ==========="
Logger.info "=========== BEGIN Processing Universe Event The 666 Project: A Horror Anthology Show (Oct 24) ==========="

Logger.info "=========== Writing Event The 666 Project: A Horror Anthology Show (Oct 24) ==========="
event = SeedHelpers.create_event(
  %{
    slug: "GFP4M5",
    title: "The 666 Project: A Horror Anthology Show (Oct 24)",
    description: """
    <p style="text-align: center;">In the grand tradition of The Twilight Zone and Tales from the Crypt comes The 666 Project. The Push Comedy Theater has gathered six writers, six directors and six actors to bring you six rib-tickling, tales of terror. i</p><p style="text-align: center;">The Push Comedy Theater is proud to present The 666 Project: A Horror Anthology Show!</p><p style="text-align: center;">October 17, 22, 23, 24, 30 and 31 at The Push Comedy Theater</p><p style="text-align: center;">The show starts at 8pm.</p><p style="text-align: center;">Tickets are $15 and are available at the links below or at pushcomedytheater.com</p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-oct-17-tickets-norfolk-71PMGS" rel="nofollow" target="_blank">Saturday, October 17</a></p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-oct-22-tickets-norfolk-2KFD07" rel="nofollow" target="_blank">Thursday, October 22</a></p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-tickets-norfolk-J8XPYZ" rel="nofollow" target="_blank">Friday, October 23</a></p><p style="text-align: center;">Saturday, October 24</p><p style="text-align: center;">Friday, October 30</p><p style="text-align: center;">Saturday, October 31</p><p style="text-align: center;">The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p><a href="https://www.facebook.com/events/862223163884514/" rel="nofollow" target="_blank"><img src="https://s3.amazonaws.com/uniiverse_production/attachments/43c3d62c11efcf26daa282c90c0d7692-Push%20Halloween%20Project%20White%20Poster.jpg" alt="" style="display: block; margin: auto;"></a></p><p style="text-align: center;">Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p style="text-align: center;">---</p><p style="text-align: center;">The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p style="text-align: center;">In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p style="text-align: center;">The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p style="text-align: center;">Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p style="text-align: center;">--</p><p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p style="text-align: center;">The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The 666 Project: A Horror Anthology Show (Oct 24) ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "GFP4M5",
    title: "The 666 Project: A Horror Anthology Show (Oct 24)",
    description: """
    <p style="text-align: center;">In the grand tradition of The Twilight Zone and Tales from the Crypt comes The 666 Project. The Push Comedy Theater has gathered six writers, six directors and six actors to bring you six rib-tickling, tales of terror. i</p><p style="text-align: center;">The Push Comedy Theater is proud to present The 666 Project: A Horror Anthology Show!</p><p style="text-align: center;">October 17, 22, 23, 24, 30 and 31 at The Push Comedy Theater</p><p style="text-align: center;">The show starts at 8pm.</p><p style="text-align: center;">Tickets are $15 and are available at the links below or at pushcomedytheater.com</p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-oct-17-tickets-norfolk-71PMGS" rel="nofollow" target="_blank">Saturday, October 17</a></p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-oct-22-tickets-norfolk-2KFD07" rel="nofollow" target="_blank">Thursday, October 22</a></p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-tickets-norfolk-J8XPYZ" rel="nofollow" target="_blank">Friday, October 23</a></p><p style="text-align: center;">Saturday, October 24</p><p style="text-align: center;">Friday, October 30</p><p style="text-align: center;">Saturday, October 31</p><p style="text-align: center;">The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p><a href="https://www.facebook.com/events/862223163884514/" rel="nofollow" target="_blank"><img src="https://s3.amazonaws.com/uniiverse_production/attachments/43c3d62c11efcf26daa282c90c0d7692-Push%20Halloween%20Project%20White%20Poster.jpg" alt="" style="display: block; margin: auto;"></a></p><p style="text-align: center;">Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p style="text-align: center;">---</p><p style="text-align: center;">The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p style="text-align: center;">In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p style="text-align: center;">The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p style="text-align: center;">Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p style="text-align: center;">--</p><p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p style="text-align: center;">The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-10-24T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-10-24T22:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c2f1a2f4-c9e4-4c31-ade3-63c9d5979240",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c2f1a2f4-c9e4-4c31-ade3-63c9d5979240",
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
    name: "Ticket for The 666 Project: A Horror Anthology Show (Oct 24)",
    status: "available",
    description: "Ticket for The 666 Project: A Horror Anthology Show (Oct 24)",
    price: 1500,
    sale_start:  NaiveDateTime.from_iso8601!("2015-09-30T16:51:46.144Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The 666 Project: A Horror Anthology Show (Oct 24) ==========="
Logger.info "=========== BEGIN Processing Universe Event Couples Therapy ==========="

Logger.info "=========== Writing Event Couples Therapy ==========="
event = SeedHelpers.create_event(
  %{
    slug: "8GRF69",
    title: "Couples Therapy",
    description: """
    <p><strong></strong><strong>You think your relationship has problems?!?</strong></p><p>In Couples Therapy you'll meet a couple on the rocks... be it newlyweds on a honeymoon from hell or an elderly couple at the end of their rope.<br>Based on an audience suggestion, Sean and Brittany take you through a roller coaster ride of emotions as they whisk you the trials and tribulations of couple they create right before your eyes.</p><p>Oh yeah, and they do it all in a single, 25 minute long improvised scene.</p><p>Two Improvisers... One Scene!!!</p><p><strong>Couples Therapy... is sometimes hilarious, sometimes poignant, always magical.</strong></p><p>Sean Devereux and Brittany Shearer are members of the improv group, Alan Johnson and the Johnson Quintet. The duo have dazzled audience members at Improvageddon, and now they're getting their own show.</p><p>When not performing with the Quintet, Sean is a member of The Pushers and Brittany performs with The Pre Madonnas.</p><p>Sean and Brittany are not a couple in real life, but occasionally they play one on stage.</p><p><strong>Couples Therapy with Alan Johnson and the Alan Johnson Quintet</strong><br>Saturday, May 28th at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Couples Therapy ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "8GRF69",
    title: "Couples Therapy",
    description: """
    <p><strong></strong><strong>You think your relationship has problems?!?</strong></p><p>In Couples Therapy you'll meet a couple on the rocks... be it newlyweds on a honeymoon from hell or an elderly couple at the end of their rope.<br>Based on an audience suggestion, Sean and Brittany take you through a roller coaster ride of emotions as they whisk you the trials and tribulations of couple they create right before your eyes.</p><p>Oh yeah, and they do it all in a single, 25 minute long improvised scene.</p><p>Two Improvisers... One Scene!!!</p><p><strong>Couples Therapy... is sometimes hilarious, sometimes poignant, always magical.</strong></p><p>Sean Devereux and Brittany Shearer are members of the improv group, Alan Johnson and the Johnson Quintet. The duo have dazzled audience members at Improvageddon, and now they're getting their own show.</p><p>When not performing with the Quintet, Sean is a member of The Pushers and Brittany performs with The Pre Madonnas.</p><p>Sean and Brittany are not a couple in real life, but occasionally they play one on stage.</p><p><strong>Couples Therapy with Alan Johnson and the Alan Johnson Quintet</strong><br>Saturday, May 28th at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-05-28T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-05-28T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/03052876-c7f0-46ba-970c-2665e96a9bdf",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/03052876-c7f0-46ba-970c-2665e96a9bdf",
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

# Insert couple
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "couple"
})
Logger.info "=========== Wrote tag ==========="

# Insert therapy
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "therapy"
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
    name: "Ticket for Couples Therapy",
    status: "available",
    description: "Ticket for Couples Therapy",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-25T03:11:10.116Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Couples Therapy ==========="
Logger.info "=========== BEGIN Processing Universe Event Good Talk: The Brad McMurran Show ==========="

Logger.info "=========== Writing Event Good Talk: The Brad McMurran Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "2R6LXV",
    title: "Good Talk: The Brad McMurran Show",
    description: """
    <p>Get ready for a night of comedy from the Pushers' own Brad McMurran.
</p>
<p><br>
</p>
<p>"My Bicycle Journey Across America" is the tale of the wild situations and lessons learned in Brad's one-man adventure to find himself.  Based on the Jounal Brad kept during this 66 day exploration of our great nation, this show is about man (dip-shit) vs. nature. Through camping on his own, near-death experiences with perfect strangers, making bad decisions with the help of alcohol, and feeling a little like the Old Man and the Sea, this show will have you on the edge of your seat with suspense, and crying with laughter.
</p>
<p><br>
</p>
<p>Good Talk: The Brad McMurran Show -
</p>
<p>My Bicycle Journey Across America
</p>
<p>Sunday, September 3rd at 7pm
</p>
<p>Tickets are $12
</p>
<p><br><br><br>Good Talk is a one-man show starring Brad McMurran and focusing on McMurran's wildly popular Facebook posts.<br>Each month, Good Talk looks at the life and experiences of a sketch and improv comedian. Through storytelling, improv and mixed media, Brad will bring his Good Talk Facebook posts to life.<br>You'll see is struggles with bill collectors, relationships, alcohol, parents, opening a theater and just trying to act like an adult.<br>The show is going to be an unpredictable, wild and borderline-insane ride... just like Brad's life.
</p>
<p><br><br><br>Upcoming episodes of Good Talk: The Brad McMurran Show will include -<br>
</p>
<p>Halloween Special: My Horror Posts
</p>
<p>Alcohol and Drugs
</p>
<p>Christmas Talks
</p>
<p>New Years Resolutions
</p>
<p>Crazy for Love
</p>
<p>My Life in Comedy
</p>
<p>The College Years
</p>
<p>The New York Years
</p>
<p>Life and Death
</p>
<p>Failure
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
    slug: "2R6LXV",
    title: "Good Talk: The Brad McMurran Show",
    description: """
    <p>Get ready for a night of comedy from the Pushers' own Brad McMurran.
</p>
<p><br>
</p>
<p>"My Bicycle Journey Across America" is the tale of the wild situations and lessons learned in Brad's one-man adventure to find himself.  Based on the Jounal Brad kept during this 66 day exploration of our great nation, this show is about man (dip-shit) vs. nature. Through camping on his own, near-death experiences with perfect strangers, making bad decisions with the help of alcohol, and feeling a little like the Old Man and the Sea, this show will have you on the edge of your seat with suspense, and crying with laughter.
</p>
<p><br>
</p>
<p>Good Talk: The Brad McMurran Show -
</p>
<p>My Bicycle Journey Across America
</p>
<p>Sunday, September 3rd at 7pm
</p>
<p>Tickets are $12
</p>
<p><br><br><br>Good Talk is a one-man show starring Brad McMurran and focusing on McMurran's wildly popular Facebook posts.<br>Each month, Good Talk looks at the life and experiences of a sketch and improv comedian. Through storytelling, improv and mixed media, Brad will bring his Good Talk Facebook posts to life.<br>You'll see is struggles with bill collectors, relationships, alcohol, parents, opening a theater and just trying to act like an adult.<br>The show is going to be an unpredictable, wild and borderline-insane ride... just like Brad's life.
</p>
<p><br><br><br>Upcoming episodes of Good Talk: The Brad McMurran Show will include -<br>
</p>
<p>Halloween Special: My Horror Posts
</p>
<p>Alcohol and Drugs
</p>
<p>Christmas Talks
</p>
<p>New Years Resolutions
</p>
<p>Crazy for Love
</p>
<p>My Life in Comedy
</p>
<p>The College Years
</p>
<p>The New York Years
</p>
<p>Life and Death
</p>
<p>Failure
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-09-03T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-03T20:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-08-05T23:46:15.906Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Good Talk: The Brad McMurran Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Sketchmageddon ==========="

Logger.info "=========== Writing Event Sketchmageddon ==========="
event = SeedHelpers.create_event(
  %{
    slug: "DPL9XR",
    title: "Sketchmageddon",
    description: """
    <p><strong>The Push Comedy Theater's Experimental Sketch Comedy Showcase is back with a vengeance!!!!</strong>
</p>
<p>This is the show where anything goes ... and we do mean anything.
</p>
<p>Last month the champions, <strong>Adam and Evil </strong>secured another victory.  Can the new champs make it a three-peat?!?!?!
</p>
<p><strong>Find out at Skethcmageddon!!!</strong>
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
<p>Friday, September 2nd at 10pm
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
    slug: "DPL9XR",
    title: "Sketchmageddon",
    description: """
    <p><strong>The Push Comedy Theater's Experimental Sketch Comedy Showcase is back with a vengeance!!!!</strong>
</p>
<p>This is the show where anything goes ... and we do mean anything.
</p>
<p>Last month the champions, <strong>Adam and Evil </strong>secured another victory.  Can the new champs make it a three-peat?!?!?!
</p>
<p><strong>Find out at Skethcmageddon!!!</strong>
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
<p>Friday, September 2nd at 10pm
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
    start_at:  NaiveDateTime.from_iso8601!("2016-10-01T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-10-01T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-09-19T16:25:56.613Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Sketchmageddon ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 101 Grad Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 101 Grad Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "W8NYH5",
    title: "Class Dismissed: The Improv 101 Grad Show",
    description: """
    <p>Dust off those caps and gowns... because it's graduation time at the Push.
</p>
<p>Check out the Push Comedy Theater's Improv 101 class as they show off their comedy chops.
</p>
<p>You won't believe what these improv newcomers have in store for you!!!
</p>
<p>Class Dismissed: The Improv 101 Graduation Show<br>Tuesday, November 1st at 8pm<br>Tickets are $5
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
    slug: "W8NYH5",
    title: "Class Dismissed: The Improv 101 Grad Show",
    description: """
    <p>Dust off those caps and gowns... because it's graduation time at the Push.
</p>
<p>Check out the Push Comedy Theater's Improv 101 class as they show off their comedy chops.
</p>
<p>You won't believe what these improv newcomers have in store for you!!!
</p>
<p>Class Dismissed: The Improv 101 Graduation Show<br>Tuesday, November 1st at 8pm<br>Tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2016-11-01T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-11-01T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/87dc866e-46e3-4d6e-9494-46cc076c3e6d",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/87dc866e-46e3-4d6e-9494-46cc076c3e6d",
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
    name: "Ticket for Class Dismissed: The Improv 101 Grad Show",
    status: "available",
    description: "Ticket for Class Dismissed: The Improv 101 Grad Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-10-26T01:18:33.281Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 101 Grad Show ==========="
Logger.info "=========== BEGIN Processing Universe Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="

Logger.info "=========== Writing Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "8F0BMV",
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
<p><strong>TOO FAR: The Dirtiest, Most Inappropriate Comedy Show... EVER!</strong><br>Saturday, November 19th <br>Tickets are $10, Show starts at 10:00pm
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
    slug: "8F0BMV",
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
<p><strong>TOO FAR: The Dirtiest, Most Inappropriate Comedy Show... EVER!</strong><br>Saturday, November 19th <br>Tickets are $10, Show starts at 10:00pm
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
    start_at:  NaiveDateTime.from_iso8601!("2016-11-19T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-11-19T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-08T02:01:19.720Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improvised Teen Murder Mystery ==========="

Logger.info "=========== Writing Event The Improvised Teen Murder Mystery ==========="
event = SeedHelpers.create_event(
  %{
    slug: "5WV62Y",
    title: "The Improvised Teen Murder Mystery",
    description: """
    <p style="text-align: center;">Get ready for a spine tingling murder mystery... teen style!!!</p><p style="text-align: center;">There's a killer on the loose in the Push Comedy Theater... can you solve this classic who dunnit before they strike again!?!</p><p style="text-align: center;">This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.</p><p style="text-align: center;">...And it will all be made up on the spot by the gang of the Teen Improv Class!!!</p><p style="text-align: center;">Don't miss this exciting mystery, all based off the audience's suggestion.</p><p style="text-align: center;">The Teen Improv Class presents</p><p style="text-align: center;">Who Dunnit? ...The Improvised Murder Mystery</p><p style="text-align: center;">Sunday, October 18th at the Push Comedy Theater</p><p style="text-align: center;">The show starts at 4pm, tickets are $5</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/a1fc43dab247dd7323aeb1d8993a2101-MurderMusteryLogoNew.png" alt="" style="display: block; margin: auto;"></p><p style="text-align: center;">The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p style="text-align: center;">Free parking available behind Virginia Furniture Company (745 Granby Street) and at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p style="text-align: center;">---</p><p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p style="text-align: center;">The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Improvised Teen Murder Mystery ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "5WV62Y",
    title: "The Improvised Teen Murder Mystery",
    description: """
    <p style="text-align: center;">Get ready for a spine tingling murder mystery... teen style!!!</p><p style="text-align: center;">There's a killer on the loose in the Push Comedy Theater... can you solve this classic who dunnit before they strike again!?!</p><p style="text-align: center;">This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.</p><p style="text-align: center;">...And it will all be made up on the spot by the gang of the Teen Improv Class!!!</p><p style="text-align: center;">Don't miss this exciting mystery, all based off the audience's suggestion.</p><p style="text-align: center;">The Teen Improv Class presents</p><p style="text-align: center;">Who Dunnit? ...The Improvised Murder Mystery</p><p style="text-align: center;">Sunday, October 18th at the Push Comedy Theater</p><p style="text-align: center;">The show starts at 4pm, tickets are $5</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/a1fc43dab247dd7323aeb1d8993a2101-MurderMusteryLogoNew.png" alt="" style="display: block; margin: auto;"></p><p style="text-align: center;">The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p style="text-align: center;">Free parking available behind Virginia Furniture Company (745 Granby Street) and at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p style="text-align: center;">---</p><p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p style="text-align: center;">The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-10-18T16:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-10-18T17:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/63b0a931-c2f1-4f5a-a0c5-dd6e78a4af24",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/63b0a931-c2f1-4f5a-a0c5-dd6e78a4af24",
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

# Insert teen
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "teen"
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
    name: "Ticket for The Improvised Teen Murder Mystery",
    status: "available",
    description: "Ticket for The Improvised Teen Murder Mystery",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2015-10-12T03:17:20.257Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improvised Teen Murder Mystery ==========="
Logger.info "=========== BEGIN Processing Universe Event WS: The New Movement's Language and Philosophies ==========="

Logger.info "=========== Writing Event WS: The New Movement's Language and Philosophies ==========="
event = SeedHelpers.create_event(
  %{
    slug: "K5J9TV",
    title: "WS: The New Movement's Language and Philosophies",
    description: """
    <p>The New Movement's Language and Philosophies
</p>
<p>"They have built their own language of improv" - The Austin-American Statesman
</p>
<p>Learn to work your scenes without the aid of a suggestion from the audience. Discover how to map patterns using only the beginning of the scene. Experience a workshop where each student is guaranteed a plethora of stage time. The New Movement has been aggressively exploring an alternative approach to improv since its inception - this workshop is a peek into what we think makes improv tick.
</p>
<p>About the teacher: Chris Trew has been teaching workshops all over the country since 2006. He's opened multiple comedy theaters (most notable The New Movement in Austin and New Orleans), founded several comedy festivals, and co-authored a book, Improv Wins. He can be seen this Fall on MTV. The Chicagoist said Trew is "bit of a renaissance man from an alternate universe" in a recent Chicago Improv Festival post.
</p>
<p>The New Movement's Language and Philosophies with Chris Trew
</p>
<p>Saturday, September 10th at 1pm
</p>
<p>Cost: $40
</p>
<p>Copies of Improv Wins will be available for purchase.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing WS: The New Movement's Language and Philosophies ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "K5J9TV",
    title: "WS: The New Movement's Language and Philosophies",
    description: """
    <p>The New Movement's Language and Philosophies
</p>
<p>"They have built their own language of improv" - The Austin-American Statesman
</p>
<p>Learn to work your scenes without the aid of a suggestion from the audience. Discover how to map patterns using only the beginning of the scene. Experience a workshop where each student is guaranteed a plethora of stage time. The New Movement has been aggressively exploring an alternative approach to improv since its inception - this workshop is a peek into what we think makes improv tick.
</p>
<p>About the teacher: Chris Trew has been teaching workshops all over the country since 2006. He's opened multiple comedy theaters (most notable The New Movement in Austin and New Orleans), founded several comedy festivals, and co-authored a book, Improv Wins. He can be seen this Fall on MTV. The Chicagoist said Trew is "bit of a renaissance man from an alternate universe" in a recent Chicago Improv Festival post.
</p>
<p>The New Movement's Language and Philosophies with Chris Trew
</p>
<p>Saturday, September 10th at 1pm
</p>
<p>Cost: $40
</p>
<p>Copies of Improv Wins will be available for purchase.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-10T13:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-10T15:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1ab5fd33-f98c-475f-844e-1b75554a05ff",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1ab5fd33-f98c-475f-844e-1b75554a05ff",
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
    name: "Ticket for WS: The New Movement's Language and Philosophies",
    status: "available",
    description: "Ticket for WS: The New Movement's Language and Philosophies",
    price: 4000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-09-01T18:29:00.332Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event WS: The New Movement's Language and Philosophies ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More Storytelling ==========="

Logger.info "=========== Writing Event Tell Me More Storytelling ==========="
event = SeedHelpers.create_event(
  %{
    slug: "0GD48Y",
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
    slug: "0GD48Y",
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
    start_at:  NaiveDateTime.from_iso8601!("2016-10-16T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-10-16T20:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-10-15T20:04:20.228Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More Storytelling ==========="
Logger.info "=========== BEGIN Processing Universe Event The Pullers! - Kids Improv Graduation Show ==========="

Logger.info "=========== Writing Event The Pullers! - Kids Improv Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "X3BJP0",
    title: "The Pullers! - Kids Improv Graduation Show",
    description: """
    <p>You've heard of Generation X and Gen Y. Now get ready for the funniest, silliest, cutest generation of them all as The Pushers bring to you... The Pre-Teen Improv Superstars!!!</p><p>Don't miss this group of talented tween-boppers as they put on a funny and fast paced 'Who's Line Is It Anyway' style show.</p><p>The group is coached by local comedy couple, Jim and Mary Veverka, and local comedy giants, The Pushers.</p><p>The Pushers present The Pullers! - Kids Pre-Teen Improv Graduation Show</p><p>Sunday, May 22nd<br>The show starts at 2:30pm.<br>Tickets are $5 for adults, kids 17 and under are free!!!</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>Push Comedy Theater</p><p>763 Granby Street<br>Norfolk, VA</p><p>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=SAQEp-CGB&amp;enc=AZPSkpnzx134nCcYgDU_0YyrxP8zVtNaf96oRmxhwRhXWkRATDUW2gOh6TNIa-MQOgs&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a></p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Pullers! - Kids Improv Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "X3BJP0",
    title: "The Pullers! - Kids Improv Graduation Show",
    description: """
    <p>You've heard of Generation X and Gen Y. Now get ready for the funniest, silliest, cutest generation of them all as The Pushers bring to you... The Pre-Teen Improv Superstars!!!</p><p>Don't miss this group of talented tween-boppers as they put on a funny and fast paced 'Who's Line Is It Anyway' style show.</p><p>The group is coached by local comedy couple, Jim and Mary Veverka, and local comedy giants, The Pushers.</p><p>The Pushers present The Pullers! - Kids Pre-Teen Improv Graduation Show</p><p>Sunday, May 22nd<br>The show starts at 2:30pm.<br>Tickets are $5 for adults, kids 17 and under are free!!!</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>Push Comedy Theater</p><p>763 Granby Street<br>Norfolk, VA</p><p>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=SAQEp-CGB&amp;enc=AZPSkpnzx134nCcYgDU_0YyrxP8zVtNaf96oRmxhwRhXWkRATDUW2gOh6TNIa-MQOgs&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a></p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-05-22T14:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-05-22T15:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/956c4dd4-f384-4e42-81da-ffce538d8992",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/956c4dd4-f384-4e42-81da-ffce538d8992",
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

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Pullers! - Kids Improv Graduation Show",
    status: "available",
    description: "Ticket for The Pullers! - Kids Improv Graduation Show",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-08T03:05:44.004Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Pullers! - Kids Improv Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Second Saturday Stand-Up ==========="

Logger.info "=========== Writing Event Second Saturday Stand-Up ==========="
event = SeedHelpers.create_event(
  %{
    slug: "Q6RXDT",
    title: "Second Saturday Stand-Up",
    description: """
    <p><strong>Second Saturday Stand-Up</strong>
</p>
<p>This once-a-month show is hosted by almost-jaded veteran comic, <strong>Hatton Jordan </strong>who sets the lineup with proven comedians delivering road-tested jokes while they squeeze in new material.
</p>
<p>This is NOT a "open mic" .....it's selected talent working on their craft. Every month is a new seasoned lineup.
</p>
<p><strong>Scheduled: </strong>
</p>
<p><strong>Host: Hatton Jordan</strong>
</p>
<p><strong> </strong>
</p>
<p>J T Rome<br>TRAVIS CARL<br>SEBASTIAN PIGNATO<br>JOSH VAN HART<br>WINSTON HODGES<br>JOY JULIAN<br>JAY GATES
</p>
<p><strong>Second Saturday Stand-Up</strong>
</p>
<p>Saturday, June 10th at 10pm
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
    slug: "Q6RXDT",
    title: "Second Saturday Stand-Up",
    description: """
    <p><strong>Second Saturday Stand-Up</strong>
</p>
<p>This once-a-month show is hosted by almost-jaded veteran comic, <strong>Hatton Jordan </strong>who sets the lineup with proven comedians delivering road-tested jokes while they squeeze in new material.
</p>
<p>This is NOT a "open mic" .....it's selected talent working on their craft. Every month is a new seasoned lineup.
</p>
<p><strong>Scheduled: </strong>
</p>
<p><strong>Host: Hatton Jordan</strong>
</p>
<p><strong> </strong>
</p>
<p>J T Rome<br>TRAVIS CARL<br>SEBASTIAN PIGNATO<br>JOSH VAN HART<br>WINSTON HODGES<br>JOY JULIAN<br>JAY GATES
</p>
<p><strong>Second Saturday Stand-Up</strong>
</p>
<p>Saturday, June 10th at 10pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-07-08T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-08T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-06-30T18:42:22.768Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Second Saturday Stand-Up ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 501 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 501 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "5ZLW2Q",
    title: "Class Dismissed: The Improv 501 Graduation Show",
    description: """
    <p>Get ready for a colossal night of comedy and mayhem at the Push Comedy Theater, brought to you by some of Hampton Roads' finest improvisers.
</p>
<p>Don't miss this improv extravaganza, brought to you by the Push's upperclassmen.
</p>
<p>Class Dismissed: The Improv 501 Graduation Show
</p>
<p>Thursday, September 7th at 8pm
</p>
<p>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>--
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
Logger.info "=========== Writing Event Listing Class Dismissed: The Improv 501 Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "5ZLW2Q",
    title: "Class Dismissed: The Improv 501 Graduation Show",
    description: """
    <p>Get ready for a colossal night of comedy and mayhem at the Push Comedy Theater, brought to you by some of Hampton Roads' finest improvisers.
</p>
<p>Don't miss this improv extravaganza, brought to you by the Push's upperclassmen.
</p>
<p>Class Dismissed: The Improv 501 Graduation Show
</p>
<p>Thursday, September 7th at 8pm
</p>
<p>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-09-07T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-07T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8f0d85cf-3c5b-48c1-b07f-b79385d9b915",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8f0d85cf-3c5b-48c1-b07f-b79385d9b915",
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
    name: "Ticket for Class Dismissed: The Improv 501 Graduation Show",
    status: "available",
    description: "Ticket for Class Dismissed: The Improv 501 Graduation Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-05T12:19:06.557Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 501 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Bright Side - Sunny Sketch Comedy Show ft. The Gay Agenda ==========="

Logger.info "=========== Writing Event The Bright Side - Sunny Sketch Comedy Show ft. The Gay Agenda ==========="
event = SeedHelpers.create_event(
  %{
    slug: "DYCSKV",
    title: "The Bright Side - Sunny Sketch Comedy Show ft. The Gay Agenda",
    description: """
    <p>The Bright Side Sketch &amp; Improv Comedy presents: God Bless You, America!
</p>
<p>A Sunny Sketch Comedy Show
</p>
<p>with special opening act The Gay Agenda!
</p>
<p>Have you ever watched SNL, Key &amp; Peele, or Mad TV and wished you could be in the audience? Now's your chance!
</p>
<p> The Bright Side Sketch &amp; Improv Comedy brings that same style of crazy characters, outrageous situations, and non-stop live energy to the Push Comedy Theater stage!
</p>
<p>Breakdancing squirrels!
</p>
<p>Bible-thumping IT specialists!
</p>
<p>Beer!
</p>
<p>The Bright Side Sketch &amp; Improv Comedy is a performance group from Norfolk, VA. In early 2015, Andrea Bourguignon, Matt Cole, Brian Garraty, and Drew Richard decided to join forces as The Bright Side! Their particular brand of comedy is a celebration of the absurdity of the mundane world. Audiences at a Bright Side show can expect to see smart, polished comedy that reflects the group’s life experiences and optimistic perspectives. Look on The Bright Side!
</p>
<p>The Gay Agenda is a sketch comedy group based out of the Push Comedy Theater specializing in smart comedy with biting social commentary!
</p>
<p>The Bright Side Sketch &amp; Improv Comedy presents: God Bless You, America! A Sunny Sketch Comedy Show
</p>
<p>Saturday, July 1, 10:00 PM
</p>
<p>Push Comedy Theater, Tickets are $10
</p>
<p>Come out to see and support one of Hampton Road's own sketch comedy groups at the intimate Push Comedy Theater in the heart of the new Norfolk Arts District!
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
Logger.info "=========== Writing Event Listing The Bright Side - Sunny Sketch Comedy Show ft. The Gay Agenda ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "DYCSKV",
    title: "The Bright Side - Sunny Sketch Comedy Show ft. The Gay Agenda",
    description: """
    <p>The Bright Side Sketch &amp; Improv Comedy presents: God Bless You, America!
</p>
<p>A Sunny Sketch Comedy Show
</p>
<p>with special opening act The Gay Agenda!
</p>
<p>Have you ever watched SNL, Key &amp; Peele, or Mad TV and wished you could be in the audience? Now's your chance!
</p>
<p> The Bright Side Sketch &amp; Improv Comedy brings that same style of crazy characters, outrageous situations, and non-stop live energy to the Push Comedy Theater stage!
</p>
<p>Breakdancing squirrels!
</p>
<p>Bible-thumping IT specialists!
</p>
<p>Beer!
</p>
<p>The Bright Side Sketch &amp; Improv Comedy is a performance group from Norfolk, VA. In early 2015, Andrea Bourguignon, Matt Cole, Brian Garraty, and Drew Richard decided to join forces as The Bright Side! Their particular brand of comedy is a celebration of the absurdity of the mundane world. Audiences at a Bright Side show can expect to see smart, polished comedy that reflects the group’s life experiences and optimistic perspectives. Look on The Bright Side!
</p>
<p>The Gay Agenda is a sketch comedy group based out of the Push Comedy Theater specializing in smart comedy with biting social commentary!
</p>
<p>The Bright Side Sketch &amp; Improv Comedy presents: God Bless You, America! A Sunny Sketch Comedy Show
</p>
<p>Saturday, July 1, 10:00 PM
</p>
<p>Push Comedy Theater, Tickets are $10
</p>
<p>Come out to see and support one of Hampton Road's own sketch comedy groups at the intimate Push Comedy Theater in the heart of the new Norfolk Arts District!
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-07-01T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-01T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/e1407f19-7687-466e-a247-cd5d3df2e8dc",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/e1407f19-7687-466e-a247-cd5d3df2e8dc",
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
    name: "Ticket for The Bright Side - Sunny Sketch Comedy Show ft. The Gay Agenda",
    status: "available",
    description: "Ticket for The Bright Side - Sunny Sketch Comedy Show ft. The Gay Agenda",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-06-26T02:03:34.009Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Bright Side - Sunny Sketch Comedy Show ft. The Gay Agenda ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More… Storytelling Nights: Disappointments ==========="

Logger.info "=========== Writing Event Tell Me More… Storytelling Nights: Disappointments ==========="
event = SeedHelpers.create_event(
  %{
    slug: "1MCXJ0",
    title: "Tell Me More… Storytelling Nights: Disappointments",
    description: """
    <p>You had every detail figured out. You mapped the way to your destination. Everything was perfect. But nothing worked out as planned. Come out and join us 7 p.m. March. 20 to hear stories along these lines.</p><p>Theme: Disappointments<br>Song: “Failure,” by Kings Of Convenience<br>Possibly inspiring stories of: Succeeding at failing hard.</p><p>FEATURED STORYTELLERS<br>Storytellers to be announced. If you’re interested in telling a story, tell us about it: <a href="http://tellmemorelive.org/sign-up/" rel="nofollow" target="_blank">http://tellmemorelive.org/<wbr>sign-up/</wbr></a></p><p>OUR HOST<br>Brendan Kennedy, is a comedian, storyteller and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”</p><p>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, March 20, 2016<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $5 </p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch and improv comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Tell Me More… Storytelling Nights: Disappointments ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "1MCXJ0",
    title: "Tell Me More… Storytelling Nights: Disappointments",
    description: """
    <p>You had every detail figured out. You mapped the way to your destination. Everything was perfect. But nothing worked out as planned. Come out and join us 7 p.m. March. 20 to hear stories along these lines.</p><p>Theme: Disappointments<br>Song: “Failure,” by Kings Of Convenience<br>Possibly inspiring stories of: Succeeding at failing hard.</p><p>FEATURED STORYTELLERS<br>Storytellers to be announced. If you’re interested in telling a story, tell us about it: <a href="http://tellmemorelive.org/sign-up/" rel="nofollow" target="_blank">http://tellmemorelive.org/<wbr>sign-up/</wbr></a></p><p>OUR HOST<br>Brendan Kennedy, is a comedian, storyteller and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”</p><p>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, March 20, 2016<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $5 </p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch and improv comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-03-20T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-03-20T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/a85d80d7-f30c-420f-9ffa-776374ac64e6",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/a85d80d7-f30c-420f-9ffa-776374ac64e6",
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
    name: "Ticket for Tell Me More… Storytelling Nights: Disappointments",
    status: "available",
    description: "Ticket for Tell Me More… Storytelling Nights: Disappointments",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-02-27T01:51:20.010Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More… Storytelling Nights: Disappointments ==========="
Logger.info "=========== BEGIN Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="

Logger.info "=========== Writing Event Who Dunnit? ...The Improvised Murder Mystery ==========="
event = SeedHelpers.create_event(
  %{
    slug: "MF9V12",
    title: "Who Dunnit? ...The Improvised Murder Mystery",
    description: """
    <p><strong>Get ready for a spine tingling murder mystery!!!</strong><br>
</p>
<p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.
</p>
<p>...And it will all be made up on the spot!!!
</p>
<p>Don't miss this exciting mystery, all based off the audience's suggestion.
</p>
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, July 8th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $10
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
Logger.info "=========== Writing Event Listing Who Dunnit? ...The Improvised Murder Mystery ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "MF9V12",
    title: "Who Dunnit? ...The Improvised Murder Mystery",
    description: """
    <p><strong>Get ready for a spine tingling murder mystery!!!</strong><br>
</p>
<p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.
</p>
<p>...And it will all be made up on the spot!!!
</p>
<p>Don't miss this exciting mystery, all based off the audience's suggestion.
</p>
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, July 8th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $10
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
    start_at:  NaiveDateTime.from_iso8601!("2017-07-08T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-08T21:30:00.000-04:00")
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
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-06-11T02:30:39.457Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="
