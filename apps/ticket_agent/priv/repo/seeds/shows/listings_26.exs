require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event Girl-Prov: Special Panties in a Twist Edition! ==========="

Logger.info "=========== Writing Event Girl-Prov: Special Panties in a Twist Edition! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "DJ1L4K",
    title: "Girl-Prov: Special Panties in a Twist Edition!",
    description: """
    <p><strong></strong><strong>GET READY FOR GIRL'S NIGHT WITH THE LADIES FROM PANTIES IN A TWIST!!!</strong>
</p>
<p>Move over, gentleman!
</p>
<p>The ladies are taking over for a girls' night!
</p>
<p>This month, our group will have extra special guests from the cast of Panties In a Twist: The All Female Sketch Comedy Show!
</p>
<p>GirlProv is an all-female improv show, making audiences lose it with laughter at the Push Comedy Theater.
</p>
<p>It's slumber party meets night out on the town meet sorority house party!
</p>
<p>Don't miss this night of comedy- all made up on the spot from the audience's suggestion!
</p>
<p>Girl-Prov: The Girls' Night of Improv
</p>
<p>Saturday, February 4th at the Push Comedy Theater
</p>
<p>The show starts at 8, tickets are $5
</p>
<p>For Information and Tickets to Panties in a Twist, visit:
</p>
<p>Pantiesinatwist.com
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
Logger.info "=========== Writing Event Listing Girl-Prov: Special Panties in a Twist Edition! ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "DJ1L4K",
    title: "Girl-Prov: Special Panties in a Twist Edition!",
    description: """
    <p><strong></strong><strong>GET READY FOR GIRL'S NIGHT WITH THE LADIES FROM PANTIES IN A TWIST!!!</strong>
</p>
<p>Move over, gentleman!
</p>
<p>The ladies are taking over for a girls' night!
</p>
<p>This month, our group will have extra special guests from the cast of Panties In a Twist: The All Female Sketch Comedy Show!
</p>
<p>GirlProv is an all-female improv show, making audiences lose it with laughter at the Push Comedy Theater.
</p>
<p>It's slumber party meets night out on the town meet sorority house party!
</p>
<p>Don't miss this night of comedy- all made up on the spot from the audience's suggestion!
</p>
<p>Girl-Prov: The Girls' Night of Improv
</p>
<p>Saturday, February 4th at the Push Comedy Theater
</p>
<p>The show starts at 8, tickets are $5
</p>
<p>For Information and Tickets to Panties in a Twist, visit:
</p>
<p>Pantiesinatwist.com
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
    start_at:  NaiveDateTime.from_iso8601!("2017-02-04T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-02-04T21:30:00.000-05:00")
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

# Insert panties
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "panties"
})
Logger.info "=========== Wrote tag ==========="

# Insert panties-in-a-twist
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "panties-in-a-twist"
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
    name: "Ticket for Girl-Prov: Special Panties in a Twist Edition!",
    status: "available",
    description: "Ticket for Girl-Prov: Special Panties in a Twist Edition!",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-01-29T07:32:01.733Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Girl-Prov: Special Panties in a Twist Edition! ==========="
Logger.info "=========== BEGIN Processing Universe Event Harold Night ==========="

Logger.info "=========== Writing Event Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "G4KMY6",
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
<p>Friday, November 25th at 10:00pm
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
    slug: "G4KMY6",
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
<p>Friday, November 25th at 10:00pm
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
    start_at:  NaiveDateTime.from_iso8601!("2016-11-25T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-11-25T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-10T02:19:38.769Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Harold Night ==========="
Logger.info "=========== BEGIN Processing Universe Event Party Crashers: Speeding Rainbow ==========="

Logger.info "=========== Writing Event Party Crashers: Speeding Rainbow ==========="
event = SeedHelpers.create_event(
  %{
    slug: "ZBNLRG",
    title: "Party Crashers: Speeding Rainbow",
    description: """
    We're The Party Crashers! Back at it again!<br>Tell your mom, your dad, and bring your girlfriend!<br><br>Party Crashers present- Speeding Rainbow 🌈 <br><br>Saturday, February 4<br><br>Show starts at 10pm<br><br>Tickets are $5<br><br>The Push comedy theatre is a 99 seat venue, so we recommend you get your tickets in advance.
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Party Crashers: Speeding Rainbow ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "ZBNLRG",
    title: "Party Crashers: Speeding Rainbow",
    description: """
    We're The Party Crashers! Back at it again!<br>Tell your mom, your dad, and bring your girlfriend!<br><br>Party Crashers present- Speeding Rainbow 🌈 <br><br>Saturday, February 4<br><br>Show starts at 10pm<br><br>Tickets are $5<br><br>The Push comedy theatre is a 99 seat venue, so we recommend you get your tickets in advance.
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-02-04T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-02-04T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bf494a97-0d73-4aea-b194-1763f4998409",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bf494a97-0d73-4aea-b194-1763f4998409",
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
    name: "Ticket for Party Crashers: Speeding Rainbow",
    status: "available",
    description: "Ticket for Party Crashers: Speeding Rainbow",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-01-30T17:27:42.138Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Party Crashers: Speeding Rainbow ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="

Logger.info "=========== Writing Event The Improv Riot: The Short Form Improv Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "H0N4YL",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.
</p>
<p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.
</p>
<p><strong>The Improv Riot: The Short Form Improv Show</strong>
</p>
<p>Friday, September 23rd, 8pm
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
    slug: "H0N4YL",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.
</p>
<p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.
</p>
<p><strong>The Improv Riot: The Short Form Improv Show</strong>
</p>
<p>Friday, September 23rd, 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2016-09-23T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-23T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-09-16T14:23:02.262Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The First Timers Club: A Sketch Comedy Show ==========="

Logger.info "=========== Writing Event The First Timers Club: A Sketch Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "JN08ZB",
    title: "The First Timers Club: A Sketch Comedy Show",
    description: """
    <p><strong>Get ready to laugh your butts off!!!</strong>
</p>
<p>It's<strong> The First Timers Club: A Brand New Comedy Show </strong>from the minds of the <strong>Push Comedy Theater's Sketch Comedy Writing Class.</strong>
</p>
<p>The writers of our Sketch 101 Writing Class have been slaving away for months (under our expert and somewhat drunken tutelage)... and they've come up with a kick ass show full of   Mexican ghosts, edible wipes, John Cena, Christian house parties, guys night out, Kim Kardashian, rice and much, much more.
</p>
<p>Don't miss this hilarious show from some amazing first time writers...
</p>
<p><strong>The First Timers Club: A Sketch Comedy Show</strong>
</p>
<p>Sunday, June 26th
</p>
<p>The show starts at 7pm
</p>
<p>Tickets are $5
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
    slug: "JN08ZB",
    title: "The First Timers Club: A Sketch Comedy Show",
    description: """
    <p><strong>Get ready to laugh your butts off!!!</strong>
</p>
<p>It's<strong> The First Timers Club: A Brand New Comedy Show </strong>from the minds of the <strong>Push Comedy Theater's Sketch Comedy Writing Class.</strong>
</p>
<p>The writers of our Sketch 101 Writing Class have been slaving away for months (under our expert and somewhat drunken tutelage)... and they've come up with a kick ass show full of   Mexican ghosts, edible wipes, John Cena, Christian house parties, guys night out, Kim Kardashian, rice and much, much more.
</p>
<p>Don't miss this hilarious show from some amazing first time writers...
</p>
<p><strong>The First Timers Club: A Sketch Comedy Show</strong>
</p>
<p>Sunday, June 26th
</p>
<p>The show starts at 7pm
</p>
<p>Tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2016-06-26T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-26T20:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-06-17T05:25:56.321Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The First Timers Club: A Sketch Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Free Free Free Improv Jam ==========="

Logger.info "=========== Writing Event Free Free Free Improv Jam ==========="
event = SeedHelpers.create_event(
  %{
    slug: "569ZGK",
    title: "Free Free Free Improv Jam",
    description: """
    <p>Check out the best improv the Push Comedy Theater has to offer... totally for free.
</p>
<p>It's a night of free improv at the Push, with special guest and Theater 99 founder... Greg Tavares.
</p>
<p><strong>Free Free Free Improv Jam</strong>
</p>
<p>Thursday, October 26th at 10pm
</p>
<p>This show is totally free.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Free Free Free Improv Jam ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "569ZGK",
    title: "Free Free Free Improv Jam",
    description: """
    <p>Check out the best improv the Push Comedy Theater has to offer... totally for free.
</p>
<p>It's a night of free improv at the Push, with special guest and Theater 99 founder... Greg Tavares.
</p>
<p><strong>Free Free Free Improv Jam</strong>
</p>
<p>Thursday, October 26th at 10pm
</p>
<p>This show is totally free.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-10-26T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-10-26T23:10:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/af639825-966e-42f9-9609-5a9d367963ff",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/af639825-966e-42f9-9609-5a9d367963ff",
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
    name: "Ticket for Free Free Free Improv Jam",
    status: "available",
    description: "Ticket for Free Free Free Improv Jam",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-25T15:48:38.558Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Free Free Free Improv Jam ==========="
Logger.info "=========== BEGIN Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="

Logger.info "=========== Writing Event Girl-Prov: The Girls' Night of Improv ==========="
event = SeedHelpers.create_event(
  %{
    slug: "T03SYK",
    title: "Girl-Prov: The Girls' Night of Improv",
    description: """
    <p><strong></strong><strong>GET READY FOR GIRL'S NIGHT!</strong></p> Move over, gentleman! <br>The ladies are taking over for a girls' night!<br><br>GirlProv is an all-female improv group, making their debut at the Push Comedy Theater.<br><br>It's slumber party meets night out on the town meet sorority house party! <br><br>Don't miss this night of comedy- all made up on the spot from the audience's suggestion!<br><br><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, December 4th at the Push Comedy Theater<br>The show starts at 10, tickets are $5<br><br><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/50a0392b69cc52568bb822e3825e683d-GirlProv.jpg"></p><br>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=QAQFvQct2&amp;enc=AZPCE7aZnJAwf402uudRnXGABJYHjEnWLy-72JCX08YIudaSkeFMPpBWFeD5PSo5Jcc&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.<br><br>---<br><br>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.<br><br>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. <br><br>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.<br><br>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.<br><br>--<br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. <br><br>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
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
    slug: "T03SYK",
    title: "Girl-Prov: The Girls' Night of Improv",
    description: """
    <p><strong></strong><strong>GET READY FOR GIRL'S NIGHT!</strong></p> Move over, gentleman! <br>The ladies are taking over for a girls' night!<br><br>GirlProv is an all-female improv group, making their debut at the Push Comedy Theater.<br><br>It's slumber party meets night out on the town meet sorority house party! <br><br>Don't miss this night of comedy- all made up on the spot from the audience's suggestion!<br><br><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, December 4th at the Push Comedy Theater<br>The show starts at 10, tickets are $5<br><br><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/50a0392b69cc52568bb822e3825e683d-GirlProv.jpg"></p><br>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=QAQFvQct2&amp;enc=AZPCE7aZnJAwf402uudRnXGABJYHjEnWLy-72JCX08YIudaSkeFMPpBWFeD5PSo5Jcc&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.<br><br>---<br><br>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.<br><br>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. <br><br>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.<br><br>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.<br><br>--<br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. <br><br>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-12-04T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-12-04T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/fa6623f7-9004-44b8-bc78-58391b74009a",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/fa6623f7-9004-44b8-bc78-58391b74009a",
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
    sale_start:  NaiveDateTime.from_iso8601!("2015-12-02T00:00:06.407Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="
Logger.info "=========== BEGIN Processing Universe Event Teacher's Pet ==========="

Logger.info "=========== Writing Event Teacher's Pet ==========="
event = SeedHelpers.create_event(
  %{
    slug: "HQWM7K",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Saturday, July 23rd, 10pm<br>Tickets are $5
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
    slug: "HQWM7K",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Saturday, July 23rd, 10pm<br>Tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2016-07-23T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-23T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-12T17:16:11.821Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Teacher's Pet ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Stand-up Comedy Grad Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Stand-up Comedy Grad Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "N0M5TP",
    title: "Class Dismissed: The Stand-up Comedy Grad Show",
    description: """
    <strong></strong>Get your first glimpse at Hampton Roads' newest comedy superstars!!!<br><br>The Push Comedy Theater is proud to present the debut show from Tami Tatum, Marissa Patterson, Alex Sanchez, Jordan Romero, Robert Taylor, Jackson Nacey, TJ Ramsey, Pam Francis, Caswell Richardson and Loretta Reese! <br><br>Hosted by Hatton Jordan<br>Hatton is a veteran stand-up comic who has kept his microphone in the comedy game for more than 25 years and has performed professionally in more than 15 states.<br><br>Hatton started his comedy career at the ol' Thoroughgood Inn Comedy Club in Va Beach and since then has worked many hot comedy spots such as the Improv in Washington DC, The Comedy Cabana in South Carolina, JRs in Erie, Pennyslvania and the River Center Comedy Club in San Antonio.<br><br>Support the stand-up scene at the Push Theater!!
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Class Dismissed: The Stand-up Comedy Grad Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "N0M5TP",
    title: "Class Dismissed: The Stand-up Comedy Grad Show",
    description: """
    <strong></strong>Get your first glimpse at Hampton Roads' newest comedy superstars!!!<br><br>The Push Comedy Theater is proud to present the debut show from Tami Tatum, Marissa Patterson, Alex Sanchez, Jordan Romero, Robert Taylor, Jackson Nacey, TJ Ramsey, Pam Francis, Caswell Richardson and Loretta Reese! <br><br>Hosted by Hatton Jordan<br>Hatton is a veteran stand-up comic who has kept his microphone in the comedy game for more than 25 years and has performed professionally in more than 15 states.<br><br>Hatton started his comedy career at the ol' Thoroughgood Inn Comedy Club in Va Beach and since then has worked many hot comedy spots such as the Improv in Washington DC, The Comedy Cabana in South Carolina, JRs in Erie, Pennyslvania and the River Center Comedy Club in San Antonio.<br><br>Support the stand-up scene at the Push Theater!!
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-08-02T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-02T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/36ce77c5-7653-4919-8f10-5598d7a13f7c",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/36ce77c5-7653-4919-8f10-5598d7a13f7c",
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
    name: "Ticket for Class Dismissed: The Stand-up Comedy Grad Show",
    status: "available",
    description: "Ticket for Class Dismissed: The Stand-up Comedy Grad Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-28T02:56:51.658Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Stand-up Comedy Grad Show ==========="
Logger.info "=========== BEGIN Processing Universe Event For All Intensive Porpoises ==========="

Logger.info "=========== Writing Event For All Intensive Porpoises ==========="
event = SeedHelpers.create_event(
  %{
    slug: "CW60HY",
    title: "For All Intensive Porpoises",
    description: """
    <p>Get ready for a fun-filled night of sketch comedy!<br>The Pre Madonnas are back at the Push Comedy Theater with more fun than ever. Whether you like your comedy dirty or silly, slapstick or satirical, The Pre Madonnas will have something for everyone in their new sketch comedy show "For All Intensive Porpoises"
</p>
<p><br><br>Contact: thepremadonnas@gmail.com<br>Twitter: @ Pre_Madonnas<br>Instagram: @ thepremadonnas
</p>
<p><br><br>Tickets are $10 and can be bought ahead of time or at the door. We highly recommend buying tickets in advance, and arriving at the theater early to get a great seat!.
</p>
<p><br><br>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">Pushcomedytheater.com</a>
</p>
<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p><br><br>
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
Logger.info "=========== Writing Event Listing For All Intensive Porpoises ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "CW60HY",
    title: "For All Intensive Porpoises",
    description: """
    <p>Get ready for a fun-filled night of sketch comedy!<br>The Pre Madonnas are back at the Push Comedy Theater with more fun than ever. Whether you like your comedy dirty or silly, slapstick or satirical, The Pre Madonnas will have something for everyone in their new sketch comedy show "For All Intensive Porpoises"
</p>
<p><br><br>Contact: thepremadonnas@gmail.com<br>Twitter: @ Pre_Madonnas<br>Instagram: @ thepremadonnas
</p>
<p><br><br>Tickets are $10 and can be bought ahead of time or at the door. We highly recommend buying tickets in advance, and arriving at the theater early to get a great seat!.
</p>
<p><br><br>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">Pushcomedytheater.com</a>
</p>
<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p><br><br>
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-05-19T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-19T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/561b3235-724f-4f42-93d4-f579b1811252",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/561b3235-724f-4f42-93d4-f579b1811252",
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
    name: "Ticket for For All Intensive Porpoises",
    status: "available",
    description: "Ticket for For All Intensive Porpoises",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-10T22:07:28.530Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event For All Intensive Porpoises ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="

Logger.info "=========== Writing Event The Improv Riot: The Short Form Improv Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "1H8VKW",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.
</p>
<p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.
</p>
<p><strong>The Improv Riot: The Short Form Improv Show</strong>
</p>
<p>Friday, June 30th, 8pm
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
    slug: "1H8VKW",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.
</p>
<p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.
</p>
<p><strong>The Improv Riot: The Short Form Improv Show</strong>
</p>
<p>Friday, June 30th, 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-06-30T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-06-30T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-06-19T21:56:27.146Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Pullers! Pre-teen 201 Murder Mystery Graduation Show ==========="

Logger.info "=========== Writing Event The Pullers! Pre-teen 201 Murder Mystery Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "5RG1BH",
    title: "The Pullers! Pre-teen 201 Murder Mystery Graduation Show",
    description: """
    <p>You've heard of Generation X and iGen. Now get ready for the funniest, silliest, cutest generation of them all as The Pushers bring to you... The Pre-Teen Improvised Murder Mystery Superstars!!!
</p>
<p>Don't miss this group of talented tween-boppers as they put on a funny and fast paced Murder Mystery Show!
</p>
<p><br>The group is coached by local comedy couple, Jim and Mary Veverka, and local comedy giants, The Pushers.
</p>
<p><br><strong>The Pushers present The Pullers! Pre-teen Murder Mystery Graduation Show</strong>
</p>
<p><br><br>Sunday, November 5th.<br>The show starts at 1pm.<br><strong>This is a free show!!!!</strong><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
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
Logger.info "=========== Writing Event Listing The Pullers! Pre-teen 201 Murder Mystery Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "5RG1BH",
    title: "The Pullers! Pre-teen 201 Murder Mystery Graduation Show",
    description: """
    <p>You've heard of Generation X and iGen. Now get ready for the funniest, silliest, cutest generation of them all as The Pushers bring to you... The Pre-Teen Improvised Murder Mystery Superstars!!!
</p>
<p>Don't miss this group of talented tween-boppers as they put on a funny and fast paced Murder Mystery Show!
</p>
<p><br>The group is coached by local comedy couple, Jim and Mary Veverka, and local comedy giants, The Pushers.
</p>
<p><br><strong>The Pushers present The Pullers! Pre-teen Murder Mystery Graduation Show</strong>
</p>
<p><br><br>Sunday, November 5th.<br>The show starts at 1pm.<br><strong>This is a free show!!!!</strong><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
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
    start_at:  NaiveDateTime.from_iso8601!("2017-11-05T13:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-05T14:00:00.000-05:00")
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
    name: "Ticket for The Pullers! Pre-teen 201 Murder Mystery Graduation Show",
    status: "available",
    description: "Ticket for The Pullers! Pre-teen 201 Murder Mystery Graduation Show",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-31T19:15:43.669Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Pullers! Pre-teen 201 Murder Mystery Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Pushie Awards Show ==========="

Logger.info "=========== Writing Event The Pushie Awards Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "YQKZ9H",
    title: "The Pushie Awards Show",
    description: """
    <p>Imagine the Oscars, the Emmys, the Tonys and Nickelodeon Kid's Choice Awards all rolled into one!
</p>
<p>Well imagine no more... because the Push Comedy Theater is proud to announce The First Annual Pushie Awards!!!
</p>
<p>The Pushie Awards are our chance to honor some of the funniest performers, shows and moments of 2016.
</p>
<p>Stay tuned for the full list of awards and nominees.
</p>
<p>Like all award shows, this night will be full of pomp and circumstance, surprise guest stars and amazing performances.
</p>
<p>The Pushie Awards will be held on Saturday, January 31st from 6 to 9pm.
</p>
<p>Don't miss this amazing inaugural event!!!
</p>
<p>*********************************
</p>
<p>The Pushie Awards Show
</p>
<p>Saturday, December 31st at 6pm
</p>
<p>Tickets are $12 in advance, $15 the night of the show.
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
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For more than ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In November of 2014, they opened their own theater, The Push Comedy Theater, located in the Norfolk Arts District.
</p>
<p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.
</p>
<p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.
</p>
<p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, the NorVa, and the Virginia Beach Funny Bone.
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
Logger.info "=========== Writing Event Listing The Pushie Awards Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "YQKZ9H",
    title: "The Pushie Awards Show",
    description: """
    <p>Imagine the Oscars, the Emmys, the Tonys and Nickelodeon Kid's Choice Awards all rolled into one!
</p>
<p>Well imagine no more... because the Push Comedy Theater is proud to announce The First Annual Pushie Awards!!!
</p>
<p>The Pushie Awards are our chance to honor some of the funniest performers, shows and moments of 2016.
</p>
<p>Stay tuned for the full list of awards and nominees.
</p>
<p>Like all award shows, this night will be full of pomp and circumstance, surprise guest stars and amazing performances.
</p>
<p>The Pushie Awards will be held on Saturday, January 31st from 6 to 9pm.
</p>
<p>Don't miss this amazing inaugural event!!!
</p>
<p>*********************************
</p>
<p>The Pushie Awards Show
</p>
<p>Saturday, December 31st at 6pm
</p>
<p>Tickets are $12 in advance, $15 the night of the show.
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
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For more than ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In November of 2014, they opened their own theater, The Push Comedy Theater, located in the Norfolk Arts District.
</p>
<p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.
</p>
<p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.
</p>
<p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, the NorVa, and the Virginia Beach Funny Bone.
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
    start_at:  NaiveDateTime.from_iso8601!("2016-12-31T18:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-12-31T21:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/818fdbf4-f518-4ddb-8ef8-965046822e9d",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/818fdbf4-f518-4ddb-8ef8-965046822e9d",
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

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "sketch"
})
Logger.info "=========== Wrote tag ==========="

# Insert pushie
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "pushie"
})
Logger.info "=========== Wrote tag ==========="

# Insert awards
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "awards"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Pushie Awards Show",
    status: "available",
    description: "Ticket for The Pushie Awards Show",
    price: 1200,
    sale_start:  NaiveDateTime.from_iso8601!("2016-12-17T16:00:43.802Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Pushie Awards Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Summer Improv Sampler ==========="

Logger.info "=========== Writing Event The Summer Improv Sampler ==========="
event = SeedHelpers.create_event(
  %{
    slug: "KYLCSX",
    title: "The Summer Improv Sampler",
    description: """
    <p><strong></strong><strong>Summer is almost here!!! </strong>
</p>
<p><strong></strong>To celebrate, the Push Comedy Theater is throwing a free show. Join the Pushers and friends for a night of hilarious improv.
</p>
<p>If you've never been to the Push, this is your chance to check it out.
</p>
<p><strong>The Summer Improv Sampler (Free Show)</strong><br>Friday, August 12th at 8pm<br>Tickets are $5.
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the parking lot directly across from the theater.<br><br>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For more than 11 years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
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
Logger.info "=========== Writing Event Listing The Summer Improv Sampler ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "KYLCSX",
    title: "The Summer Improv Sampler",
    description: """
    <p><strong></strong><strong>Summer is almost here!!! </strong>
</p>
<p><strong></strong>To celebrate, the Push Comedy Theater is throwing a free show. Join the Pushers and friends for a night of hilarious improv.
</p>
<p>If you've never been to the Push, this is your chance to check it out.
</p>
<p><strong>The Summer Improv Sampler (Free Show)</strong><br>Friday, August 12th at 8pm<br>Tickets are $5.
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the parking lot directly across from the theater.<br><br>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For more than 11 years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
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
    start_at:  NaiveDateTime.from_iso8601!("2016-08-12T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-12T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b9264549-ba31-4e8a-a7ce-efd2ad6f8516",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b9264549-ba31-4e8a-a7ce-efd2ad6f8516",
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
    name: "Ticket for The Summer Improv Sampler",
    status: "available",
    description: "Ticket for The Summer Improv Sampler",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-09T05:44:35.859Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Summer Improv Sampler ==========="
Logger.info "=========== BEGIN Processing Universe Event Laughs for Lacey ==========="

Logger.info "=========== Writing Event Laughs for Lacey ==========="
event = SeedHelpers.create_event(
  %{
    slug: "M9QPDJ",
    title: "Laughs for Lacey",
    description: """
    <p><strong>Please Join us for a special event to support local comedian Don Hughes and his family after the loss of his sister Lacey Jane Hughes.</strong>
</p>
<p>Comedy Provided by:
</p>
<p>Remus Borisov, Isaac Fields, Henry Pounders and Garrett Barnes. Followed by improv performed by the Push Comedy Theater.
</p>
<p><strong>Laughs for Lacey</strong>
</p>
<p><strong>Wednesday, November 8th 7pm-9pm</strong>
</p>
<p>Tickets are $12, with all proceeds going to the Hughes family
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
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>---
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
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
Logger.info "=========== Writing Event Listing Laughs for Lacey ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "M9QPDJ",
    title: "Laughs for Lacey",
    description: """
    <p><strong>Please Join us for a special event to support local comedian Don Hughes and his family after the loss of his sister Lacey Jane Hughes.</strong>
</p>
<p>Comedy Provided by:
</p>
<p>Remus Borisov, Isaac Fields, Henry Pounders and Garrett Barnes. Followed by improv performed by the Push Comedy Theater.
</p>
<p><strong>Laughs for Lacey</strong>
</p>
<p><strong>Wednesday, November 8th 7pm-9pm</strong>
</p>
<p>Tickets are $12, with all proceeds going to the Hughes family
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
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>---
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-11-08T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-08T21:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9a81d2a8-7e2c-41b1-927d-38f448f82182",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9a81d2a8-7e2c-41b1-927d-38f448f82182",
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
    name: "Ticket for Laughs for Lacey",
    status: "available",
    description: "Ticket for Laughs for Lacey",
    price: 1200,
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-06T12:45:17.730Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Laughs for Lacey ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More… Storytelling Night: Indulgences ==========="

Logger.info "=========== Writing Event Tell Me More… Storytelling Night: Indulgences ==========="
event = SeedHelpers.create_event(
  %{
    slug: "86S073",
    title: "Tell Me More… Storytelling Night: Indulgences",
    description: """
    <p>Have you pushed too hard or swallowed too much? Join us 7 p.m. May 15 for stories of indulgence.</p><p><strong>THEME: INDULGENCES</strong><br>Song: “No Church in the Wild,” Kanye West, Jay-Z<br>Possibly inspiring stories of: Gluttony, greed or going too far</p><p><strong>FEATURED STORYTELLERS</strong><br>Storytellers to be announced. If you’re interested in telling a story, tell us about it. Call, 757-785-5590, and pitch your story</p><p><strong>OUR HOST</strong><br>Brendan Kennedy, is a comedian, storyteller, and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”</p><p><strong>DETAILS</strong><br>Time: 7 p.m.<br>Date: Sunday, May 15, 2016<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $5</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Tell Me More… Storytelling Night: Indulgences ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "86S073",
    title: "Tell Me More… Storytelling Night: Indulgences",
    description: """
    <p>Have you pushed too hard or swallowed too much? Join us 7 p.m. May 15 for stories of indulgence.</p><p><strong>THEME: INDULGENCES</strong><br>Song: “No Church in the Wild,” Kanye West, Jay-Z<br>Possibly inspiring stories of: Gluttony, greed or going too far</p><p><strong>FEATURED STORYTELLERS</strong><br>Storytellers to be announced. If you’re interested in telling a story, tell us about it. Call, 757-785-5590, and pitch your story</p><p><strong>OUR HOST</strong><br>Brendan Kennedy, is a comedian, storyteller, and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”</p><p><strong>DETAILS</strong><br>Time: 7 p.m.<br>Date: Sunday, May 15, 2016<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $5</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-05-15T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-05-15T21:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b3c405f6-e2fe-4c3c-b31e-a1d1991d3ebb",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b3c405f6-e2fe-4c3c-b31e-a1d1991d3ebb",
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
    name: "Ticket for Tell Me More… Storytelling Night: Indulgences",
    status: "available",
    description: "Ticket for Tell Me More… Storytelling Night: Indulgences",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-01T21:45:11.718Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More… Storytelling Night: Indulgences ==========="
Logger.info "=========== BEGIN Processing Universe Event Good Talk: The Brad McMurran Show ==========="

Logger.info "=========== Writing Event Good Talk: The Brad McMurran Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "PK78R2",
    title: "Good Talk: The Brad McMurran Show",
    description: """
    <p style="text-align: center;">Get ready for a night of comedy from the Pushers' own Brad McMurran.
</p>
<p style="text-align: center;">The Halloween Special
</p>
<p style="text-align: center;">Get ready for true stories of the macabre as only can be told by Brad McMurran. Brad will be recreating the scariest (and funniest moments) of his life in the special Halloween show.  It's a night of ex-girlfriends, trips to jail, illicit drug use, Michael Myers masks, the ghosts of old ladies and more.
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;">Good Talk: The Brad McMurran Show
</p>
<p style="text-align: center;">Halloween Special
</p>
<p style="text-align: center;">Sunday, October 1st at 7pm
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
<p style="text-align: center;">Alcohol and Drugs
</p>
<p style="text-align: center;">Christmas Talks
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
    slug: "PK78R2",
    title: "Good Talk: The Brad McMurran Show",
    description: """
    <p style="text-align: center;">Get ready for a night of comedy from the Pushers' own Brad McMurran.
</p>
<p style="text-align: center;">The Halloween Special
</p>
<p style="text-align: center;">Get ready for true stories of the macabre as only can be told by Brad McMurran. Brad will be recreating the scariest (and funniest moments) of his life in the special Halloween show.  It's a night of ex-girlfriends, trips to jail, illicit drug use, Michael Myers masks, the ghosts of old ladies and more.
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;">Good Talk: The Brad McMurran Show
</p>
<p style="text-align: center;">Halloween Special
</p>
<p style="text-align: center;">Sunday, October 1st at 7pm
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
<p style="text-align: center;">Alcohol and Drugs
</p>
<p style="text-align: center;">Christmas Talks
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
    start_at:  NaiveDateTime.from_iso8601!("2017-10-01T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-10-01T21:00:00.000-04:00")
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

# Insert special
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "special"
})
Logger.info "=========== Wrote tag ==========="

# Insert halloween
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "halloween"
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-03T03:45:08.594Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Good Talk: The Brad McMurran Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Second Saturday Stand-Up ==========="

Logger.info "=========== Writing Event Second Saturday Stand-Up ==========="
event = SeedHelpers.create_event(
  %{
    slug: "MGCJPF",
    title: "Second Saturday Stand-Up",
    description: """
    <p><strong>Second Saturday Stand-Up</strong>
</p>
<p>This once-a-month show is hosted by almost-jaded veteran comic, <strong>Hatton Jordan </strong>who sets the lineup with proven comedians delivering road-tested jokes while they squeeze in new material.
</p>
<p>This is NOT a "open mic" .....it's selected talent working on their craft. Every month is a new seasoned lineup.
</p>
<p>Every show 90 minutes.
</p>
<p><strong>Scheduled: </strong>
</p>
<p><strong>Host: Hatton Jordan</strong>
</p>
<p><strong>Avery Barnard</strong>
</p>
<p><strong>Brian Shelsby</strong>
</p>
<p><strong>Scott Brown</strong>
</p>
<p><strong>Marissa Patterson</strong>
</p>
<p><strong>Susan Sussman</strong>
</p>
<p><strong>Tim Young</strong>
</p>
<p><br>
</p>
<p><strong>Second Saturday Stand-Up</strong>
</p>
<p>Saturday, April 8th at 10pm
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
    slug: "MGCJPF",
    title: "Second Saturday Stand-Up",
    description: """
    <p><strong>Second Saturday Stand-Up</strong>
</p>
<p>This once-a-month show is hosted by almost-jaded veteran comic, <strong>Hatton Jordan </strong>who sets the lineup with proven comedians delivering road-tested jokes while they squeeze in new material.
</p>
<p>This is NOT a "open mic" .....it's selected talent working on their craft. Every month is a new seasoned lineup.
</p>
<p>Every show 90 minutes.
</p>
<p><strong>Scheduled: </strong>
</p>
<p><strong>Host: Hatton Jordan</strong>
</p>
<p><strong>Avery Barnard</strong>
</p>
<p><strong>Brian Shelsby</strong>
</p>
<p><strong>Scott Brown</strong>
</p>
<p><strong>Marissa Patterson</strong>
</p>
<p><strong>Susan Sussman</strong>
</p>
<p><strong>Tim Young</strong>
</p>
<p><br>
</p>
<p><strong>Second Saturday Stand-Up</strong>
</p>
<p>Saturday, April 8th at 10pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-04-08T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-04-08T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-26T22:28:59.345Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Second Saturday Stand-Up ==========="
Logger.info "=========== BEGIN Processing Universe Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="

Logger.info "=========== Writing Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "GSX0MY",
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
<p><strong>TOO FAR: The Dirtiest, Most Inappropriate Comedy Show... EVER!</strong><br>Saturday, September 17th<br>Tickets are $10, Show starts at 10:00pm
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
    slug: "GSX0MY",
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
<p><strong>TOO FAR: The Dirtiest, Most Inappropriate Comedy Show... EVER!</strong><br>Saturday, September 17th<br>Tickets are $10, Show starts at 10:00pm
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
    start_at:  NaiveDateTime.from_iso8601!("2016-09-17T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-17T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-09-05T03:20:43.781Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Bright Side III ==========="

Logger.info "=========== Writing Event The Bright Side III ==========="
event = SeedHelpers.create_event(
  %{
    slug: "GK6MCJ",
    title: "The Bright Side III",
    description: """
    <p style="text-align: center;"><strong></strong><strong>The Bright Side Forever!!! </strong></p><p style="text-align: center;"><strong></strong>Fresh off of their appearance at the Norfolk Comedy Festival, <a href="https://www.facebook.com/thebrightsidecomedy/" rel="nofollow" target="_blank">The Bright Side Sketch &amp; Improv Comedy</a> is taking to the <a href="https://www.facebook.com/PushComedyTheater/" rel="nofollow" target="_blank">Push Comedy Theater</a> stage once again for a night filled with high energy sketch comedy!!!!</p><p style="text-align: center;">The Bright Side is a sketch and long form improvisational comedy group from Norfolk, Va. </p><p style="text-align: center;">In early 2015, Andrea Bourguignon, Matt Cole, Brian Garraty, and Drew Richard decided to join forces and The Bright Side was born! The group describes their particular brand of comedy as a celebration of the absurd world in which we all exist. Audiences at a Bright Side show can expect to see polished and smart comedy that reflects the group members’ personal life experiences.</p><p style="text-align: center;"><strong>The Bright Side Sketch &amp; Improv presents The Bright Side III </strong><br>Friday, November 20th, 8:00 PM</p><p style="text-align: center;">Come out to see and support one of Hampton Road's favorite sketch comedy groups at the intimate Push Comedy Theater in the heart of Norfolk's new Neon Arts District.</p><p style="text-align: center;">Free parking available behind Virginia Furniture Company (745 Granby Street) and at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/a82a61c6d4344a44053a145992af0a62-brightside.png" alt="" style="display: block; margin: auto;"></p><p style="text-align: center;">--</p><p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Bright Side III ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "GK6MCJ",
    title: "The Bright Side III",
    description: """
    <p style="text-align: center;"><strong></strong><strong>The Bright Side Forever!!! </strong></p><p style="text-align: center;"><strong></strong>Fresh off of their appearance at the Norfolk Comedy Festival, <a href="https://www.facebook.com/thebrightsidecomedy/" rel="nofollow" target="_blank">The Bright Side Sketch &amp; Improv Comedy</a> is taking to the <a href="https://www.facebook.com/PushComedyTheater/" rel="nofollow" target="_blank">Push Comedy Theater</a> stage once again for a night filled with high energy sketch comedy!!!!</p><p style="text-align: center;">The Bright Side is a sketch and long form improvisational comedy group from Norfolk, Va. </p><p style="text-align: center;">In early 2015, Andrea Bourguignon, Matt Cole, Brian Garraty, and Drew Richard decided to join forces and The Bright Side was born! The group describes their particular brand of comedy as a celebration of the absurd world in which we all exist. Audiences at a Bright Side show can expect to see polished and smart comedy that reflects the group members’ personal life experiences.</p><p style="text-align: center;"><strong>The Bright Side Sketch &amp; Improv presents The Bright Side III </strong><br>Friday, November 20th, 8:00 PM</p><p style="text-align: center;">Come out to see and support one of Hampton Road's favorite sketch comedy groups at the intimate Push Comedy Theater in the heart of Norfolk's new Neon Arts District.</p><p style="text-align: center;">Free parking available behind Virginia Furniture Company (745 Granby Street) and at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/a82a61c6d4344a44053a145992af0a62-brightside.png" alt="" style="display: block; margin: auto;"></p><p style="text-align: center;">--</p><p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-11-20T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-11-20T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/410cb97d-969f-47e5-b694-ac96c98013bc",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/410cb97d-969f-47e5-b694-ac96c98013bc",
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
    name: "Ticket for The Bright Side III",
    status: "available",
    description: "Ticket for The Bright Side III",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-03T22:28:20.569Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Bright Side III ==========="
