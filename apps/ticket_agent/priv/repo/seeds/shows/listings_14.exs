require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event Double Feature: The Totally Improvised Movie ==========="

Logger.info "=========== Writing Event Double Feature: The Totally Improvised Movie ==========="
event = SeedHelpers.create_event(
  %{
    slug: "PZCRXM",
    title: "Double Feature: The Totally Improvised Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong></p><p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.</p><p><strong>Double Feature: The Totally Improvised Movie</strong><br>Friday, March 4th, 10pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.</p><p><br>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "PZCRXM",
    title: "Double Feature: The Totally Improvised Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong></p><p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.</p><p><strong>Double Feature: The Totally Improvised Movie</strong><br>Friday, March 4th, 10pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.</p><p><br>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-03-04T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-03-04T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8d5f99ae-dfa9-49c7-a92b-c3fc95cb6d6a",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8d5f99ae-dfa9-49c7-a92b-c3fc95cb6d6a",
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-02-25T05:28:10.333Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Double Feature: The Totally Improvised Movie ==========="
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
    start_at:  NaiveDateTime.from_iso8601!("2018-01-13T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-13T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/e736e2a2-4950-4b7c-b606-f0ce63e26dff",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/e736e2a2-4950-4b7c-b606-f0ce63e26dff",
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
    name: "Ticket for Who Dunnit? ...The Improvised Murder Mystery (January)",
    status: "available",
    description: "Ticket for Who Dunnit? ...The Improvised Murder Mystery (January)",
    price: 1500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-13T17:21:30.743Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery (January) ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More... Storytelling Nights: Family ==========="

Logger.info "=========== Writing Event Tell Me More... Storytelling Nights: Family ==========="
event = SeedHelpers.create_event(
  %{
    slug: "W69FHT",
    title: "Tell Me More... Storytelling Nights: Family",
    description: """
    <p>Join Tell Me More… for our storytelling night on Nov. 15 at the Push Comedy Theater in Norfolk, Va., where we tell stories inspired by one word and song.</p><p>Theme: Family<br>Song: “Landslide,” by Fleetwood Mac<br>Possibly inspiring stories of: Relationships and dysfunction</p><p>FEATURED STORYTELLERS<br>To be announced at the beginning of October. Visit<a href="http://tellmemorelive.org/" rel="nofollow" target="_blank">http://tellmemorelive.org/</a> for updates.</p><p>OUR HOST<br>Brendan Kennedy<br><br>RECORDINGS<br>If all goes as planned, all stories will be recorded and posted individually as an episode for the Tell Me More… Live podcast.</p><p>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, Nov. 15, 2015<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $5</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Tell Me More... Storytelling Nights: Family ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "W69FHT",
    title: "Tell Me More... Storytelling Nights: Family",
    description: """
    <p>Join Tell Me More… for our storytelling night on Nov. 15 at the Push Comedy Theater in Norfolk, Va., where we tell stories inspired by one word and song.</p><p>Theme: Family<br>Song: “Landslide,” by Fleetwood Mac<br>Possibly inspiring stories of: Relationships and dysfunction</p><p>FEATURED STORYTELLERS<br>To be announced at the beginning of October. Visit<a href="http://tellmemorelive.org/" rel="nofollow" target="_blank">http://tellmemorelive.org/</a> for updates.</p><p>OUR HOST<br>Brendan Kennedy<br><br>RECORDINGS<br>If all goes as planned, all stories will be recorded and posted individually as an episode for the Tell Me More… Live podcast.</p><p>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, Nov. 15, 2015<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $5</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-11-15T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-11-15T21:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/6cca682d-4df6-41bb-a01b-7928e66ceaad",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/6cca682d-4df6-41bb-a01b-7928e66ceaad",
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
    name: "Ticket for Tell Me More... Storytelling Nights: Family",
    status: "available",
    description: "Ticket for Tell Me More... Storytelling Nights: Family",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-03T03:49:04.674Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More... Storytelling Nights: Family ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More Storytelling ==========="

Logger.info "=========== Writing Event Tell Me More Storytelling ==========="
event = SeedHelpers.create_event(
  %{
    slug: "3N2X5P",
    title: "Tell Me More Storytelling",
    description: """
    <p>You trip, yet you land on your feet.
</p>
<p>STORYTELLING NIGHT THEME
</p>
<p>Suggested theme: Luck
</p>
<p>FEATURED STORYTELLERS
</p>
<p>-Rafael Henriquez
</p>
<p>-Angel Sanchez
</p>
<p>-Rick Krupnick
</p>
<p>-Jenifer Byrd
</p>
<p>-Deb Markham
</p>
<p>HOST
</p>
<p>Brendan Kennedy, is a comedian, storyteller and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”
</p>
<p>EVENT DETAILS
</p>
<p>Time: 7 p.m.
</p>
<p>Date: Sunday, Feb. 19, 2017
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
Logger.info "=========== Writing Event Listing Tell Me More Storytelling ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "3N2X5P",
    title: "Tell Me More Storytelling",
    description: """
    <p>You trip, yet you land on your feet.
</p>
<p>STORYTELLING NIGHT THEME
</p>
<p>Suggested theme: Luck
</p>
<p>FEATURED STORYTELLERS
</p>
<p>-Rafael Henriquez
</p>
<p>-Angel Sanchez
</p>
<p>-Rick Krupnick
</p>
<p>-Jenifer Byrd
</p>
<p>-Deb Markham
</p>
<p>HOST
</p>
<p>Brendan Kennedy, is a comedian, storyteller and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”
</p>
<p>EVENT DETAILS
</p>
<p>Time: 7 p.m.
</p>
<p>Date: Sunday, Feb. 19, 2017
</p>
<p>Location: Push Comedy Theater, 763 Granby Street, Norfolk
</p>
<p>Admission: $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-02-19T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-02-19T20:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/ecf707d2-741c-4a34-8790-154cf77b290c",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/ecf707d2-741c-4a34-8790-154cf77b290c",
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-02-16T20:17:36.001Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More Storytelling ==========="
Logger.info "=========== BEGIN Processing Universe Event Lip Service!  The Ultimate Lip Syncing Competition ==========="

Logger.info "=========== Writing Event Lip Service!  The Ultimate Lip Syncing Competition ==========="
event = SeedHelpers.create_event(
  %{
    slug: "Y5WF6T",
    title: "Lip Service!  The Ultimate Lip Syncing Competition",
    description: """
    <p>Because of the weather, we are regrettably canceling our shows tonight.  Lip Service: The Ultimate Lip Sync Competition is being moved to Friday, November 4th at 8pm.
</p>
<p>If you are unable to attend this new date, please email us at pusherscomedy@gmail.com and we will refund your ticket.
</p>
<p>Sorry for the inconvenience,
</p>
<p>-Push Comedy Theater
</p>
<p><br>
</p>
<p><br>
</p>
<p><strong>Are you ready for this?</strong>
</p>
<p>Nine contestants, four months, one Golden Mic!  Core Theatre Ensemble and Push Comedy Theater present the ultimate Lip Sync Competition in Hampton Roads!
</p>
<p>Each month three brave contestants will show off their Lip Syncing skills over three different rounds!
</p>
<p>Join us for an evening of loud music, sweet dance moves, trash talking, and a few surprises along the way!<br>
</p>
<p><br>
</p>
<p><strong>Friday, July 8th @ </strong><strong>8pm</strong>.  Featuring Nancy Bloom, Evan Lambert, and Skye Zentz.
</p>
<p>Special Guest: Ashley Hall
</p>
<p><br>
</p>
<p><strong>Saturday, August 6th @ </strong><strong>10pm</strong>.  Featuring Angel Sanchez, Jessa Gaul, Pam Goode
</p>
<p>Special Guest: Dennis Andrews
</p>
<p><br>
</p>
<p><strong>Saturday, September 3rd @ </strong><strong>10pm</strong>.  Featuring Mark Haynie, Willie McGhee, Amanda Steadele<br>
</p>
<p>Special Guest; Amber Forehand-Hughes
</p>
<p><br>
</p>
<p>The winner of each show will then battle it out in our final night:
</p>
<p><strong>Friday, November 4 at 8pm. </strong> The winner takes home the Golden Mic!
</p>
<p><br>
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br><br>Free parking available behind Virginia Furniture Company (745 Granby Street) and at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.<br>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Lip Service!  The Ultimate Lip Syncing Competition ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "Y5WF6T",
    title: "Lip Service!  The Ultimate Lip Syncing Competition",
    description: """
    <p>Because of the weather, we are regrettably canceling our shows tonight.  Lip Service: The Ultimate Lip Sync Competition is being moved to Friday, November 4th at 8pm.
</p>
<p>If you are unable to attend this new date, please email us at pusherscomedy@gmail.com and we will refund your ticket.
</p>
<p>Sorry for the inconvenience,
</p>
<p>-Push Comedy Theater
</p>
<p><br>
</p>
<p><br>
</p>
<p><strong>Are you ready for this?</strong>
</p>
<p>Nine contestants, four months, one Golden Mic!  Core Theatre Ensemble and Push Comedy Theater present the ultimate Lip Sync Competition in Hampton Roads!
</p>
<p>Each month three brave contestants will show off their Lip Syncing skills over three different rounds!
</p>
<p>Join us for an evening of loud music, sweet dance moves, trash talking, and a few surprises along the way!<br>
</p>
<p><br>
</p>
<p><strong>Friday, July 8th @ </strong><strong>8pm</strong>.  Featuring Nancy Bloom, Evan Lambert, and Skye Zentz.
</p>
<p>Special Guest: Ashley Hall
</p>
<p><br>
</p>
<p><strong>Saturday, August 6th @ </strong><strong>10pm</strong>.  Featuring Angel Sanchez, Jessa Gaul, Pam Goode
</p>
<p>Special Guest: Dennis Andrews
</p>
<p><br>
</p>
<p><strong>Saturday, September 3rd @ </strong><strong>10pm</strong>.  Featuring Mark Haynie, Willie McGhee, Amanda Steadele<br>
</p>
<p>Special Guest; Amber Forehand-Hughes
</p>
<p><br>
</p>
<p>The winner of each show will then battle it out in our final night:
</p>
<p><strong>Friday, November 4 at 8pm. </strong> The winner takes home the Golden Mic!
</p>
<p><br>
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br><br>Free parking available behind Virginia Furniture Company (745 Granby Street) and at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.<br>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-07-08T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-08T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/2ccb286c-b539-42e4-b17b-626c3a4cbdc0",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/2ccb286c-b539-42e4-b17b-626c3a4cbdc0",
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
    name: "Ticket for Lip Service!  The Ultimate Lip Syncing Competition",
    status: "available",
    description: "Ticket for Lip Service!  The Ultimate Lip Syncing Competition",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-06-29T05:29:16.347Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Lip Service!  The Ultimate Lip Syncing Competition ==========="
Logger.info "=========== BEGIN Processing Universe Event Double Feature: The Totally Improvised Movie ==========="

Logger.info "=========== Writing Event Double Feature: The Totally Improvised Movie ==========="
event = SeedHelpers.create_event(
  %{
    slug: "RJCT7W",
    title: "Double Feature: The Totally Improvised Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong></p><p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.</p><p><strong>Double Feature: The Totally Improvised Movie</strong><br>Friday, February 5th, 10pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.</p><p><br>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "RJCT7W",
    title: "Double Feature: The Totally Improvised Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong></p><p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.</p><p><strong>Double Feature: The Totally Improvised Movie</strong><br>Friday, February 5th, 10pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.</p><p><br>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-02-05T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-02-05T23:30:00.000-05:00")
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
    name: "Ticket for Double Feature: The Totally Improvised Movie",
    status: "available",
    description: "Ticket for Double Feature: The Totally Improvised Movie",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-02-01T05:04:23.294Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Double Feature: The Totally Improvised Movie ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More Storytelling ==========="

Logger.info "=========== Writing Event Tell Me More Storytelling ==========="
event = SeedHelpers.create_event(
  %{
    slug: "TRBPM4",
    title: "Tell Me More Storytelling",
    description: """
    <p>“I do not at all understand the mystery of grace – only that it meets us where we are but does not leave us where it found us.” – Anne Lamott
</p>
<p><br><br>THEME<br>Grace
</p>
<p><br><br>FEATURING<br>Storytellers to be decided.
</p>
<p><br><br>Interested in telling a story? Tell us about it, (757) 785-5590.
</p>
<p><br><br>HOST<br>Brendan Kennedy is a comedian, storyteller and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”
</p>
<p><br><br>DETAILS<br>Time: 7 p.m.<br>Date: Sunday, March 19, 2017<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>
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
    slug: "TRBPM4",
    title: "Tell Me More Storytelling",
    description: """
    <p>“I do not at all understand the mystery of grace – only that it meets us where we are but does not leave us where it found us.” – Anne Lamott
</p>
<p><br><br>THEME<br>Grace
</p>
<p><br><br>FEATURING<br>Storytellers to be decided.
</p>
<p><br><br>Interested in telling a story? Tell us about it, (757) 785-5590.
</p>
<p><br><br>HOST<br>Brendan Kennedy is a comedian, storyteller and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”
</p>
<p><br><br>DETAILS<br>Time: 7 p.m.<br>Date: Sunday, March 19, 2017<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>
</p>
<p>Admission: $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-03-19T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-19T20:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bfd7254f-00ea-42e7-b080-d75c3b2f1cfc",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bfd7254f-00ea-42e7-b080-d75c3b2f1cfc",
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-04T17:46:12.556Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More Storytelling ==========="
Logger.info "=========== BEGIN Processing Universe Event The Bright Side - Citizens of the Month ==========="

Logger.info "=========== Writing Event The Bright Side - Citizens of the Month ==========="
event = SeedHelpers.create_event(
  %{
    slug: "N5TQ7F",
    title: "The Bright Side - Citizens of the Month",
    description: """
    <p>The Bright Side Presents: Citizens of the Month
</p>
<p><br><br>The Bright Side is taking to the Push Comedy Theater stage once again with a night filled with high energy sketch comedy!!!! The group that previously brought you breakdancing anarchist squirrels, mimeophobic parents, and a one-man Muppet Theater, will bring their latest outrageous characters and unorthodox sketches to the stage.
</p>
<p><br><br>The Bright Side is a sketch and long form improvisational comedy group from Norfolk, VA.
</p>
<p><br><br>In early 2015, Andrea Bourguignon, Matt Cole, Brian Garraty, and Drew Richard decided to join forces as The Bright Side! Their particular brand of comedy is a celebration of the absurd world in which we all must exist. Audiences at a Bright Side show can expect to see smart, polished comedy that reflects the group members’ personal life experiences and optimistic perspectives. Look on The Bright Side!
</p>
<p><br><br>The Bright Side Sketch &amp; Improv presents Citizens of the Month<br>Saturday, December 3rd, 10:00 PM
</p>
<p>Tickets are $10<br>Push Comedy Theater
</p>
<p><br><br>Come out to see and support one of Hampton Road's own sketch comedy groups at the intimate Push Comedy Theater in the heart of Norfolk's new Neon Arts District.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p><br><br>--
</p>
<p><br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.
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
Logger.info "=========== Writing Event Listing The Bright Side - Citizens of the Month ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "N5TQ7F",
    title: "The Bright Side - Citizens of the Month",
    description: """
    <p>The Bright Side Presents: Citizens of the Month
</p>
<p><br><br>The Bright Side is taking to the Push Comedy Theater stage once again with a night filled with high energy sketch comedy!!!! The group that previously brought you breakdancing anarchist squirrels, mimeophobic parents, and a one-man Muppet Theater, will bring their latest outrageous characters and unorthodox sketches to the stage.
</p>
<p><br><br>The Bright Side is a sketch and long form improvisational comedy group from Norfolk, VA.
</p>
<p><br><br>In early 2015, Andrea Bourguignon, Matt Cole, Brian Garraty, and Drew Richard decided to join forces as The Bright Side! Their particular brand of comedy is a celebration of the absurd world in which we all must exist. Audiences at a Bright Side show can expect to see smart, polished comedy that reflects the group members’ personal life experiences and optimistic perspectives. Look on The Bright Side!
</p>
<p><br><br>The Bright Side Sketch &amp; Improv presents Citizens of the Month<br>Saturday, December 3rd, 10:00 PM
</p>
<p>Tickets are $10<br>Push Comedy Theater
</p>
<p><br><br>Come out to see and support one of Hampton Road's own sketch comedy groups at the intimate Push Comedy Theater in the heart of Norfolk's new Neon Arts District.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p><br><br>--
</p>
<p><br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p><br><br>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-12-03T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-12-03T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/fd32978b-d004-4917-8245-1788287c97b1",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/fd32978b-d004-4917-8245-1788287c97b1",
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
    name: "Ticket for The Bright Side - Citizens of the Month",
    status: "available",
    description: "Ticket for The Bright Side - Citizens of the Month",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-28T23:40:04.766Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Bright Side - Citizens of the Month ==========="
Logger.info "=========== BEGIN Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="

Logger.info "=========== Writing Event Girl-Prov: The Girls' Night of Improv ==========="
event = SeedHelpers.create_event(
  %{
    slug: "Z0Y5KR",
    title: "Girl-Prov: The Girls' Night of Improv",
    description: """
    <p><strong></strong><strong>GET READY FOR GIRL'S NIGHT!</strong></p><p>Move over, gentleman! <br>The ladies are taking over for a girls' night!</p><p>GirlProv is an all-female improv group, making audiences lose it with laughter at the Push Comedy Theater.</p><p>It's slumber party meets night out on the town meet sorority house party! </p><p>Don't miss this night of comedy- all made up on the spot from the audience's suggestion!</p><p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Saturday, April 2nd at the Push Comedy Theater<br>The show starts at 8, tickets are $5</p><p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">pushcomedytheater.com</a></p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "Z0Y5KR",
    title: "Girl-Prov: The Girls' Night of Improv",
    description: """
    <p><strong></strong><strong>GET READY FOR GIRL'S NIGHT!</strong></p><p>Move over, gentleman! <br>The ladies are taking over for a girls' night!</p><p>GirlProv is an all-female improv group, making audiences lose it with laughter at the Push Comedy Theater.</p><p>It's slumber party meets night out on the town meet sorority house party! </p><p>Don't miss this night of comedy- all made up on the spot from the audience's suggestion!</p><p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Saturday, April 2nd at the Push Comedy Theater<br>The show starts at 8, tickets are $5</p><p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">pushcomedytheater.com</a></p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-02T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-02T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-28T22:57:07.488Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improvised Ghost Story ==========="

Logger.info "=========== Writing Event The Improvised Ghost Story ==========="
event = SeedHelpers.create_event(
  %{
    slug: "NCV2Q6",
    title: "The Improvised Ghost Story",
    description: """
    <p>The Push presents a frightful night of comedy (or is it a hilarious night of frights).
</p>
<p><strong>Tales from the Campfire is quickly becoming one of the Push's biggest hits.</strong>
</p>
<p><strong><br></strong>
</p>
<p>With an audience suggestion, this talented group of improvisers will make up a gut-busting ghost story right before your eyes.<br>
</p>
<p><br>
</p>
<p><strong>Tales from the Campfire: The Improvised Ghost Story</strong>
</p>
<p>Friday, October 14th at 8pm
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
    slug: "NCV2Q6",
    title: "The Improvised Ghost Story",
    description: """
    <p>The Push presents a frightful night of comedy (or is it a hilarious night of frights).
</p>
<p><strong>Tales from the Campfire is quickly becoming one of the Push's biggest hits.</strong>
</p>
<p><strong><br></strong>
</p>
<p>With an audience suggestion, this talented group of improvisers will make up a gut-busting ghost story right before your eyes.<br>
</p>
<p><br>
</p>
<p><strong>Tales from the Campfire: The Improvised Ghost Story</strong>
</p>
<p>Friday, October 14th at 8pm
</p>
<p>Tickets are $5
</p>
<p><br>
</p>
<p>I ain't afraid of no ghost!
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-10-14T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-10-14T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-09-23T15:29:17.616Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improvised Ghost Story ==========="
Logger.info "=========== BEGIN Processing Universe Event Double Feature: The Made Up Movie ==========="

Logger.info "=========== Writing Event Double Feature: The Made Up Movie ==========="
event = SeedHelpers.create_event(
  %{
    slug: "HB613Y",
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
    slug: "HB613Y",
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
    start_at:  NaiveDateTime.from_iso8601!("2016-08-06T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-06T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-19T02:06:53.779Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Double Feature: The Made Up Movie ==========="
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="

Logger.info "=========== Writing Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "J91FVT",
    title: "IMPROVAGEDDON: The Ultimate Improv Competition!",
    description: """
    <p><strong>Prepare for Glory!!</strong></p><p>Prepare for IMPROVAGEDDON: The Ultimate Improv Competition!!!</p><p>Last time, The Dudes won their third, consecutive IMPROVAGEDDON title!!  It's something that no Improvageddon team has been able to accomplish since the modern rules were adopted a little over a year ago! Will the Hammer of Lowell stay within their grasp? Or are they just a flash in the pan? You'll have to come to this show to find out! </p><p>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory. </p><p>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet! <br>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest. </p><p>Gimmicks will be displayed! <br>Trash will be talked! <br>Feats of comedic strength will be performed! </p><p>Let the final war for comedic supremacy begin!</p><p><strong>IMPROVAGEDDON: The Ultimate Improv Competition!</strong><br>Saturday, March 26th</p><p>The show starts at 10pm</p><p>Tickets are $5 </p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.</p>
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
    slug: "J91FVT",
    title: "IMPROVAGEDDON: The Ultimate Improv Competition!",
    description: """
    <p><strong>Prepare for Glory!!</strong></p><p>Prepare for IMPROVAGEDDON: The Ultimate Improv Competition!!!</p><p>Last time, The Dudes won their third, consecutive IMPROVAGEDDON title!!  It's something that no Improvageddon team has been able to accomplish since the modern rules were adopted a little over a year ago! Will the Hammer of Lowell stay within their grasp? Or are they just a flash in the pan? You'll have to come to this show to find out! </p><p>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory. </p><p>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet! <br>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest. </p><p>Gimmicks will be displayed! <br>Trash will be talked! <br>Feats of comedic strength will be performed! </p><p>Let the final war for comedic supremacy begin!</p><p><strong>IMPROVAGEDDON: The Ultimate Improv Competition!</strong><br>Saturday, March 26th</p><p>The show starts at 10pm</p><p>Tickets are $5 </p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-03-26T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-03-26T23:45:00.000-04:00")
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

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for IMPROVAGEDDON: The Ultimate Improv Competition!",
    status: "available",
    description: "Ticket for IMPROVAGEDDON: The Ultimate Improv Competition!",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-02-29T04:48:44.031Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="
Logger.info "=========== BEGIN Processing Universe Event Panties in a Twist : The All Female Comedy Show ==========="

Logger.info "=========== Writing Event Panties in a Twist : The All Female Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "3DL1YS",
    title: "Panties in a Twist : The All Female Comedy Show",
    description: """
    <p style="text-align: center;"><strong>The biggest show in Hampton Roads is back!!!</strong></p><p style="text-align: center;"><strong>Panties in a Twist : The All Female Sketch Comedy Show</strong></p><p style="text-align: center;">Panties In A Twist is a sketch comedy show written by women... directed by women... and starring women.<br>The Push Comedy Theater has gathered Hampton Roads' finest and funniest female writers, actresses and comedians for the most kick ass comedy show ever seen!!!</p><p style="text-align: center;">This year we are proud to be celebrating the 5th Anniversary of Panties in a Twist. In honor of this momentous occasion, the show will be held at the historic Wells Theater.</p><p style="text-align: center;"><strong>We can't stress this enough... GET YOUR TICKETS NOW.</strong></p><p style="text-align: center;">Last year's Panties show sold out The NorVA... and we promise, this year's show is going to be even bigger. <br>We have assembled our biggest and funniest cast ever.<br>With all these funny women in one place, this is guaranteed to be a huge event!!!</p><p style="text-align: center;">Panties in a Twist is one of Hampton Roads' most talked about shows... so make sure you're part of history and get your tickets now!</p><p style="text-align: center;"><strong>Panties In A Twist : The All Female Sketch Comedy Show</strong><br>Saturday, February 13thst at 8pm.<br>Tickets are $20.</p><p style="text-align: center;"><strong>The Wells Theater</strong><br>108 E Tazewell St, Norfolk</p><p style="text-align: center;">------<br>Panties in a Twist is produced by The Pushers.</p><p style="text-align: center;">The Pushers are Virginia's premiere sketch and improv comedy group. For over ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In 2014, they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p style="text-align: center;">In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p style="text-align: center;">The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p style="text-align: center;">Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p style="text-align: center;">--</p><p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Panties in a Twist : The All Female Comedy Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "3DL1YS",
    title: "Panties in a Twist : The All Female Comedy Show",
    description: """
    <p style="text-align: center;"><strong>The biggest show in Hampton Roads is back!!!</strong></p><p style="text-align: center;"><strong>Panties in a Twist : The All Female Sketch Comedy Show</strong></p><p style="text-align: center;">Panties In A Twist is a sketch comedy show written by women... directed by women... and starring women.<br>The Push Comedy Theater has gathered Hampton Roads' finest and funniest female writers, actresses and comedians for the most kick ass comedy show ever seen!!!</p><p style="text-align: center;">This year we are proud to be celebrating the 5th Anniversary of Panties in a Twist. In honor of this momentous occasion, the show will be held at the historic Wells Theater.</p><p style="text-align: center;"><strong>We can't stress this enough... GET YOUR TICKETS NOW.</strong></p><p style="text-align: center;">Last year's Panties show sold out The NorVA... and we promise, this year's show is going to be even bigger. <br>We have assembled our biggest and funniest cast ever.<br>With all these funny women in one place, this is guaranteed to be a huge event!!!</p><p style="text-align: center;">Panties in a Twist is one of Hampton Roads' most talked about shows... so make sure you're part of history and get your tickets now!</p><p style="text-align: center;"><strong>Panties In A Twist : The All Female Sketch Comedy Show</strong><br>Saturday, February 13thst at 8pm.<br>Tickets are $20.</p><p style="text-align: center;"><strong>The Wells Theater</strong><br>108 E Tazewell St, Norfolk</p><p style="text-align: center;">------<br>Panties in a Twist is produced by The Pushers.</p><p style="text-align: center;">The Pushers are Virginia's premiere sketch and improv comedy group. For over ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In 2014, they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p style="text-align: center;">In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p style="text-align: center;">The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p style="text-align: center;">Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p style="text-align: center;">--</p><p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-02-13T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-02-13T22:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/003b349b-b16f-4342-afcb-55f6df794030",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/003b349b-b16f-4342-afcb-55f6df794030",
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

# Insert women
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "women"
})
Logger.info "=========== Wrote tag ==========="

# Insert female
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "female"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Panties in a Twist : The All Female Comedy Show",
    status: "available",
    description: "Ticket for Panties in a Twist : The All Female Comedy Show",
    price: 2000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-01-04T22:42:03.453Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Panties in a Twist : The All Female Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Date Night ==========="

Logger.info "=========== Writing Event Date Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "Z1KJCP",
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
<p>Friday, November 3rd at 8pm
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
    slug: "Z1KJCP",
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
<p>Friday, November 3rd at 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-11-03T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-03T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-13T21:31:02.791Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Date Night ==========="
Logger.info "=========== BEGIN Processing Universe Event Low Key Starved: With Heidi Peelen ==========="

Logger.info "=========== Writing Event Low Key Starved: With Heidi Peelen ==========="
event = SeedHelpers.create_event(
  %{
    slug: "HG10V4",
    title: "Low Key Starved: With Heidi Peelen",
    description: """
    <p><strong>Low Key Starved: With Heidi Peelen</strong><strong></strong><br>
</p>
<p>Being an artist is hard. Despite mom and dads unconditional love and support, we find it almost impossible to scratch seventeen thousand and fifty two dimes together to pay studio rent. Not to mention, the unbearable long days of rack hunting, with an eye for aesthetic it takes to achieve the perfect blend of apathy, poverty, and vintage as to build a wardrobe that whispers "homeless chic" (its called fashion, look it up). Low-Key Starved is an in-depth semi-comedic homage to the creative martyrs of the 757. Unfortunately, this event is priced at the unreasonable high cost of $10 per ticket, which is considerably expensive when you take into account that an artist's diet consists mainly of burnt coffee, bummed cigarettes, and organic produce. Patrons will be rewarded with an hour of riveting material presented in a carefully curated one woman performance in an attempt to vegas-style marry all of the art worlds; from the visual and performative to the written and the vlogged (Sort of like polygamy but without a lot of religious contingencies.)
</p>
<p><br><strong>Low Key Starved: With Heidi Peelen<br>Friday, August 18th, 8pm<br></strong>Tickets $10
</p>
<p><br>___
</p>
<p><br>Leigh HP is an incredibly self aware victim of the millennial generation which means she enjoys celebrating things like waking up in time for work and having her bills paid within a week after delinquent charges are applied by adding boomerangs to her Instagram with hashtags like #adulting and #blessed. Her hobbies include social media scrolling, premature existential crises and giving unsolicited and unwarranted advice on life. <br>If you think she is pretty or you like to look at the internet please visit, like, comment or block any of her social media aliases at decadent-debauchery (insta), Leigh HP (Facebook) or <a href="https://l.facebook.com/l.php?u=http%3A%2F%2Fwww.heidipeelen.com%2F&amp;h=ATMNsVx7kCXHVkTZSPiHLtX_fPYDoCiYL_p-D01dHfl4RUrJhhlekiaDrH0Ukw5GGf8CszUq0F8gtOm-47JhFkTPm9BK-Zx844IHop6kcpbUjQYVlf9w7L7iOEKZqxCI2iNQQQ3pBvs&amp;enc=AZMXHM2x1HWFDNpWJWPgSHfcg3qDiABKYg8fMPnG_q79VFgWr6YodxtjtKeA4jDDD-k&amp;s=1" rel="nofollow" target="_blank">www.heidipeelen.com</a> (world wide web)
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Low Key Starved: With Heidi Peelen ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "HG10V4",
    title: "Low Key Starved: With Heidi Peelen",
    description: """
    <p><strong>Low Key Starved: With Heidi Peelen</strong><strong></strong><br>
</p>
<p>Being an artist is hard. Despite mom and dads unconditional love and support, we find it almost impossible to scratch seventeen thousand and fifty two dimes together to pay studio rent. Not to mention, the unbearable long days of rack hunting, with an eye for aesthetic it takes to achieve the perfect blend of apathy, poverty, and vintage as to build a wardrobe that whispers "homeless chic" (its called fashion, look it up). Low-Key Starved is an in-depth semi-comedic homage to the creative martyrs of the 757. Unfortunately, this event is priced at the unreasonable high cost of $10 per ticket, which is considerably expensive when you take into account that an artist's diet consists mainly of burnt coffee, bummed cigarettes, and organic produce. Patrons will be rewarded with an hour of riveting material presented in a carefully curated one woman performance in an attempt to vegas-style marry all of the art worlds; from the visual and performative to the written and the vlogged (Sort of like polygamy but without a lot of religious contingencies.)
</p>
<p><br><strong>Low Key Starved: With Heidi Peelen<br>Friday, August 18th, 8pm<br></strong>Tickets $10
</p>
<p><br>___
</p>
<p><br>Leigh HP is an incredibly self aware victim of the millennial generation which means she enjoys celebrating things like waking up in time for work and having her bills paid within a week after delinquent charges are applied by adding boomerangs to her Instagram with hashtags like #adulting and #blessed. Her hobbies include social media scrolling, premature existential crises and giving unsolicited and unwarranted advice on life. <br>If you think she is pretty or you like to look at the internet please visit, like, comment or block any of her social media aliases at decadent-debauchery (insta), Leigh HP (Facebook) or <a href="https://l.facebook.com/l.php?u=http%3A%2F%2Fwww.heidipeelen.com%2F&amp;h=ATMNsVx7kCXHVkTZSPiHLtX_fPYDoCiYL_p-D01dHfl4RUrJhhlekiaDrH0Ukw5GGf8CszUq0F8gtOm-47JhFkTPm9BK-Zx844IHop6kcpbUjQYVlf9w7L7iOEKZqxCI2iNQQQ3pBvs&amp;enc=AZMXHM2x1HWFDNpWJWPgSHfcg3qDiABKYg8fMPnG_q79VFgWr6YodxtjtKeA4jDDD-k&amp;s=1" rel="nofollow" target="_blank">www.heidipeelen.com</a> (world wide web)
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-08-18T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-08-18T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c156361f-8489-45c3-a512-d16e791803c3",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c156361f-8489-45c3-a512-d16e791803c3",
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
    name: "Ticket for Low Key Starved: With Heidi Peelen",
    status: "available",
    description: "Ticket for Low Key Starved: With Heidi Peelen",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-18T15:09:07.926Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Low Key Starved: With Heidi Peelen ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Stand-up Comedy Grad Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Stand-up Comedy Grad Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "GZS26Q",
    title: "Class Dismissed: The Stand-up Comedy Grad Show",
    description: """
    <p>Get your first glimpse at Hampton Roads' newest comedy superstars!!!
</p>
<p>The Push Comedy Theater is proud to present the debut show from some talented, new stand-up comedians! See seven newbies grab the mic and find their funny!
</p>
<p>Starring:
</p>
<p>Stephen Devery
</p>
<p>Jackson Nacey
</p>
<p>Dean Perry
</p>
<p>Robert Taylor
</p>
<p>Paul Caffrey
</p>
<p>TJ Ramsey
</p>
<p>Marty Boo
</p>
<p>Hosted by Hatton Jordan
</p>
<p>Hatton is a veteran stand-up comic who has kept his microphone in the comedy game for more than 25 years and has performed professionally in more than 15 states.
</p>
<p>Hatton started his comedy career at the ol' Thoroughgood Inn Comedy Club in Va Beach and since then has worked many hot comedy spots such as the Improv in Washington DC, The Comedy Cabana in South Carolina, JRs in Erie, Pennyslvania and the River Center Comedy Club in San Antonio.
</p>
<p>Support the stand-up scene at the Push Theater!!
</p>
<p>Class Dismissed: The Stand-Up Comedy 101 Grad Show
</p>
<p>Saturday, May 27th at 6pm
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
Logger.info "=========== Writing Event Listing Class Dismissed: The Stand-up Comedy Grad Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "GZS26Q",
    title: "Class Dismissed: The Stand-up Comedy Grad Show",
    description: """
    <p>Get your first glimpse at Hampton Roads' newest comedy superstars!!!
</p>
<p>The Push Comedy Theater is proud to present the debut show from some talented, new stand-up comedians! See seven newbies grab the mic and find their funny!
</p>
<p>Starring:
</p>
<p>Stephen Devery
</p>
<p>Jackson Nacey
</p>
<p>Dean Perry
</p>
<p>Robert Taylor
</p>
<p>Paul Caffrey
</p>
<p>TJ Ramsey
</p>
<p>Marty Boo
</p>
<p>Hosted by Hatton Jordan
</p>
<p>Hatton is a veteran stand-up comic who has kept his microphone in the comedy game for more than 25 years and has performed professionally in more than 15 states.
</p>
<p>Hatton started his comedy career at the ol' Thoroughgood Inn Comedy Club in Va Beach and since then has worked many hot comedy spots such as the Improv in Washington DC, The Comedy Cabana in South Carolina, JRs in Erie, Pennyslvania and the River Center Comedy Club in San Antonio.
</p>
<p>Support the stand-up scene at the Push Theater!!
</p>
<p>Class Dismissed: The Stand-Up Comedy 101 Grad Show
</p>
<p>Saturday, May 27th at 6pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-05-27T18:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-27T19:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-26T23:38:51.125Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Stand-up Comedy Grad Show ==========="
Logger.info "=========== BEGIN Processing Universe Event New Harold Night ==========="

Logger.info "=========== Writing Event New Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "FH2ZMD",
    title: "New Harold Night",
    description: """
    <p><strong></strong><strong>It's New Harold Night at the Push Comedy Theater!</strong></p><p>Don't miss it as we unveil our brand, new house teams... Star 69 and Cahoots!!!</p><p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p><strong>New Harold Night </strong><br>Friday, January 2nd, 8pm<br>Tickets are $5.<br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "FH2ZMD",
    title: "New Harold Night",
    description: """
    <p><strong></strong><strong>It's New Harold Night at the Push Comedy Theater!</strong></p><p>Don't miss it as we unveil our brand, new house teams... Star 69 and Cahoots!!!</p><p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p><strong>New Harold Night </strong><br>Friday, January 2nd, 8pm<br>Tickets are $5.<br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-01-02T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-01-02T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2015-12-29T19:30:41.973Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event New Harold Night ==========="
Logger.info "=========== BEGIN Processing Universe Event Set Phasers to Dumb: The Improvised Star Trek Show ==========="

Logger.info "=========== Writing Event Set Phasers to Dumb: The Improvised Star Trek Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "DK4QRV",
    title: "Set Phasers to Dumb: The Improvised Star Trek Show",
    description: """
    <p>Set your phasers to dumb... the Push Comedy Theater presents and improvised parody of the original Star Trek.
</p>
<p>Join Kirk, Spock, Bones and the rest of the Enterprise crew as they boldly go... wherever the audience's suggestion sends them.
</p>
<p>Whether you're a Trekker, a casual fan or don't know the difference between Star Trek and Star Wars, this show is guaranteed to be a blast.
</p>
<p><strong>Set Phasers to Dumb: The Improvised Star Trek Show</strong><br>Friday, July 22 at 8pm
</p>
<p>Tickets are $5
</p>
<p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
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
Logger.info "=========== Writing Event Listing Set Phasers to Dumb: The Improvised Star Trek Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "DK4QRV",
    title: "Set Phasers to Dumb: The Improvised Star Trek Show",
    description: """
    <p>Set your phasers to dumb... the Push Comedy Theater presents and improvised parody of the original Star Trek.
</p>
<p>Join Kirk, Spock, Bones and the rest of the Enterprise crew as they boldly go... wherever the audience's suggestion sends them.
</p>
<p>Whether you're a Trekker, a casual fan or don't know the difference between Star Trek and Star Wars, this show is guaranteed to be a blast.
</p>
<p><strong>Set Phasers to Dumb: The Improvised Star Trek Show</strong><br>Friday, July 22 at 8pm
</p>
<p>Tickets are $5
</p>
<p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
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
    start_at:  NaiveDateTime.from_iso8601!("2016-07-22T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-22T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/3cef5079-f1ca-4456-a5e6-454f5e24f573",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/3cef5079-f1ca-4456-a5e6-454f5e24f573",
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

# Insert trek
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "trek"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Set Phasers to Dumb: The Improvised Star Trek Show",
    status: "available",
    description: "Ticket for Set Phasers to Dumb: The Improvised Star Trek Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-19T03:35:36.056Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Set Phasers to Dumb: The Improvised Star Trek Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More Storytelling ==========="

Logger.info "=========== Writing Event Tell Me More Storytelling ==========="
event = SeedHelpers.create_event(
  %{
    slug: "M50P7J",
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
    slug: "M50P7J",
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-16T04:42:14.924Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More Storytelling ==========="
Logger.info "=========== BEGIN Processing Universe Event Storytelling Night: Awkward ==========="

Logger.info "=========== Writing Event Storytelling Night: Awkward ==========="
event = SeedHelpers.create_event(
  %{
    slug: "2TDPML",
    title: "Storytelling Night: Awkward",
    description: """
    <p>Join us 7 p.m. Sept. 17 at the Push Comedy Theater for a night of stories. This month the theme is "awkward." Storytellers to be announced. Admission: $5.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Storytelling Night: Awkward ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "2TDPML",
    title: "Storytelling Night: Awkward",
    description: """
    <p>Join us 7 p.m. Sept. 17 at the Push Comedy Theater for a night of stories. This month the theme is "awkward." Storytellers to be announced. Admission: $5.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-09-17T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-17T20:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/ef34afa5-7c02-4dc3-a6c3-cbcccffec5d6",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/ef34afa5-7c02-4dc3-a6c3-cbcccffec5d6",
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
    name: "Ticket for Storytelling Night: Awkward",
    status: "available",
    description: "Ticket for Storytelling Night: Awkward",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-12T17:42:16.453Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Storytelling Night: Awkward ==========="
