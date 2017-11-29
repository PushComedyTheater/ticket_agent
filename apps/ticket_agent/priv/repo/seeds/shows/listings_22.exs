require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="

Logger.info "=========== Writing Event The Improv Riot: The Short Form Improv Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "N6JYL8",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.
</p>
<p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.
</p>
<p><strong style="background-color: initial;">The Improv Riot: The Short Form Improv Show</strong>
</p>
<p>Friday, August 26th, 8pm
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
    slug: "N6JYL8",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.
</p>
<p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.
</p>
<p><strong style="background-color: initial;">The Improv Riot: The Short Form Improv Show</strong>
</p>
<p>Friday, August 26th, 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2016-08-26T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-26T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-19T02:47:03.164Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="

Logger.info "=========== Writing Event Girl-Prov: The Girls' Night of Improv ==========="
event = SeedHelpers.create_event(
  %{
    slug: "D56791",
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
<p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, May 12th at the Push Comedy Theater<br>The show starts at 8, tickets are $5
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
    slug: "D56791",
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
<p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, May 12th at the Push Comedy Theater<br>The show starts at 8, tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2017-05-12T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-12T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-03T19:06:24.078Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="
Logger.info "=========== BEGIN Processing Universe Event Couples Therapy ==========="

Logger.info "=========== Writing Event Couples Therapy ==========="
event = SeedHelpers.create_event(
  %{
    slug: "VZH2D0",
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
<p><br><br>Couples Therapy with Alan Johnson and the Alan Johnson Quintet<br>Saturday, March 25th at 8pm<br>Tickets are $5
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
    slug: "VZH2D0",
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
<p><br><br>Couples Therapy with Alan Johnson and the Alan Johnson Quintet<br>Saturday, March 25th at 8pm<br>Tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2017-03-25T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-25T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-04T19:07:17.480Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Couples Therapy ==========="
Logger.info "=========== BEGIN Processing Universe Event Double Feature: The Made Up Movie ==========="

Logger.info "=========== Writing Event Double Feature: The Made Up Movie ==========="
event = SeedHelpers.create_event(
  %{
    slug: "CRX0GQ",
    title: "Double Feature: The Made Up Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong>
</p>
<p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.
</p>
<p><strong>Double Feature: The Totally Improvised Movie</strong><br>Saturday, July 2nd at 8pm
</p>
<p>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.
</p>
<p><br>---
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
Logger.info "=========== Writing Event Listing Double Feature: The Made Up Movie ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "CRX0GQ",
    title: "Double Feature: The Made Up Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong>
</p>
<p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.
</p>
<p><strong>Double Feature: The Totally Improvised Movie</strong><br>Saturday, July 2nd at 8pm
</p>
<p>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.
</p>
<p><br>---
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
    start_at:  NaiveDateTime.from_iso8601!("2016-07-02T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-02T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-06-20T01:43:33.943Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Double Feature: The Made Up Movie ==========="
Logger.info "=========== BEGIN Processing Universe Event Second Saturday Stand-Up ==========="

Logger.info "=========== Writing Event Second Saturday Stand-Up ==========="
event = SeedHelpers.create_event(
  %{
    slug: "83X0VM",
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
<p><strong>Isaac Fields</strong>
</p>
<p><strong>John Gilbreath</strong>
</p>
<p><strong>Gary Mitchell</strong>
</p>
<p><strong>Jon Smalls</strong>
</p>
<p><strong>Sid Bridge</strong>
</p>
<p><strong>...and....</strong>
</p>
<p><strong>Cletus Kassady</strong>
</p>
<p><br>
</p>
<p><strong>Second Saturday Stand-Up</strong>
</p>
<p>Saturday, May 13th at 10pm
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
    slug: "83X0VM",
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
<p><strong>Isaac Fields</strong>
</p>
<p><strong>John Gilbreath</strong>
</p>
<p><strong>Gary Mitchell</strong>
</p>
<p><strong>Jon Smalls</strong>
</p>
<p><strong>Sid Bridge</strong>
</p>
<p><strong>...and....</strong>
</p>
<p><strong>Cletus Kassady</strong>
</p>
<p><br>
</p>
<p><strong>Second Saturday Stand-Up</strong>
</p>
<p>Saturday, May 13th at 10pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-05-13T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-13T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-03T19:28:08.134Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Second Saturday Stand-Up ==========="
Logger.info "=========== BEGIN Processing Universe Event NCF: Squirm & Germ and The Pushers (Thursday) ==========="

Logger.info "=========== Writing Event NCF: Squirm & Germ and The Pushers (Thursday) ==========="
event = SeedHelpers.create_event(
  %{
    slug: "8LRZBV",
    title: "NCF: Squirm & Germ and The Pushers (Thursday)",
    description: """
    <p style="text-align: center;"><strong>SQUIRM AND GERM</strong> is a high-energy music comedy duo hailing from NYC.  These two MC's use their hip-hop alter egos to celebrate their irreverent passions in life with songs about everything from active pregnancies to the state of Maine, naps and neti pots. They produce infectious beats, legit harmonies reminiscent of Rockapella, and rhyme faster than a kid who drank five Red Bulls at a sleepover.
</p>
<p style="text-align: center;"> Their raucous live show is for music lovers with an appreciation for hip-hop, funk, rock, tasty synths, club jams, and rapid fire pop culture references.  This will be their first time playing in Norfolk and they hope everybody is ready to jump out of their seats for a ridiculous feel-good party!
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2014/06/5390419168_558cca99fb_o_2.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2014/06/5390419168_558cca99fb_o_2-300x300.jpg" alt="5390419168_558cca99fb_o_2"></a><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2014/06/photo.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2014/06/photo-300x300.jpg" alt="photo"></a>
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;">Squirm and Germ (Tim Girrbach and Rodney Umble) have rocked the mic at a number of notable venues around NYC including The Apollo, Joe's Pub, Ars Nova, Upright Citizens Brigade Theatre East, Tammany Hall, and the 92Y Tribeca. INNY Award nominees for "Maine, MoFo" (Best Comedy Song and Video) and Official Selections of NYC Comedy Week, NY Funny Songs Fest, Empire Comedy Festival, ANT Fest at Ars Nova, Philly Funny Songs Fest, and the 2014 Charleston Comedy Festival. With their sketch group Drop Six they performed in the Sketch Comedy Festivals of D.C., NYC, Seattle, and won Best of the Fest at the 2007 Toronto Sketch Fest.
</p>
<p style="text-align: center;">S&amp;G have trained extensively in improvisation at the Second City, Upright Citizens Brigade, and Magnet Theaters. Their debut album 'Late Bloomers' was co-produced by Sammy Bananas of Fool's Gold Records and is available on iTunes, Amazon, Spotify, and Pandora.
</p>
<p style="text-align: center;">For more info, check out <a href="http://squirmandgerm.com/" rel="nofollow" target="_blank">squirmandgerm.com </a>
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2014/06/NYFunnySongsFestSaturdayNight_6-1-13_r_w_506.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2014/06/NYFunnySongsFestSaturdayNight_6-1-13_r_w_506-300x201.jpg" alt="NYFunnySongsFestSaturdayNight_6-1-13_r_w_506"></a>
</p>
<p style="text-align: center;">_________________________________________
</p>
<p style="text-align: center;"><strong>THE PUSHERS</strong> are Virginia's premiere sketch and improv comedy group.  For more than a decade they've had audiences howling with laughter (both on and off stage).  The group is known for their racy, high-octane show that's utterly unpredictable.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Pushers.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Pushers.jpg" alt="Pushers"></a>
</p>
<p style="text-align: center;">The Pushers are the creators and producers of <strong>Panties in a Twist: The All Female Sketch Comedy Show</strong> and <strong>The Norfolk Comedy Festival</strong>.  Members of The Pushers co-wrote the Off-Broadway hit, <strong>Cuff Me: The Fifty Shades of Gray Musical Parody</strong>.
</p>
<p style="text-align: center;">In September you can catch The Pushers every week on Channel 3's new show,<strong> Coast Live</strong>.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Our-Theater.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Our-Theater.jpg" alt="Our Theater"></a>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing NCF: Squirm & Germ and The Pushers (Thursday) ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "8LRZBV",
    title: "NCF: Squirm & Germ and The Pushers (Thursday)",
    description: """
    <p style="text-align: center;"><strong>SQUIRM AND GERM</strong> is a high-energy music comedy duo hailing from NYC.  These two MC's use their hip-hop alter egos to celebrate their irreverent passions in life with songs about everything from active pregnancies to the state of Maine, naps and neti pots. They produce infectious beats, legit harmonies reminiscent of Rockapella, and rhyme faster than a kid who drank five Red Bulls at a sleepover.
</p>
<p style="text-align: center;"> Their raucous live show is for music lovers with an appreciation for hip-hop, funk, rock, tasty synths, club jams, and rapid fire pop culture references.  This will be their first time playing in Norfolk and they hope everybody is ready to jump out of their seats for a ridiculous feel-good party!
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2014/06/5390419168_558cca99fb_o_2.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2014/06/5390419168_558cca99fb_o_2-300x300.jpg" alt="5390419168_558cca99fb_o_2"></a><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2014/06/photo.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2014/06/photo-300x300.jpg" alt="photo"></a>
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;">Squirm and Germ (Tim Girrbach and Rodney Umble) have rocked the mic at a number of notable venues around NYC including The Apollo, Joe's Pub, Ars Nova, Upright Citizens Brigade Theatre East, Tammany Hall, and the 92Y Tribeca. INNY Award nominees for "Maine, MoFo" (Best Comedy Song and Video) and Official Selections of NYC Comedy Week, NY Funny Songs Fest, Empire Comedy Festival, ANT Fest at Ars Nova, Philly Funny Songs Fest, and the 2014 Charleston Comedy Festival. With their sketch group Drop Six they performed in the Sketch Comedy Festivals of D.C., NYC, Seattle, and won Best of the Fest at the 2007 Toronto Sketch Fest.
</p>
<p style="text-align: center;">S&amp;G have trained extensively in improvisation at the Second City, Upright Citizens Brigade, and Magnet Theaters. Their debut album 'Late Bloomers' was co-produced by Sammy Bananas of Fool's Gold Records and is available on iTunes, Amazon, Spotify, and Pandora.
</p>
<p style="text-align: center;">For more info, check out <a href="http://squirmandgerm.com/" rel="nofollow" target="_blank">squirmandgerm.com </a>
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2014/06/NYFunnySongsFestSaturdayNight_6-1-13_r_w_506.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2014/06/NYFunnySongsFestSaturdayNight_6-1-13_r_w_506-300x201.jpg" alt="NYFunnySongsFestSaturdayNight_6-1-13_r_w_506"></a>
</p>
<p style="text-align: center;">_________________________________________
</p>
<p style="text-align: center;"><strong>THE PUSHERS</strong> are Virginia's premiere sketch and improv comedy group.  For more than a decade they've had audiences howling with laughter (both on and off stage).  The group is known for their racy, high-octane show that's utterly unpredictable.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Pushers.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Pushers.jpg" alt="Pushers"></a>
</p>
<p style="text-align: center;">The Pushers are the creators and producers of <strong>Panties in a Twist: The All Female Sketch Comedy Show</strong> and <strong>The Norfolk Comedy Festival</strong>.  Members of The Pushers co-wrote the Off-Broadway hit, <strong>Cuff Me: The Fifty Shades of Gray Musical Parody</strong>.
</p>
<p style="text-align: center;">In September you can catch The Pushers every week on Channel 3's new show,<strong> Coast Live</strong>.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Our-Theater.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Our-Theater.jpg" alt="Our Theater"></a>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-08T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-08T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c4d8228c-6d4e-4893-8a62-420baeaea1a9",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c4d8228c-6d4e-4893-8a62-420baeaea1a9",
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

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "sketch"
})
Logger.info "=========== Wrote tag ==========="

# Insert songs
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "songs"
})
Logger.info "=========== Wrote tag ==========="

# Insert fest
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "fest"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for NCF: Squirm & Germ and The Pushers (Thursday)",
    status: "available",
    description: "Ticket for NCF: Squirm & Germ and The Pushers (Thursday)",
    price: 1200,
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-02T04:27:00.805Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event NCF: Squirm & Germ and The Pushers (Thursday) ==========="
Logger.info "=========== BEGIN Processing Universe Event Double Treble: 2 Women, 2 Musicals, All Improv! ==========="

Logger.info "=========== Writing Event Double Treble: 2 Women, 2 Musicals, All Improv! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "P7XQYB",
    title: "Double Treble: 2 Women, 2 Musicals, All Improv!",
    description: """
    <p>Double Treble is back for more musical improv fun!<br>
</p>
<p>Get ready for the musical stylings of Hampton Roads' new Musical Improv Duo: Double Treble!!!
</p>
<p>You read right: MUSICAL IMPROV!
</p>
<p>Sit back in amazement as Kate Baldwin and Alba Woolard dazzle you as they create 2 completely improvised musicals before your very eyes!
</p>
<p>The duo are joined by the amazing and talented Andy Poindexter on the keyboard! Don't miss this spectacular event!
</p>
<p>Double Treble: 2 Women, 2 Musicals, All Improv
</p>
<p>Saturday, May 20th at 8pm
</p>
<p>Tickets are $10
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
Logger.info "=========== Writing Event Listing Double Treble: 2 Women, 2 Musicals, All Improv! ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "P7XQYB",
    title: "Double Treble: 2 Women, 2 Musicals, All Improv!",
    description: """
    <p>Double Treble is back for more musical improv fun!<br>
</p>
<p>Get ready for the musical stylings of Hampton Roads' new Musical Improv Duo: Double Treble!!!
</p>
<p>You read right: MUSICAL IMPROV!
</p>
<p>Sit back in amazement as Kate Baldwin and Alba Woolard dazzle you as they create 2 completely improvised musicals before your very eyes!
</p>
<p>The duo are joined by the amazing and talented Andy Poindexter on the keyboard! Don't miss this spectacular event!
</p>
<p>Double Treble: 2 Women, 2 Musicals, All Improv
</p>
<p>Saturday, May 20th at 8pm
</p>
<p>Tickets are $10
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
    start_at:  NaiveDateTime.from_iso8601!("2017-05-20T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-20T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/41525196-ef6d-4b54-b19c-addaa87584bd",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/41525196-ef6d-4b54-b19c-addaa87584bd",
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

# Insert music
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "music"
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
    name: "Ticket for Double Treble: 2 Women, 2 Musicals, All Improv!",
    status: "available",
    description: "Ticket for Double Treble: 2 Women, 2 Musicals, All Improv!",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-11T03:06:04.142Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Double Treble: 2 Women, 2 Musicals, All Improv! ==========="
Logger.info "=========== BEGIN Processing Universe Event Tales from the Campfire: The Improvised Ghost Story ==========="

Logger.info "=========== Writing Event Tales from the Campfire: The Improvised Ghost Story ==========="
event = SeedHelpers.create_event(
  %{
    slug: "7BZ0QW",
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
<p>Saturday, September 2nd at 8pm
</p>
<p>Tickets are $5
</p>
<p><br>
</p>
<p><br>
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
    slug: "7BZ0QW",
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
<p>Saturday, September 2nd at 8pm
</p>
<p>Tickets are $5
</p>
<p><br>
</p>
<p><br>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-10-07T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-10-07T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-02T15:27:27.762Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tales from the Campfire: The Improvised Ghost Story ==========="
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="

Logger.info "=========== Writing Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
event = SeedHelpers.create_event(
  %{
    slug: "J8Q953",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, September 30th
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
    slug: "J8Q953",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, September 30th
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
    start_at:  NaiveDateTime.from_iso8601!("2017-09-30T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-30T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-26T17:56:08.757Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
Logger.info "=========== BEGIN Processing Universe Event A Very Pushers Christmas: An Inappropriate Comedy Show ==========="

Logger.info "=========== Writing Event A Very Pushers Christmas: An Inappropriate Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "GNCJQZ",
    title: "A Very Pushers Christmas: An Inappropriate Comedy Show",
    description: """
    <p>Remember all those wonderful Christmas Specials you loved as a kid?
</p>
<p><br>
</p>
<p>Remember the singing and the dancing and the loads of holiday cheer?
</p>
<p><br>
</p>
<p>We sure do!
</p>
<p><br>
</p>
<p>That's why we're proud to present our very own warped version of those timeless, holiday classics...
</p>
<p><strong>A Very Pushers Christmas: An Inappropriate Comedy Show.</strong>
</p>
<p><strong><br></strong>
</p>
<p>The Pushers are back with their 8th Annual Christmas Special.
</p>
<p>Don't miss what's become one of Hampton Roads' greatest holiday traditions.
</p>
<p><br>
</p>
<p><strong>A Very Pushers Christmas: An Inappropriate Comedy Show</strong>
</p>
<p>Saturday, December 16th
</p>
<p>Tickets are $10
</p>
<p>Push Comedy Theater
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
<p><strong>The Pushers </strong>are Virginia's premiere sketch and improv comedy group. For more than ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
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
Logger.info "=========== Writing Event Listing A Very Pushers Christmas: An Inappropriate Comedy Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "GNCJQZ",
    title: "A Very Pushers Christmas: An Inappropriate Comedy Show",
    description: """
    <p>Remember all those wonderful Christmas Specials you loved as a kid?
</p>
<p><br>
</p>
<p>Remember the singing and the dancing and the loads of holiday cheer?
</p>
<p><br>
</p>
<p>We sure do!
</p>
<p><br>
</p>
<p>That's why we're proud to present our very own warped version of those timeless, holiday classics...
</p>
<p><strong>A Very Pushers Christmas: An Inappropriate Comedy Show.</strong>
</p>
<p><strong><br></strong>
</p>
<p>The Pushers are back with their 8th Annual Christmas Special.
</p>
<p>Don't miss what's become one of Hampton Roads' greatest holiday traditions.
</p>
<p><br>
</p>
<p><strong>A Very Pushers Christmas: An Inappropriate Comedy Show</strong>
</p>
<p>Saturday, December 16th
</p>
<p>Tickets are $10
</p>
<p>Push Comedy Theater
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
<p><strong>The Pushers </strong>are Virginia's premiere sketch and improv comedy group. For more than ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
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
    start_at:  NaiveDateTime.from_iso8601!("2016-12-16T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-12-16T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/dc7d34bb-37eb-4a6b-9dea-0284451fed2f",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/dc7d34bb-37eb-4a6b-9dea-0284451fed2f",
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

# Insert christmas
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "christmas"
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
    name: "Ticket for A Very Pushers Christmas: An Inappropriate Comedy Show",
    status: "available",
    description: "Ticket for A Very Pushers Christmas: An Inappropriate Comedy Show",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-22T21:09:32.172Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event A Very Pushers Christmas: An Inappropriate Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 201 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 201 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "0HFX1B",
    title: "Class Dismissed: The Improv 201 Graduation Show",
    description: """
    <p><strong></strong><strong>Dust off those caps and gowns... because it's graduation time at the Push.</strong></p><p>Check out the Push Comedy Theater's Improv 201 class as they show off their comedy chops.</p><p>Watch as these brave 201 souls dive head first into the wonderful world of The Harold. So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p><strong>Class Dismissed: The Improv 201 Graduation Show </strong><br>Sunday, April 10th at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p>
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
    slug: "0HFX1B",
    title: "Class Dismissed: The Improv 201 Graduation Show",
    description: """
    <p><strong></strong><strong>Dust off those caps and gowns... because it's graduation time at the Push.</strong></p><p>Check out the Push Comedy Theater's Improv 201 class as they show off their comedy chops.</p><p>Watch as these brave 201 souls dive head first into the wonderful world of The Harold. So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p><strong>Class Dismissed: The Improv 201 Graduation Show </strong><br>Sunday, April 10th at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-10T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-10T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-04T22:08:14.610Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 201 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="

Logger.info "=========== Writing Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
event = SeedHelpers.create_event(
  %{
    slug: "KM0NJZ",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, September 24th
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
    slug: "KM0NJZ",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, September 24th
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
    start_at:  NaiveDateTime.from_iso8601!("2016-09-24T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-24T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-09-16T14:36:47.921Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
Logger.info "=========== BEGIN Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="

Logger.info "=========== Writing Event Who Dunnit? ...The Improvised Murder Mystery ==========="
event = SeedHelpers.create_event(
  %{
    slug: "9ZYFPK",
    title: "Who Dunnit? ...The Improvised Murder Mystery",
    description: """
    <p><strong></strong><strong>Get ready for a spine tingling murder mystery!!!</strong></p><p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.</p><p>...And it will all be made up on the spot!!!</p><p>Don't miss this exciting mystery, all based off the audience's suggestion.</p><p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, May 14th at the Push Comedy Theater<br>The show starts at 8, tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "9ZYFPK",
    title: "Who Dunnit? ...The Improvised Murder Mystery",
    description: """
    <p><strong></strong><strong>Get ready for a spine tingling murder mystery!!!</strong></p><p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.</p><p>...And it will all be made up on the spot!!!</p><p>Don't miss this exciting mystery, all based off the audience's suggestion.</p><p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, May 14th at the Push Comedy Theater<br>The show starts at 8, tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-05-14T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-05-14T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-09T23:42:21.985Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="
Logger.info "=========== BEGIN Processing Universe Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="

Logger.info "=========== Writing Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "9VWCK4",
    title: "TOO FAR: The Dirty, Inappropriate Comedy Show",
    description: """
    <p><strong></strong><strong>Are you ready to get dirty!?!</strong>
</p>
<p>Brad and Sean of the Pushers have assembled a twisted team of writers and actors to bring you the dirtiest, most offensive show Hampton Roads has ever seen.
</p>
<p>It's a show we call Too Far!
</p>
<p>WARNING: This show isn't for everyone. If you're not a fan of foul, sophomoric, potty humor... then this is not the show for you.
</p>
<p>Join The Pushers and the Too Far crew... and let's get dirty!!!
</p>
<p><strong>TOO FAR: The Dirtiest, Most Inappropriate Comedy Show... EVER!</strong><br>Saturday, December 16th <br>Tickets are $10, Show starts at 10:00pm
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
    slug: "9VWCK4",
    title: "TOO FAR: The Dirty, Inappropriate Comedy Show",
    description: """
    <p><strong></strong><strong>Are you ready to get dirty!?!</strong>
</p>
<p>Brad and Sean of the Pushers have assembled a twisted team of writers and actors to bring you the dirtiest, most offensive show Hampton Roads has ever seen.
</p>
<p>It's a show we call Too Far!
</p>
<p>WARNING: This show isn't for everyone. If you're not a fan of foul, sophomoric, potty humor... then this is not the show for you.
</p>
<p>Join The Pushers and the Too Far crew... and let's get dirty!!!
</p>
<p><strong>TOO FAR: The Dirtiest, Most Inappropriate Comedy Show... EVER!</strong><br>Saturday, December 16th <br>Tickets are $10, Show starts at 10:00pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-12-16T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-12-16T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-14T01:51:58.430Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="

Logger.info "=========== Writing Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
event = SeedHelpers.create_event(
  %{
    slug: "0MRP5N",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, November 26th
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
    slug: "0MRP5N",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, November 26th
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
    start_at:  NaiveDateTime.from_iso8601!("2016-11-26T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-11-26T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-10T02:38:21.046Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
Logger.info "=========== BEGIN Processing Universe Event The Dudes: We're All Dudes! ==========="

Logger.info "=========== Writing Event The Dudes: We're All Dudes! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "5FRMXT",
    title: "The Dudes: We're All Dudes!",
    description: """
    <p>Kiss us, we're Dudes! <br>We're back from our road trips down south, it's St. Paddy's Day, and we're officially introducing our newest Dude, Angel. He's been a guest Dude, a substiDUDE, but now he's officially a Dudes' Dude! Come out for some high-octane, serious laughter at The Push Comedy Theater in Norfolk's NEON Arts District!
</p>
<p><br><br>The Dudes are bunch of guys, often laid back, sometimes high-strung, who like to drink beer, talk about dude things, and perfom improv comedy. They're multi-IMPROVAGEDDON champions and have performed up and down the lower-Atlantic seaboard!
</p>
<p><br><br>We're Dudes, you're dudes, they're dudes, WE'RE ALL DUDES!
</p>
<p><br><br>The Dudes Improvisational Comedy are:<br>Rafael <br>Adam <br>James <br>Angel<br>Matt <br>Brian <br>Anthony 
</p>
<p><br><br>The Dudes present... We're All Dudes!<br>Friday, March 17th at 10pm<br>Tickets are $5
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
Logger.info "=========== Writing Event Listing The Dudes: We're All Dudes! ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "5FRMXT",
    title: "The Dudes: We're All Dudes!",
    description: """
    <p>Kiss us, we're Dudes! <br>We're back from our road trips down south, it's St. Paddy's Day, and we're officially introducing our newest Dude, Angel. He's been a guest Dude, a substiDUDE, but now he's officially a Dudes' Dude! Come out for some high-octane, serious laughter at The Push Comedy Theater in Norfolk's NEON Arts District!
</p>
<p><br><br>The Dudes are bunch of guys, often laid back, sometimes high-strung, who like to drink beer, talk about dude things, and perfom improv comedy. They're multi-IMPROVAGEDDON champions and have performed up and down the lower-Atlantic seaboard!
</p>
<p><br><br>We're Dudes, you're dudes, they're dudes, WE'RE ALL DUDES!
</p>
<p><br><br>The Dudes Improvisational Comedy are:<br>Rafael <br>Adam <br>James <br>Angel<br>Matt <br>Brian <br>Anthony 
</p>
<p><br><br>The Dudes present... We're All Dudes!<br>Friday, March 17th at 10pm<br>Tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2017-03-17T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-17T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8505e9ae-e479-4eb1-97ed-17c7f82f07b9",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8505e9ae-e479-4eb1-97ed-17c7f82f07b9",
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
    name: "Ticket for The Dudes: We're All Dudes!",
    status: "available",
    description: "Ticket for The Dudes: We're All Dudes!",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-09T01:05:58.240Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Dudes: We're All Dudes! ==========="
Logger.info "=========== BEGIN Processing Universe Event Stories With Santa ==========="

Logger.info "=========== Writing Event Stories With Santa ==========="
event = SeedHelpers.create_event(
  %{
    slug: "ZTHQFL",
    title: "Stories With Santa",
    description: """
    <p><strong>Santa Claus is coming to the Push Comedy Theater!</strong>
</p>
<p>Come visit with Santa and take part in interactive holiday stories. There will be stories, some improv and Santa.
</p>
<p>Enjoy seasonal treats including cookies, hot cocoa, juice and coffee or tea for the adults.
</p>
<p>Children will have a chance to chat with Santa and receive a goodie bag.
</p>
<p>There is limited seating and reservations are recommended.
</p>
<p>Parents, make sure to bring your cameras!
</p>
<p><strong><br></strong>
</p>
<p><strong>Stories with Santa</strong>
</p>
<p>Saturday, December 16th
</p>
<p>Sunday, December 17th
</p>
<p>Friday, December 22nd.<br>
</p>
<p>The show starts at noon.
</p>
<p>Tickets are $5.
</p>
<p>This show is fun for the whole family.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p><br>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Stories With Santa ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "ZTHQFL",
    title: "Stories With Santa",
    description: """
    <p><strong>Santa Claus is coming to the Push Comedy Theater!</strong>
</p>
<p>Come visit with Santa and take part in interactive holiday stories. There will be stories, some improv and Santa.
</p>
<p>Enjoy seasonal treats including cookies, hot cocoa, juice and coffee or tea for the adults.
</p>
<p>Children will have a chance to chat with Santa and receive a goodie bag.
</p>
<p>There is limited seating and reservations are recommended.
</p>
<p>Parents, make sure to bring your cameras!
</p>
<p><strong><br></strong>
</p>
<p><strong>Stories with Santa</strong>
</p>
<p>Saturday, December 16th
</p>
<p>Sunday, December 17th
</p>
<p>Friday, December 22nd.<br>
</p>
<p>The show starts at noon.
</p>
<p>Tickets are $5.
</p>
<p>This show is fun for the whole family.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p><br>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-12-16T12:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-12-22T14:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bbdfb86d-39d8-465c-8f0e-9b5d33a8b4ec",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bbdfb86d-39d8-465c-8f0e-9b5d33a8b4ec",
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

# Insert christmas
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "christmas"
})
Logger.info "=========== Wrote tag ==========="

# Insert santa
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "santa"
})
Logger.info "=========== Wrote tag ==========="

# Insert stories
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "stories"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Stories With Santa",
    status: "available",
    description: "Ticket for Stories With Santa",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-10T01:42:21.104Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Stories With Santa ==========="
Logger.info "=========== BEGIN Processing Universe Event Lip Service - Ultimate Lip Sync Competition: Round 1 ==========="

Logger.info "=========== Writing Event Lip Service - Ultimate Lip Sync Competition: Round 1 ==========="
event = SeedHelpers.create_event(
  %{
    slug: "1DQ8T7",
    title: "Lip Service - Ultimate Lip Sync Competition: Round 1",
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
Logger.info "=========== Writing Event Listing Lip Service - Ultimate Lip Sync Competition: Round 1 ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "1DQ8T7",
    title: "Lip Service - Ultimate Lip Sync Competition: Round 1",
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
    start_at:  NaiveDateTime.from_iso8601!("2017-08-18T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-08-18T23:30:00.000-04:00")
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
    name: "Ticket for Lip Service - Ultimate Lip Sync Competition: Round 1",
    status: "available",
    description: "Ticket for Lip Service - Ultimate Lip Sync Competition: Round 1",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-08-11T20:51:32.430Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Lip Service - Ultimate Lip Sync Competition: Round 1 ==========="
Logger.info "=========== BEGIN Processing Universe Event The Upright Senior Citizens Brigade ==========="

Logger.info "=========== Writing Event The Upright Senior Citizens Brigade ==========="
event = SeedHelpers.create_event(
  %{
    slug: "G5T1Z6",
    title: "The Upright Senior Citizens Brigade",
    description: """
    <p>YOUTH IS WASTED ON THE YOUNG<br>
</p>
<p>Don't Miss the Upright Senior Citizens Brigade
</p>
<p>Saturday, November 5th at 8pm at the Push Comedy Theater
</p>
<p>Tickets are $5
</p>
<p>The Upright Senior Citizens Brigade is a group of 50-year old and up individuals who perform both long and short-form improv as well as sketch comedy. They were trained by The Pushers and with more than 500 years of life experience, they bridge the generation gap in ways you cannot imagine!
</p>
<p>These 50+ year old fogeys will have you in stitches and wishing you wore your depends.
</p>
<p>Don't miss it!
</p>
<p>The Upright Senior Citizens Brigade
</p>
<p>Saturday, November 5th at 8pm
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Upright Senior Citizens Brigade ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "G5T1Z6",
    title: "The Upright Senior Citizens Brigade",
    description: """
    <p>YOUTH IS WASTED ON THE YOUNG<br>
</p>
<p>Don't Miss the Upright Senior Citizens Brigade
</p>
<p>Saturday, November 5th at 8pm at the Push Comedy Theater
</p>
<p>Tickets are $5
</p>
<p>The Upright Senior Citizens Brigade is a group of 50-year old and up individuals who perform both long and short-form improv as well as sketch comedy. They were trained by The Pushers and with more than 500 years of life experience, they bridge the generation gap in ways you cannot imagine!
</p>
<p>These 50+ year old fogeys will have you in stitches and wishing you wore your depends.
</p>
<p>Don't miss it!
</p>
<p>The Upright Senior Citizens Brigade
</p>
<p>Saturday, November 5th at 8pm
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-11-05T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-11-05T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/10788d93-9d86-4d73-be89-a775d43e1b1e",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/10788d93-9d86-4d73-be89-a775d43e1b1e",
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

# Insert uscb
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "uscb"
})
Logger.info "=========== Wrote tag ==========="

# Insert upright
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "upright"
})
Logger.info "=========== Wrote tag ==========="

# Insert senior-citizens
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "senior-citizens"
})
Logger.info "=========== Wrote tag ==========="

# Insert senior
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "senior"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Upright Senior Citizens Brigade",
    status: "available",
    description: "Ticket for The Upright Senior Citizens Brigade",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-09-23T18:36:40.158Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Upright Senior Citizens Brigade ==========="
Logger.info "=========== BEGIN Processing Universe Event Musical Improv with Double Treble ==========="

Logger.info "=========== Writing Event Musical Improv with Double Treble ==========="
event = SeedHelpers.create_event(
  %{
    slug: "HLKJ5S",
    title: "Musical Improv with Double Treble",
    description: """
    <p>Double Treble is back for more musical improv fun!<br>
</p>
<p>Get ready for the musical stylings of Hampton Roads' new Musical Improv Duo: Double Treble!!!
</p>
<p>You read right: MUSICAL IMPROV!
</p>
<p>Sit back in amazement as Kate Baldwin and Alba Woolard dazzle you as they create 2 completely improvised musicals before your very eyes!
</p>
<p>The duo are joined by the amazing and talented Andy Poindexter on the keyboard! Don't miss this spectacular event!
</p>
<p>Double Treble: 2 Women, 2 Musicals, All Improv
</p>
<p>Saturday, September 23rd at 8pm
</p>
<p>Tickets are $10
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
Logger.info "=========== Writing Event Listing Musical Improv with Double Treble ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "HLKJ5S",
    title: "Musical Improv with Double Treble",
    description: """
    <p>Double Treble is back for more musical improv fun!<br>
</p>
<p>Get ready for the musical stylings of Hampton Roads' new Musical Improv Duo: Double Treble!!!
</p>
<p>You read right: MUSICAL IMPROV!
</p>
<p>Sit back in amazement as Kate Baldwin and Alba Woolard dazzle you as they create 2 completely improvised musicals before your very eyes!
</p>
<p>The duo are joined by the amazing and talented Andy Poindexter on the keyboard! Don't miss this spectacular event!
</p>
<p>Double Treble: 2 Women, 2 Musicals, All Improv
</p>
<p>Saturday, September 23rd at 8pm
</p>
<p>Tickets are $10
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
    start_at:  NaiveDateTime.from_iso8601!("2017-09-23T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-23T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/27884f84-c5fe-414b-ad7c-2ed7b10519e8",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/27884f84-c5fe-414b-ad7c-2ed7b10519e8",
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

# Insert music
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "music"
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
    name: "Ticket for Musical Improv with Double Treble",
    status: "available",
    description: "Ticket for Musical Improv with Double Treble",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-17T20:31:10.043Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Musical Improv with Double Treble ==========="
