require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event Brad McMurran's St Paddy's Day Parade ==========="

Logger.info "=========== Writing Event Brad McMurran's St Paddy's Day Parade ==========="
event = SeedHelpers.create_event(
  %{
    slug: "C8036N",
    title: "Brad McMurran's St Paddy's Day Parade",
    description: """
    <p>Join us for a drunken look at Improv!<br> <br> Brad McMurran's St Paddy's Day Parade<br> Saturday, March 12th, 10pm<br> Tickets are $5<br> <br> <br> The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br> <br>  Free parking available at Slone Chiropractic (111 W Virginia Beach)  just one block from the theater. There is also limited parking on the  street.<br> <br> ---<br> <br> The  Pushers are Virginia's premiere sketch and improv comedy group. For  nearly ten years they have thrilled (and shocked) audiences with their  wild antics both on and off stage. The group puts on a racy,  high-octane, energetic show that is guaranteed to have audiences howling  with laughter. This fall they opened their own theater, The Push Comedy  Theater, located in the new Norfolk Arts District.<br> <br> In 2013 The  Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of  Grey Musical Parody debuted in New York City. It ran for over a year in  both New York and Chicago. A third production is currently touring the  country.<br> <br> The Pushers have appeared at both The Charleston  Comedy Festival and The North Carolina Comedy Arts Festival. In New  York, they have performed at The People's Improv Theater, The Upright  Citizen's Brigade and at The Kraine Theater in New York's East Village.<br> <br> Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.<br> <br> --<br> <br>  The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's  brand new Arts District. Founded by local comedy group The Pushers, the  Push Comedy Theater is dedicated to bringing you live comedy from the  best local and national acts.<br> <br> The Push Comedy Theater will host  live sketch, improv and stand-up comedy on Friday and Saturday nights.  During the week classes will be offered in stand-up, sketch and improv  comedy as well as acting and film production.<br> <br> Whether you're a  die-hard comedy lover or a casual fan... a seasoned performer or someone  who's never stepped foot on stage... the Push Comedy Theater has  something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Brad McMurran's St Paddy's Day Parade ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "C8036N",
    title: "Brad McMurran's St Paddy's Day Parade",
    description: """
    <p>Join us for a drunken look at Improv!<br> <br> Brad McMurran's St Paddy's Day Parade<br> Saturday, March 12th, 10pm<br> Tickets are $5<br> <br> <br> The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br> <br>  Free parking available at Slone Chiropractic (111 W Virginia Beach)  just one block from the theater. There is also limited parking on the  street.<br> <br> ---<br> <br> The  Pushers are Virginia's premiere sketch and improv comedy group. For  nearly ten years they have thrilled (and shocked) audiences with their  wild antics both on and off stage. The group puts on a racy,  high-octane, energetic show that is guaranteed to have audiences howling  with laughter. This fall they opened their own theater, The Push Comedy  Theater, located in the new Norfolk Arts District.<br> <br> In 2013 The  Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of  Grey Musical Parody debuted in New York City. It ran for over a year in  both New York and Chicago. A third production is currently touring the  country.<br> <br> The Pushers have appeared at both The Charleston  Comedy Festival and The North Carolina Comedy Arts Festival. In New  York, they have performed at The People's Improv Theater, The Upright  Citizen's Brigade and at The Kraine Theater in New York's East Village.<br> <br> Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.<br> <br> --<br> <br>  The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's  brand new Arts District. Founded by local comedy group The Pushers, the  Push Comedy Theater is dedicated to bringing you live comedy from the  best local and national acts.<br> <br> The Push Comedy Theater will host  live sketch, improv and stand-up comedy on Friday and Saturday nights.  During the week classes will be offered in stand-up, sketch and improv  comedy as well as acting and film production.<br> <br> Whether you're a  die-hard comedy lover or a casual fan... a seasoned performer or someone  who's never stepped foot on stage... the Push Comedy Theater has  something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-03-12T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-03-12T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b5ba1335-ef46-41b6-9d0c-b466d66095a7",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b5ba1335-ef46-41b6-9d0c-b466d66095a7",
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
    name: "Ticket for Brad McMurran's St Paddy's Day Parade",
    status: "available",
    description: "Ticket for Brad McMurran's St Paddy's Day Parade",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-08T03:56:57.268Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Brad McMurran's St Paddy's Day Parade ==========="
Logger.info "=========== BEGIN Processing Universe Event Couples Therapy ==========="

Logger.info "=========== Writing Event Couples Therapy ==========="
event = SeedHelpers.create_event(
  %{
    slug: "2DX1M6",
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
<p><br>Couples Therapy with Alan Johnson and the Alan Johnson Quintet<br>Saturday, August 26th at 8pm<br>Tickets are $5
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
    slug: "2DX1M6",
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
<p><br>Couples Therapy with Alan Johnson and the Alan Johnson Quintet<br>Saturday, August 26th at 8pm<br>Tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2017-08-26T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-08-26T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-08-23T00:40:16.320Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Couples Therapy ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More... Storytelling Nights: Hope ==========="

Logger.info "=========== Writing Event Tell Me More... Storytelling Nights: Hope ==========="
event = SeedHelpers.create_event(
  %{
    slug: "XY4K06",
    title: "Tell Me More... Storytelling Nights: Hope",
    description: """
    <p>Yes. We’re doing it. We’re really doing it! A December storytelling night perfect for the holidays. Join us 7 p.m. Sunday, Dec. 20, at the Push Comedy Theater in Norfolk, Va., where we will tell stories inspired by the word “hope” and the song “Better Days,” by Rufus featuring Chaka Khan.</p><p>We hope you’ll enjoy the show!</p><p>FEATURED STORYTELLERS<br>-Rashod Ollison, award-winning Virginian-Pilot music critic and author of “Soul Serenade: Rhythm, Blues &amp; Coming of Age Through Vinyl,” which will debut this January.</p><p>-Mike D’Orso, award-winning journalist and author of 16 books, eight of them bestsellers.</p><p>-Anna Sosa, actress currently appearing in the VSC’s production of “A Christmas Carol.” </p><p>-Daniel Neale, a well-known local musician whom you may have seen on Colley Avenue as he played his accordion and suitcase drum. </p><p>HOST<br>-Brendan Kennedy, a comedian, storyteller and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”</p><p>RECORDINGS<br>If all goes as planned, and with the permission of the storytellers, each story will be recorded and posted individually episodes for the Tell Me More… Live podcast.</p><p>EVENT DETAILS<br>Time: 7 p.m.Date: Sunday, Dec. 20, 2015Location: Push Comedy Theater, 763 Granby Street, NorfolkAdmission: $5</p><p>Visit <a href="http://l.facebook.com/l.php?u=http%3A%2F%2Ftellmemorelive.org%2F&amp;h=UAQGPSD0D&amp;enc=AZOQrHDc21wTUhc6YPTbwjAo06a2pjT43SaWQRcuBluZ-AC8vx3UVjOQKIrHyA_idYY&amp;s=1" rel="nofollow" target="_blank">tellmemorelive.org</a> for details.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Tell Me More... Storytelling Nights: Hope ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "XY4K06",
    title: "Tell Me More... Storytelling Nights: Hope",
    description: """
    <p>Yes. We’re doing it. We’re really doing it! A December storytelling night perfect for the holidays. Join us 7 p.m. Sunday, Dec. 20, at the Push Comedy Theater in Norfolk, Va., where we will tell stories inspired by the word “hope” and the song “Better Days,” by Rufus featuring Chaka Khan.</p><p>We hope you’ll enjoy the show!</p><p>FEATURED STORYTELLERS<br>-Rashod Ollison, award-winning Virginian-Pilot music critic and author of “Soul Serenade: Rhythm, Blues &amp; Coming of Age Through Vinyl,” which will debut this January.</p><p>-Mike D’Orso, award-winning journalist and author of 16 books, eight of them bestsellers.</p><p>-Anna Sosa, actress currently appearing in the VSC’s production of “A Christmas Carol.” </p><p>-Daniel Neale, a well-known local musician whom you may have seen on Colley Avenue as he played his accordion and suitcase drum. </p><p>HOST<br>-Brendan Kennedy, a comedian, storyteller and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”</p><p>RECORDINGS<br>If all goes as planned, and with the permission of the storytellers, each story will be recorded and posted individually episodes for the Tell Me More… Live podcast.</p><p>EVENT DETAILS<br>Time: 7 p.m.Date: Sunday, Dec. 20, 2015Location: Push Comedy Theater, 763 Granby Street, NorfolkAdmission: $5</p><p>Visit <a href="http://l.facebook.com/l.php?u=http%3A%2F%2Ftellmemorelive.org%2F&amp;h=UAQGPSD0D&amp;enc=AZOQrHDc21wTUhc6YPTbwjAo06a2pjT43SaWQRcuBluZ-AC8vx3UVjOQKIrHyA_idYY&amp;s=1" rel="nofollow" target="_blank">tellmemorelive.org</a> for details.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-12-20T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-12-20T21:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/4e81b1f1-49e0-4196-b1cf-f4561f76e813",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/4e81b1f1-49e0-4196-b1cf-f4561f76e813",
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
    name: "Ticket for Tell Me More... Storytelling Nights: Hope",
    status: "available",
    description: "Ticket for Tell Me More... Storytelling Nights: Hope",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2015-12-15T17:46:23.721Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More... Storytelling Nights: Hope ==========="
Logger.info "=========== BEGIN Processing Universe Event Harold Night ==========="

Logger.info "=========== Writing Event Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "V6JGTK",
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
<p>Friday, December 23rd at 10:00pm
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
    slug: "V6JGTK",
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
<p>Friday, December 23rd at 10:00pm
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
    start_at:  NaiveDateTime.from_iso8601!("2016-12-23T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-12-23T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-12-16T01:40:28.253Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Harold Night ==========="
Logger.info "=========== BEGIN Processing Universe Event The First Timers Club: A Sketch Comedy Show ==========="

Logger.info "=========== Writing Event The First Timers Club: A Sketch Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "SLXJQW",
    title: "The First Timers Club: A Sketch Comedy Show",
    description: """
    <p><strong></strong><strong>Get ready to laugh your ass off!!!</strong></p><p>It's <strong>The First Timers Club: A Brand New Comedy Show</strong> from the minds of the <strong>Push Comedy Theater's Sketch Comedy Writing Class</strong>.</p><p>The writers of our Sketch 101 Writing Class have been slaving away for months (under our expert and somewhat drunken tutelage)... and they've come up with a kick ass show. </p><p>This show has everything... Resting Bitch Face, MTV's Catfish, Girl Scout Cookies, Poser Coffee Shops, Drone strikes, the true meaning Bon Jovi Shops and much, much more.</p><p>Don't miss this chance to see some fresh, new comedians. It's going to be hilarious!</p><p><strong>The First Timers Club: A Sketch Comedy Show</strong><br>Saturday, April 16th<br>The show starts at 8pm<br>Tickets are $10</p><p><strong>Push Comedy Theater</strong><br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">pushcomedytheater.com</a></p><p><br>The Pushers are very proud of this show. The students of our Sketch 101 writing class have been working their comedy butts off and we can’t wait for you to see their work. It’s some really funny stuff. Don’t miss it!!!</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p>
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
    slug: "SLXJQW",
    title: "The First Timers Club: A Sketch Comedy Show",
    description: """
    <p><strong></strong><strong>Get ready to laugh your ass off!!!</strong></p><p>It's <strong>The First Timers Club: A Brand New Comedy Show</strong> from the minds of the <strong>Push Comedy Theater's Sketch Comedy Writing Class</strong>.</p><p>The writers of our Sketch 101 Writing Class have been slaving away for months (under our expert and somewhat drunken tutelage)... and they've come up with a kick ass show. </p><p>This show has everything... Resting Bitch Face, MTV's Catfish, Girl Scout Cookies, Poser Coffee Shops, Drone strikes, the true meaning Bon Jovi Shops and much, much more.</p><p>Don't miss this chance to see some fresh, new comedians. It's going to be hilarious!</p><p><strong>The First Timers Club: A Sketch Comedy Show</strong><br>Saturday, April 16th<br>The show starts at 8pm<br>Tickets are $10</p><p><strong>Push Comedy Theater</strong><br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">pushcomedytheater.com</a></p><p><br>The Pushers are very proud of this show. The students of our Sketch 101 writing class have been working their comedy butts off and we can’t wait for you to see their work. It’s some really funny stuff. Don’t miss it!!!</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-16T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-16T21:30:00.000-04:00")
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
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-10T05:34:02.243Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The First Timers Club: A Sketch Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improv Grab Bag: 3 Brand New Forms ==========="

Logger.info "=========== Writing Event The Improv Grab Bag: 3 Brand New Forms ==========="
event = SeedHelpers.create_event(
  %{
    slug: "29Q1S5",
    title: "The Improv Grab Bag: 3 Brand New Forms",
    description: """
    <p>Get ready for 3 Brand-Spankin-New Improv forms performed in this colossal night of comedy and mayhem at the Push Comedy Theater, brought to you by some of Hampton Roads' finest improvisers.
</p>
<p>Don't miss the chance to see the new forms debut on the Push Comedy Theater stage!
</p>
<p>The Improv Grab Bag
</p>
<p>Saturday, September 2nd at 10pm
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
Logger.info "=========== Writing Event Listing The Improv Grab Bag: 3 Brand New Forms ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "29Q1S5",
    title: "The Improv Grab Bag: 3 Brand New Forms",
    description: """
    <p>Get ready for 3 Brand-Spankin-New Improv forms performed in this colossal night of comedy and mayhem at the Push Comedy Theater, brought to you by some of Hampton Roads' finest improvisers.
</p>
<p>Don't miss the chance to see the new forms debut on the Push Comedy Theater stage!
</p>
<p>The Improv Grab Bag
</p>
<p>Saturday, September 2nd at 10pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-09-02T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-02T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1168d33a-f5ae-4ad5-928d-b86089d41c27",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1168d33a-f5ae-4ad5-928d-b86089d41c27",
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
    name: "Ticket for The Improv Grab Bag: 3 Brand New Forms",
    status: "available",
    description: "Ticket for The Improv Grab Bag: 3 Brand New Forms",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-08-30T03:42:34.299Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improv Grab Bag: 3 Brand New Forms ==========="
Logger.info "=========== BEGIN Processing Universe Event Date Night ==========="

Logger.info "=========== Writing Event Date Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "FBXSRK",
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
<p>Friday, May 5th at 8pm
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
    slug: "FBXSRK",
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
<p>Friday, May 5th at 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-05-05T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-05T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bf63f02d-8d84-498a-a366-80c9f1ebe22f",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bf63f02d-8d84-498a-a366-80c9f1ebe22f",
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-04-19T02:33:06.290Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Date Night ==========="
Logger.info "=========== BEGIN Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="

Logger.info "=========== Writing Event Girl-Prov: The Girls' Night of Improv ==========="
event = SeedHelpers.create_event(
  %{
    slug: "D1FZNQ",
    title: "Girl-Prov: The Girls' Night of Improv",
    description: """
    <p><strong>GET READY FOR GIRL'S NIGHT!</strong></p><p>Move over, gentleman! <br>The ladies are taking over for a girls' night!</p><p>GirlProv is an all-female improv group, making their debut at the Push Comedy Theater.</p><p>It's slumber party meets night out on the town meet sorority house party! </p><p>Don't miss this night of comedy- all made up on the spot from the audience's suggestion!</p><p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Saturday, January 9th at the Push Comedy Theater<br>The show starts at 10, tickets are $5</p><p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=2AQFwCD6z&amp;enc=AZM1aUvbotC_VMzcZgj3x28FjKT1o7c84SaUpMcauMlFZaYy0gchua80_m3VLuiFWHk&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a></p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "D1FZNQ",
    title: "Girl-Prov: The Girls' Night of Improv",
    description: """
    <p><strong>GET READY FOR GIRL'S NIGHT!</strong></p><p>Move over, gentleman! <br>The ladies are taking over for a girls' night!</p><p>GirlProv is an all-female improv group, making their debut at the Push Comedy Theater.</p><p>It's slumber party meets night out on the town meet sorority house party! </p><p>Don't miss this night of comedy- all made up on the spot from the audience's suggestion!</p><p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Saturday, January 9th at the Push Comedy Theater<br>The show starts at 10, tickets are $5</p><p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=2AQFwCD6z&amp;enc=AZM1aUvbotC_VMzcZgj3x28FjKT1o7c84SaUpMcauMlFZaYy0gchua80_m3VLuiFWHk&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a></p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-01-09T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-01-09T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/6ed1f527-eadd-4b29-b352-3f0b05a7f115",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/6ed1f527-eadd-4b29-b352-3f0b05a7f115",
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
    sale_start:  NaiveDateTime.from_iso8601!("2015-12-31T01:05:40.423Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="
Logger.info "=========== BEGIN Processing Universe Event Storytelling Night: Arrival ==========="

Logger.info "=========== Writing Event Storytelling Night: Arrival ==========="
event = SeedHelpers.create_event(
  %{
    slug: "BLXT8W",
    title: "Storytelling Night: Arrival",
    description: """
    <p>Theme: Arrival
</p>
<p>Song: “Homeward Bound,” Simon and Garfunkel
</p>
<p><br>Possibly inspiring: Stories about returning to home or a place that feels like home, hitting a goal or making it.
</p>
<p>FEATURED STORYTELLERS<br>Storytellers to be announced soon. If you’re interested in telling a story, tell us about it, (757) 785-5590.
</p>
<p>HOST<br>Brendan Kennedy<br><br>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, Aug. 21, 2016<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $5
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Storytelling Night: Arrival ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "BLXT8W",
    title: "Storytelling Night: Arrival",
    description: """
    <p>Theme: Arrival
</p>
<p>Song: “Homeward Bound,” Simon and Garfunkel
</p>
<p><br>Possibly inspiring: Stories about returning to home or a place that feels like home, hitting a goal or making it.
</p>
<p>FEATURED STORYTELLERS<br>Storytellers to be announced soon. If you’re interested in telling a story, tell us about it, (757) 785-5590.
</p>
<p>HOST<br>Brendan Kennedy<br><br>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, Aug. 21, 2016<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-08-21T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-21T21:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c79e1181-99fd-4729-9018-b7c75bee7000",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c79e1181-99fd-4729-9018-b7c75bee7000",
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
    name: "Ticket for Storytelling Night: Arrival",
    status: "available",
    description: "Ticket for Storytelling Night: Arrival",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-28T04:00:18.998Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Storytelling Night: Arrival ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 301 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 301 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "TDNRW7",
    title: "Class Dismissed: The Improv 301 Graduation Show",
    description: """
    <p>It's Harold Time!!!<br> <br> So who the heck is Harold? More accurately the question should be... what the heck is a Harold?<br> <br>  The Harold is perhaps the best know style of long form improv. It  starts with an audience suggestion, then improvisers weave together  scenes, characters and group games to create a seamless piece. It can be  bizarre and magical, baffling and amazing... it definitely needs to be  seen.<br> <br> The Push Comedy Theater's 301 students take the Harold head on! Don't miss it.<br> <br> Class Dismissed: The Improv 301 Graduation Show<br> Wednesday, March 1st, at 8pm<br> Tickets are $5<br> <br> <br> The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br> <br>  Free parking available at Slone Chiropractic (111 W Virginia Beach)  just one block from the theater. There is also limited parking on the  street.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Class Dismissed: The Improv 301 Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "TDNRW7",
    title: "Class Dismissed: The Improv 301 Graduation Show",
    description: """
    <p>It's Harold Time!!!<br> <br> So who the heck is Harold? More accurately the question should be... what the heck is a Harold?<br> <br>  The Harold is perhaps the best know style of long form improv. It  starts with an audience suggestion, then improvisers weave together  scenes, characters and group games to create a seamless piece. It can be  bizarre and magical, baffling and amazing... it definitely needs to be  seen.<br> <br> The Push Comedy Theater's 301 students take the Harold head on! Don't miss it.<br> <br> Class Dismissed: The Improv 301 Graduation Show<br> Wednesday, March 1st, at 8pm<br> Tickets are $5<br> <br> <br> The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br> <br>  Free parking available at Slone Chiropractic (111 W Virginia Beach)  just one block from the theater. There is also limited parking on the  street.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-03-01T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-01T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/fc82b7d6-30b3-452c-b027-ff1bef131d5b",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/fc82b7d6-30b3-452c-b027-ff1bef131d5b",
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
    name: "Ticket for Class Dismissed: The Improv 301 Graduation Show",
    status: "available",
    description: "Ticket for Class Dismissed: The Improv 301 Graduation Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-02-23T03:25:26.614Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 301 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="

Logger.info "=========== Writing Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "DJ586S",
    title: "IMPROVAGEDDON: The Ultimate Improv Competition!",
    description: """
    <p><strong>Prepare for Glory!!</strong></p><p>Prepare for IMPROVAGEDDON: The Ultimate Improv Competition!!!</p><p>We stand before the dawn of a new world!  </p><p>Last month, the reigning champs, The Dudes, failed to abide and were forced to surrender the Improvageddon Championship, and the coveted Hammer of Lowell to 3 on 3 Improv tournament favorites, Short Stack. </p><p>Short Stack wowed the audience, the judges, and Caesar himself with one of the greatest single Improvageddon performances to date, however they will need to not let the momentum falter as they will be facing off against two new challenging teams on the Improvageddon stage once more! </p><p>Will they once again triumph? Will more teams from the 3 on 3 Tournament be showing up to test their mettle Improvageddon style? </p><p>Who will raise the Hammer of Lowell in final victory? </p><p>You'll have to come to this month's show to find out!</p><p>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory. </p><p>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet! </p><p><br>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest. </p><p>Gimmicks will be displayed! <br>Trash will be talked! <br>Feats of comedic strength will be performed! </p><p>Let the final war for comedic supremacy begin!</p><p><strong>IMPROVAGEDDON: The Ultimate Improv Competition!</strong><br>Saturday, May 28th</p><p>The show starts at 10pm</p><p>Tickets are $5 </p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.</p>
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
    slug: "DJ586S",
    title: "IMPROVAGEDDON: The Ultimate Improv Competition!",
    description: """
    <p><strong>Prepare for Glory!!</strong></p><p>Prepare for IMPROVAGEDDON: The Ultimate Improv Competition!!!</p><p>We stand before the dawn of a new world!  </p><p>Last month, the reigning champs, The Dudes, failed to abide and were forced to surrender the Improvageddon Championship, and the coveted Hammer of Lowell to 3 on 3 Improv tournament favorites, Short Stack. </p><p>Short Stack wowed the audience, the judges, and Caesar himself with one of the greatest single Improvageddon performances to date, however they will need to not let the momentum falter as they will be facing off against two new challenging teams on the Improvageddon stage once more! </p><p>Will they once again triumph? Will more teams from the 3 on 3 Tournament be showing up to test their mettle Improvageddon style? </p><p>Who will raise the Hammer of Lowell in final victory? </p><p>You'll have to come to this month's show to find out!</p><p>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory. </p><p>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet! </p><p><br>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest. </p><p>Gimmicks will be displayed! <br>Trash will be talked! <br>Feats of comedic strength will be performed! </p><p>Let the final war for comedic supremacy begin!</p><p><strong>IMPROVAGEDDON: The Ultimate Improv Competition!</strong><br>Saturday, May 28th</p><p>The show starts at 10pm</p><p>Tickets are $5 </p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-05-28T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-05-28T23:30:00.000-04:00")
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

# Insert hammer
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "hammer"
})
Logger.info "=========== Wrote tag ==========="

# Insert lowell
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "lowell"
})
Logger.info "=========== Wrote tag ==========="

# Insert teams
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "teams"
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-11T04:19:48.585Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="
Logger.info "=========== BEGIN Processing Universe Event Good Talk: The Brad McMurran Show ==========="

Logger.info "=========== Writing Event Good Talk: The Brad McMurran Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "BHCKZS",
    title: "Good Talk: The Brad McMurran Show",
    description: """
    <p>Get ready for a night of comedy from the Pushers' own Brad McMurran.
</p>
<p><br><br>A Comedian from God's Country, Portsmouth is a hilarious look into the life of a local comedian. Based on Brad's famous Facebook posts, this show will astonish you... or at least make you feel lucky you chose your career path
</p>
<p><br><br><br>Good Talk: The Brad McMurran Show -<br>A Comedian from God's Country, Portsmouth<br>Sunday, August 6th at 7pm<br>Tickets are $12
</p>
<p><br><br><br>Good Talk is a one-man show starring Brad McMurran and focusing on McMurran's wildly popular Facebook posts.<br>Each month, Good Talk looks at the life and experiences of a sketch and improv comedian. Through storytelling, improv and mixed media, Brad will bring his Good Talk Facebook posts to life.<br>You'll see is struggles with bill collectors, relationships, alcohol, parents, opening a theater and just trying to act like an adult.<br>The show is going to be an unpredictable, wild and borderline-insane ride... just like Brad's life.
</p>
<p><br><br><br>Upcoming episodes of Good Talk: The Brad McMurran Show will include -<br>The Bicycle Journey<br>Halloween Special<br>Alcohol and Drugs<br>Christmas Talks<br>New Years Resolutions<br>Crazy for Love<br>My Life in Comedy<br>The College Years<br>The New York Years<br>Life and Death<br>Being Fired
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
    slug: "BHCKZS",
    title: "Good Talk: The Brad McMurran Show",
    description: """
    <p>Get ready for a night of comedy from the Pushers' own Brad McMurran.
</p>
<p><br><br>A Comedian from God's Country, Portsmouth is a hilarious look into the life of a local comedian. Based on Brad's famous Facebook posts, this show will astonish you... or at least make you feel lucky you chose your career path
</p>
<p><br><br><br>Good Talk: The Brad McMurran Show -<br>A Comedian from God's Country, Portsmouth<br>Sunday, August 6th at 7pm<br>Tickets are $12
</p>
<p><br><br><br>Good Talk is a one-man show starring Brad McMurran and focusing on McMurran's wildly popular Facebook posts.<br>Each month, Good Talk looks at the life and experiences of a sketch and improv comedian. Through storytelling, improv and mixed media, Brad will bring his Good Talk Facebook posts to life.<br>You'll see is struggles with bill collectors, relationships, alcohol, parents, opening a theater and just trying to act like an adult.<br>The show is going to be an unpredictable, wild and borderline-insane ride... just like Brad's life.
</p>
<p><br><br><br>Upcoming episodes of Good Talk: The Brad McMurran Show will include -<br>The Bicycle Journey<br>Halloween Special<br>Alcohol and Drugs<br>Christmas Talks<br>New Years Resolutions<br>Crazy for Love<br>My Life in Comedy<br>The College Years<br>The New York Years<br>Life and Death<br>Being Fired
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-08-06T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-08-06T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-11T23:56:27.886Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Good Talk: The Brad McMurran Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Inaugural Party Crashers Show ==========="

Logger.info "=========== Writing Event The Inaugural Party Crashers Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "VWH807",
    title: "The Inaugural Party Crashers Show",
    description: """
    The Party Crashers are proud to announce our very first Improv show.<br><br>Enjoy family time on Thursday, Lay your life on the line on Friday, and then come get classy AF with The Party Crashers on Sunday.<br><br>With a special opening act that promises to be unlike anything you've ever seen before!
<p><strong>The Inaugural Party Crashers Show</strong>
</p>
<p>Sunday, November 27th at 7pm
</p>
<p>Tickets are $5
</p>
<p>Don't miss the 3 time IMPROVAGEDDON Champions in their very own show!!!
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Inaugural Party Crashers Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "VWH807",
    title: "The Inaugural Party Crashers Show",
    description: """
    The Party Crashers are proud to announce our very first Improv show.<br><br>Enjoy family time on Thursday, Lay your life on the line on Friday, and then come get classy AF with The Party Crashers on Sunday.<br><br>With a special opening act that promises to be unlike anything you've ever seen before!
<p><strong>The Inaugural Party Crashers Show</strong>
</p>
<p>Sunday, November 27th at 7pm
</p>
<p>Tickets are $5
</p>
<p>Don't miss the 3 time IMPROVAGEDDON Champions in their very own show!!!
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-11-27T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-11-27T20:30:00.000-05:00")
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
    name: "Ticket for The Inaugural Party Crashers Show",
    status: "available",
    description: "Ticket for The Inaugural Party Crashers Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-25T21:16:56.921Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Inaugural Party Crashers Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Hair of the Dog ==========="

Logger.info "=========== Writing Event Hair of the Dog ==========="
event = SeedHelpers.create_event(
  %{
    slug: "G7L1R2",
    title: "Hair of the Dog",
    description: """
    <p><strong></strong><strong>The New Year's Eve celebrations are over... and some you maybe feeling a little worse for wear.</strong></p><p>But don't worry, we have the cure for your holiday hangover!!!</p><p>Don't miss Hair of the Dog!<br>We've gathered some of the Push Comedy Theater's finest comedians for a fun night of comedy<br>The beer will be flowing...<br>The hot dog rollers will be... well... rolling.</p><p>Beer, Hot Dogs, Comedy...<br>It's everything you need to chase your hangover away.</p><p><strong>Hair of the Dog</strong><br>Friday, January 1 at 8pm.<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Hair of the Dog ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "G7L1R2",
    title: "Hair of the Dog",
    description: """
    <p><strong></strong><strong>The New Year's Eve celebrations are over... and some you maybe feeling a little worse for wear.</strong></p><p>But don't worry, we have the cure for your holiday hangover!!!</p><p>Don't miss Hair of the Dog!<br>We've gathered some of the Push Comedy Theater's finest comedians for a fun night of comedy<br>The beer will be flowing...<br>The hot dog rollers will be... well... rolling.</p><p>Beer, Hot Dogs, Comedy...<br>It's everything you need to chase your hangover away.</p><p><strong>Hair of the Dog</strong><br>Friday, January 1 at 8pm.<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-01-01T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-01-01T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c55df94d-05da-4b38-b53a-528c240d7eca",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c55df94d-05da-4b38-b53a-528c240d7eca",
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
    name: "Ticket for Hair of the Dog",
    status: "available",
    description: "Ticket for Hair of the Dog",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2015-12-29T18:42:23.579Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Hair of the Dog ==========="
Logger.info "=========== BEGIN Processing Universe Event The Pushers: The 'Grown Up' Sketch Show ==========="

Logger.info "=========== Writing Event The Pushers: The 'Grown Up' Sketch Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "W7QJ02",
    title: "The Pushers: The 'Grown Up' Sketch Show",
    description: """
    <p>The Pushers have been around Hampton Roads for 11 years! 11 years of comedy sure has brought a lot of crazy parties and sleepless nights... But it's also brought some grown up decisions for the Pushers. The crazy party-animal pushers have had some changes since our beginnings that we think made us more mature:</p><p>Sean got married and had a baby</p><p>Ed got married and had a baby</p><p>Alba got married and is thinking about babies</p><p>Brad gave birth to his gall-bladder</p><p>Join us as we celebrate 11 years of mature decisions!</p><p>        The Pushers: The "Grown Up" Sketch Show<br> Saturday, April 9th </p><p>Tickets are $5 </p><p>Push Comedy Theater </p><p>763 Granby Street </p><p> Norfolk, VA </p><p>757-333-7442 </p><p>pushcomedytheater.com </p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance. </p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p>---<br> <br> The  Pushers are Virginia's premiere sketch and improv comedy group. For  nearly ten years they have thrilled (and shocked) audiences with their  wild antics both on and off stage. The group puts on a racy,  high-octane, energetic show that is guaranteed to have audiences howling  with laughter. This fall they opened their own theater, The Push Comedy  Theater, located in the new Norfolk Arts District.<br> <br> In 2013 The  Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of  Grey Musical Parody debuted in New York City. It ran for over a year in  both New York and Chicago. A third production is currently touring the  country. <br> <br> The Pushers have appeared at both The Charleston  Comedy Festival and The North Carolina Comedy Arts Festival. In New  York, they have performed at The People's Improv Theater, The Upright  Citizen's Brigade and at The Kraine Theater in New York's East Village.<br> <br> Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.<br> <br> --<br> <br>  The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's  brand new Arts District. Founded by local comedy group The Pushers, the  Push Comedy Theater is dedicated to bringing you live comedy from the  best local and national acts. <br> The Push Comedy Theater hosts live  sketch, improv and stand-up comedy on Friday and Saturday nights. During  the week classes are offered in stand-up, sketch and improv comedy as  well as acting. <br> <br> Whether you're a die-hard comedy lover or a  casual fan... a seasoned performer or someone who's never stepped foot  on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Pushers: The 'Grown Up' Sketch Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "W7QJ02",
    title: "The Pushers: The 'Grown Up' Sketch Show",
    description: """
    <p>The Pushers have been around Hampton Roads for 11 years! 11 years of comedy sure has brought a lot of crazy parties and sleepless nights... But it's also brought some grown up decisions for the Pushers. The crazy party-animal pushers have had some changes since our beginnings that we think made us more mature:</p><p>Sean got married and had a baby</p><p>Ed got married and had a baby</p><p>Alba got married and is thinking about babies</p><p>Brad gave birth to his gall-bladder</p><p>Join us as we celebrate 11 years of mature decisions!</p><p>        The Pushers: The "Grown Up" Sketch Show<br> Saturday, April 9th </p><p>Tickets are $5 </p><p>Push Comedy Theater </p><p>763 Granby Street </p><p> Norfolk, VA </p><p>757-333-7442 </p><p>pushcomedytheater.com </p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance. </p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p>---<br> <br> The  Pushers are Virginia's premiere sketch and improv comedy group. For  nearly ten years they have thrilled (and shocked) audiences with their  wild antics both on and off stage. The group puts on a racy,  high-octane, energetic show that is guaranteed to have audiences howling  with laughter. This fall they opened their own theater, The Push Comedy  Theater, located in the new Norfolk Arts District.<br> <br> In 2013 The  Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of  Grey Musical Parody debuted in New York City. It ran for over a year in  both New York and Chicago. A third production is currently touring the  country. <br> <br> The Pushers have appeared at both The Charleston  Comedy Festival and The North Carolina Comedy Arts Festival. In New  York, they have performed at The People's Improv Theater, The Upright  Citizen's Brigade and at The Kraine Theater in New York's East Village.<br> <br> Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.<br> <br> --<br> <br>  The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's  brand new Arts District. Founded by local comedy group The Pushers, the  Push Comedy Theater is dedicated to bringing you live comedy from the  best local and national acts. <br> The Push Comedy Theater hosts live  sketch, improv and stand-up comedy on Friday and Saturday nights. During  the week classes are offered in stand-up, sketch and improv comedy as  well as acting. <br> <br> Whether you're a die-hard comedy lover or a  casual fan... a seasoned performer or someone who's never stepped foot  on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-09T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-09T23:45:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9f8a8dbc-71ef-4f89-9182-47ce65cdd09c",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9f8a8dbc-71ef-4f89-9182-47ce65cdd09c",
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
    name: "Ticket for The Pushers: The 'Grown Up' Sketch Show",
    status: "available",
    description: "Ticket for The Pushers: The 'Grown Up' Sketch Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-02T06:44:57.851Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Pushers: The 'Grown Up' Sketch Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Locals Only featuring Husband Material, Russia and Girl-Prov ==========="

Logger.info "=========== Writing Event Locals Only featuring Husband Material, Russia and Girl-Prov ==========="
event = SeedHelpers.create_event(
  %{
    slug: "6D34CM",
    title: "Locals Only featuring Husband Material, Russia and Girl-Prov",
    description: """
    <h3 style="text-align: center;">Mr. Miyagi's School of Karate and Improvisational Comedy</h3>
<p style="text-align: center;">It has been 33 years since the famed Hill Valley Karate Tournament. Following his famed student’s controversial win with an illegal crane kick, Mr. Miyagi’s dojo saw a surge in popularity, allowing him to expand his teachings beyond the ancient martial art to include... improv.<br>This group is the finest to ever come from the school.<br>Today though, his students have drifted far from the Master’s peaceful teachings.<br>In both karate... and comedy: they show no mercy.<br>This show is unlikely anything seen before. A hybrid of intense high kicks, and laughs.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Mr-MYiagi.jpeg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Mr-MYiagi-768x1024.jpeg" alt=""></a>
</p>
<h3 style="text-align: center;">Husband Material</h3>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Husband1.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Husband1.jpg" alt=""></a>
</p>
<h3 style="text-align: center;">Russia</h3>
<p style="text-align: center;">Russia is the Push Comedy Theater's reigning 3 on 3 Improv Tournament champions!<br>They've been studying improv together for 6 years.<br>Their favorite shows are the ones where they win.
</p>
<p style="text-align: center;">Russia brings a quiet crazy to the stage with everything from pissed off tooth fairies, the great god Thor, snake charmers, and pretty much anything else you can think of.
</p>
<p style="text-align: center;">When they are not performing Russia can be found conquering others or in their lair reading Beowulf.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Russia.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Russia.jpg" alt=""></a>
</p>
<h3 style="text-align: center;">Girl-Prov</h3>
<p style="text-align: center;">The Push Comedy Theater presents Girl-Prov!<br>Girl’s night comes to life on stage with Push Comedy Theater’s premiere all-female improv group!<br>They combine musical improv, stories ripped right from the pages of their diaries, quirky characters, and long-form improv to rush you right into their sorority! You’ll pledge your funny bone to this adorable group of women!
</p>
<p style="text-align: center;">Formed by Alba Woolard of The Pushers, Girl-Prov brings together fierce and sassy members of Push Comedy Theater's improv community for a raucous night of comedy!<br>You’ll laugh so hard you’ll snap an underwire!<br>From Mean Girls to the Real Housewives of every city in America, Girl-Prov pulls all the stops to make you cry… from laughing!
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/girlFullSizeRender.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/girlFullSizeRender.jpg" alt=""></a>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Locals Only featuring Husband Material, Russia and Girl-Prov ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "6D34CM",
    title: "Locals Only featuring Husband Material, Russia and Girl-Prov",
    description: """
    <h3 style="text-align: center;">Mr. Miyagi's School of Karate and Improvisational Comedy</h3>
<p style="text-align: center;">It has been 33 years since the famed Hill Valley Karate Tournament. Following his famed student’s controversial win with an illegal crane kick, Mr. Miyagi’s dojo saw a surge in popularity, allowing him to expand his teachings beyond the ancient martial art to include... improv.<br>This group is the finest to ever come from the school.<br>Today though, his students have drifted far from the Master’s peaceful teachings.<br>In both karate... and comedy: they show no mercy.<br>This show is unlikely anything seen before. A hybrid of intense high kicks, and laughs.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Mr-MYiagi.jpeg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Mr-MYiagi-768x1024.jpeg" alt=""></a>
</p>
<h3 style="text-align: center;">Husband Material</h3>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Husband1.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Husband1.jpg" alt=""></a>
</p>
<h3 style="text-align: center;">Russia</h3>
<p style="text-align: center;">Russia is the Push Comedy Theater's reigning 3 on 3 Improv Tournament champions!<br>They've been studying improv together for 6 years.<br>Their favorite shows are the ones where they win.
</p>
<p style="text-align: center;">Russia brings a quiet crazy to the stage with everything from pissed off tooth fairies, the great god Thor, snake charmers, and pretty much anything else you can think of.
</p>
<p style="text-align: center;">When they are not performing Russia can be found conquering others or in their lair reading Beowulf.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Russia.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Russia.jpg" alt=""></a>
</p>
<h3 style="text-align: center;">Girl-Prov</h3>
<p style="text-align: center;">The Push Comedy Theater presents Girl-Prov!<br>Girl’s night comes to life on stage with Push Comedy Theater’s premiere all-female improv group!<br>They combine musical improv, stories ripped right from the pages of their diaries, quirky characters, and long-form improv to rush you right into their sorority! You’ll pledge your funny bone to this adorable group of women!
</p>
<p style="text-align: center;">Formed by Alba Woolard of The Pushers, Girl-Prov brings together fierce and sassy members of Push Comedy Theater's improv community for a raucous night of comedy!<br>You’ll laugh so hard you’ll snap an underwire!<br>From Mean Girls to the Real Housewives of every city in America, Girl-Prov pulls all the stops to make you cry… from laughing!
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/girlFullSizeRender.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/girlFullSizeRender.jpg" alt=""></a>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-09-13T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-13T21:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/82996aa3-44ec-4561-b507-3213cb9e0c4b",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/82996aa3-44ec-4561-b507-3213cb9e0c4b",
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

# Insert girl-prov
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "girl-prov"
})
Logger.info "=========== Wrote tag ==========="

# Insert locals-only
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "locals-only"
})
Logger.info "=========== Wrote tag ==========="

# Insert girl
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "girl"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Locals Only featuring Husband Material, Russia and Girl-Prov",
    status: "available",
    description: "Ticket for Locals Only featuring Husband Material, Russia and Girl-Prov",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-08-29T00:02:29.419Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Locals Only featuring Husband Material, Russia and Girl-Prov ==========="
Logger.info "=========== BEGIN Processing Universe Event Harold Night ==========="

Logger.info "=========== Writing Event Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "H38CJ0",
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
<p>Saturday, October 21st at 10:00pm
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
    slug: "H38CJ0",
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
<p>Saturday, October 21st at 10:00pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-10-21T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-10-21T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-17T14:52:33.591Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Harold Night ==========="
Logger.info "=========== BEGIN Processing Universe Event Musical Riot: The Musical Short Form Improv Show ==========="

Logger.info "=========== Writing Event Musical Riot: The Musical Short Form Improv Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "V7N3K6",
    title: "Musical Riot: The Musical Short Form Improv Show",
    description: """
    <p>Get ready for Musical Short Form (Whose Line is it Anyway?) improv at the Push Comedy Theater!
</p>
<p>That's right! The performers will take suggestions from the audience to make up songs right before your very eyes! With the ever talented Andy Poindexter to make up the music for each of the songs!
</p>
<p><strong>Musical Riot: The Musical Short Form Improv Show</strong>
</p>
<p>Saturday, July 29th, 8pm
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
Logger.info "=========== Writing Event Listing Musical Riot: The Musical Short Form Improv Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "V7N3K6",
    title: "Musical Riot: The Musical Short Form Improv Show",
    description: """
    <p>Get ready for Musical Short Form (Whose Line is it Anyway?) improv at the Push Comedy Theater!
</p>
<p>That's right! The performers will take suggestions from the audience to make up songs right before your very eyes! With the ever talented Andy Poindexter to make up the music for each of the songs!
</p>
<p><strong>Musical Riot: The Musical Short Form Improv Show</strong>
</p>
<p>Saturday, July 29th, 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-07-29T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-29T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/2728c660-506a-45c6-8728-67491d9d524e",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/2728c660-506a-45c6-8728-67491d9d524e",
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
    name: "Ticket for Musical Riot: The Musical Short Form Improv Show",
    status: "available",
    description: "Ticket for Musical Riot: The Musical Short Form Improv Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-25T17:17:37.851Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Musical Riot: The Musical Short Form Improv Show ==========="
Logger.info "=========== BEGIN Processing Universe Event NCF: The Pullers Pre-Teen Improv ==========="

Logger.info "=========== Writing Event NCF: The Pullers Pre-Teen Improv ==========="
event = SeedHelpers.create_event(
  %{
    slug: "B5VXFK",
    title: "NCF: The Pullers Pre-Teen Improv",
    description: """
    <p style="text-align: center;">You've heard of Generation X and iGen. Now get ready for the funniest, silliest, cutest generation of them all as The Pushers bring to you... <strong>The Pullers</strong>!
</p>
<p style="text-align: center;">Don't miss this group of talented tween-boppers as they put on a funny and fast paced 'Who's Line Is It Anyway' style show.
</p>
<p style="text-align: center;">The group is coached by local comedy couple, Jim and Mary Veverka, and local comedy giants, The Pushers.
</p>
<p style="text-align: center;"><strong>The Norfolk Comedy Festival</strong> is proud to present<strong> The Pullers... Pre-Teen Improv</strong>
</p>
<p style="text-align: center;">This is a special afternoon show.
</p>
<p style="text-align: center;">4pm at the Push Comedy Theater
</p>
<p style="text-align: center;">only $5
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2015/09/The-Pullers.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2015/09/The-Pullers-300x281.jpg" alt="The Pullers"></a><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2015/09/The-Pullers1.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2015/09/The-Pullers1-300x225.jpg" alt="The Pullers1"></a><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2015/09/The-Pullers2.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2015/09/The-Pullers2-225x300.jpg" alt="The Pullers2"></a>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing NCF: The Pullers Pre-Teen Improv ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "B5VXFK",
    title: "NCF: The Pullers Pre-Teen Improv",
    description: """
    <p style="text-align: center;">You've heard of Generation X and iGen. Now get ready for the funniest, silliest, cutest generation of them all as The Pushers bring to you... <strong>The Pullers</strong>!
</p>
<p style="text-align: center;">Don't miss this group of talented tween-boppers as they put on a funny and fast paced 'Who's Line Is It Anyway' style show.
</p>
<p style="text-align: center;">The group is coached by local comedy couple, Jim and Mary Veverka, and local comedy giants, The Pushers.
</p>
<p style="text-align: center;"><strong>The Norfolk Comedy Festival</strong> is proud to present<strong> The Pullers... Pre-Teen Improv</strong>
</p>
<p style="text-align: center;">This is a special afternoon show.
</p>
<p style="text-align: center;">4pm at the Push Comedy Theater
</p>
<p style="text-align: center;">only $5
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2015/09/The-Pullers.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2015/09/The-Pullers-300x281.jpg" alt="The Pullers"></a><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2015/09/The-Pullers1.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2015/09/The-Pullers1-300x225.jpg" alt="The Pullers1"></a><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2015/09/The-Pullers2.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2015/09/The-Pullers2-225x300.jpg" alt="The Pullers2"></a>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-10T16:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-10T17:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/61c25d2b-0b2e-4481-bc0b-e3dca644124d",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/61c25d2b-0b2e-4481-bc0b-e3dca644124d",
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
    name: "Ticket for NCF: The Pullers Pre-Teen Improv",
    status: "available",
    description: "Ticket for NCF: The Pullers Pre-Teen Improv",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-02T04:56:24.089Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event NCF: The Pullers Pre-Teen Improv ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improvised Murder Mystery ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improvised Murder Mystery ==========="
event = SeedHelpers.create_event(
  %{
    slug: "MYF3R0",
    title: "Class Dismissed: The Improvised Murder Mystery",
    description: """
    <p><strong>Grab you cap and gown... it's graduation time!!!! </strong><br><br>The students of the Murder Mystery Workshop star in their very own Who Dunnit? Don't miss it as these rookie slueths, suspects and victims present to mini mysteries. <br><br>This is a special Wednesday night show.
</p>
<p><br><strong>Class Dismissed: The Improvised Murder Mystery</strong><br>Wednesday, August 2th at the Push Comedy Theater<br>The show starts at 9:30.  This is a Free Show!!!!<br>
</p>
<p>*************************************************
</p>
<p><strong></strong><strong>Get ready for a spine tingling murder mystery!!!</strong>
</p>
<p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.
</p>
<p>...And it will all be made up on the spot!!!
</p>
<p>Don't miss this exciting mystery, all based off the audience's suggestion.
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br>
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
Logger.info "=========== Writing Event Listing Class Dismissed: The Improvised Murder Mystery ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "MYF3R0",
    title: "Class Dismissed: The Improvised Murder Mystery",
    description: """
    <p><strong>Grab you cap and gown... it's graduation time!!!! </strong><br><br>The students of the Murder Mystery Workshop star in their very own Who Dunnit? Don't miss it as these rookie slueths, suspects and victims present to mini mysteries. <br><br>This is a special Wednesday night show.
</p>
<p><br><strong>Class Dismissed: The Improvised Murder Mystery</strong><br>Wednesday, August 2th at the Push Comedy Theater<br>The show starts at 9:30.  This is a Free Show!!!!<br>
</p>
<p>*************************************************
</p>
<p><strong></strong><strong>Get ready for a spine tingling murder mystery!!!</strong>
</p>
<p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.
</p>
<p>...And it will all be made up on the spot!!!
</p>
<p>Don't miss this exciting mystery, all based off the audience's suggestion.
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br>
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
    start_at:  NaiveDateTime.from_iso8601!("2016-08-24T21:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-24T23:00:00.000-04:00")
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

# Insert free
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "free"
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
    name: "Ticket for Class Dismissed: The Improvised Murder Mystery",
    status: "available",
    description: "Ticket for Class Dismissed: The Improvised Murder Mystery",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-16T05:16:21.088Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improvised Murder Mystery ==========="
