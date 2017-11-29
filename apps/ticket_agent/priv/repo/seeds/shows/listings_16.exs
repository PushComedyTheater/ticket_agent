require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The 301 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The 301 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "F8GN0C",
    title: "Class Dismissed: The 301 Graduation Show",
    description: """
    <p>It's Harold Time!!!<br> <br> So who the heck is Harold? More accurately the question should be... what the heck is a Harold?<br> <br>  The Harold is perhaps the best know style of long form improv. It  starts with an audience suggestion, then improvisers weave together  scenes, characters and group games to create a seamless piece. It can be  bizarre and magical, baffling and amazing... it definitely needs to be  seen.<br> <br> The Push Comedy Theater's 301 students take the Harold head on! Don't miss it.<br> <br> Class Dismissed: The 301 Graduation Show<br> Wednesday, March 23rd, at 8pm<br> Tickets are $5<br> <br> <br> The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br> <br>  Free parking available at Slone Chiropractic (111 W Virginia Beach)  just one block from the theater. There is also limited parking on the  street.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Class Dismissed: The 301 Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "F8GN0C",
    title: "Class Dismissed: The 301 Graduation Show",
    description: """
    <p>It's Harold Time!!!<br> <br> So who the heck is Harold? More accurately the question should be... what the heck is a Harold?<br> <br>  The Harold is perhaps the best know style of long form improv. It  starts with an audience suggestion, then improvisers weave together  scenes, characters and group games to create a seamless piece. It can be  bizarre and magical, baffling and amazing... it definitely needs to be  seen.<br> <br> The Push Comedy Theater's 301 students take the Harold head on! Don't miss it.<br> <br> Class Dismissed: The 301 Graduation Show<br> Wednesday, March 23rd, at 8pm<br> Tickets are $5<br> <br> <br> The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br> <br>  Free parking available at Slone Chiropractic (111 W Virginia Beach)  just one block from the theater. There is also limited parking on the  street.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-03-23T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-03-23T22:00:00.000-04:00")
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
    name: "Ticket for Class Dismissed: The 301 Graduation Show",
    status: "available",
    description: "Ticket for Class Dismissed: The 301 Graduation Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-21T20:56:59.357Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The 301 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Bright Side presents: Anything Is Possible! A Sketch Comedy Show ==========="

Logger.info "=========== Writing Event The Bright Side presents: Anything Is Possible! A Sketch Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "3076LK",
    title: "The Bright Side presents: Anything Is Possible! A Sketch Comedy Show",
    description: """
    <p><strong>The Bright Side presents: Anything Is Possible! A Sketch Comedy Show</strong>
</p>
<p><br>The Bright Side is taking to the Push Comedy Theater stage with their first full-length sketch comedy show of 2017! Break-dancing squirrels! Bible-thumping IT specialists! One-man Muppet Theater! When the Bright Side brings their outrageous characters and non-stop energy to the stage, Anything Is Possible!
</p>
<p><br>The Bright Side is a sketch and long form improvisational comedy group from Norfolk, VA.
</p>
<p><br>In early 2015, Andrea Bourguignon, Matt Cole, Brian Garraty, and Drew Richard decided to join forces as The Bright Side! Their particular brand of comedy is a celebration of the absurd world in which we all must exist. Audiences at a Bright Side show can expect to see smart, polished comedy that reflects the group members’ personal life experiences and optimistic perspectives. Look on The Bright Side!
</p>
<p><strong><br>The Bright Side Sketch &amp; Improv presents Anything is Possible!</strong><br>Saturday, February 18th, 10:00 PM<br>Push Comedy Theater
</p>
<p><br>Come out to see and support one of Hampton Road's own sketch comedy groups at the intimate Push Comedy Theater in the heart of Norfolk's new Neon Arts District.
</p>
<p><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p><br><br>--
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Bright Side presents: Anything Is Possible! A Sketch Comedy Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "3076LK",
    title: "The Bright Side presents: Anything Is Possible! A Sketch Comedy Show",
    description: """
    <p><strong>The Bright Side presents: Anything Is Possible! A Sketch Comedy Show</strong>
</p>
<p><br>The Bright Side is taking to the Push Comedy Theater stage with their first full-length sketch comedy show of 2017! Break-dancing squirrels! Bible-thumping IT specialists! One-man Muppet Theater! When the Bright Side brings their outrageous characters and non-stop energy to the stage, Anything Is Possible!
</p>
<p><br>The Bright Side is a sketch and long form improvisational comedy group from Norfolk, VA.
</p>
<p><br>In early 2015, Andrea Bourguignon, Matt Cole, Brian Garraty, and Drew Richard decided to join forces as The Bright Side! Their particular brand of comedy is a celebration of the absurd world in which we all must exist. Audiences at a Bright Side show can expect to see smart, polished comedy that reflects the group members’ personal life experiences and optimistic perspectives. Look on The Bright Side!
</p>
<p><strong><br>The Bright Side Sketch &amp; Improv presents Anything is Possible!</strong><br>Saturday, February 18th, 10:00 PM<br>Push Comedy Theater
</p>
<p><br>Come out to see and support one of Hampton Road's own sketch comedy groups at the intimate Push Comedy Theater in the heart of Norfolk's new Neon Arts District.
</p>
<p><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p><br><br>--
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-02-18T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-02-18T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/47646298-8e96-4160-a092-1c798516a97d",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/47646298-8e96-4160-a092-1c798516a97d",
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
    name: "Ticket for The Bright Side presents: Anything Is Possible! A Sketch Comedy Show",
    status: "available",
    description: "Ticket for The Bright Side presents: Anything Is Possible! A Sketch Comedy Show",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-01-25T04:13:22.692Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Bright Side presents: Anything Is Possible! A Sketch Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Double Treble: 2 Women, 2 Musicals, All Improv! ==========="

Logger.info "=========== Writing Event Double Treble: 2 Women, 2 Musicals, All Improv! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "HXNQCY",
    title: "Double Treble: 2 Women, 2 Musicals, All Improv!",
    description: """
    <p>After a hit show last month, Double Treble is back for more musical improv fun!<br>
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
<p>Saturday, April 22nd at 8pm
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
    slug: "HXNQCY",
    title: "Double Treble: 2 Women, 2 Musicals, All Improv!",
    description: """
    <p>After a hit show last month, Double Treble is back for more musical improv fun!<br>
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
<p>Saturday, April 22nd at 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-04-22T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-04-22T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-26T21:23:49.448Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Double Treble: 2 Women, 2 Musicals, All Improv! ==========="
Logger.info "=========== BEGIN Processing Universe Event Monocle: Style Glamour Sophistication Comedy ==========="

Logger.info "=========== Writing Event Monocle: Style Glamour Sophistication Comedy ==========="
event = SeedHelpers.create_event(
  %{
    slug: "9DJKZ4",
    title: "Monocle: Style Glamour Sophistication Comedy",
    description: """
    <p><strong>Monocle</strong>
</p>
<p><strong>Style. Glamour. Sophistication. Comedy.</strong>
</p>
<p>With a single one word suggestion, this team of elegant improvisers will fill each act with a single 25 minute long scene of profound characters under spectacular circumstances. All made up on the spot before your very eyes!
</p>
<p><br>
</p>
<p><strong>Monocle</strong>
</p>
<p><strong>Saturday, December 2nd at the Push Comedy Theater</strong>
</p>
<p>The show starts at 10pm, tickets are $5
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
Logger.info "=========== Writing Event Listing Monocle: Style Glamour Sophistication Comedy ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "9DJKZ4",
    title: "Monocle: Style Glamour Sophistication Comedy",
    description: """
    <p><strong>Monocle</strong>
</p>
<p><strong>Style. Glamour. Sophistication. Comedy.</strong>
</p>
<p>With a single one word suggestion, this team of elegant improvisers will fill each act with a single 25 minute long scene of profound characters under spectacular circumstances. All made up on the spot before your very eyes!
</p>
<p><br>
</p>
<p><strong>Monocle</strong>
</p>
<p><strong>Saturday, December 2nd at the Push Comedy Theater</strong>
</p>
<p>The show starts at 10pm, tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2017-12-02T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-12-02T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/6d12e202-9751-4905-b307-1f75327c98bf",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/6d12e202-9751-4905-b307-1f75327c98bf",
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
    name: "Ticket for Monocle: Style Glamour Sophistication Comedy",
    status: "available",
    description: "Ticket for Monocle: Style Glamour Sophistication Comedy",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-21T20:48:10.090Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Monocle: Style Glamour Sophistication Comedy ==========="
Logger.info "=========== BEGIN Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="

Logger.info "=========== Writing Event Who Dunnit? ...The Improvised Murder Mystery ==========="
event = SeedHelpers.create_event(
  %{
    slug: "VZQ0HK",
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
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, April 8th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $10
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
    slug: "VZQ0HK",
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
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, April 8th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $10
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
    start_at:  NaiveDateTime.from_iso8601!("2017-04-08T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-04-08T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-13T20:14:51.058Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="
Logger.info "=========== BEGIN Processing Universe Event Panties in a Twist... Goes to Charleston ==========="

Logger.info "=========== Writing Event Panties in a Twist... Goes to Charleston ==========="
event = SeedHelpers.create_event(
  %{
    slug: "ZDPXBV",
    title: "Panties in a Twist... Goes to Charleston",
    description: """
    <p><strong></strong><strong>Panties in a Twist: The All Female Sketch Comedy Show is going to The Charleston Comedy Festival. </strong></p><p>But before these funny ladies hit the road, catch them tonight at the Push.</p><p>It will be a night of sketch and improv comedy, as the girls get ready for their festival debut. </p><p>All proceeds from tonight's show will go towards gas, hotels and most importantly the ladies' beer tabe while they're in Charleston. </p><p><strong><br>Panties in a Twist... Goes to Charleston</strong><br>Friday, January 15th at 8pm<br>Tickets are $5</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Panties in a Twist... Goes to Charleston ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "ZDPXBV",
    title: "Panties in a Twist... Goes to Charleston",
    description: """
    <p><strong></strong><strong>Panties in a Twist: The All Female Sketch Comedy Show is going to The Charleston Comedy Festival. </strong></p><p>But before these funny ladies hit the road, catch them tonight at the Push.</p><p>It will be a night of sketch and improv comedy, as the girls get ready for their festival debut. </p><p>All proceeds from tonight's show will go towards gas, hotels and most importantly the ladies' beer tabe while they're in Charleston. </p><p><strong><br>Panties in a Twist... Goes to Charleston</strong><br>Friday, January 15th at 8pm<br>Tickets are $5</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-01-15T08:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-01-15T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8e62fc4e-0e05-4ae6-badf-c1432eb17881",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8e62fc4e-0e05-4ae6-badf-c1432eb17881",
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

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Panties in a Twist... Goes to Charleston",
    status: "available",
    description: "Ticket for Panties in a Twist... Goes to Charleston",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-01-15T07:05:26.746Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Panties in a Twist... Goes to Charleston ==========="
Logger.info "=========== BEGIN Processing Universe Event The Pullers! - Kids Improv Graduation Show ==========="

Logger.info "=========== Writing Event The Pullers! - Kids Improv Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "4PBH02",
    title: "The Pullers! - Kids Improv Graduation Show",
    description: """
    <p>You've heard of Generation X and Gen Y. Now get ready for the funniest, silliest, cutest generation of them all as The Pushers bring to you... The Pre-Teen Improv Superstars!!!
</p>
<p>Don't miss this group of talented tween-boppers as they put on a funny and fast paced 'Who's Line Is It Anyway' style show.
</p>
<p>The group is coached by local comedy couple, Jim and Mary Veverka, and local comedy giants, The Pushers.
</p>
<p>The Pushers present The Pullers! - Kids Pre-Teen Improv Graduation Show
</p>
<p>Saturday, August 6<br>The show starts at Noon.<br>Tickets are $5 for adults, kids 17 and under are free!!!
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p>--
</p>
<p>Push Comedy Theater
</p>
<p>763 Granby Street<br>Norfolk, VA
</p>
<p>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=SAQEp-CGB&amp;enc=AZPSkpnzx134nCcYgDU_0YyrxP8zVtNaf96oRmxhwRhXWkRATDUW2gOh6TNIa-MQOgs&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a>
</p>
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
    slug: "4PBH02",
    title: "The Pullers! - Kids Improv Graduation Show",
    description: """
    <p>You've heard of Generation X and Gen Y. Now get ready for the funniest, silliest, cutest generation of them all as The Pushers bring to you... The Pre-Teen Improv Superstars!!!
</p>
<p>Don't miss this group of talented tween-boppers as they put on a funny and fast paced 'Who's Line Is It Anyway' style show.
</p>
<p>The group is coached by local comedy couple, Jim and Mary Veverka, and local comedy giants, The Pushers.
</p>
<p>The Pushers present The Pullers! - Kids Pre-Teen Improv Graduation Show
</p>
<p>Saturday, August 6<br>The show starts at Noon.<br>Tickets are $5 for adults, kids 17 and under are free!!!
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p>--
</p>
<p>Push Comedy Theater
</p>
<p>763 Granby Street<br>Norfolk, VA
</p>
<p>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=SAQEp-CGB&amp;enc=AZPSkpnzx134nCcYgDU_0YyrxP8zVtNaf96oRmxhwRhXWkRATDUW2gOh6TNIa-MQOgs&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-08-06T12:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-06T13:00:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-30T01:53:52.974Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Pullers! - Kids Improv Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 201 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 201 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "TV0KMN",
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
<p><strong>Class Dismissed: The Improv 201 Graduation Show </strong><br>Monday, March 13th at 8pm<br>Tickets are $5
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
    slug: "TV0KMN",
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
<p><strong>Class Dismissed: The Improv 201 Graduation Show </strong><br>Monday, March 13th at 8pm<br>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-03-13T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-13T21:30:00.000-04:00")
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
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-06T01:57:39.347Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 201 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="

Logger.info "=========== Writing Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "DTJSV7",
    title: "IMPROVAGEDDON: The Ultimate Improv Competition!",
    description: """
    <p><strong>Prepare for Glory!!</strong></p><p>Prepare for IMPROVAGEDDON: The Ultimate Improv Competition!!!</p><p>We stand before the dawn of a new world!  </p><p>Last month, the reigning champs, The Dudes, failed to abide and were forced to surrender the Improvageddon Championship, and the coveted Hammer of Lowell to 3 on 3 Improv tournament favorites, Short Stack. </p><p>Short Stack wowed the audience, the judges, and Caesar himself with one of the greatest single Improvageddon performances to date, however they will need to not let the momentum falter as they will be facing off against two new challenging teams on the Improvageddon stage once more! </p><p>Will they once again triumph? Will more teams from the 3 on 3 Tournament be showing up to test their mettle Improvageddon style? </p><p>Who will raise the Hammer of Lowell in final victory? </p><p>You'll have to come to this month's show to find out!</p><p>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory. </p><p>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet! </p><p><br>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest. </p><p>Gimmicks will be displayed! <br>Trash will be talked! <br>Feats of comedic strength will be performed! </p><p>Let the final war for comedic supremacy begin!</p><p><strong>IMPROVAGEDDON: The Ultimate Improv Competition!</strong><br>Saturday, June 25th</p><p>The show starts at 10pm</p><p>Tickets are $5 </p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.</p>
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
    slug: "DTJSV7",
    title: "IMPROVAGEDDON: The Ultimate Improv Competition!",
    description: """
    <p><strong>Prepare for Glory!!</strong></p><p>Prepare for IMPROVAGEDDON: The Ultimate Improv Competition!!!</p><p>We stand before the dawn of a new world!  </p><p>Last month, the reigning champs, The Dudes, failed to abide and were forced to surrender the Improvageddon Championship, and the coveted Hammer of Lowell to 3 on 3 Improv tournament favorites, Short Stack. </p><p>Short Stack wowed the audience, the judges, and Caesar himself with one of the greatest single Improvageddon performances to date, however they will need to not let the momentum falter as they will be facing off against two new challenging teams on the Improvageddon stage once more! </p><p>Will they once again triumph? Will more teams from the 3 on 3 Tournament be showing up to test their mettle Improvageddon style? </p><p>Who will raise the Hammer of Lowell in final victory? </p><p>You'll have to come to this month's show to find out!</p><p>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory. </p><p>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet! </p><p><br>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest. </p><p>Gimmicks will be displayed! <br>Trash will be talked! <br>Feats of comedic strength will be performed! </p><p>Let the final war for comedic supremacy begin!</p><p><strong>IMPROVAGEDDON: The Ultimate Improv Competition!</strong><br>Saturday, June 25th</p><p>The show starts at 10pm</p><p>Tickets are $5 </p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-25T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-25T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-28T01:14:25.008Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="
Logger.info "=========== BEGIN Processing Universe Event Harold Night ==========="

Logger.info "=========== Writing Event Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "01VF8G",
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
<p>Friday, February 24th at 10:00pm
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
    slug: "01VF8G",
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
<p>Friday, February 24th at 10:00pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-02-24T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-02-24T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-02-16T20:56:06.819Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Harold Night ==========="
Logger.info "=========== BEGIN Processing Universe Event Tales from the Campfire: The Improvised Ghost Story ==========="

Logger.info "=========== Writing Event Tales from the Campfire: The Improvised Ghost Story ==========="
event = SeedHelpers.create_event(
  %{
    slug: "CVWRXT",
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
<p>Saturday, September 2nd at 8pm
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
    slug: "CVWRXT",
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
<p>Saturday, September 2nd at 8pm
</p>
<p>Tickets are $5
</p>
<p><br>
</p>
<p>I ain't afraid of no ghost!
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-09-02T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-02T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-08-25T21:40:14.674Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tales from the Campfire: The Improvised Ghost Story ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More Storytelling ==========="

Logger.info "=========== Writing Event Tell Me More Storytelling ==========="
event = SeedHelpers.create_event(
  %{
    slug: "H0F62S",
    title: "Tell Me More Storytelling",
    description: """
    <p>It's all about starting over again and again, isn't it?
</p>
<p><br><br>We're kicking off the year with a brand spanking new special "best-of" show. It will feature select storytellers who over the past two years were featured in top podcast episodes or mentioned many times by live audience members and podcast listeners.
</p>
<p><br><br>SUGGESTED THEME <br>Rebirth
</p>
<p><br><br>FEATURED STORYTELLERS<br>Ashley Hall<br>Harvest Bellante<br>Jessa Gaul<br>Scot Rose <br>and one more storyteller to be announced
</p>
<p><br><br>HOST<br>Brendan Kennedy
</p>
<p><br><br>ADMISSION<br>$5
</p>
<p><br><br>Visit <a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fwww.tellmemorelive.org%2F&amp;h=ZAQF4R59N&amp;enc=AZPwZJ_I6o1qnbI8kKetgjxqRsmJ6XLaspj_o_qEG6dSDTsKGG-TfhbDnZb0OIv28D0&amp;s=1" rel="nofollow" target="_blank">www.tellmemorelive.org</a> for more event details and a podcast featuring previous shows.
</p>
<p><br><br>
</p>
<p>Photo credit: Jeremy Bishop via Unsplash
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
    slug: "H0F62S",
    title: "Tell Me More Storytelling",
    description: """
    <p>It's all about starting over again and again, isn't it?
</p>
<p><br><br>We're kicking off the year with a brand spanking new special "best-of" show. It will feature select storytellers who over the past two years were featured in top podcast episodes or mentioned many times by live audience members and podcast listeners.
</p>
<p><br><br>SUGGESTED THEME <br>Rebirth
</p>
<p><br><br>FEATURED STORYTELLERS<br>Ashley Hall<br>Harvest Bellante<br>Jessa Gaul<br>Scot Rose <br>and one more storyteller to be announced
</p>
<p><br><br>HOST<br>Brendan Kennedy
</p>
<p><br><br>ADMISSION<br>$5
</p>
<p><br><br>Visit <a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fwww.tellmemorelive.org%2F&amp;h=ZAQF4R59N&amp;enc=AZPwZJ_I6o1qnbI8kKetgjxqRsmJ6XLaspj_o_qEG6dSDTsKGG-TfhbDnZb0OIv28D0&amp;s=1" rel="nofollow" target="_blank">www.tellmemorelive.org</a> for more event details and a podcast featuring previous shows.
</p>
<p><br><br>
</p>
<p>Photo credit: Jeremy Bishop via Unsplash
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-01-15T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-01-15T20:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/fe9ad2bc-fa3b-47d5-a854-f949f00cb8f4",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/fe9ad2bc-fa3b-47d5-a854-f949f00cb8f4",
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

# Insert podcast
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "podcast"
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-01-06T20:43:26.116Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More Storytelling ==========="
Logger.info "=========== BEGIN Processing Universe Event Tales from the Campfire: The Improvised Ghost Story ==========="

Logger.info "=========== Writing Event Tales from the Campfire: The Improvised Ghost Story ==========="
event = SeedHelpers.create_event(
  %{
    slug: "VNL8CP",
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
<p>Saturday, December 2nd at 8pm
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
    slug: "VNL8CP",
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
<p>Saturday, December 2nd at 8pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-12-02T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-12-02T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-20T23:31:41.338Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tales from the Campfire: The Improvised Ghost Story ==========="
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="

Logger.info "=========== Writing Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "1GXJV3",
    title: "IMPROVAGEDDON: The Ultimate Improv Competition!",
    description: """
    <p><strong>Prepare for Glory!!</strong></p><p>Prepare for IMPROVAGEDDON: The Ultimate Improv Competition!!!</p><p>We stand before the dawn of a new world!  </p><p>Last month, the reigning champs, The Dudes, failed to abide and were forced to surrender the Improvageddon Championship, and the coveted Hammer of Lowell to 3 on 3 Improv tournament favorites, Short Stack. </p><p>Short Stack wowed the audience, the judges, and Caesar himself with one of the greatest single Improvageddon performances to date, however they will need to not let the momentum falter as they will be facing off against two new challenging teams on the Improvageddon stage once more! </p><p>Will they once again triumph? Will more teams from the 3 on 3 Tournament be showing up to test their mettle Improvageddon style? </p><p>Who will raise the Hammer of Lowell in final victory? </p><p>You'll have to come to this month's show to find out!</p><p>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory. </p><p>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet! </p><p><br>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest. </p><p>Gimmicks will be displayed! <br>Trash will be talked! <br>Feats of comedic strength will be performed! </p><p>Let the final war for comedic supremacy begin!</p><p><strong>IMPROVAGEDDON: The Ultimate Improv Competition!</strong><br>Saturday, April 23rd</p><p>The show starts at 10pm</p><p>Tickets are $5 </p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.</p>
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
    slug: "1GXJV3",
    title: "IMPROVAGEDDON: The Ultimate Improv Competition!",
    description: """
    <p><strong>Prepare for Glory!!</strong></p><p>Prepare for IMPROVAGEDDON: The Ultimate Improv Competition!!!</p><p>We stand before the dawn of a new world!  </p><p>Last month, the reigning champs, The Dudes, failed to abide and were forced to surrender the Improvageddon Championship, and the coveted Hammer of Lowell to 3 on 3 Improv tournament favorites, Short Stack. </p><p>Short Stack wowed the audience, the judges, and Caesar himself with one of the greatest single Improvageddon performances to date, however they will need to not let the momentum falter as they will be facing off against two new challenging teams on the Improvageddon stage once more! </p><p>Will they once again triumph? Will more teams from the 3 on 3 Tournament be showing up to test their mettle Improvageddon style? </p><p>Who will raise the Hammer of Lowell in final victory? </p><p>You'll have to come to this month's show to find out!</p><p>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory. </p><p>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet! </p><p><br>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest. </p><p>Gimmicks will be displayed! <br>Trash will be talked! <br>Feats of comedic strength will be performed! </p><p>Let the final war for comedic supremacy begin!</p><p><strong>IMPROVAGEDDON: The Ultimate Improv Competition!</strong><br>Saturday, April 23rd</p><p>The show starts at 10pm</p><p>Tickets are $5 </p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-23T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-23T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-05T22:09:44.533Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: The Ultimate Improv Competition! ==========="
Logger.info "=========== BEGIN Processing Universe Event A Very Pushers Christmas ==========="

Logger.info "=========== Writing Event A Very Pushers Christmas ==========="
event = SeedHelpers.create_event(
  %{
    slug: "XVRJWL",
    title: "A Very Pushers Christmas",
    description: """
    <p>Remember all those wonderful Christmas Specials you loved as a kid? </p><p>Remember the singing and the dancing and the loads of holiday cheer? </p><p>We sure do! </p><p>That's why we're proud to present our very own warped version of those timeless, holiday classics...<br><strong>A Very Pushers Christmas: An Inappropriate Comedy Show.</strong></p><p><strong>The Pushers are back with their 7th Annual Christmas Special!!!</strong></p><p><strong></strong>Don't miss what's become one of Hampton Roads' greatest holiday traditions. </p><p><br><strong>A Very Pushers Christmas: An Inappropriate Comedy Show</strong><br>Saturday, December 5th<br>Tickets are $5</p><p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=6AQEk5VLi&amp;enc=AZNxuSnjbnZAxlayq4FpgXYzgUwKCdaNVlw3C7xbRXOp-3jN3m9Ra9Eg6C-fslI5WkE&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a></p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing A Very Pushers Christmas ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "XVRJWL",
    title: "A Very Pushers Christmas",
    description: """
    <p>Remember all those wonderful Christmas Specials you loved as a kid? </p><p>Remember the singing and the dancing and the loads of holiday cheer? </p><p>We sure do! </p><p>That's why we're proud to present our very own warped version of those timeless, holiday classics...<br><strong>A Very Pushers Christmas: An Inappropriate Comedy Show.</strong></p><p><strong>The Pushers are back with their 7th Annual Christmas Special!!!</strong></p><p><strong></strong>Don't miss what's become one of Hampton Roads' greatest holiday traditions. </p><p><br><strong>A Very Pushers Christmas: An Inappropriate Comedy Show</strong><br>Saturday, December 5th<br>Tickets are $5</p><p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=6AQEk5VLi&amp;enc=AZNxuSnjbnZAxlayq4FpgXYzgUwKCdaNVlw3C7xbRXOp-3jN3m9Ra9Eg6C-fslI5WkE&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a></p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-12-05T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-12-05T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b5bd4b74-ec38-471b-b92f-d2bd16e1eccd",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b5bd4b74-ec38-471b-b92f-d2bd16e1eccd",
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
    name: "Ticket for A Very Pushers Christmas",
    status: "available",
    description: "Ticket for A Very Pushers Christmas",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-25T07:08:22.965Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event A Very Pushers Christmas ==========="
Logger.info "=========== BEGIN Processing Universe Event Good Talk: The Brad McMurran Show ==========="

Logger.info "=========== Writing Event Good Talk: The Brad McMurran Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "JXTVZ0",
    title: "Good Talk: The Brad McMurran Show",
    description: """
    <p style="text-align: center;">Get ready for a night of comedy from the Pushers' own Brad McMurran.
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><strong>Good Talk: The Brad McMurran Show</strong>
</p>
<p style="text-align: center;">Christmas Talks
</p>
<p style="text-align: center;">Sunday, December 3rd at 7pm
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
<p style="text-align: center;">New Years Resolutions<br>
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
    slug: "JXTVZ0",
    title: "Good Talk: The Brad McMurran Show",
    description: """
    <p style="text-align: center;">Get ready for a night of comedy from the Pushers' own Brad McMurran.
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><strong>Good Talk: The Brad McMurran Show</strong>
</p>
<p style="text-align: center;">Christmas Talks
</p>
<p style="text-align: center;">Sunday, December 3rd at 7pm
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
<p style="text-align: center;">New Years Resolutions<br>
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
    start_at:  NaiveDateTime.from_iso8601!("2017-12-03T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-12-03T21:00:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-06T01:15:59.748Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Good Talk: The Brad McMurran Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Party Crashers: Led Reather Lellow Weather ==========="

Logger.info "=========== Writing Event The Party Crashers: Led Reather Lellow Weather ==========="
event = SeedHelpers.create_event(
  %{
    slug: "7Y5TS4",
    title: "The Party Crashers: Led Reather Lellow Weather",
    description: """
    <p>Founded by a group of mormon monks in the 12th century, the Push Comedy Theater is dedicated to bringing the freshest seafood to lonely housewives.
</p>
<p>The Push Comedy Theater hosts international exchange students marketing their handmade wares Friday thru Sunday. During the week classes in underwater basket weaving and Plumbus crafting.
</p>
<p>Whether you're a die-hard comedy lover or 3 raccoons in a trenchcoat...  the Push Comedy Theater has somefin fo dat ass... additional parking is located at Sacred Heart Hospital.
</p>
<p><br>
</p>
<p>The Party Crashers: Led Reather Lellow Weather<br>
</p>
<p>Saturday, March 18th at 10pm
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
Logger.info "=========== Writing Event Listing The Party Crashers: Led Reather Lellow Weather ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "7Y5TS4",
    title: "The Party Crashers: Led Reather Lellow Weather",
    description: """
    <p>Founded by a group of mormon monks in the 12th century, the Push Comedy Theater is dedicated to bringing the freshest seafood to lonely housewives.
</p>
<p>The Push Comedy Theater hosts international exchange students marketing their handmade wares Friday thru Sunday. During the week classes in underwater basket weaving and Plumbus crafting.
</p>
<p>Whether you're a die-hard comedy lover or 3 raccoons in a trenchcoat...  the Push Comedy Theater has somefin fo dat ass... additional parking is located at Sacred Heart Hospital.
</p>
<p><br>
</p>
<p>The Party Crashers: Led Reather Lellow Weather<br>
</p>
<p>Saturday, March 18th at 10pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-03-18T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-18T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/89882be8-f1b8-4870-83b3-a1fac936ecf7",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/89882be8-f1b8-4870-83b3-a1fac936ecf7",
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
    name: "Ticket for The Party Crashers: Led Reather Lellow Weather",
    status: "available",
    description: "Ticket for The Party Crashers: Led Reather Lellow Weather",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-08T04:08:39.469Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Party Crashers: Led Reather Lellow Weather ==========="
Logger.info "=========== BEGIN Processing Universe Event The Upright Senior Citizens Brigade ==========="

Logger.info "=========== Writing Event The Upright Senior Citizens Brigade ==========="
event = SeedHelpers.create_event(
  %{
    slug: "F786S0",
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
    slug: "F786S0",
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-18T03:03:45.229Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Upright Senior Citizens Brigade ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 401 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 401 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "LD9VNF",
    title: "Class Dismissed: The Improv 401 Graduation Show",
    description: """
    <p><strong></strong><strong>It's Harold Time!!!</strong></p><p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p>The Push Comedy Theater's 401 students take the Harold head on! Don't miss it.</p><p><strong>Class Dismissed: The 401 Graduation Show</strong><br>Wednesday, June 1st at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>--</p><p><strong>The Push Comedy Theater </strong>is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Class Dismissed: The Improv 401 Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "LD9VNF",
    title: "Class Dismissed: The Improv 401 Graduation Show",
    description: """
    <p><strong></strong><strong>It's Harold Time!!!</strong></p><p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p>The Push Comedy Theater's 401 students take the Harold head on! Don't miss it.</p><p><strong>Class Dismissed: The 401 Graduation Show</strong><br>Wednesday, June 1st at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>--</p><p><strong>The Push Comedy Theater </strong>is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-01T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-01T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/90d3c943-72cc-4d0e-a103-5554a0bb4743",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/90d3c943-72cc-4d0e-a103-5554a0bb4743",
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
    name: "Ticket for Class Dismissed: The Improv 401 Graduation Show",
    status: "available",
    description: "Ticket for Class Dismissed: The Improv 401 Graduation Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-18T16:23:20.555Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 401 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="

Logger.info "=========== Writing Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
event = SeedHelpers.create_event(
  %{
    slug: "F7BYKZ",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, May 27th
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
    slug: "F7BYKZ",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, May 27th
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
    start_at:  NaiveDateTime.from_iso8601!("2017-05-27T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-27T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-04-25T01:13:37.539Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
