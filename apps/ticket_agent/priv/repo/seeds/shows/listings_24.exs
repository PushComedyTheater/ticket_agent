require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event Couples Therapy ==========="

Logger.info "=========== Writing Event Couples Therapy ==========="
event = SeedHelpers.create_event(
  %{
    slug: "LM4R9K",
    title: "Couples Therapy",
    description: """
    <p><strong></strong><strong>You think your relationship has problems?!?</strong>
</p>
<p>In Couples Therapy you'll meet a couple on the rocks... be it newlyweds on a honeymoon from hell or an elderly couple at the end of their rope.<br>Based on an audience suggestion, Sean and Brittany take you through a roller coaster ride of emotions as they whisk you the trials and tribulations of couple they create right before your eyes.
</p>
<p>Oh yeah, and they do it all in a single, 25 minute long improvised scene.
</p>
<p>Two Improvisers... One Scene!!!
</p>
<p><strong>Couples Therapy... is sometimes hilarious, sometimes poignant, always magical.</strong>
</p>
<p>Sean Devereux and Brittany Shearer are members of the improv group, Alan Johnson and the Johnson Quintet. The duo have dazzled audience members at Improvageddon, and now they're getting their own show.
</p>
<p>When not performing with the Quintet, Sean is a member of The Pushers and Brittany performs with The Pre Madonnas.
</p>
<p>Sean and Brittany are not a couple in real life, but occasionally they play one on stage.
</p>
<p><strong>Couples Therapy with Alan Johnson and the Alan Johnson Quintet</strong><br>Saturday, July 30th at 8pm<br>Tickets are $5
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
Logger.info "=========== Writing Event Listing Couples Therapy ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "LM4R9K",
    title: "Couples Therapy",
    description: """
    <p><strong></strong><strong>You think your relationship has problems?!?</strong>
</p>
<p>In Couples Therapy you'll meet a couple on the rocks... be it newlyweds on a honeymoon from hell or an elderly couple at the end of their rope.<br>Based on an audience suggestion, Sean and Brittany take you through a roller coaster ride of emotions as they whisk you the trials and tribulations of couple they create right before your eyes.
</p>
<p>Oh yeah, and they do it all in a single, 25 minute long improvised scene.
</p>
<p>Two Improvisers... One Scene!!!
</p>
<p><strong>Couples Therapy... is sometimes hilarious, sometimes poignant, always magical.</strong>
</p>
<p>Sean Devereux and Brittany Shearer are members of the improv group, Alan Johnson and the Johnson Quintet. The duo have dazzled audience members at Improvageddon, and now they're getting their own show.
</p>
<p>When not performing with the Quintet, Sean is a member of The Pushers and Brittany performs with The Pre Madonnas.
</p>
<p>Sean and Brittany are not a couple in real life, but occasionally they play one on stage.
</p>
<p><strong>Couples Therapy with Alan Johnson and the Alan Johnson Quintet</strong><br>Saturday, July 30th at 8pm<br>Tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2016-07-30T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-30T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-06-26T02:40:07.670Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Couples Therapy ==========="
Logger.info "=========== BEGIN Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="

Logger.info "=========== Writing Event Who Dunnit? ...The Improvised Murder Mystery ==========="
event = SeedHelpers.create_event(
  %{
    slug: "WX2CYP",
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
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, December 9th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $10
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
Logger.info "=========== Writing Event Listing Who Dunnit? ...The Improvised Murder Mystery ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "WX2CYP",
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
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, December 9th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $10
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
    start_at:  NaiveDateTime.from_iso8601!("2017-12-09T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-12-09T21:30:00.000-05:00")
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
    name: "Ticket for Who Dunnit? ...The Improvised Murder Mystery",
    status: "available",
    description: "Ticket for Who Dunnit? ...The Improvised Murder Mystery",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-13T17:00:27.979Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="
Logger.info "=========== BEGIN Processing Universe Event Tales from the Campfire: The Improvised Ghost Story ==========="

Logger.info "=========== Writing Event Tales from the Campfire: The Improvised Ghost Story ==========="
event = SeedHelpers.create_event(
  %{
    slug: "XKG4F3",
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
<p>Saturday, August 5th at 8pm
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
    slug: "XKG4F3",
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
<p>Saturday, August 5th at 8pm
</p>
<p>Tickets are $5
</p>
<p><br>
</p>
<p>I ain't afraid of no ghost!
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-08-05T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-08-05T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-21T18:38:37.152Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tales from the Campfire: The Improvised Ghost Story ==========="
Logger.info "=========== BEGIN Processing Universe Event The Pushers Halloween Spooktacular and Costume Contest!!! ==========="

Logger.info "=========== Writing Event The Pushers Halloween Spooktacular and Costume Contest!!! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "8Z1F5C",
    title: "The Pushers Halloween Spooktacular and Costume Contest!!!",
    description: """
    <p>Halloween is almost here... and that means it's time for <strong>The Pushers Halloween Spooktacular and Costume Contest!!!</strong><br> <br>  The Pushers are back with a vengeance. The  gang has written a freaky and frightening new show chock full of their  trademarked racy and raucous humor. This is the show people are going to  be talking about for a long time to come.<br> <strong><br> The Pushers Halloween Spooktacular!!!</strong><br> It has all the spooks, frights and carnage of a normal Pushers' show only it's all amped up to 11.<br> <br><strong>***During Intermission we will be holding a good, old-fashioned Halloween costume contest***</strong><br>We have some great prizes we will be handing out. And all those coming to the show in costume receive $5 off their ticket.<br> <br> <strong>The Pushers Halloween Spooktacular</strong><br> Friday, October 27th at The Push Comedy Theater<br> The show starts at 10pm<br> <br> The Push Comedy Theater<br> 763 Granby Street  .  Norfolk<br> <br> <a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">pushcomedytheater.com</a>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Pushers Halloween Spooktacular and Costume Contest!!! ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "8Z1F5C",
    title: "The Pushers Halloween Spooktacular and Costume Contest!!!",
    description: """
    <p>Halloween is almost here... and that means it's time for <strong>The Pushers Halloween Spooktacular and Costume Contest!!!</strong><br> <br>  The Pushers are back with a vengeance. The  gang has written a freaky and frightening new show chock full of their  trademarked racy and raucous humor. This is the show people are going to  be talking about for a long time to come.<br> <strong><br> The Pushers Halloween Spooktacular!!!</strong><br> It has all the spooks, frights and carnage of a normal Pushers' show only it's all amped up to 11.<br> <br><strong>***During Intermission we will be holding a good, old-fashioned Halloween costume contest***</strong><br>We have some great prizes we will be handing out. And all those coming to the show in costume receive $5 off their ticket.<br> <br> <strong>The Pushers Halloween Spooktacular</strong><br> Friday, October 27th at The Push Comedy Theater<br> The show starts at 10pm<br> <br> The Push Comedy Theater<br> 763 Granby Street  .  Norfolk<br> <br> <a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">pushcomedytheater.com</a>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-10-27T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-10-27T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/de2ae134-3bad-42e7-b8f4-156826e4b6a1",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/de2ae134-3bad-42e7-b8f4-156826e4b6a1",
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

# Insert halloween
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "halloween"
})
Logger.info "=========== Wrote tag ==========="

# Insert spooktacular
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "spooktacular"
})
Logger.info "=========== Wrote tag ==========="

# Insert costume
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "costume"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Pushers Halloween Spooktacular and Costume Contest!!!",
    status: "available",
    description: "Ticket for The Pushers Halloween Spooktacular and Costume Contest!!!",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-17T02:21:26.367Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Pushers Halloween Spooktacular and Costume Contest!!! ==========="
Logger.info "=========== BEGIN Processing Universe Event On The House: Housewarming Sketch Comedy Show ==========="

Logger.info "=========== Writing Event On The House: Housewarming Sketch Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "LTJFWQ",
    title: "On The House: Housewarming Sketch Comedy Show",
    description: """
    <p>The Push Comedy Theater is proud to present On The House: Housewarming Sketch Comedy Show!
</p>
<p>This crazy, funny family of hysterically dysfunctional young comedians (plus one older guy) will have you rolling in the aisles.
</p>
<p>Its On The House's inaugural show, and you can be a part of history as they offer their take on dating, food, sex, and more!
</p>
<p>Come on in. The beers are cold. The comedy is hot.
</p>
<p>Let's party.
</p>
<p>On The House
</p>
<p>Sunday, June 11th at 7pm
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
Logger.info "=========== Writing Event Listing On The House: Housewarming Sketch Comedy Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "LTJFWQ",
    title: "On The House: Housewarming Sketch Comedy Show",
    description: """
    <p>The Push Comedy Theater is proud to present On The House: Housewarming Sketch Comedy Show!
</p>
<p>This crazy, funny family of hysterically dysfunctional young comedians (plus one older guy) will have you rolling in the aisles.
</p>
<p>Its On The House's inaugural show, and you can be a part of history as they offer their take on dating, food, sex, and more!
</p>
<p>Come on in. The beers are cold. The comedy is hot.
</p>
<p>Let's party.
</p>
<p>On The House
</p>
<p>Sunday, June 11th at 7pm
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
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-06-11T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-06-11T20:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/304160b8-a984-471b-b5a3-df208d0e9735",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/304160b8-a984-471b-b5a3-df208d0e9735",
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
    name: "Ticket for On The House: Housewarming Sketch Comedy Show",
    status: "available",
    description: "Ticket for On The House: Housewarming Sketch Comedy Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-24T20:02:25.760Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event On The House: Housewarming Sketch Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 301 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 301 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "JH9L8Y",
    title: "Class Dismissed: The Improv 301 Graduation Show",
    description: """
    <p>It's Harold Time!!!<br> <br> So who the heck is Harold? More accurately the question should be... what the heck is a Harold?<br> <br>  The Harold is perhaps the best know style of long form improv. It  starts with an audience suggestion, then improvisers weave together  scenes, characters and group games to create a seamless piece. It can be  bizarre and magical, baffling and amazing... it definitely needs to be  seen.<br> <br> The Push Comedy Theater's 301 students take the Harold head on! Don't miss it.<br> <br> Class Dismissed: The Improv 301 Graduation Show<br> Wednesday, June 8th, at 8pm<br> Tickets are $5<br> <br> <br> The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br> <br>  Free parking available at Slone Chiropractic (111 W Virginia Beach)  just one block from the theater. There is also limited parking on the  street.</p>
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
    slug: "JH9L8Y",
    title: "Class Dismissed: The Improv 301 Graduation Show",
    description: """
    <p>It's Harold Time!!!<br> <br> So who the heck is Harold? More accurately the question should be... what the heck is a Harold?<br> <br>  The Harold is perhaps the best know style of long form improv. It  starts with an audience suggestion, then improvisers weave together  scenes, characters and group games to create a seamless piece. It can be  bizarre and magical, baffling and amazing... it definitely needs to be  seen.<br> <br> The Push Comedy Theater's 301 students take the Harold head on! Don't miss it.<br> <br> Class Dismissed: The Improv 301 Graduation Show<br> Wednesday, June 8th, at 8pm<br> Tickets are $5<br> <br> <br> The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br> <br>  Free parking available at Slone Chiropractic (111 W Virginia Beach)  just one block from the theater. There is also limited parking on the  street.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-08T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-08T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/a60414d2-b0f3-48d7-85c1-817e45faf7be",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/a60414d2-b0f3-48d7-85c1-817e45faf7be",
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-25T21:24:22.269Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 301 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Dudes: What Would The Jesus Do? ==========="

Logger.info "=========== Writing Event The Dudes: What Would The Jesus Do? ==========="
event = SeedHelpers.create_event(
  %{
    slug: "FT7NSY",
    title: "The Dudes: What Would The Jesus Do?",
    description: """
    <p>Easter and Shabbos are done... now what? WWTJD - What Would The Jesus Do?</p><p>Come find out with The Dudes! The Dudes are bunch of guys who like to drink like dudes, talk dude things, and perfom dude comedy. They're multi-IMPROVAGEDDON champions and they have an oscillating fan for some reason.</p><p>Don't miss a night of Dude-inspired comedy, with an appearance from a special, secret guest Dude(tte), and featuring the Cinderellas of the 3-on-3 Improv Tournament, The Cat Nips!</p><p><strong>The Dudes Improvasitional Comedy are:</strong></p><p>Rafael <br>Adam Paine<br>James Roach<br>Matt Cole <br>Brian Garraty<br>Anthony Nobles</p><p><strong>The Dudes: What Would The Jesus Do?</strong><br>Saturday, April 2nd at 10pm<br>Tickets are $5</p><p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Dudes: What Would The Jesus Do? ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "FT7NSY",
    title: "The Dudes: What Would The Jesus Do?",
    description: """
    <p>Easter and Shabbos are done... now what? WWTJD - What Would The Jesus Do?</p><p>Come find out with The Dudes! The Dudes are bunch of guys who like to drink like dudes, talk dude things, and perfom dude comedy. They're multi-IMPROVAGEDDON champions and they have an oscillating fan for some reason.</p><p>Don't miss a night of Dude-inspired comedy, with an appearance from a special, secret guest Dude(tte), and featuring the Cinderellas of the 3-on-3 Improv Tournament, The Cat Nips!</p><p><strong>The Dudes Improvasitional Comedy are:</strong></p><p>Rafael <br>Adam Paine<br>James Roach<br>Matt Cole <br>Brian Garraty<br>Anthony Nobles</p><p><strong>The Dudes: What Would The Jesus Do?</strong><br>Saturday, April 2nd at 10pm<br>Tickets are $5</p><p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-02T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-02T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/eb76ed68-49d8-4a43-9379-9fb5013e31ff",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/eb76ed68-49d8-4a43-9379-9fb5013e31ff",
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
    name: "Ticket for The Dudes: What Would The Jesus Do?",
    status: "available",
    description: "Ticket for The Dudes: What Would The Jesus Do?",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-28T22:22:56.553Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Dudes: What Would The Jesus Do? ==========="
Logger.info "=========== BEGIN Processing Universe Event Stand-Up for Veterans ==========="

Logger.info "=========== Writing Event Stand-Up for Veterans ==========="
event = SeedHelpers.create_event(
  %{
    slug: "3VDQCF",
    title: "Stand-Up for Veterans",
    description: """
    <p>Join the Armed Services Arts Partnership (ASAP) and the Push Comedy Theater for an evening of stand-up comedy to support the Hampton Roads military community. The show will feature a cast of talented veteran comics, all graduates of ASAP’s nationally recognized Comedy Bootcamp program. It will be a tremendous evening with lots of laughs.
</p>
<p>The event will take place at 6pm on Sunday, August 14th at the Push Comedy Theater in Norfolk, VA. Over 50% of proceeds help benefit the local community and support ASAP’s mission of serving veterans through the arts.
</p>
<p><strong>Line-Up --</strong>
</p>
<p>Maurice Johnson
</p>
<p>Mike Lake
</p>
<p>Sharon Kang
</p>
<p>Jim King
</p>
<p>Jose Roman
</p>
<p>Mae Brayton
</p>
<p>Maureen Norman
</p>
<p>Tyler Strausbaugh
</p>
<p>Isaura Ramirez
</p>
<p><br>
</p>
<p><strong>Stand-Up for Veterans</strong>
</p>
<p>Sunday, September 25th at 7pm
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
Logger.info "=========== Writing Event Listing Stand-Up for Veterans ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "3VDQCF",
    title: "Stand-Up for Veterans",
    description: """
    <p>Join the Armed Services Arts Partnership (ASAP) and the Push Comedy Theater for an evening of stand-up comedy to support the Hampton Roads military community. The show will feature a cast of talented veteran comics, all graduates of ASAP’s nationally recognized Comedy Bootcamp program. It will be a tremendous evening with lots of laughs.
</p>
<p>The event will take place at 6pm on Sunday, August 14th at the Push Comedy Theater in Norfolk, VA. Over 50% of proceeds help benefit the local community and support ASAP’s mission of serving veterans through the arts.
</p>
<p><strong>Line-Up --</strong>
</p>
<p>Maurice Johnson
</p>
<p>Mike Lake
</p>
<p>Sharon Kang
</p>
<p>Jim King
</p>
<p>Jose Roman
</p>
<p>Mae Brayton
</p>
<p>Maureen Norman
</p>
<p>Tyler Strausbaugh
</p>
<p>Isaura Ramirez
</p>
<p><br>
</p>
<p><strong>Stand-Up for Veterans</strong>
</p>
<p>Sunday, September 25th at 7pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-25T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-25T21:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/ac937fba-9dd1-4409-ac17-b4abcb8587d6",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/ac937fba-9dd1-4409-ac17-b4abcb8587d6",
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
    name: "Ticket for Stand-Up for Veterans",
    status: "available",
    description: "Ticket for Stand-Up for Veterans",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-23T03:06:47.779Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Stand-Up for Veterans ==========="
Logger.info "=========== BEGIN Processing Universe Event First Friday at the Push Comedy Theater ==========="

Logger.info "=========== Writing Event First Friday at the Push Comedy Theater ==========="
event = SeedHelpers.create_event(
  %{
    slug: "3L52DP",
    title: "First Friday at the Push Comedy Theater",
    description: """
    <p>In honor of <strong>First Friday in </strong><strong>The NEON District</strong>, we will be offering a night of free improv!
</p>
<p>Starting at 5pm, The Pushers and our friends will be performing a free improv show every half hour.
</p>
<p>It'll be like a mini improv marathon...  Don't miss out on the fun.  It's totally FREE.
</p>
<p><strong>First Friday at the Push Comedy Theater</strong>
</p>
<p>Friday, June 2nd starting at 5pm.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing First Friday at the Push Comedy Theater ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "3L52DP",
    title: "First Friday at the Push Comedy Theater",
    description: """
    <p>In honor of <strong>First Friday in </strong><strong>The NEON District</strong>, we will be offering a night of free improv!
</p>
<p>Starting at 5pm, The Pushers and our friends will be performing a free improv show every half hour.
</p>
<p>It'll be like a mini improv marathon...  Don't miss out on the fun.  It's totally FREE.
</p>
<p><strong>First Friday at the Push Comedy Theater</strong>
</p>
<p>Friday, June 2nd starting at 5pm.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-06-02T17:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-06-02T21:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/0dd4af21-9893-4704-82a4-5d709ab95a4f",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/0dd4af21-9893-4704-82a4-5d709ab95a4f",
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
    name: "Ticket for First Friday at the Push Comedy Theater",
    status: "available",
    description: "Ticket for First Friday at the Push Comedy Theater",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-24T20:18:49.841Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event First Friday at the Push Comedy Theater ==========="
Logger.info "=========== BEGIN Processing Universe Event The Upright Senior Citizens Brigade: Holiday Extravaganza! ==========="

Logger.info "=========== Writing Event The Upright Senior Citizens Brigade: Holiday Extravaganza! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "J9L72Z",
    title: "The Upright Senior Citizens Brigade: Holiday Extravaganza!",
    description: """
    <p>YOUTH IS WASTED ON THE YOUNG
</p>
<p>Don't Miss The Upright Senior Citizens Brigade as they show you how they celebrate the holidays!
</p>
<p>With special guest, Brad McMurran!
</p>
<p>The Upright Senior Citizens Brigade is a group of 50-year old and up individuals who perform both long and short-form improv as well as sketch comedy. They were trained by The Pushers and with more than 500 years of life experience, they bridge the generation gap in ways you cannot imagine!
</p>
<p>These 50+ year old fogeys will have you in stitches and wishing you wore your depends.
</p>
<p>Don't miss it!
</p>
<p>The Upright Senior Citizens Brigade
</p>
<p>Friday, December 15th at 8pm
</p>
<p>Tickets are $10
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Upright Senior Citizens Brigade: Holiday Extravaganza! ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "J9L72Z",
    title: "The Upright Senior Citizens Brigade: Holiday Extravaganza!",
    description: """
    <p>YOUTH IS WASTED ON THE YOUNG
</p>
<p>Don't Miss The Upright Senior Citizens Brigade as they show you how they celebrate the holidays!
</p>
<p>With special guest, Brad McMurran!
</p>
<p>The Upright Senior Citizens Brigade is a group of 50-year old and up individuals who perform both long and short-form improv as well as sketch comedy. They were trained by The Pushers and with more than 500 years of life experience, they bridge the generation gap in ways you cannot imagine!
</p>
<p>These 50+ year old fogeys will have you in stitches and wishing you wore your depends.
</p>
<p>Don't miss it!
</p>
<p>The Upright Senior Citizens Brigade
</p>
<p>Friday, December 15th at 8pm
</p>
<p>Tickets are $10
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-12-15T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-12-15T21:30:00.000-05:00")
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
    name: "Ticket for The Upright Senior Citizens Brigade: Holiday Extravaganza!",
    status: "available",
    description: "Ticket for The Upright Senior Citizens Brigade: Holiday Extravaganza!",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-21T21:10:24.536Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Upright Senior Citizens Brigade: Holiday Extravaganza! ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More Storytelling ==========="

Logger.info "=========== Writing Event Tell Me More Storytelling ==========="
event = SeedHelpers.create_event(
  %{
    slug: "BQG0KD",
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
    slug: "BQG0KD",
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-16T04:40:19.730Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More Storytelling ==========="
Logger.info "=========== BEGIN Processing Universe Event The Dudes: The Bums' Revolution ==========="

Logger.info "=========== Writing Event The Dudes: The Bums' Revolution ==========="
event = SeedHelpers.create_event(
  %{
    slug: "QJDPLH",
    title: "The Dudes: The Bums' Revolution",
    description: """
    <p>"Your revolution is over, Mr. Lebowski! Condolences. The BUMS lost." - Jeffery "Big" Lebowski
</p>
<p>With the BIG election coming to a close, The Dudes refuse to let the election-hangover aggression stand, man. In fact, we're revolting against the whole system! Come out for some promising, honest laughs at The Push Comedy Theater in Norfolk's NEON Arts District!
</p>
<p>The Dudes are bunch of guys, often laid back but sometimes high-strung, who like to drink beer, talk about dude things, and perfom improv comedy. They're multi-IMPROVAGEDDON champions and have performed up and down I-64.
</p>
<p>Don't miss a night of Dude-inspired comedy, featuring "The Rant" (a.k..a The Walter) longform-style improv!
</p>
<p>The Dudes Improvisational Comedy are:
</p>
<p>Rafael
</p>
<p>Adam
</p>
<p>James
</p>
<p>Matt
</p>
<p>Brian
</p>
<p>Anthony
</p>
<p>The Dudes present... The Bums' Revolution
</p>
<p>Saturday, November 12th at 10pm
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
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.
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
Logger.info "=========== Writing Event Listing The Dudes: The Bums' Revolution ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "QJDPLH",
    title: "The Dudes: The Bums' Revolution",
    description: """
    <p>"Your revolution is over, Mr. Lebowski! Condolences. The BUMS lost." - Jeffery "Big" Lebowski
</p>
<p>With the BIG election coming to a close, The Dudes refuse to let the election-hangover aggression stand, man. In fact, we're revolting against the whole system! Come out for some promising, honest laughs at The Push Comedy Theater in Norfolk's NEON Arts District!
</p>
<p>The Dudes are bunch of guys, often laid back but sometimes high-strung, who like to drink beer, talk about dude things, and perfom improv comedy. They're multi-IMPROVAGEDDON champions and have performed up and down I-64.
</p>
<p>Don't miss a night of Dude-inspired comedy, featuring "The Rant" (a.k..a The Walter) longform-style improv!
</p>
<p>The Dudes Improvisational Comedy are:
</p>
<p>Rafael
</p>
<p>Adam
</p>
<p>James
</p>
<p>Matt
</p>
<p>Brian
</p>
<p>Anthony
</p>
<p>The Dudes present... The Bums' Revolution
</p>
<p>Saturday, November 12th at 10pm
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
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-11-12T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-11-12T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/79382678-d486-41e3-881a-0a78203ebea3",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/79382678-d486-41e3-881a-0a78203ebea3",
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
    name: "Ticket for The Dudes: The Bums' Revolution",
    status: "available",
    description: "Ticket for The Dudes: The Bums' Revolution",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-10-26T20:27:03.844Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Dudes: The Bums' Revolution ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Musical Improv 101 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Musical Improv 101 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "7KGDXF",
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
<p>Sunday, September 10th at 6pm
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
    slug: "7KGDXF",
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
<p>Sunday, September 10th at 6pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-09-10T18:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-10T19:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-07T01:15:30.335Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Musical Improv 101 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More... Storytelling Nights: Iced ==========="

Logger.info "=========== Writing Event Tell Me More... Storytelling Nights: Iced ==========="
event = SeedHelpers.create_event(
  %{
    slug: "CP76QR",
    title: "Tell Me More... Storytelling Nights: Iced",
    description: """
    <p>Join us 7 p.m. Jan. 17 to hear stories along these lines. The night air may literally meet the theme, but you’ll be warm inside with us.</p><p>THEME<br>Theme: Iced<br>Song: “Cold Shot,” by Stevie Ray Vaughn<br>Possibly inspiring stories of: Cold, hard facts and unavoidable truth.</p><p>FEATURED STORYTELLERS<br>We’re picking our storytellers now. We’ll let you know when we’re done. If you’re interested in telling a story for a future show, tell us about it here:<a href="http://tellmemorelive.org/sign-up/" rel="nofollow" target="_blank">http://tellmemorelive.org/<wbr>sign-up/</wbr></a></p><p>OUR HOST<br>Brendan Kennedy, is a comedian, storyteller and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”</p><p>RECORDINGS<br>If all goes as planned, and with the permission of the storytellers, each story will be recorded and posted individually episodes for the Tell Me More… Live podcast.</p><p>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, Jan. 17, 2015<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Tell Me More... Storytelling Nights: Iced ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "CP76QR",
    title: "Tell Me More... Storytelling Nights: Iced",
    description: """
    <p>Join us 7 p.m. Jan. 17 to hear stories along these lines. The night air may literally meet the theme, but you’ll be warm inside with us.</p><p>THEME<br>Theme: Iced<br>Song: “Cold Shot,” by Stevie Ray Vaughn<br>Possibly inspiring stories of: Cold, hard facts and unavoidable truth.</p><p>FEATURED STORYTELLERS<br>We’re picking our storytellers now. We’ll let you know when we’re done. If you’re interested in telling a story for a future show, tell us about it here:<a href="http://tellmemorelive.org/sign-up/" rel="nofollow" target="_blank">http://tellmemorelive.org/<wbr>sign-up/</wbr></a></p><p>OUR HOST<br>Brendan Kennedy, is a comedian, storyteller and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”</p><p>RECORDINGS<br>If all goes as planned, and with the permission of the storytellers, each story will be recorded and posted individually episodes for the Tell Me More… Live podcast.</p><p>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, Jan. 17, 2015<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-01-17T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-01-17T21:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9e843970-70b2-40ca-9a6e-1fb421618f6a",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9e843970-70b2-40ca-9a6e-1fb421618f6a",
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
    name: "Ticket for Tell Me More... Storytelling Nights: Iced",
    status: "available",
    description: "Ticket for Tell Me More... Storytelling Nights: Iced",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-01-13T03:40:18.475Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More... Storytelling Nights: Iced ==========="
Logger.info "=========== BEGIN Processing Universe Event Tales from the Campfire: The Improvised Ghost Story ==========="

Logger.info "=========== Writing Event Tales from the Campfire: The Improvised Ghost Story ==========="
event = SeedHelpers.create_event(
  %{
    slug: "PKZS4D",
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
<p>Saturday, November 4th at 8pm
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
    slug: "PKZS4D",
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
<p>Saturday, November 4th at 8pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-11-04T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-04T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-13T20:14:20.047Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tales from the Campfire: The Improvised Ghost Story ==========="
Logger.info "=========== BEGIN Processing Universe Event Double Feature: The Made Up Movie ==========="

Logger.info "=========== Writing Event Double Feature: The Made Up Movie ==========="
event = SeedHelpers.create_event(
  %{
    slug: "Q8YNZC",
    title: "Double Feature: The Made Up Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong>
</p>
<p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.
</p>
<p><strong>Double Feature: The Totally Improvised Movie</strong><br>Friday, February 17th at 10pm
</p>
<p>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.
</p>
<p><br>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In November of 2014, they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
</p>
<p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.
</p>
<p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.
</p>
<p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funny Bone.
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
    slug: "Q8YNZC",
    title: "Double Feature: The Made Up Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong>
</p>
<p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.
</p>
<p><strong>Double Feature: The Totally Improvised Movie</strong><br>Friday, February 17th at 10pm
</p>
<p>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.
</p>
<p><br>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In November of 2014, they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
</p>
<p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.
</p>
<p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.
</p>
<p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funny Bone.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-02-17T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-02-17T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-02-16T20:07:48.904Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Double Feature: The Made Up Movie ==========="
Logger.info "=========== BEGIN Processing Universe Event Teacher's Pet ==========="

Logger.info "=========== Writing Event Teacher's Pet ==========="
event = SeedHelpers.create_event(
  %{
    slug: "CLVH1W",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Saturday, November 18th, 10pm<br>Tickets are $5
</p>
<p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p>--<br>
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
    slug: "CLVH1W",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Saturday, November 18th, 10pm<br>Tickets are $5
</p>
<p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p>--<br>
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-11-18T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-18T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-14T02:54:01.709Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Teacher's Pet ==========="
Logger.info "=========== BEGIN Processing Universe Event The Neon Festival at the Push (FREE SHOW!!!) ==========="

Logger.info "=========== Writing Event The Neon Festival at the Push (FREE SHOW!!!) ==========="
event = SeedHelpers.create_event(
  %{
    slug: "G26QNK",
    title: "The Neon Festival at the Push (FREE SHOW!!!)",
    description: """
    <p style="text-align: center;"><strong></strong><strong>The NEON Festival comes to the Push!!!</strong></p><p style="text-align: center;">In honor of this amazing celebration, the Push will be hosting free improv shows all night long.</p><p style="text-align: center;">Starting at 6:30 we will have a free improv shows every half hour featuring The Pushers and some of the Push Comedy Theater's funniest improvisers.</p><p style="text-align: center;"><strong>The Neon Festival at the Push (FREE SHOW!!!)</strong><br>Friday, October 16th. Free shows every half hour starting at 6:30</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/6cee6127f91c79fb724b43506a7dd1ef-Neon.jpg" alt="" style="display: block; margin: auto;"></p><p style="text-align: center;"><br>Announcing The NEON Festival, a two day celebration of energy and light in Norfolk’s Arts District. The festival is a showcase for public art and performances that will transform the NEON into a true arts destination. Wander through the neighborhood to discover tiny art happenings, large-scale murals and pops of neon color and light. </p><p style="text-align: center;">From 5 to10 pm on the nights of October 15 and 16, expect to see local and national artists, performers and musicians in NEON District venues like the Chrysler Museum &amp; Glass Studio, Work Release, The Parlor, Push Comedy Theater, Zeke's Beans &amp; Bowls, and more. More information and a full schedule of events coming soon. </p><p style="text-align: center;">Presented by Business Consortium for Arts Support and The Virginian-Pilot and produced by Downtown Norfolk Council, Chrysler Museum &amp; Glass Studio, Virginia Arts Festival and AltDaily.</p><p style="text-align: center;">It's time to turn NEON on!</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Neon Festival at the Push (FREE SHOW!!!) ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "G26QNK",
    title: "The Neon Festival at the Push (FREE SHOW!!!)",
    description: """
    <p style="text-align: center;"><strong></strong><strong>The NEON Festival comes to the Push!!!</strong></p><p style="text-align: center;">In honor of this amazing celebration, the Push will be hosting free improv shows all night long.</p><p style="text-align: center;">Starting at 6:30 we will have a free improv shows every half hour featuring The Pushers and some of the Push Comedy Theater's funniest improvisers.</p><p style="text-align: center;"><strong>The Neon Festival at the Push (FREE SHOW!!!)</strong><br>Friday, October 16th. Free shows every half hour starting at 6:30</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/6cee6127f91c79fb724b43506a7dd1ef-Neon.jpg" alt="" style="display: block; margin: auto;"></p><p style="text-align: center;"><br>Announcing The NEON Festival, a two day celebration of energy and light in Norfolk’s Arts District. The festival is a showcase for public art and performances that will transform the NEON into a true arts destination. Wander through the neighborhood to discover tiny art happenings, large-scale murals and pops of neon color and light. </p><p style="text-align: center;">From 5 to10 pm on the nights of October 15 and 16, expect to see local and national artists, performers and musicians in NEON District venues like the Chrysler Museum &amp; Glass Studio, Work Release, The Parlor, Push Comedy Theater, Zeke's Beans &amp; Bowls, and more. More information and a full schedule of events coming soon. </p><p style="text-align: center;">Presented by Business Consortium for Arts Support and The Virginian-Pilot and produced by Downtown Norfolk Council, Chrysler Museum &amp; Glass Studio, Virginia Arts Festival and AltDaily.</p><p style="text-align: center;">It's time to turn NEON on!</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-10-16T06:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-10-16T22:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/65cc2bfe-806f-4e42-9bb5-bb96bf191fb3",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/65cc2bfe-806f-4e42-9bb5-bb96bf191fb3",
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

# Insert neon
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "neon"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Neon Festival at the Push (FREE SHOW!!!)",
    status: "available",
    description: "Ticket for The Neon Festival at the Push (FREE SHOW!!!)",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2015-10-08T04:51:46.975Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Neon Festival at the Push (FREE SHOW!!!) ==========="
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="

Logger.info "=========== Writing Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "STHG48",
    title: "IMPROVAGEDDON: The Ultimate Improv Competition!",
    description: """
    <p><strong>Prepare for Glory!!</strong></p><p>Prepare for IMPROVAGEDDON: The Ultimate Improv Competition!!!</p><p>Last time, The Dudes became the first ever three-time IMPROVAGEDDON champion!!!  It's something that no Improvageddon team has been able to accomplish since the modern rules were adopted a little over a year ago! Will the Hammer of Lowell stay within their grasp? Or are they just a flash in the pan? You'll have to come to this show to find out! </p><p>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory. </p><p>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet! <br>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest. </p><p>Gimmicks will be displayed! <br>Trash will be talked! <br>Feats of comedic strength will be performed! </p><p>Let the final war for comedic supremacy begin!</p><p><strong>IMPROVAGEDDON: The Ultimate Improv Competition!</strong><br>Saturday, January 2nd</p><p>The show starts at 10pm</p><p>Tickets are $5 </p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.</p>
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
    slug: "STHG48",
    title: "IMPROVAGEDDON: The Ultimate Improv Competition!",
    description: """
    <p><strong>Prepare for Glory!!</strong></p><p>Prepare for IMPROVAGEDDON: The Ultimate Improv Competition!!!</p><p>Last time, The Dudes became the first ever three-time IMPROVAGEDDON champion!!!  It's something that no Improvageddon team has been able to accomplish since the modern rules were adopted a little over a year ago! Will the Hammer of Lowell stay within their grasp? Or are they just a flash in the pan? You'll have to come to this show to find out! </p><p>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory. </p><p>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet! <br>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest. </p><p>Gimmicks will be displayed! <br>Trash will be talked! <br>Feats of comedic strength will be performed! </p><p>Let the final war for comedic supremacy begin!</p><p><strong>IMPROVAGEDDON: The Ultimate Improv Competition!</strong><br>Saturday, January 2nd</p><p>The show starts at 10pm</p><p>Tickets are $5 </p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-01-30T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-01-30T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-01-26T17:29:20.791Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="
Logger.info "=========== BEGIN Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="

Logger.info "=========== Writing Event Girl-Prov: The Girls' Night of Improv ==========="
event = SeedHelpers.create_event(
  %{
    slug: "S7ZN2W",
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
<p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, July 14th at the Push Comedy Theater<br>The show starts at 8, tickets are $5
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
    slug: "S7ZN2W",
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
<p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, July 14th at the Push Comedy Theater<br>The show starts at 8, tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2017-07-14T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-14T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-04T18:25:11.070Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="
