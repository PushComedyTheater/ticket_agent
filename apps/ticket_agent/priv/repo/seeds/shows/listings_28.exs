require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 101 and 201 Grad Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 101 and 201 Grad Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "48YNG3",
    title: "Class Dismissed: The Improv 101 and 201 Grad Show",
    description: """
    <p><strong></strong><strong>Dust off those caps and gowns... because it's graduation time at the Push.</strong></p><p>Check out the Push Comedy Theater's <strong>Improv 101</strong> class as they show off their comedy chops.</p><p>You won't believe what these improv newcomers have in store for you!!!</p><p>AND THEN...</p><p>Check out the Push Comedy Theater's<strong> Improv 201 </strong>class as they show off their comedy chops.</p><p>Watch as these brave 201 souls dive head first into the wonderful world of The Harold. So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p><strong>Class Dismissed: The Improv 101 and 201 Graduation Show</strong> </p><p>Wednesday, November 11th at 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/6bc37d4ff9c8c20785ca99b1f14e92fd-Class%20101%20and%20201.jpg"></p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Class Dismissed: The Improv 101 and 201 Grad Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "48YNG3",
    title: "Class Dismissed: The Improv 101 and 201 Grad Show",
    description: """
    <p><strong></strong><strong>Dust off those caps and gowns... because it's graduation time at the Push.</strong></p><p>Check out the Push Comedy Theater's <strong>Improv 101</strong> class as they show off their comedy chops.</p><p>You won't believe what these improv newcomers have in store for you!!!</p><p>AND THEN...</p><p>Check out the Push Comedy Theater's<strong> Improv 201 </strong>class as they show off their comedy chops.</p><p>Watch as these brave 201 souls dive head first into the wonderful world of The Harold. So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p><strong>Class Dismissed: The Improv 101 and 201 Graduation Show</strong> </p><p>Wednesday, November 11th at 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/6bc37d4ff9c8c20785ca99b1f14e92fd-Class%20101%20and%20201.jpg"></p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-11-11T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-11-11T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/3c139ed3-e20d-4dd4-917e-b7251edea6ed",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/3c139ed3-e20d-4dd4-917e-b7251edea6ed",
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

# Insert class
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "class"
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
    name: "Ticket for Class Dismissed: The Improv 101 and 201 Grad Show",
    status: "available",
    description: "Ticket for Class Dismissed: The Improv 101 and 201 Grad Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-03T03:04:54.963Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 101 and 201 Grad Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="

Logger.info "=========== Writing Event The Improv Riot: The Short Form Improv Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "JQNXSK",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.
</p>
<p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.
</p>
<p><strong>The Improv Riot: The Short Form Improv Show</strong>
</p>
<p>Friday, May 26th, 8pm
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
    slug: "JQNXSK",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.
</p>
<p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.
</p>
<p><strong>The Improv Riot: The Short Form Improv Show</strong>
</p>
<p>Friday, May 26th, 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-05-26T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-26T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-04-25T00:48:54.975Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Harold Night ==========="

Logger.info "=========== Writing Event Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "J8D0LR",
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
<p>Friday, October 28th at 10:00pm
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
    slug: "J8D0LR",
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
<p>Friday, October 28th at 10:00pm
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
    start_at:  NaiveDateTime.from_iso8601!("2016-10-28T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-10-28T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/49cb7b83-12f7-40fe-a963-5ad538df05a4",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/49cb7b83-12f7-40fe-a963-5ad538df05a4",
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
    name: "Ticket for Harold Night",
    status: "available",
    description: "Ticket for Harold Night",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-10-13T23:40:30.005Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Harold Night ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More... Storytelling Night: Liberation ==========="

Logger.info "=========== Writing Event Tell Me More... Storytelling Night: Liberation ==========="
event = SeedHelpers.create_event(
  %{
    slug: "94F71J",
    title: "Tell Me More... Storytelling Night: Liberation",
    description: """
    <p><strong></strong><strong>Ever just wanted to break free? Join us 7 p.m. June 19 for stories of liberation.</strong></p><p>June Storytelling Night Theme<br>Theme: Liberation<br>Song: “I Want to Break Free,” Queen<br>Possibly inspiring stories of: Getting out of town or a situation or both</p><p>Featured Storytellers<br>Storytellers to be announced soon.</p><p>Our host<br>Brendan Kennedy, is a comedian, storyteller and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”<br>Event details</p><p>Time: 7 p.m.<br>Date: Sunday, June 19, 2016<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Tell Me More... Storytelling Night: Liberation ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "94F71J",
    title: "Tell Me More... Storytelling Night: Liberation",
    description: """
    <p><strong></strong><strong>Ever just wanted to break free? Join us 7 p.m. June 19 for stories of liberation.</strong></p><p>June Storytelling Night Theme<br>Theme: Liberation<br>Song: “I Want to Break Free,” Queen<br>Possibly inspiring stories of: Getting out of town or a situation or both</p><p>Featured Storytellers<br>Storytellers to be announced soon.</p><p>Our host<br>Brendan Kennedy, is a comedian, storyteller and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”<br>Event details</p><p>Time: 7 p.m.<br>Date: Sunday, June 19, 2016<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-19T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-19T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c5a51aba-0360-434f-b6d4-0fb8bba1f416",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c5a51aba-0360-434f-b6d4-0fb8bba1f416",
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
    name: "Ticket for Tell Me More... Storytelling Night: Liberation",
    status: "available",
    description: "Ticket for Tell Me More... Storytelling Night: Liberation",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-06-08T03:50:54.750Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More... Storytelling Night: Liberation ==========="
Logger.info "=========== BEGIN Processing Universe Event ENCORE: The Push Comedy Theater Anniversary Jam ==========="

Logger.info "=========== Writing Event ENCORE: The Push Comedy Theater Anniversary Jam ==========="
event = SeedHelpers.create_event(
  %{
    slug: "LPNZH4",
    title: "ENCORE: The Push Comedy Theater Anniversary Jam",
    description: """
    <p><strong></strong><strong>The Push Comedy Theater Anniversary Bash has SOLD OUT!!!!</strong></p><p>But don't worry, you can still celebrate with the gang. We are adding a new show, The Push Comedy Theater Annivesary Jam. <br><strong>The Pushers</strong> are joining forces with members of <strong>The Bright Side</strong>, <strong>Pre Madonnas</strong>, <strong>Absolute Uncertainty</strong>, <strong>The Upright Senior Citizens Brigade</strong> and more for a good, old-fashioned improv jam.</p><p>It's going to be the party of the year!!!!<br>Plus there's a rumor we will be celebrating Brad McMurran's birthday too!</p><p>The show starts at 11 and is absolutely free (though we do recommend you reserve your seat online).</p><p><strong>The Push Comedy Theater Anniversary Jam (FREE SHOW)</strong><br>Saturday, November 14th at 11pm.<br>Absolutely Free</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/c9990a18508e3bc53c896edbc3d8c1e4-ss8.jpg"></p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing ENCORE: The Push Comedy Theater Anniversary Jam ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "LPNZH4",
    title: "ENCORE: The Push Comedy Theater Anniversary Jam",
    description: """
    <p><strong></strong><strong>The Push Comedy Theater Anniversary Bash has SOLD OUT!!!!</strong></p><p>But don't worry, you can still celebrate with the gang. We are adding a new show, The Push Comedy Theater Annivesary Jam. <br><strong>The Pushers</strong> are joining forces with members of <strong>The Bright Side</strong>, <strong>Pre Madonnas</strong>, <strong>Absolute Uncertainty</strong>, <strong>The Upright Senior Citizens Brigade</strong> and more for a good, old-fashioned improv jam.</p><p>It's going to be the party of the year!!!!<br>Plus there's a rumor we will be celebrating Brad McMurran's birthday too!</p><p>The show starts at 11 and is absolutely free (though we do recommend you reserve your seat online).</p><p><strong>The Push Comedy Theater Anniversary Jam (FREE SHOW)</strong><br>Saturday, November 14th at 11pm.<br>Absolutely Free</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/c9990a18508e3bc53c896edbc3d8c1e4-ss8.jpg"></p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-11-14T23:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-11-15T01:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/4f92e6d5-9f33-46a6-811e-11e1dd653639",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/4f92e6d5-9f33-46a6-811e-11e1dd653639",
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
    name: "Ticket for ENCORE: The Push Comedy Theater Anniversary Jam",
    status: "available",
    description: "Ticket for ENCORE: The Push Comedy Theater Anniversary Jam",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-13T21:55:38.510Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event ENCORE: The Push Comedy Theater Anniversary Jam ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 201 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 201 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "BY54H3",
    title: "Class Dismissed: The Improv 201 Graduation Show",
    description: """
    <p><strong></strong><strong>Dust off those caps and gowns... because it's graduation time at the Push.</strong></p><p>Check out the Push Comedy Theater's Improv 201 class as they show off their comedy chops.</p><p>Watch as these brave 201 souls dive head first into the wonderful world of The Harold. So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p><strong>Class Dismissed: The Improv 201 Graduation Show </strong><br>Wednesday, March 16th at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Class Dismissed: The Improv 201 Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "BY54H3",
    title: "Class Dismissed: The Improv 201 Graduation Show",
    description: """
    <p><strong></strong><strong>Dust off those caps and gowns... because it's graduation time at the Push.</strong></p><p>Check out the Push Comedy Theater's Improv 201 class as they show off their comedy chops.</p><p>Watch as these brave 201 souls dive head first into the wonderful world of The Harold. So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p><strong>Class Dismissed: The Improv 201 Graduation Show </strong><br>Wednesday, March 16th at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-03-16T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-03-16T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8b5822d7-25d6-4a77-a774-ff0916f5db49",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8b5822d7-25d6-4a77-a774-ff0916f5db49",
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
    name: "Ticket for Class Dismissed: The Improv 201 Graduation Show",
    status: "available",
    description: "Ticket for Class Dismissed: The Improv 201 Graduation Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-11T16:29:05.626Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 201 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Getting to Know the Couple: with Brad and Alba ==========="

Logger.info "=========== Writing Event Getting to Know the Couple: with Brad and Alba ==========="
event = SeedHelpers.create_event(
  %{
    slug: "BQR1M4",
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
<p>Friday, September 30th at 8pm
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
    slug: "BQR1M4",
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
<p>Friday, September 30th at 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2016-09-30T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-30T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-09-19T22:50:13.108Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Getting to Know the Couple: with Brad and Alba ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improvised Ghost Story ==========="

Logger.info "=========== Writing Event The Improvised Ghost Story ==========="
event = SeedHelpers.create_event(
  %{
    slug: "9CL3VS",
    title: "The Improvised Ghost Story",
    description: """
    <p>In honor of the new Ghostbusters movie... the Push presents a frightful night of comedy (or is it a hilarious night of frights).
</p>
<p><br>
</p>
<p><strong>Don't miss the debut of Tales from the Campfire.</strong>
</p>
<p><strong><br></strong>
</p>
<p>With an audience suggestion, this talented group of improvisers will make up a gut-busting ghost story right before your eyes.
</p>
<p><br>
</p>
<p><strong>Tales from the Campfire: The Improvised Ghost Story</strong>
</p>
<p>Friday, July 15 at 8pm
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
Logger.info "=========== Writing Event Listing The Improvised Ghost Story ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "9CL3VS",
    title: "The Improvised Ghost Story",
    description: """
    <p>In honor of the new Ghostbusters movie... the Push presents a frightful night of comedy (or is it a hilarious night of frights).
</p>
<p><br>
</p>
<p><strong>Don't miss the debut of Tales from the Campfire.</strong>
</p>
<p><strong><br></strong>
</p>
<p>With an audience suggestion, this talented group of improvisers will make up a gut-busting ghost story right before your eyes.
</p>
<p><br>
</p>
<p><strong>Tales from the Campfire: The Improvised Ghost Story</strong>
</p>
<p>Friday, July 15 at 8pm
</p>
<p>Tickets are $5
</p>
<p><br>
</p>
<p>I ain't afraid of no ghost!
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-07-15T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-15T21:30:00.000-04:00")
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
    name: "Ticket for The Improvised Ghost Story",
    status: "available",
    description: "Ticket for The Improvised Ghost Story",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-13T16:56:52.265Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improvised Ghost Story ==========="
Logger.info "=========== BEGIN Processing Universe Event The Pre Madonnas Present: Heavenly Bodies ==========="

Logger.info "=========== Writing Event The Pre Madonnas Present: Heavenly Bodies ==========="
event = SeedHelpers.create_event(
  %{
    slug: "193H4L",
    title: "The Pre Madonnas Present: Heavenly Bodies",
    description: """
    <p><strong>Get ready for a fun-filled night of sketch comedy!</strong><br>The Pre Madonnas are back at the Push Comedy Theater with more fun than ever. Whether you like your comedy dirty or silly, slapstick or satire, <strong>The Pre Madonnas </strong>will have something for everyone in their new sketch comedy show <strong>"Heavenly Bodies."</strong>
</p>
<p><br><br>The Pre Madonnas:<br>Nate Fender (the old man)<br>Evan Grummell (the brain)<br>Evan Hartley (the hair)<br>Bobby Mercer (the gun show)<br>Amber Nettles (the sass)<br>Brittany Shearer (the cat lady)<br>Barrett Sigmon (the bro)<br>
</p>
<p><br><br>Contact: thepremadonnas@gmail.com<br>Twitter: @ Pre_Madonnas<br>Instagram: @ thepremadonnas
</p>
<p><br><br>Tickets are $10 and can be bought ahead of time or at the door. We highly recommend buying tickets in advance, and arriving at the theater early to get a great seat!.
</p>
<p><br><br>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2FPushcomedytheater.com%2F&amp;h=-AQF6fjIW&amp;enc=AZN2owOQ7e-qLGZzKmJfK82LZQeLCkyPA8ffhTPHyy-_nKOc9Pj0rxyWyiIn1BhYJIo&amp;s=1" rel="nofollow" target="_blank">Pushcomedytheater.com</a>
</p>
<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p><br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Pre Madonnas are back at the Push Comedy Theater with more fun than ever. Whether you like your comedy dirty or silly, slapstick or satire, The Pre Madonnas will have something for everyone in their new sketch comedy show "Heavenly Bodies."
</p>
<p><br><br>The Pre Madonnas:<br>Nate Fender (the old man)<br>Evan Grummell (the brain)<br>Evan Hartley (the hair)<br>Bobby Mercer (the gun show)<br>Amber Nettles (the sass)<br>Brittany Shearer (the cat lady)<br>Barrett Sigmon (the bro)<br>
</p>
<p><br><br>Contact: thepremadonnas@gmail.com<br>Twitter: @ Pre_Madonnas<br>Instagram: @ thepremadonnas
</p>
<p><br><br>Tickets are $10 and can be bought ahead of time or at the door. We highly recommend buying tickets in advance, and arriving at the theater early to get a great seat!.
</p>
<p><br><br>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2FPushcomedytheater.com%2F&amp;h=-AQF6fjIW&amp;enc=AZN2owOQ7e-qLGZzKmJfK82LZQeLCkyPA8ffhTPHyy-_nKOc9Pj0rxyWyiIn1BhYJIo&amp;s=1" rel="nofollow" target="_blank">Pushcomedytheater.com</a>
</p>
<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p><br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Pre Madonnas Present: Heavenly Bodies ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "193H4L",
    title: "The Pre Madonnas Present: Heavenly Bodies",
    description: """
    <p><strong>Get ready for a fun-filled night of sketch comedy!</strong><br>The Pre Madonnas are back at the Push Comedy Theater with more fun than ever. Whether you like your comedy dirty or silly, slapstick or satire, <strong>The Pre Madonnas </strong>will have something for everyone in their new sketch comedy show <strong>"Heavenly Bodies."</strong>
</p>
<p><br><br>The Pre Madonnas:<br>Nate Fender (the old man)<br>Evan Grummell (the brain)<br>Evan Hartley (the hair)<br>Bobby Mercer (the gun show)<br>Amber Nettles (the sass)<br>Brittany Shearer (the cat lady)<br>Barrett Sigmon (the bro)<br>
</p>
<p><br><br>Contact: thepremadonnas@gmail.com<br>Twitter: @ Pre_Madonnas<br>Instagram: @ thepremadonnas
</p>
<p><br><br>Tickets are $10 and can be bought ahead of time or at the door. We highly recommend buying tickets in advance, and arriving at the theater early to get a great seat!.
</p>
<p><br><br>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2FPushcomedytheater.com%2F&amp;h=-AQF6fjIW&amp;enc=AZN2owOQ7e-qLGZzKmJfK82LZQeLCkyPA8ffhTPHyy-_nKOc9Pj0rxyWyiIn1BhYJIo&amp;s=1" rel="nofollow" target="_blank">Pushcomedytheater.com</a>
</p>
<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p><br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Pre Madonnas are back at the Push Comedy Theater with more fun than ever. Whether you like your comedy dirty or silly, slapstick or satire, The Pre Madonnas will have something for everyone in their new sketch comedy show "Heavenly Bodies."
</p>
<p><br><br>The Pre Madonnas:<br>Nate Fender (the old man)<br>Evan Grummell (the brain)<br>Evan Hartley (the hair)<br>Bobby Mercer (the gun show)<br>Amber Nettles (the sass)<br>Brittany Shearer (the cat lady)<br>Barrett Sigmon (the bro)<br>
</p>
<p><br><br>Contact: thepremadonnas@gmail.com<br>Twitter: @ Pre_Madonnas<br>Instagram: @ thepremadonnas
</p>
<p><br><br>Tickets are $10 and can be bought ahead of time or at the door. We highly recommend buying tickets in advance, and arriving at the theater early to get a great seat!.
</p>
<p><br><br>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2FPushcomedytheater.com%2F&amp;h=-AQF6fjIW&amp;enc=AZN2owOQ7e-qLGZzKmJfK82LZQeLCkyPA8ffhTPHyy-_nKOc9Pj0rxyWyiIn1BhYJIo&amp;s=1" rel="nofollow" target="_blank">Pushcomedytheater.com</a>
</p>
<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p><br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-11-05T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-11-05T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/458aeb4b-3c61-4345-ab8d-f0e35fea9318",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/458aeb4b-3c61-4345-ab8d-f0e35fea9318",
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

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "sketch"
})
Logger.info "=========== Wrote tag ==========="

# Insert thepremadonnas
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "thepremadonnas"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Pre Madonnas Present: Heavenly Bodies",
    status: "available",
    description: "Ticket for The Pre Madonnas Present: Heavenly Bodies",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-10-12T22:56:47.047Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Pre Madonnas Present: Heavenly Bodies ==========="
Logger.info "=========== BEGIN Processing Universe Event The Dudes: Calmer Than You Are, Dude ==========="

Logger.info "=========== Writing Event The Dudes: Calmer Than You Are, Dude ==========="
event = SeedHelpers.create_event(
  %{
    slug: "NFL4VB",
    title: "The Dudes: Calmer Than You Are, Dude",
    description: """
    <p><strong>Summer daze are in full effect, man. </strong>
</p>
<p>What better way to cool off your steam than to have fun with some of the most nonchalant, imperturbable, unruffled, blasé, cool, equable, even-tempered, low-maintenance, insouciant, calm, unperturbed, unflustered, unflappable Dudes in the 757?
</p>
<p>Come out for a night of easy-going, relaxed, unbothered laughs at The Push Comedy Theater in Norfolk's NEON Arts District!
</p>
<p><br>The Dudes are bunch of guys who like to drink beer, talk about dude things, and perfom improv comedy. They're multi-IMPROVAGEDDON champions and have performed up and down I-64.
</p>
<p>Don't miss a night of Dude-inspired comedy, featuring special guests TBD!
</p>
<p><br><br>The Dudes Improvasitional Comedy are:
</p>
<p>Rafael <br>Adam Paine<br>James Roach<br>Matt Cole <br>Brian Garraty<br>Anthony Nobles
</p>
<p><br><br>The Dudes: Calmer Than You Are, Dude<br>Friday, July 22nd at 10pm<br>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p><br>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy.
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
Logger.info "=========== Writing Event Listing The Dudes: Calmer Than You Are, Dude ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "NFL4VB",
    title: "The Dudes: Calmer Than You Are, Dude",
    description: """
    <p><strong>Summer daze are in full effect, man. </strong>
</p>
<p>What better way to cool off your steam than to have fun with some of the most nonchalant, imperturbable, unruffled, blasé, cool, equable, even-tempered, low-maintenance, insouciant, calm, unperturbed, unflustered, unflappable Dudes in the 757?
</p>
<p>Come out for a night of easy-going, relaxed, unbothered laughs at The Push Comedy Theater in Norfolk's NEON Arts District!
</p>
<p><br>The Dudes are bunch of guys who like to drink beer, talk about dude things, and perfom improv comedy. They're multi-IMPROVAGEDDON champions and have performed up and down I-64.
</p>
<p>Don't miss a night of Dude-inspired comedy, featuring special guests TBD!
</p>
<p><br><br>The Dudes Improvasitional Comedy are:
</p>
<p>Rafael <br>Adam Paine<br>James Roach<br>Matt Cole <br>Brian Garraty<br>Anthony Nobles
</p>
<p><br><br>The Dudes: Calmer Than You Are, Dude<br>Friday, July 22nd at 10pm<br>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p><br>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-07-22T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-22T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/167acb76-77f5-4342-889c-0166d4c993b2",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/167acb76-77f5-4342-889c-0166d4c993b2",
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
    name: "Ticket for The Dudes: Calmer Than You Are, Dude",
    status: "available",
    description: "Ticket for The Dudes: Calmer Than You Are, Dude",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-07T21:18:18.811Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Dudes: Calmer Than You Are, Dude ==========="
Logger.info "=========== BEGIN Processing Universe Event NCF:  Who Dunnit? ...The Improvised Murder Mystery ==========="

Logger.info "=========== Writing Event NCF:  Who Dunnit? ...The Improvised Murder Mystery ==========="
event = SeedHelpers.create_event(
  %{
    slug: "BKP7JM",
    title: "NCF:  Who Dunnit? ...The Improvised Murder Mystery",
    description: """
    <p><strong>Get ready for a spine tingling murder mystery!!!</strong>
</p>
<p>There’s a killer on the loose… can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery… a dastardly villain, shifty suspects and an intrepid detective.
</p>
<p>…And it will all be made up on the spot!!!
</p>
<p><strong>Who Dunnit? …The Improvised Murder Mystery</strong> is the Push Comedy Theater’s hit show.  It’s had sold out crowds howling with laughter 11 months in a row.  Don’t miss this very special Norfolk Comedy Festival edition.
</p>
<p><strong></strong>
</p>
<p>The Norfolk Comedy Festival is proud to present<br><strong>Who Dunnit? …The Improvised Murder Mystery</strong>
</p>
<p><strong>Saturday, September 10 at 7pm.</strong>
</p>
<p><strong>Tickets are $10 in advance, $12 the day of show.</strong>
</p>
<p><strong><br></strong>
</p>
<p><strong>To get the full Norfolk Comedy Festival Line-Up, got to <a href="http://www.norfolkcomedyfestival.com" rel="nofollow" target="_blank">www.norfolkcomedyfestival.com</a></strong>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing NCF:  Who Dunnit? ...The Improvised Murder Mystery ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "BKP7JM",
    title: "NCF:  Who Dunnit? ...The Improvised Murder Mystery",
    description: """
    <p><strong>Get ready for a spine tingling murder mystery!!!</strong>
</p>
<p>There’s a killer on the loose… can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery… a dastardly villain, shifty suspects and an intrepid detective.
</p>
<p>…And it will all be made up on the spot!!!
</p>
<p><strong>Who Dunnit? …The Improvised Murder Mystery</strong> is the Push Comedy Theater’s hit show.  It’s had sold out crowds howling with laughter 11 months in a row.  Don’t miss this very special Norfolk Comedy Festival edition.
</p>
<p><strong></strong>
</p>
<p>The Norfolk Comedy Festival is proud to present<br><strong>Who Dunnit? …The Improvised Murder Mystery</strong>
</p>
<p><strong>Saturday, September 10 at 7pm.</strong>
</p>
<p><strong>Tickets are $10 in advance, $12 the day of show.</strong>
</p>
<p><strong><br></strong>
</p>
<p><strong>To get the full Norfolk Comedy Festival Line-Up, got to <a href="http://www.norfolkcomedyfestival.com" rel="nofollow" target="_blank">www.norfolkcomedyfestival.com</a></strong>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-10T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-10T20:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/5b80d55d-4a73-4eeb-85ef-46f8a779a3fa",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/5b80d55d-4a73-4eeb-85ef-46f8a779a3fa",
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

# Insert ncf
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "ncf"
})
Logger.info "=========== Wrote tag ==========="

# Insert norfolk
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "norfolk"
})
Logger.info "=========== Wrote tag ==========="

# Insert comedy
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "comedy"
})
Logger.info "=========== Wrote tag ==========="

# Insert festival
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "festival"
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
    name: "Ticket for NCF:  Who Dunnit? ...The Improvised Murder Mystery",
    status: "available",
    description: "Ticket for NCF:  Who Dunnit? ...The Improvised Murder Mystery",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-31T02:53:27.496Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event NCF:  Who Dunnit? ...The Improvised Murder Mystery ==========="
Logger.info "=========== BEGIN Processing Universe Event The Bright Side Family Hour ==========="

Logger.info "=========== Writing Event The Bright Side Family Hour ==========="
event = SeedHelpers.create_event(
  %{
    slug: "0M6C8D",
    title: "The Bright Side Family Hour",
    description: """
    <p>The Bright Side Improv &amp; Sketch Comedy is excited to announce their very first Family Hour show on Sunday, October 11th, at Norfolk's Push Comedy Theater!!! The Family Hour show will feature high energy, hilarious sketch comedy suitable for the whole family (ages 8 and up)!!! Only $5!!!</p><p>The Bright Side is a sketch and long form improvisational comedy group from Norfolk, Va. </p><p>In early 2015, Andrea Bourguignon, Matt Cole, Brian Garraty, and Drew Richard decided to join forces and The Bright Side was born! The group describes their particular brand of comedy as a celebration of the absurd world in which we all exist. Audiences at a Bright Side show can expect to see polished and smart comedy that reflects the group members’ personal life experiences.</p><p>The Bright Side Family Hour, Sunday, October 11th, 5:00 PM</p><p>Come out to see and support one of Hampton Road's newest sketch comedy groups at the intimate Push Comedy Theater in the heart of Norfolk's new Neon Arts District.</p><p>Free parking available behind Virginia Furniture Company (745 Granby Street) and at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Bright Side Family Hour ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "0M6C8D",
    title: "The Bright Side Family Hour",
    description: """
    <p>The Bright Side Improv &amp; Sketch Comedy is excited to announce their very first Family Hour show on Sunday, October 11th, at Norfolk's Push Comedy Theater!!! The Family Hour show will feature high energy, hilarious sketch comedy suitable for the whole family (ages 8 and up)!!! Only $5!!!</p><p>The Bright Side is a sketch and long form improvisational comedy group from Norfolk, Va. </p><p>In early 2015, Andrea Bourguignon, Matt Cole, Brian Garraty, and Drew Richard decided to join forces and The Bright Side was born! The group describes their particular brand of comedy as a celebration of the absurd world in which we all exist. Audiences at a Bright Side show can expect to see polished and smart comedy that reflects the group members’ personal life experiences.</p><p>The Bright Side Family Hour, Sunday, October 11th, 5:00 PM</p><p>Come out to see and support one of Hampton Road's newest sketch comedy groups at the intimate Push Comedy Theater in the heart of Norfolk's new Neon Arts District.</p><p>Free parking available behind Virginia Furniture Company (745 Granby Street) and at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-10-11T16:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-10-11T17:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/a7757032-c730-418f-916b-14c34d1ad812",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/a7757032-c730-418f-916b-14c34d1ad812",
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

# Insert family
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "family"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Bright Side Family Hour",
    status: "available",
    description: "Ticket for The Bright Side Family Hour",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2015-10-05T19:05:56.705Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Bright Side Family Hour ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="

Logger.info "=========== Writing Event The Improv Riot: The Short Form Improv Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "4G3FZL",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.</p><p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.</p><p><strong style="background-color: initial;">The Improv Riot: The Short Form Improv Show</strong></p><p>Friday, April 22nd, 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the parking lot directly across from the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "4G3FZL",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.</p><p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.</p><p><strong style="background-color: initial;">The Improv Riot: The Short Form Improv Show</strong></p><p>Friday, April 22nd, 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the parking lot directly across from the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-22T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-22T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-29T03:12:13.268Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Harold Night ==========="

Logger.info "=========== Writing Event Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "TSKGFW",
    title: "Harold Night",
    description: """
    <p><strong>It's Harold Night at the Push Comedy Theater!</strong><br> <br> So who the heck is Harold? More accurately the question should be... what the heck is a Harold?<br> <br>  The Harold is the big, bad grand daddy of all long form improv! It  starts with an audience suggestion, then improvisers weave together  scenes, characters and group games to create a seamless piece. It can be  bizarre and magical, baffling and amazing... it definitely needs to be  seen.<br> This month don't miss house teams The Cahoots and Third Choice<br> <br> <strong>Harold Night</strong><br>Friday, June 24th at 10:00pm<br>Tickets are $5<br> <br> The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br> <br>  Free parking available at Slone Chiropractic (111 W Virginia Beach)  just one block from the theater. There is also limited parking on the  street.<br> <br> --<br> <br> The Push Comedy Theater is a 99 seat venue  in the heart of Norfolk's brand new Arts District. Founded by local  comedy group The Pushers, the Push Comedy Theater is dedicated to  bringing you live comedy from the best local and national acts.<br> <br>  The Push Comedy Theater hosts live sketch, improv and stand-up comedy  on Friday and Saturday nights. During the week classesare offered in  stand-up, sketch and improv comedy as well as acting.<br> </p><p>Whether  you're a die-hard comedy lover or a casual fan... a seasoned performer  or someone who's never stepped foot on stage... the Push Comedy Theater  has something for you.</p>
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
    slug: "TSKGFW",
    title: "Harold Night",
    description: """
    <p><strong>It's Harold Night at the Push Comedy Theater!</strong><br> <br> So who the heck is Harold? More accurately the question should be... what the heck is a Harold?<br> <br>  The Harold is the big, bad grand daddy of all long form improv! It  starts with an audience suggestion, then improvisers weave together  scenes, characters and group games to create a seamless piece. It can be  bizarre and magical, baffling and amazing... it definitely needs to be  seen.<br> This month don't miss house teams The Cahoots and Third Choice<br> <br> <strong>Harold Night</strong><br>Friday, June 24th at 10:00pm<br>Tickets are $5<br> <br> The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br> <br>  Free parking available at Slone Chiropractic (111 W Virginia Beach)  just one block from the theater. There is also limited parking on the  street.<br> <br> --<br> <br> The Push Comedy Theater is a 99 seat venue  in the heart of Norfolk's brand new Arts District. Founded by local  comedy group The Pushers, the Push Comedy Theater is dedicated to  bringing you live comedy from the best local and national acts.<br> <br>  The Push Comedy Theater hosts live sketch, improv and stand-up comedy  on Friday and Saturday nights. During the week classesare offered in  stand-up, sketch and improv comedy as well as acting.<br> </p><p>Whether  you're a die-hard comedy lover or a casual fan... a seasoned performer  or someone who's never stepped foot on stage... the Push Comedy Theater  has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-24T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-24T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/3cfcf9ab-ac14-45eb-8a9e-f4b165ba7615",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/3cfcf9ab-ac14-45eb-8a9e-f4b165ba7615",
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
    name: "Ticket for Harold Night",
    status: "available",
    description: "Ticket for Harold Night",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-28T00:57:21.943Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Harold Night ==========="
