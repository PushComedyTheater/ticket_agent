require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event Harold Night ==========="

Logger.info "=========== Writing Event Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "3J821X",
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
<p>Friday, June 30th at 10:00pm
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
    slug: "3J821X",
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
<p>Friday, June 30th at 10:00pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-06-30T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-06-30T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-06-19T21:48:36.160Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Harold Night ==========="
Logger.info "=========== BEGIN Processing Universe Event Triple Threat: The Axis of Improv Integrity ==========="

Logger.info "=========== Writing Event Triple Threat: The Axis of Improv Integrity ==========="
event = SeedHelpers.create_event(
  %{
    slug: "1MJZ3B",
    title: "Triple Threat: The Axis of Improv Integrity",
    description: """
    <p>Normally Brad McMurran, Alba Woolard, and Sean Devereux spend their rehearsal time finding new and exciting ways to prank each other, push each other's buttons, and test each other's mental and emotional boundaries.</p>  For this show, these three improv teachers will join forces to test improvisational limits!!!  Triple Threat: The Axis of Improvisational Integrity Friday, April 8th, 8pm Tickets are $5 The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance. Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street. --- The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District. In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village. Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone. -- The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production. Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Triple Threat: The Axis of Improv Integrity ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "1MJZ3B",
    title: "Triple Threat: The Axis of Improv Integrity",
    description: """
    <p>Normally Brad McMurran, Alba Woolard, and Sean Devereux spend their rehearsal time finding new and exciting ways to prank each other, push each other's buttons, and test each other's mental and emotional boundaries.</p>  For this show, these three improv teachers will join forces to test improvisational limits!!!  Triple Threat: The Axis of Improvisational Integrity Friday, April 8th, 8pm Tickets are $5 The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance. Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street. --- The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District. In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village. Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone. -- The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production. Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-08T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-08T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/f3a220f7-118f-4397-9e85-9c6def756d86",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/f3a220f7-118f-4397-9e85-9c6def756d86",
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
    name: "Ticket for Triple Threat: The Axis of Improv Integrity",
    status: "available",
    description: "Ticket for Triple Threat: The Axis of Improv Integrity",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-06T22:35:23.160Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Triple Threat: The Axis of Improv Integrity ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 501 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 501 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "8W20QF",
    title: "Class Dismissed: The Improv 501 Graduation Show",
    description: """
    <p>Get ready for a colossal night of comedy and mayhem at the Push Comedy Theater, brought to you by some of Hampton Roads' finest improvisers.</p><p>Don't miss this improv extravaganza, brought to you by the Push's upperclassmen. </p><p><strong>Class Dismissed: The Improv 501 Graduation Show</strong> </p><p>Thursday , November 12th at 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/8d656ed892236a8b2d19757c831aff25-class501.jpg"></p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "8W20QF",
    title: "Class Dismissed: The Improv 501 Graduation Show",
    description: """
    <p>Get ready for a colossal night of comedy and mayhem at the Push Comedy Theater, brought to you by some of Hampton Roads' finest improvisers.</p><p>Don't miss this improv extravaganza, brought to you by the Push's upperclassmen. </p><p><strong>Class Dismissed: The Improv 501 Graduation Show</strong> </p><p>Thursday , November 12th at 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/8d656ed892236a8b2d19757c831aff25-class501.jpg"></p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-03-31T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-03-31T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bd2a7da0-ccce-4005-a5d2-90147f2b158e",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bd2a7da0-ccce-4005-a5d2-90147f2b158e",
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-25T02:24:31.208Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 501 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event A Tribute to John Sharp ==========="

Logger.info "=========== Writing Event A Tribute to John Sharp ==========="
event = SeedHelpers.create_event(
  %{
    slug: "3M24WB",
    title: "A Tribute to John Sharp",
    description: """
    <p><strong>John Sharp</strong> was a hilarious and beloved member of the Push Comedy Theater family.   He was a joy to watch and perform with on stage... and we were honored to call him our friend.
</p>
<p>When we last saw John, he said "No p#ssy crying when I die, only laughs."   We of course are going to honor his wishes.
</p>
<p>We have gathered John's funny friends from across Hampton Roads for a night of sketch, improv and stand up comedy.
</p>
<p><strong>A Tribute to John Sharp</strong>
</p>
<p>Thursday, June 23rd at 8pm
</p>
<p>All the money from tickets, food and beverage sales will go to John's family to help pay for funeral costs.
</p>
<p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/07547e3d3c10d77bddee8b2732c3daf8-John.png"><br>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing A Tribute to John Sharp ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "3M24WB",
    title: "A Tribute to John Sharp",
    description: """
    <p><strong>John Sharp</strong> was a hilarious and beloved member of the Push Comedy Theater family.   He was a joy to watch and perform with on stage... and we were honored to call him our friend.
</p>
<p>When we last saw John, he said "No p#ssy crying when I die, only laughs."   We of course are going to honor his wishes.
</p>
<p>We have gathered John's funny friends from across Hampton Roads for a night of sketch, improv and stand up comedy.
</p>
<p><strong>A Tribute to John Sharp</strong>
</p>
<p>Thursday, June 23rd at 8pm
</p>
<p>All the money from tickets, food and beverage sales will go to John's family to help pay for funeral costs.
</p>
<p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/07547e3d3c10d77bddee8b2732c3daf8-John.png"><br>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-23T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-23T22:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/51b6943e-1314-4aa1-9e6f-7e263f77cb37",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/51b6943e-1314-4aa1-9e6f-7e263f77cb37",
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
    name: "Ticket for A Tribute to John Sharp",
    status: "available",
    description: "Ticket for A Tribute to John Sharp",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-06-15T23:28:07.417Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event A Tribute to John Sharp ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 201 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 201 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "HWYGD0",
    title: "Class Dismissed: The Improv 201 Graduation Show",
    description: """
    <p><strong></strong><strong>Dust off those caps and gowns... because it's graduation time at the Push.</strong>
</p>
<p>Check out the Push Comedy Theater's Improv 201 class as they show off their comedy chops.
</p>
<p>Watch as these brave 201 souls dive head first into the wonderful world of The Harold. So who the heck is Harold? More accurately the question should be... what the heck is a Harold?
</p>
<p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.
</p>
<p><strong>Class Dismissed: The Improv 201 Graduation Show </strong><br>Tuesday, January 3rd at 8pm<br>Tickets are $5
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
Logger.info "=========== Writing Event Listing Class Dismissed: The Improv 201 Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "HWYGD0",
    title: "Class Dismissed: The Improv 201 Graduation Show",
    description: """
    <p><strong></strong><strong>Dust off those caps and gowns... because it's graduation time at the Push.</strong>
</p>
<p>Check out the Push Comedy Theater's Improv 201 class as they show off their comedy chops.
</p>
<p>Watch as these brave 201 souls dive head first into the wonderful world of The Harold. So who the heck is Harold? More accurately the question should be... what the heck is a Harold?
</p>
<p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.
</p>
<p><strong>Class Dismissed: The Improv 201 Graduation Show </strong><br>Tuesday, January 3rd at 8pm<br>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-01-03T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-01-03T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-12-23T06:47:18.226Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 201 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Couples Therapy ==========="

Logger.info "=========== Writing Event Couples Therapy ==========="
event = SeedHelpers.create_event(
  %{
    slug: "F2TB1K",
    title: "Couples Therapy",
    description: """
    <p>You think your relationship has problems?!?
</p>
<p><br><br>In Couples Therapy you'll meet a couple on the rocks... be it newlyweds on a honeymoon from hell or an elderly couple at the end of their rope.<br>Based on an audience suggestion, Sean and Brittany take you through a roller coaster ride of emotions as they whisk you the trials and tribulations of couple they create right before your eyes.
</p>
<p><br><br>Oh yeah, and they do it all in a single, 25 minute long improvised scene.
</p>
<p><br><br>Two Improvisers... One Scene!!!
</p>
<p><br><br>Couples Therapy... is sometimes hilarious, sometimes poignant, always magical.
</p>
<p><br><br>Sean Devereux and Brittany Shearer are members of the improv group, Alan Johnson and the Johnson Quintet. The duo have dazzled audience members at Improvageddon, and now they're getting their own show.
</p>
<p><br><br>When not performing with the Quintet, Sean is a member of The Pushers and Brittany performs with The Pre Madonnas.
</p>
<p><br><br>Sean and Brittany are not a couple in real life, but occasionally they play one on stage.
</p>
<p><br><br>Couples Therapy with Alan Johnson and the Alan Johnson Quintet<br>Saturday, September 24th at 8pm<br>Tickets are $5
</p>
<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p><br><br>---
</p>
<p><br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p><br><br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.
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
Logger.info "=========== Writing Event Listing Couples Therapy ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "F2TB1K",
    title: "Couples Therapy",
    description: """
    <p>You think your relationship has problems?!?
</p>
<p><br><br>In Couples Therapy you'll meet a couple on the rocks... be it newlyweds on a honeymoon from hell or an elderly couple at the end of their rope.<br>Based on an audience suggestion, Sean and Brittany take you through a roller coaster ride of emotions as they whisk you the trials and tribulations of couple they create right before your eyes.
</p>
<p><br><br>Oh yeah, and they do it all in a single, 25 minute long improvised scene.
</p>
<p><br><br>Two Improvisers... One Scene!!!
</p>
<p><br><br>Couples Therapy... is sometimes hilarious, sometimes poignant, always magical.
</p>
<p><br><br>Sean Devereux and Brittany Shearer are members of the improv group, Alan Johnson and the Johnson Quintet. The duo have dazzled audience members at Improvageddon, and now they're getting their own show.
</p>
<p><br><br>When not performing with the Quintet, Sean is a member of The Pushers and Brittany performs with The Pre Madonnas.
</p>
<p><br><br>Sean and Brittany are not a couple in real life, but occasionally they play one on stage.
</p>
<p><br><br>Couples Therapy with Alan Johnson and the Alan Johnson Quintet<br>Saturday, September 24th at 8pm<br>Tickets are $5
</p>
<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p><br><br>---
</p>
<p><br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p><br><br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.
</p>
<p><br><br>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-24T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-24T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/496fbc13-a69a-41cb-82ca-5d4cbcc3e5a2",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/496fbc13-a69a-41cb-82ca-5d4cbcc3e5a2",
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-09-16T14:29:05.926Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Couples Therapy ==========="
Logger.info "=========== BEGIN Processing Universe Event 3 on 3 Improv Tournament - The Final Four ==========="

Logger.info "=========== Writing Event 3 on 3 Improv Tournament - The Final Four ==========="
event = SeedHelpers.create_event(
  %{
    slug: "QMNLCS",
    title: "3 on 3 Improv Tournament - The Final Four",
    description: """
    <p><strong></strong><strong>IT'S MARCH MADNESS AT THE PUSH!!!</strong></p><p>We're proud to announce the inaugural Push Comedy Theater 3 on 3 Improv Tournament. </p><p>We started with 16 teams... 12 left in defeat and shame.<br>Only 4 remain!!! We've had upsets! We've had controversy! We've had some of the most amazing improv in Push history.</p><p>Don't miss this elimination style competition for 3 on 3 improv supremacy! Will one of the improv powerhouses be crowned champion, or will a Cinderella story take it all? </p><p>For the Final Four, each team will be given just 15 minutes to dazzle both the audience and our secret panel of judges with their improv skills.</p><p><br><strong>3 on 3 Improv Tournament - The Final Four</strong><br>Friday, March 25th, 8pm at the Push Comedy Theater<br>Tickets are $5</p><p>This event is going to be huge, so get your tickets now.</p>
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
    slug: "QMNLCS",
    title: "3 on 3 Improv Tournament - The Final Four",
    description: """
    <p><strong></strong><strong>IT'S MARCH MADNESS AT THE PUSH!!!</strong></p><p>We're proud to announce the inaugural Push Comedy Theater 3 on 3 Improv Tournament. </p><p>We started with 16 teams... 12 left in defeat and shame.<br>Only 4 remain!!! We've had upsets! We've had controversy! We've had some of the most amazing improv in Push history.</p><p>Don't miss this elimination style competition for 3 on 3 improv supremacy! Will one of the improv powerhouses be crowned champion, or will a Cinderella story take it all? </p><p>For the Final Four, each team will be given just 15 minutes to dazzle both the audience and our secret panel of judges with their improv skills.</p><p><br><strong>3 on 3 Improv Tournament - The Final Four</strong><br>Friday, March 25th, 8pm at the Push Comedy Theater<br>Tickets are $5</p><p>This event is going to be huge, so get your tickets now.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-03-25T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-03-25T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-13T17:36:44.751Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event 3 on 3 Improv Tournament - The Final Four ==========="
Logger.info "=========== BEGIN Processing Universe Event Double Feature: The Totally Improvised Movie ==========="

Logger.info "=========== Writing Event Double Feature: The Totally Improvised Movie ==========="
event = SeedHelpers.create_event(
  %{
    slug: "J6KQTS",
    title: "Double Feature: The Totally Improvised Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong></p><p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.</p><p><strong><br>Double Feature: The Totally Improvised Movie</strong><br>Friday, December 4th, 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.</p><p><br>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Double Feature: The Totally Improvised Movie ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "J6KQTS",
    title: "Double Feature: The Totally Improvised Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong></p><p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.</p><p><strong><br>Double Feature: The Totally Improvised Movie</strong><br>Friday, December 4th, 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.</p><p><br>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-12-04T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-12-04T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1172bce3-0965-4133-8c91-794b43952305",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1172bce3-0965-4133-8c91-794b43952305",
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
    name: "Ticket for Double Feature: The Totally Improvised Movie",
    status: "available",
    description: "Ticket for Double Feature: The Totally Improvised Movie",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-27T06:11:53.382Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Double Feature: The Totally Improvised Movie ==========="
Logger.info "=========== BEGIN Processing Universe Event NCF Workshop: Improv Booster Shot- Andy Livengood ==========="

Logger.info "=========== Writing Event NCF Workshop: Improv Booster Shot- Andy Livengood ==========="
event = SeedHelpers.create_event(
  %{
    slug: "ZJWXB5",
    title: "NCF Workshop: Improv Booster Shot- Andy Livengood",
    description: """
    <p>You know how to yes, and. You can heighten with the best of them. You can spot a game from a mile away. So now what? It's time for a Booster Shot! This exciting workshop combines fun exercises and scene specific feedback to help kick your improv to the next level! This class will focus on building better characters, creating stronger games, and having more fun in your improv scenes. Aren't you overdue for your booster shot?
</p>
<p>Andy Livengood
</p>
<p>Andy has been performing improv for over a decade. In that time he has studied at Theatre 99 (Charleston, SC), The Annoyance Theatre (Chicago), and The Upright Citizens Brigade Theatre (NY). He regularly performs at Theatre 99 where he was a founding member of the groups CLUTCH and Cats Hugging Cats. In 2010 Andy was voted Charleston's best comic. He is a massive improv nerd and will always geek out with fellow improvisers at bars after shows.
</p>
<p>Improv Booster Shot with Andy Livengood
</p>
<p>Saturday, September 10th at 10am
</p>
<p>Cost: $40
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing NCF Workshop: Improv Booster Shot- Andy Livengood ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "ZJWXB5",
    title: "NCF Workshop: Improv Booster Shot- Andy Livengood",
    description: """
    <p>You know how to yes, and. You can heighten with the best of them. You can spot a game from a mile away. So now what? It's time for a Booster Shot! This exciting workshop combines fun exercises and scene specific feedback to help kick your improv to the next level! This class will focus on building better characters, creating stronger games, and having more fun in your improv scenes. Aren't you overdue for your booster shot?
</p>
<p>Andy Livengood
</p>
<p>Andy has been performing improv for over a decade. In that time he has studied at Theatre 99 (Charleston, SC), The Annoyance Theatre (Chicago), and The Upright Citizens Brigade Theatre (NY). He regularly performs at Theatre 99 where he was a founding member of the groups CLUTCH and Cats Hugging Cats. In 2010 Andy was voted Charleston's best comic. He is a massive improv nerd and will always geek out with fellow improvisers at bars after shows.
</p>
<p>Improv Booster Shot with Andy Livengood
</p>
<p>Saturday, September 10th at 10am
</p>
<p>Cost: $40
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-10T10:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-10T12:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/4bca7f57-86b2-45d7-a5de-37a69762970c",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/4bca7f57-86b2-45d7-a5de-37a69762970c",
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

# Insert workshop
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "workshop"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for NCF Workshop: Improv Booster Shot- Andy Livengood",
    status: "available",
    description: "Ticket for NCF Workshop: Improv Booster Shot- Andy Livengood",
    price: 4000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-31T20:47:12.851Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event NCF Workshop: Improv Booster Shot- Andy Livengood ==========="
Logger.info "=========== BEGIN Processing Universe Event The Party Crashers Present: One Year Later ==========="

Logger.info "=========== Writing Event The Party Crashers Present: One Year Later ==========="
event = SeedHelpers.create_event(
  %{
    slug: "L7YV24",
    title: "The Party Crashers Present: One Year Later",
    description: """
    <p>Alas, it has already been a year since 5 members of Push Comedy Theater banded together to form an improv group like no other... The Party Crashers. (That's us!)
</p>
<p><br><br>We will be working out some new ideas to ready ourselves for The Cape Fear Comedy Festival in Willmington NC in late May, so come expiriment with us like you did in college!
</p>
<p><br><br>Be our party guests as we celebrate our One Year Anniversary Saturday, April 21 at 10pm.<br>---
</p>
<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p><br><br>---
</p>
<p><br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p><br><br>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.
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
Logger.info "=========== Writing Event Listing The Party Crashers Present: One Year Later ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "L7YV24",
    title: "The Party Crashers Present: One Year Later",
    description: """
    <p>Alas, it has already been a year since 5 members of Push Comedy Theater banded together to form an improv group like no other... The Party Crashers. (That's us!)
</p>
<p><br><br>We will be working out some new ideas to ready ourselves for The Cape Fear Comedy Festival in Willmington NC in late May, so come expiriment with us like you did in college!
</p>
<p><br><br>Be our party guests as we celebrate our One Year Anniversary Saturday, April 21 at 10pm.<br>---
</p>
<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p><br><br>---
</p>
<p><br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p><br><br>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p><br><br>
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-04-21T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-04-21T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/dd9f97e2-e008-452c-bc51-58dbc49fef74",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/dd9f97e2-e008-452c-bc51-58dbc49fef74",
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

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Party Crashers Present: One Year Later",
    status: "available",
    description: "Ticket for The Party Crashers Present: One Year Later",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-04-18T12:47:02.919Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Party Crashers Present: One Year Later ==========="
Logger.info "=========== BEGIN Processing Universe Event Second Saturday Stand-Up ==========="

Logger.info "=========== Writing Event Second Saturday Stand-Up ==========="
event = SeedHelpers.create_event(
  %{
    slug: "HQJXGC",
    title: "Second Saturday Stand-Up",
    description: """
    <p><strong>Second Saturday Stand-Up</strong>
</p>
<p>This once-a-month show is brought to you by almost-jaded veteran comic, <strong>Hatton Jordan </strong>who sets the lineup with proven comedians delivering road-tested jokes while they squeeze in new material.
</p>
<p>This is NOT a "open mic" .....it's selected talent working on their craft. Every month is a new seasoned lineup.
</p>
<p><strong><br></strong>
</p>
<p><strong>Scheduled: </strong>
</p>
<p><strong>Host: Brandan Kennedy </strong>
</p>
<p><strong> </strong>
</p>
<p>Justin King
</p>
<p>Joel Palilla
</p>
<p>Henry Pounders
</p>
<p>Jon Kranz
</p>
<p>Derrick Brooks
</p>
<p>David Beck
</p>
<p><strong><br></strong>
</p>
<p><strong>Second Saturday Stand-Up</strong>
</p>
<p>Saturday, August 12th at 10pm
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
    slug: "HQJXGC",
    title: "Second Saturday Stand-Up",
    description: """
    <p><strong>Second Saturday Stand-Up</strong>
</p>
<p>This once-a-month show is brought to you by almost-jaded veteran comic, <strong>Hatton Jordan </strong>who sets the lineup with proven comedians delivering road-tested jokes while they squeeze in new material.
</p>
<p>This is NOT a "open mic" .....it's selected talent working on their craft. Every month is a new seasoned lineup.
</p>
<p><strong><br></strong>
</p>
<p><strong>Scheduled: </strong>
</p>
<p><strong>Host: Brandan Kennedy </strong>
</p>
<p><strong> </strong>
</p>
<p>Justin King
</p>
<p>Joel Palilla
</p>
<p>Henry Pounders
</p>
<p>Jon Kranz
</p>
<p>Derrick Brooks
</p>
<p>David Beck
</p>
<p><strong><br></strong>
</p>
<p><strong>Second Saturday Stand-Up</strong>
</p>
<p>Saturday, August 12th at 10pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-08-12T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-08-12T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-08-06T00:27:50.950Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Second Saturday Stand-Up ==========="
Logger.info "=========== BEGIN Processing Universe Event Couples Therapy ==========="

Logger.info "=========== Writing Event Couples Therapy ==========="
event = SeedHelpers.create_event(
  %{
    slug: "HNZ2L1",
    title: "Couples Therapy",
    description: """
    <p><strong></strong><strong>You think your relationship has problems?!?</strong></p><p>In Couples Therapy you'll meet a couple on the rocks... be it newlyweds on a honeymen from hell or an elderly couple at the end of their rope.<br>Based on an audience suggestion, Sean and Brittany take you through a roller coaster ride of emotions as they whisk you the trials and tribulations of couple they create right before your eyes.</p><p>Oh yeah, and they do it all in a single, 25 minute long improvised scene.</p><p>Two Improvisers... One Scene!!!</p><p><strong>Couples Therapy... is sometimes hilarious, sometimes poignant, always magical.</strong></p><p>Sean Devereux and Brittany Shearer are members of the improv group, Alan Johnson and the Johnson Quintet. The duo have dazzled audience members at Improvageddon, and now they're getting their own show.</p><p>When not performing with the Quintet, Sean is a member of The Pushers and Brittany performs with The Pre Madonnas.</p><p>Sean and Brittany are not a couple in real life, but occasionally they play one on stage.</p><p><strong>Couples Therapy with Alan Johnson and the Alan Johnson Quintet</strong><br>Saturday, February 27th at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "HNZ2L1",
    title: "Couples Therapy",
    description: """
    <p><strong></strong><strong>You think your relationship has problems?!?</strong></p><p>In Couples Therapy you'll meet a couple on the rocks... be it newlyweds on a honeymen from hell or an elderly couple at the end of their rope.<br>Based on an audience suggestion, Sean and Brittany take you through a roller coaster ride of emotions as they whisk you the trials and tribulations of couple they create right before your eyes.</p><p>Oh yeah, and they do it all in a single, 25 minute long improvised scene.</p><p>Two Improvisers... One Scene!!!</p><p><strong>Couples Therapy... is sometimes hilarious, sometimes poignant, always magical.</strong></p><p>Sean Devereux and Brittany Shearer are members of the improv group, Alan Johnson and the Johnson Quintet. The duo have dazzled audience members at Improvageddon, and now they're getting their own show.</p><p>When not performing with the Quintet, Sean is a member of The Pushers and Brittany performs with The Pre Madonnas.</p><p>Sean and Brittany are not a couple in real life, but occasionally they play one on stage.</p><p><strong>Couples Therapy with Alan Johnson and the Alan Johnson Quintet</strong><br>Saturday, February 27th at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-02-27T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-02-27T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-02-08T04:08:48.583Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Couples Therapy ==========="
Logger.info "=========== BEGIN Processing Universe Event 3 on 3 Improv Tournament - Sweet 16 Eastern Region ==========="

Logger.info "=========== Writing Event 3 on 3 Improv Tournament - Sweet 16 Eastern Region ==========="
event = SeedHelpers.create_event(
  %{
    slug: "ZGP24B",
    title: "3 on 3 Improv Tournament - Sweet 16 Eastern Region",
    description: """
    <p><strong></strong><strong>IT'S MARCH MADNESS AT THE PUSH!!!</strong></p><p>We're proud to announce the inaugural Push Comedy Theater 3 on 3 Improv Tournament. </p><p>Don't miss it as 16 teams battle it out in an elimination style competition for 3 on 3 improv supremacy! Will one of the improv powerhouses be crowned champion, or will a Cinderella story take it all? </p><p>It all starts with the sweet 16! <br>Each team will be given just five minutes to dazzle both the audience and our secret panel of judges with their improv skills.</p><p>Don't miss these great match ups:</p><p><strong>Eastern Region </strong><br>#1) 1,000 Likes vs #8)<br>#2) E3 vs #7) ADA<br>#3) What About Bobby vs #6) Itty Bitty Witty Committee<br>#4) Donna Lewis and the Boys vs #5) Anti-Social Network</p><p><strong>3 on 3 Improv Tournament - Sweet 16 Eastern Region</strong><br>Friday, 8pm at the Push Comedy Theater<br>Tickets are $5</p><p>This event is going to be huge, so get your tickets now.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing 3 on 3 Improv Tournament - Sweet 16 Eastern Region ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "ZGP24B",
    title: "3 on 3 Improv Tournament - Sweet 16 Eastern Region",
    description: """
    <p><strong></strong><strong>IT'S MARCH MADNESS AT THE PUSH!!!</strong></p><p>We're proud to announce the inaugural Push Comedy Theater 3 on 3 Improv Tournament. </p><p>Don't miss it as 16 teams battle it out in an elimination style competition for 3 on 3 improv supremacy! Will one of the improv powerhouses be crowned champion, or will a Cinderella story take it all? </p><p>It all starts with the sweet 16! <br>Each team will be given just five minutes to dazzle both the audience and our secret panel of judges with their improv skills.</p><p>Don't miss these great match ups:</p><p><strong>Eastern Region </strong><br>#1) 1,000 Likes vs #8)<br>#2) E3 vs #7) ADA<br>#3) What About Bobby vs #6) Itty Bitty Witty Committee<br>#4) Donna Lewis and the Boys vs #5) Anti-Social Network</p><p><strong>3 on 3 Improv Tournament - Sweet 16 Eastern Region</strong><br>Friday, 8pm at the Push Comedy Theater<br>Tickets are $5</p><p>This event is going to be huge, so get your tickets now.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-03-11T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-03-11T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/70fe8a03-210d-4c0e-b849-b3182f8402e4",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/70fe8a03-210d-4c0e-b849-b3182f8402e4",
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
    name: "Ticket for 3 on 3 Improv Tournament - Sweet 16 Eastern Region",
    status: "available",
    description: "Ticket for 3 on 3 Improv Tournament - Sweet 16 Eastern Region",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-03T05:07:04.415Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event 3 on 3 Improv Tournament - Sweet 16 Eastern Region ==========="
Logger.info "=========== BEGIN Processing Universe Event The Dudes: Out of Our Element ==========="

Logger.info "=========== Writing Event The Dudes: Out of Our Element ==========="
event = SeedHelpers.create_event(
  %{
    slug: "0NS6J7",
    title: "The Dudes: Out of Our Element",
    description: """
    <p>The Dudes are packing their dirty undies, popping in some Creedence, and driving up to Richmond for The 2nd Best Comedy Fest... but before we do, come have some fun with us for a night of easy-going laughs at The Push Comedy Theater!</p><p>The Dudes are bunch of guys who like to drink beer, talk dude things, and perfom improv comedy. They're multi-IMPROVAGEDDON champions and they have an oscillating fan for some reason.</p><p>Don't miss a night of Dude-inspired comedy, with an appearance from super secret special guest dude(s) and/or dudette(s) !</p><p>The Dudes Improvasitional Comedy are:</p><p>Rafael <br>Adam Paine<br>James Roach<br>Matt Cole <br>Brian Garraty<br>Anthony Nobles</p><p><strong>The Dudes: Out of Our Element</strong><br>Friday, June 3rd at 10pm<br>Tickets are $5</p><p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Dudes: Out of Our Element ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "0NS6J7",
    title: "The Dudes: Out of Our Element",
    description: """
    <p>The Dudes are packing their dirty undies, popping in some Creedence, and driving up to Richmond for The 2nd Best Comedy Fest... but before we do, come have some fun with us for a night of easy-going laughs at The Push Comedy Theater!</p><p>The Dudes are bunch of guys who like to drink beer, talk dude things, and perfom improv comedy. They're multi-IMPROVAGEDDON champions and they have an oscillating fan for some reason.</p><p>Don't miss a night of Dude-inspired comedy, with an appearance from super secret special guest dude(s) and/or dudette(s) !</p><p>The Dudes Improvasitional Comedy are:</p><p>Rafael <br>Adam Paine<br>James Roach<br>Matt Cole <br>Brian Garraty<br>Anthony Nobles</p><p><strong>The Dudes: Out of Our Element</strong><br>Friday, June 3rd at 10pm<br>Tickets are $5</p><p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-03T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-03T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/931577dc-5fd5-464f-97d6-919ec5d47699",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/931577dc-5fd5-464f-97d6-919ec5d47699",
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
    name: "Ticket for The Dudes: Out of Our Element",
    status: "available",
    description: "Ticket for The Dudes: Out of Our Element",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-26T19:20:22.449Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Dudes: Out of Our Element ==========="
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="

Logger.info "=========== Writing Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
event = SeedHelpers.create_event(
  %{
    slug: "8127H0",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, July 29th
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
    slug: "8127H0",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, July 29th
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
    start_at:  NaiveDateTime.from_iso8601!("2017-07-29T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-29T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-21T17:18:31.555Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
Logger.info "=========== BEGIN Processing Universe Event Teacher's Pet ==========="

Logger.info "=========== Writing Event Teacher's Pet ==========="
event = SeedHelpers.create_event(
  %{
    slug: "M6WF1L",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Friday, August 11th, 10pm<br>Tickets are $5
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
    slug: "M6WF1L",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Friday, August 11th, 10pm<br>Tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2017-08-11T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-08-11T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-08-06T00:10:49.812Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Teacher's Pet ==========="
Logger.info "=========== BEGIN Processing Universe Event New Harold Night - Free Show ==========="

Logger.info "=========== Writing Event New Harold Night - Free Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "YGDLXJ",
    title: "New Harold Night - Free Show",
    description: """
    <p><strong></strong><strong>It's New Harold Night at the Push Comedy Theater!</strong></p><p>Don't miss it as we unveil our brand, new house teams... Star 69 and Third Choice!!!</p><p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p><strong>New Harold Night </strong><br>Friday, January 29th, 10pm<br>Tickets are $5.</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing New Harold Night - Free Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "YGDLXJ",
    title: "New Harold Night - Free Show",
    description: """
    <p><strong></strong><strong>It's New Harold Night at the Push Comedy Theater!</strong></p><p>Don't miss it as we unveil our brand, new house teams... Star 69 and Third Choice!!!</p><p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p><strong>New Harold Night </strong><br>Friday, January 29th, 10pm<br>Tickets are $5.</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-01-30T18:30:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-01-30T20:00:00.000-05:00")
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

# Insert free
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "free"
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
    name: "Ticket for New Harold Night - Free Show",
    status: "available",
    description: "Ticket for New Harold Night - Free Show",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2016-01-26T16:59:41.280Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event New Harold Night - Free Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Pushers Unscripted ==========="

Logger.info "=========== Writing Event The Pushers Unscripted ==========="
event = SeedHelpers.create_event(
  %{
    slug: "YHFPSQ",
    title: "The Pushers Unscripted",
    description: """
    <p>The Pushers are back!!!!
</p>
<p>Don't miss Hampton Roads' kings (and queen) of comedy as they unveil a never-before-seen/never-to-be-seen-again show.
</p>
<p>You give us a word... we give you a night of comedy made up on the spot, right before your eyes.
</p>
<p>That's right! We're going full improv!
</p>
<p>It's a once in a lifetime show you've never seen before... and you'll never see again. That's the beauty of improv.
</p>
<p>The Pushers Unscripted
</p>
<p>Friday, December 16th at 10pm
</p>
<p>Tickets are $5
</p>
<p><br>
</p>
<p>763 Granby Street
</p>
<p>Norfolk, VA
</p>
<p>757-333-7442
</p>
<p><br>
</p>
<p>pushcomedytheater.com
</p>
<p><br>
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br>
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>---
</p>
<p><strong>The Pushers </strong>are Virginia's premiere sketch and improv comedy group. For more than ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In November of 2014, they opened The Push Comedy Theater, located in the Norfolk Arts District.
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
Logger.info "=========== Writing Event Listing The Pushers Unscripted ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "YHFPSQ",
    title: "The Pushers Unscripted",
    description: """
    <p>The Pushers are back!!!!
</p>
<p>Don't miss Hampton Roads' kings (and queen) of comedy as they unveil a never-before-seen/never-to-be-seen-again show.
</p>
<p>You give us a word... we give you a night of comedy made up on the spot, right before your eyes.
</p>
<p>That's right! We're going full improv!
</p>
<p>It's a once in a lifetime show you've never seen before... and you'll never see again. That's the beauty of improv.
</p>
<p>The Pushers Unscripted
</p>
<p>Friday, December 16th at 10pm
</p>
<p>Tickets are $5
</p>
<p><br>
</p>
<p>763 Granby Street
</p>
<p>Norfolk, VA
</p>
<p>757-333-7442
</p>
<p><br>
</p>
<p>pushcomedytheater.com
</p>
<p><br>
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br>
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>---
</p>
<p><strong>The Pushers </strong>are Virginia's premiere sketch and improv comedy group. For more than ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In November of 2014, they opened The Push Comedy Theater, located in the Norfolk Arts District.
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
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-12-16T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-12-16T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/98bea607-2b53-4739-90d9-a0adc2e3b4c1",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/98bea607-2b53-4739-90d9-a0adc2e3b4c1",
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
    name: "Ticket for The Pushers Unscripted",
    status: "available",
    description: "Ticket for The Pushers Unscripted",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-12-11T23:17:59.054Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Pushers Unscripted ==========="
Logger.info "=========== BEGIN Processing Universe Event The Funeral (An Improvised Comedy Show) ==========="

Logger.info "=========== Writing Event The Funeral (An Improvised Comedy Show) ==========="
event = SeedHelpers.create_event(
  %{
    slug: "ZMV9LP",
    title: "The Funeral (An Improvised Comedy Show)",
    description: """
    <p><strong></strong><strong></strong>There's been a death in the family... and you're invited to the funeral. <br>The Funeral is a brand new form, conceived by Brad McMurran and the students of the Improv 501 class. The audience decides how the deceased died, then we show the trials and tribulations of their life... leading up to their untimely demise.
</p>
<p><br><br>The Funeral is a dark comedy that is sure to have you laughing to death.
</p>
<p><br>The Funeral (An Improvised Comedy Show)<br>Friday, August 5th at 8pm<br>Tickets are $5USS <i>Grissom</i>
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>--
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
Logger.info "=========== Writing Event Listing The Funeral (An Improvised Comedy Show) ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "ZMV9LP",
    title: "The Funeral (An Improvised Comedy Show)",
    description: """
    <p><strong></strong><strong></strong>There's been a death in the family... and you're invited to the funeral. <br>The Funeral is a brand new form, conceived by Brad McMurran and the students of the Improv 501 class. The audience decides how the deceased died, then we show the trials and tribulations of their life... leading up to their untimely demise.
</p>
<p><br><br>The Funeral is a dark comedy that is sure to have you laughing to death.
</p>
<p><br>The Funeral (An Improvised Comedy Show)<br>Friday, August 5th at 8pm<br>Tickets are $5USS <i>Grissom</i>
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-08-05T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-05T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bfae32e5-39e6-4122-afd4-aa7fb80be598",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bfae32e5-39e6-4122-afd4-aa7fb80be598",
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

# Insert funeral
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "funeral"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Funeral (An Improvised Comedy Show)",
    status: "available",
    description: "Ticket for The Funeral (An Improvised Comedy Show)",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-28T02:23:16.312Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Funeral (An Improvised Comedy Show) ==========="
Logger.info "=========== BEGIN Processing Universe Event Double Feature: The Made Up Movie ==========="

Logger.info "=========== Writing Event Double Feature: The Made Up Movie ==========="
event = SeedHelpers.create_event(
  %{
    slug: "LMC5J4",
    title: "Double Feature: The Made Up Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong></p><p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.</p><p><strong>Double Feature: The Totally Improvised Movie</strong><br>Saturday, June 4th at 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.</p><p><br>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "LMC5J4",
    title: "Double Feature: The Made Up Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong></p><p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.</p><p><strong>Double Feature: The Totally Improvised Movie</strong><br>Saturday, June 4th at 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.</p><p><br>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-04T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-04T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-19T22:01:41.991Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Double Feature: The Made Up Movie ==========="
