require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event Upright Senior Citizens Brigade: Sundays with the Oldies ==========="

Logger.info "=========== Writing Event Upright Senior Citizens Brigade: Sundays with the Oldies ==========="
event = SeedHelpers.create_event(
  %{
    slug: "MF5Q90",
    title: "Upright Senior Citizens Brigade: Sundays with the Oldies",
    description: """
    <h2 style="text-align: center;">Upright Senior Citizens Brigade</h2>
<h3 style="text-align: center;">Sundays with the Oldies</h3>
<p style="text-align: center;">YOUTH IS WASTED ON THE YOUNG
</p>
<p style="text-align: center;">Don't miss the Upright Senior Citizens Brigade as they present an afternoon sketch comedy, song parodies and whose line is it anyway-style improv.
</p>
<p style="text-align: center;">We promise you'll be out in time to hit the early-bird special.
</p>
<p style="text-align: center;">The Upright Senior Citizens Brigade is a group of 50-year old and up individuals who perform both improv and sketch comedy. They were trained by The Pushers and with more than 500 years of life experience, they bridge the generation gap in ways you cannot imagine!
</p>
<p style="text-align: center;">These 50+ year old fogeys will have you in stitches and wishing you wore your depends.
</p>
<p style="text-align: center;"><strong>The Upright Senior Citizens Brigade: Sundays with the Oldies</strong><br>Sunday, September 17th at 2pm<br>Tickets are $5
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2015/09/upscb.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2015/09/upscb.jpg" alt=""></a>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Upright Senior Citizens Brigade: Sundays with the Oldies ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "MF5Q90",
    title: "Upright Senior Citizens Brigade: Sundays with the Oldies",
    description: """
    <h2 style="text-align: center;">Upright Senior Citizens Brigade</h2>
<h3 style="text-align: center;">Sundays with the Oldies</h3>
<p style="text-align: center;">YOUTH IS WASTED ON THE YOUNG
</p>
<p style="text-align: center;">Don't miss the Upright Senior Citizens Brigade as they present an afternoon sketch comedy, song parodies and whose line is it anyway-style improv.
</p>
<p style="text-align: center;">We promise you'll be out in time to hit the early-bird special.
</p>
<p style="text-align: center;">The Upright Senior Citizens Brigade is a group of 50-year old and up individuals who perform both improv and sketch comedy. They were trained by The Pushers and with more than 500 years of life experience, they bridge the generation gap in ways you cannot imagine!
</p>
<p style="text-align: center;">These 50+ year old fogeys will have you in stitches and wishing you wore your depends.
</p>
<p style="text-align: center;"><strong>The Upright Senior Citizens Brigade: Sundays with the Oldies</strong><br>Sunday, September 17th at 2pm<br>Tickets are $5
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2015/09/upscb.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2015/09/upscb.jpg" alt=""></a>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-09-17T14:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-17T15:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/591ee769-c247-43ed-ae68-25d3ffff5e77",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/591ee769-c247-43ed-ae68-25d3ffff5e77",
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
    name: "Ticket for Upright Senior Citizens Brigade: Sundays with the Oldies",
    status: "available",
    description: "Ticket for Upright Senior Citizens Brigade: Sundays with the Oldies",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-08-27T16:09:17.365Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Upright Senior Citizens Brigade: Sundays with the Oldies ==========="
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON!!! (Free with Costume) ==========="

Logger.info "=========== Writing Event IMPROVAGEDDON!!! (Free with Costume) ==========="
event = SeedHelpers.create_event(
  %{
    slug: "VH1W8M",
    title: "IMPROVAGEDDON!!! (Free with Costume)",
    description: """
    <p>Prepare for Glory!!</p><p><strong>Prepare for IMPROVAGEDDON: The Battle of Samhain!</strong></p><p>It's Halloween night, and The Dudes are now TWO TIME Improvageddon champs? </p><p>Can they be the first team EVER to make it three? </p><p>Will the Hammer of Lowell stay within their grasp? </p><p>Or will one of the challenging teams, which will be selected for the first time by Lottery drawing (!!!) walk away with the championship? </p><p>You'll have to come to this show to find out!</p><p>ALSO! Since it's Halloween night, there will be a costume contest. Judging this event, will be the Emperor himself, Improvacus Caesar! </p><p><strong>Come dressed up, and get in FREE!!!</strong></p><p>----</p><p>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory.</p><p>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet! </p><p>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest.</p><p>Gimmicks will be displayed! </p><p>Trash will be talked! </p><p>Feats of comedic strength will be performed!</p><p>Let the final war for comedic supremacy begin!</p><p><strong>IMPROVAGEDDON: The Battle of Samhain!</strong> </p><p>Saturday, October 31st</p><p>The show starts at 10pm</p><p>Tickets are $5 OR FREE if you come in costume! </p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing IMPROVAGEDDON!!! (Free with Costume) ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "VH1W8M",
    title: "IMPROVAGEDDON!!! (Free with Costume)",
    description: """
    <p>Prepare for Glory!!</p><p><strong>Prepare for IMPROVAGEDDON: The Battle of Samhain!</strong></p><p>It's Halloween night, and The Dudes are now TWO TIME Improvageddon champs? </p><p>Can they be the first team EVER to make it three? </p><p>Will the Hammer of Lowell stay within their grasp? </p><p>Or will one of the challenging teams, which will be selected for the first time by Lottery drawing (!!!) walk away with the championship? </p><p>You'll have to come to this show to find out!</p><p>ALSO! Since it's Halloween night, there will be a costume contest. Judging this event, will be the Emperor himself, Improvacus Caesar! </p><p><strong>Come dressed up, and get in FREE!!!</strong></p><p>----</p><p>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory.</p><p>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet! </p><p>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest.</p><p>Gimmicks will be displayed! </p><p>Trash will be talked! </p><p>Feats of comedic strength will be performed!</p><p>Let the final war for comedic supremacy begin!</p><p><strong>IMPROVAGEDDON: The Battle of Samhain!</strong> </p><p>Saturday, October 31st</p><p>The show starts at 10pm</p><p>Tickets are $5 OR FREE if you come in costume! </p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-10-31T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-10-31T23:45:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/fd3a41c8-d76b-457c-94f6-5705555170c6",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/fd3a41c8-d76b-457c-94f6-5705555170c6",
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
    name: "Ticket for IMPROVAGEDDON!!! (Free with Costume)",
    status: "available",
    description: "Ticket for IMPROVAGEDDON!!! (Free with Costume)",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2015-10-25T21:35:10.835Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON!!! (Free with Costume) ==========="
Logger.info "=========== BEGIN Processing Universe Event The Pullers! - Kids Improv 101 Graduation Show ==========="

Logger.info "=========== Writing Event The Pullers! - Kids Improv 101 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "M8N6CF",
    title: "The Pullers! - Kids Improv 101 Graduation Show",
    description: """
    <p>You've heard of Generation X and Gen Y. Now get ready for the funniest, silliest, cutest generation of them all as The Pushers bring to you... The Pre-Teen Improv Superstars!!!
</p>
<p>Don't miss this group of talented tween-boppers as they put on a funny and fast paced 'Who's Line Is It Anyway' style show.
</p>
<p>The group is coached by local comedy couple, Jim and Mary Veverka, and local comedy giants, The Pushers.
</p>
<p>The Pushers present The Pullers! - Kids Pre-Teen Improv Graduation Show
</p>
<p>Saturday, November 11th<br>The show starts at 12pm.<br>This is a free show!!!
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
Logger.info "=========== Writing Event Listing The Pullers! - Kids Improv 101 Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "M8N6CF",
    title: "The Pullers! - Kids Improv 101 Graduation Show",
    description: """
    <p>You've heard of Generation X and Gen Y. Now get ready for the funniest, silliest, cutest generation of them all as The Pushers bring to you... The Pre-Teen Improv Superstars!!!
</p>
<p>Don't miss this group of talented tween-boppers as they put on a funny and fast paced 'Who's Line Is It Anyway' style show.
</p>
<p>The group is coached by local comedy couple, Jim and Mary Veverka, and local comedy giants, The Pushers.
</p>
<p>The Pushers present The Pullers! - Kids Pre-Teen Improv Graduation Show
</p>
<p>Saturday, November 11th<br>The show starts at 12pm.<br>This is a free show!!!
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
    start_at:  NaiveDateTime.from_iso8601!("2017-11-11T12:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-11T13:00:00.000-05:00")
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
    name: "Ticket for The Pullers! - Kids Improv 101 Graduation Show",
    status: "available",
    description: "Ticket for The Pullers! - Kids Improv 101 Graduation Show",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-31T19:28:13.395Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Pullers! - Kids Improv 101 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 501 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 501 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "ZW1YTX",
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
    slug: "ZW1YTX",
    title: "Class Dismissed: The Improv 501 Graduation Show",
    description: """
    <p>Get ready for a colossal night of comedy and mayhem at the Push Comedy Theater, brought to you by some of Hampton Roads' finest improvisers.</p><p>Don't miss this improv extravaganza, brought to you by the Push's upperclassmen. </p><p><strong>Class Dismissed: The Improv 501 Graduation Show</strong> </p><p>Thursday , November 12th at 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/8d656ed892236a8b2d19757c831aff25-class501.jpg"></p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-11-12T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-11-12T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-03T18:26:33.287Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 501 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Double Feature: The Made Up Movie ==========="

Logger.info "=========== Writing Event Double Feature: The Made Up Movie ==========="
event = SeedHelpers.create_event(
  %{
    slug: "HDZV8B",
    title: "Double Feature: The Made Up Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong></p><p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.</p><p><strong>Double Feature: The Totally Improvised Movie</strong><br>Saturday, May 7th at 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.</p><p><br>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "HDZV8B",
    title: "Double Feature: The Made Up Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong></p><p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.</p><p><strong>Double Feature: The Totally Improvised Movie</strong><br>Saturday, May 7th at 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.</p><p><br>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-05-07T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-05-07T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-28T21:41:23.107Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Double Feature: The Made Up Movie ==========="
Logger.info "=========== BEGIN Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="

Logger.info "=========== Writing Event Girl-Prov: The Girls' Night of Improv ==========="
event = SeedHelpers.create_event(
  %{
    slug: "9LY78V",
    title: "Girl-Prov: The Girls' Night of Improv",
    description: """
    <p><strong></strong><strong>GET READY FOR GIRL'S NIGHT!</strong>
</p>
<p>Move over, gentleman! <br>The ladies are taking over for a girls' night!
</p>
<p>GirlProv is an all-female improv group, making audiences lose it with laughter at the Push Comedy Theater.
</p>
<p>It's slumber party meets night out on the town meet sorority house party!
</p>
<p>Don't miss this night of comedy- all made up on the spot from the audience's suggestion!
</p>
<p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, August 12th at the Push Comedy Theater<br>The show starts at 10, tickets are $5
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
    slug: "9LY78V",
    title: "Girl-Prov: The Girls' Night of Improv",
    description: """
    <p><strong></strong><strong>GET READY FOR GIRL'S NIGHT!</strong>
</p>
<p>Move over, gentleman! <br>The ladies are taking over for a girls' night!
</p>
<p>GirlProv is an all-female improv group, making audiences lose it with laughter at the Push Comedy Theater.
</p>
<p>It's slumber party meets night out on the town meet sorority house party!
</p>
<p>Don't miss this night of comedy- all made up on the spot from the audience's suggestion!
</p>
<p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, August 12th at the Push Comedy Theater<br>The show starts at 10, tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2016-08-12T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-12T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-09T05:29:34.721Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: Teen Improv Graduation ==========="

Logger.info "=========== Writing Event Class Dismissed: Teen Improv Graduation ==========="
event = SeedHelpers.create_event(
  %{
    slug: "5VR7T9",
    title: "Class Dismissed: Teen Improv Graduation",
    description: """
    <p><strong></strong><strong>Get ready for Hampton Roads' newest generation of comedy superstars!</strong></p><p>It's the Teen Improv Graduation Show!!! Don't miss this group of talented teenage improvisers as they put on a funny and fast paced 'Who's Line Is It Anyway' style show. </p><p><br><strong>FREE FOR EVERYONE 17 AND UNDER!!!!</strong></p><p><strong>Class Dismissed: Teen Improv Graduation</strong><br>Saturday, March 5th at 3pm<br>Tickets are $5</p><p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=IAQFXbWK-&amp;enc=AZOPL4oGCU8KwLS1ULzXIGkAlp390nUXmKxOesT9vjgB6P5g9tvKt2_4aOrkgku0E98&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a></p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Class Dismissed: Teen Improv Graduation ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "5VR7T9",
    title: "Class Dismissed: Teen Improv Graduation",
    description: """
    <p><strong></strong><strong>Get ready for Hampton Roads' newest generation of comedy superstars!</strong></p><p>It's the Teen Improv Graduation Show!!! Don't miss this group of talented teenage improvisers as they put on a funny and fast paced 'Who's Line Is It Anyway' style show. </p><p><br><strong>FREE FOR EVERYONE 17 AND UNDER!!!!</strong></p><p><strong>Class Dismissed: Teen Improv Graduation</strong><br>Saturday, March 5th at 3pm<br>Tickets are $5</p><p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=IAQFXbWK-&amp;enc=AZOPL4oGCU8KwLS1ULzXIGkAlp390nUXmKxOesT9vjgB6P5g9tvKt2_4aOrkgku0E98&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a></p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-03-05T15:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-03-05T16:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b10e4c68-360d-4a5d-baf5-aaa3e2d7ec8a",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b10e4c68-360d-4a5d-baf5-aaa3e2d7ec8a",
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

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Class Dismissed: Teen Improv Graduation",
    status: "available",
    description: "Ticket for Class Dismissed: Teen Improv Graduation",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-03T17:31:36.049Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: Teen Improv Graduation ==========="
Logger.info "=========== BEGIN Processing Universe Event NCF: Improv Explosion (Friday) ==========="

Logger.info "=========== Writing Event NCF: Improv Explosion (Friday) ==========="
event = SeedHelpers.create_event(
  %{
    slug: "V074MT",
    title: "NCF: Improv Explosion (Friday)",
    description: """
    <h3><strong>Chris Trew +2</strong></h3>
<p>Trew + 2 is Chris Trew plus two strangers from the audience with no improv experience who get a very quick lesson (less than 3 minutes). The three of them do a montage, the final scene being the first and only scene featuring only the two strangers who, strangely enough, always seem to figure it out and make something killer and memorable happen.
</p>
<p>Trew + 2 is a big hit on the comedy festival circuit and is appearing at several festivals this year.
</p>
<p><strong>About Chris:  </strong>Chris Trew is a full time comedian (“Trew is out of his fucking mind” - The Austin Chronicle) and part time professional wrestling manager (“a performance artist at the highest level” - The Wrestling Blog) splitting his time between New Orleans and Austin where he is the Creative Director of <a href="http://tnmcomedy.com/" rel="nofollow" target="_blank">The New Movement</a>, a comedy theater and training center that's home to events like Hell Yes Fest and the Megaphone Marathons.
</p>
<p>Trew has headlined comedy festivals all over the U.S. and has been featured in <a href="http://www.gq.com/story/air-sex" rel="nofollow" target="_blank">GQ Magazine</a>, Splitsider, the Sturgis Motorcycle Rally, America’s Got Talent, and many other strange things.  He helped “start a comedy scene from scratch” (<a href="http://splitsider.com/2014/12/how-the-new-movement-built-a-comedy-scene-from-scratch-in-new-orleans/" rel="nofollow" target="_blank">Splitsider</a>) and is the co-host of Air Sex Battles on MTV, debuting later this year.
</p>
<p>He was named "one of 10 comedians you should know" by Paper Magazine and is the co-author of Improv Wins, a book about improv that serves as the textbook at The New Movement.
</p>
<p>For bearded, out of the box comedy, your aim is Trew - <a href="http://www.starnewsonline.com/article/20150429/ENT/150429677?Title=Cape-Fear-Comedy-Festival-to-feature-Trew" rel="nofollow" target="_blank">Star News Online, Wilmington, North Carolina</a>
</p>
<p>Chris Trew’s Unabashedly Weird Comedy Comes to the Scruffy City Comedy Festival - <a href="http://www.knoxmercury.com/2015/11/11/chris-trews-unabashedly-weird-comedy-comes-to-the-scruffy-city-comedy-festival/" rel="nofollow" target="_blank">Knoxville Mercury</a>
</p>
<p>What Not to Miss at This Year's Chicago Improv Festival - <a href="http://chicagoist.com/2016/04/29/our_picks_for_chicago_improv_festiv.php" rel="nofollow" target="_blank">The Chicagoist</a>
</p>
<p><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Chris-Trew-2.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Chris-Trew-2-300x150.jpg" alt="Chris Trew 2" style="display: block; margin: auto;"></a>
</p>
<hr>
<h3><strong>Jet Pack</strong></h3>
<p>Andy Livengood (Theatre 99, Charleston SC) has assembled an improv team from all over the east coast. Charleston, Norfolk, New York come together to create a one of a kind improv experience. Fast, unpredictable , and explosive; Jet Pack combines lightning quick improv with grounded characters and scenes. Strap yourself in, you never know where Jet Pack will take you!
</p>
<p>Jet Pack Improv: you'll laugh so hard, you'll wet somebody else's pants!!
</p>
<p><strong>About Andy:</strong> Andy has been performing improv for over a decade. In that time he has studied at Theatre 99 (Charleston, SC), The Annoyance Theatre (Chicago), and The Upright Citizens Brigade Theatre (NY).
</p>
<p>He regularly performs at Theatre 99 where he was a founding member of the groups CLUTCH and Cats Hugging Cats. In 2010 Andy was voted Charleston's best comic.
</p>
<p>He is a massive improv nerd and will always geek out with fellow improvisers at bars after shows.
</p>
<p><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/13884383_10208237038617896_381051755_n.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/13884383_10208237038617896_381051755_n-225x300.jpg" alt="Jet Pack" style="display: block; margin: auto;"></a>
</p>
<p>__________________________<wbr>__<br><br>Coalition TourCo<br><br>Coalition TourCo are a premium blend of performers from Richmond, Virginia’s Coalition Theater. Since 2009, the Coalition have been producing high-energy, physical, weird longform improv shows.<br><br>Coalition Theater is Richmond's home for live comedy shows and improv, sketch and stand-up classes. Find out more info at <a href="http://l.facebook.com/l.php?u=http%3A%2F%2Frvacomedy.com%2F&amp;h=iAQEivz7V&amp;enc=AZPl_ig-RgEm46ezdM8cHESq3ddDiR9AhqBNta1S406hSRDhdGYnxp_GQU_P54RZ2og&amp;s=1" rel="nofollow" target="_blank">rvacomedy.com.</a> <br><br>Live Comedy. Dead Serious.<br>
</wbr></p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing NCF: Improv Explosion (Friday) ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "V074MT",
    title: "NCF: Improv Explosion (Friday)",
    description: """
    <h3><strong>Chris Trew +2</strong></h3>
<p>Trew + 2 is Chris Trew plus two strangers from the audience with no improv experience who get a very quick lesson (less than 3 minutes). The three of them do a montage, the final scene being the first and only scene featuring only the two strangers who, strangely enough, always seem to figure it out and make something killer and memorable happen.
</p>
<p>Trew + 2 is a big hit on the comedy festival circuit and is appearing at several festivals this year.
</p>
<p><strong>About Chris:  </strong>Chris Trew is a full time comedian (“Trew is out of his fucking mind” - The Austin Chronicle) and part time professional wrestling manager (“a performance artist at the highest level” - The Wrestling Blog) splitting his time between New Orleans and Austin where he is the Creative Director of <a href="http://tnmcomedy.com/" rel="nofollow" target="_blank">The New Movement</a>, a comedy theater and training center that's home to events like Hell Yes Fest and the Megaphone Marathons.
</p>
<p>Trew has headlined comedy festivals all over the U.S. and has been featured in <a href="http://www.gq.com/story/air-sex" rel="nofollow" target="_blank">GQ Magazine</a>, Splitsider, the Sturgis Motorcycle Rally, America’s Got Talent, and many other strange things.  He helped “start a comedy scene from scratch” (<a href="http://splitsider.com/2014/12/how-the-new-movement-built-a-comedy-scene-from-scratch-in-new-orleans/" rel="nofollow" target="_blank">Splitsider</a>) and is the co-host of Air Sex Battles on MTV, debuting later this year.
</p>
<p>He was named "one of 10 comedians you should know" by Paper Magazine and is the co-author of Improv Wins, a book about improv that serves as the textbook at The New Movement.
</p>
<p>For bearded, out of the box comedy, your aim is Trew - <a href="http://www.starnewsonline.com/article/20150429/ENT/150429677?Title=Cape-Fear-Comedy-Festival-to-feature-Trew" rel="nofollow" target="_blank">Star News Online, Wilmington, North Carolina</a>
</p>
<p>Chris Trew’s Unabashedly Weird Comedy Comes to the Scruffy City Comedy Festival - <a href="http://www.knoxmercury.com/2015/11/11/chris-trews-unabashedly-weird-comedy-comes-to-the-scruffy-city-comedy-festival/" rel="nofollow" target="_blank">Knoxville Mercury</a>
</p>
<p>What Not to Miss at This Year's Chicago Improv Festival - <a href="http://chicagoist.com/2016/04/29/our_picks_for_chicago_improv_festiv.php" rel="nofollow" target="_blank">The Chicagoist</a>
</p>
<p><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Chris-Trew-2.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Chris-Trew-2-300x150.jpg" alt="Chris Trew 2" style="display: block; margin: auto;"></a>
</p>
<hr>
<h3><strong>Jet Pack</strong></h3>
<p>Andy Livengood (Theatre 99, Charleston SC) has assembled an improv team from all over the east coast. Charleston, Norfolk, New York come together to create a one of a kind improv experience. Fast, unpredictable , and explosive; Jet Pack combines lightning quick improv with grounded characters and scenes. Strap yourself in, you never know where Jet Pack will take you!
</p>
<p>Jet Pack Improv: you'll laugh so hard, you'll wet somebody else's pants!!
</p>
<p><strong>About Andy:</strong> Andy has been performing improv for over a decade. In that time he has studied at Theatre 99 (Charleston, SC), The Annoyance Theatre (Chicago), and The Upright Citizens Brigade Theatre (NY).
</p>
<p>He regularly performs at Theatre 99 where he was a founding member of the groups CLUTCH and Cats Hugging Cats. In 2010 Andy was voted Charleston's best comic.
</p>
<p>He is a massive improv nerd and will always geek out with fellow improvisers at bars after shows.
</p>
<p><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/13884383_10208237038617896_381051755_n.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/13884383_10208237038617896_381051755_n-225x300.jpg" alt="Jet Pack" style="display: block; margin: auto;"></a>
</p>
<p>__________________________<wbr>__<br><br>Coalition TourCo<br><br>Coalition TourCo are a premium blend of performers from Richmond, Virginia’s Coalition Theater. Since 2009, the Coalition have been producing high-energy, physical, weird longform improv shows.<br><br>Coalition Theater is Richmond's home for live comedy shows and improv, sketch and stand-up classes. Find out more info at <a href="http://l.facebook.com/l.php?u=http%3A%2F%2Frvacomedy.com%2F&amp;h=iAQEivz7V&amp;enc=AZPl_ig-RgEm46ezdM8cHESq3ddDiR9AhqBNta1S406hSRDhdGYnxp_GQU_P54RZ2og&amp;s=1" rel="nofollow" target="_blank">rvacomedy.com.</a> <br><br>Live Comedy. Dead Serious.<br>
</wbr></p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-09T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-09T20:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8caef2a3-2bd6-44e1-870b-56d9426f40eb",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8caef2a3-2bd6-44e1-870b-56d9426f40eb",
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

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for NCF: Improv Explosion (Friday)",
    status: "available",
    description: "Ticket for NCF: Improv Explosion (Friday)",
    price: 1200,
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-01T04:37:33.865Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event NCF: Improv Explosion (Friday) ==========="
Logger.info "=========== BEGIN Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="

Logger.info "=========== Writing Event Who Dunnit? ...The Improvised Murder Mystery ==========="
event = SeedHelpers.create_event(
  %{
    slug: "NGM498",
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
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, August 12th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $10
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
    slug: "NGM498",
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
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, August 12th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $10
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
    start_at:  NaiveDateTime.from_iso8601!("2017-08-12T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-08-12T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-08T17:02:02.924Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More Storytelling ==========="

Logger.info "=========== Writing Event Tell Me More Storytelling ==========="
event = SeedHelpers.create_event(
  %{
    slug: "6ZX1J5",
    title: "Tell Me More Storytelling",
    description: """
    <p>Suggested theme: <br>Surrender
</p>
<p><br><br>FEATURED STORYTELLERS<br>To be decided. Interested in telling a story? <br>Tell us about it, (757) 785-5590.
</p>
<p><br><br>HOST<br>Brendan Kennedy, is a comedian, storyteller, and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”
</p>
<p><br><br>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, May 21, 2017<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>
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
    slug: "6ZX1J5",
    title: "Tell Me More Storytelling",
    description: """
    <p>Suggested theme: <br>Surrender
</p>
<p><br><br>FEATURED STORYTELLERS<br>To be decided. Interested in telling a story? <br>Tell us about it, (757) 785-5590.
</p>
<p><br><br>HOST<br>Brendan Kennedy, is a comedian, storyteller, and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”
</p>
<p><br><br>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, May 21, 2017<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>
</p>
<p>Admission: $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-05-21T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-21T20:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/ac976d1c-091b-40ad-b223-e030d8e1011c",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/ac976d1c-091b-40ad-b223-e030d8e1011c",
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-03T02:16:24.969Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More Storytelling ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 501 Midterm Mayhem Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 501 Midterm Mayhem Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "RV7N39",
    title: "Class Dismissed: The Improv 501 Midterm Mayhem Show",
    description: """
    <p>While the teachers are away, the students will play! The Pushers are out of town on business (no, really) and have turned the theater over to the upperclassmen of the current Improv 501 class. Get ready for a rockin' night of comedy at the Push Comedy Theater, brought to you by some of Hampton Roads' finest improvisers. Midterms have never been so much fun.
</p>
<p>Class Dismissed: The Improv 501 Midterm Mayhem Show
</p>
<p>Friday, February 3rd at 8pm
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
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For more than 11 years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
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
Logger.info "=========== Writing Event Listing Class Dismissed: The Improv 501 Midterm Mayhem Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "RV7N39",
    title: "Class Dismissed: The Improv 501 Midterm Mayhem Show",
    description: """
    <p>While the teachers are away, the students will play! The Pushers are out of town on business (no, really) and have turned the theater over to the upperclassmen of the current Improv 501 class. Get ready for a rockin' night of comedy at the Push Comedy Theater, brought to you by some of Hampton Roads' finest improvisers. Midterms have never been so much fun.
</p>
<p>Class Dismissed: The Improv 501 Midterm Mayhem Show
</p>
<p>Friday, February 3rd at 8pm
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
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For more than 11 years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
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
    start_at:  NaiveDateTime.from_iso8601!("2017-02-03T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-02-03T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/94369bf6-fdee-4586-8427-fdf5af9c4273",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/94369bf6-fdee-4586-8427-fdf5af9c4273",
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
    name: "Ticket for Class Dismissed: The Improv 501 Midterm Mayhem Show",
    status: "available",
    description: "Ticket for Class Dismissed: The Improv 501 Midterm Mayhem Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-01-30T18:48:16.199Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 501 Midterm Mayhem Show ==========="
Logger.info "=========== BEGIN Processing Universe Event ​The Bright Side Presents: Spring Break Forever ==========="

Logger.info "=========== Writing Event ​The Bright Side Presents: Spring Break Forever ==========="
event = SeedHelpers.create_event(
  %{
    slug: "9ZWBK1",
    title: "​The Bright Side Presents: Spring Break Forever",
    description: """
    <p><strong></strong><strong>The Bright Side Presents: Spring Break Forever!!! </strong></p><p>With their first full length show of 2016, The Bright Side is taking to the Push Comedy Theater stage once again with a night filled with high energy sketch comedy!!!!</p><p>Breakdancing anarchist squirrels! <br>Bible-thumping IT specialists! <br>French Pee-Wee's Playhouse ripoffs! <br>One-man Muppet Theater! <br>Divorced dads dancing in a competition for the love and affection of their children! <br>You'll see it all!</p><p>As an added bonus, the show will feature an opening set by the upstart sketch group, The Pre Madonnas!!!</p><p>The Bright Side is a sketch and long form improvisational comedy group from Norfolk, VA.</p><p>In early 2015, Andrea Bourguignon, Matt Cole, Brian Garraty, and Drew Richard decided to join forces as The Bright Side! Their particular brand of comedy is a celebration of the absurd world in which we all must exist. Audiences at a Bright Side show can expect to see smart, polished comedy that reflects the group members’ personal life experiences and optimistic perspectives. Look on The Bright Side!</p><p><strong>The Bright Side Sketch &amp; Improv presents Spring Break Forever!!!</strong><br>Saturday, March 5th, 8:00 PM<br>Push Comedy Theater</p><p>Come out to see and support one of Hampton Road's own sketch comedy groups at the intimate Push Comedy Theater in the heart of Norfolk's new Neon Arts District.</p><p>Free parking available behind Virginia Furniture Company (745 Granby Street) and at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing ​The Bright Side Presents: Spring Break Forever ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "9ZWBK1",
    title: "​The Bright Side Presents: Spring Break Forever",
    description: """
    <p><strong></strong><strong>The Bright Side Presents: Spring Break Forever!!! </strong></p><p>With their first full length show of 2016, The Bright Side is taking to the Push Comedy Theater stage once again with a night filled with high energy sketch comedy!!!!</p><p>Breakdancing anarchist squirrels! <br>Bible-thumping IT specialists! <br>French Pee-Wee's Playhouse ripoffs! <br>One-man Muppet Theater! <br>Divorced dads dancing in a competition for the love and affection of their children! <br>You'll see it all!</p><p>As an added bonus, the show will feature an opening set by the upstart sketch group, The Pre Madonnas!!!</p><p>The Bright Side is a sketch and long form improvisational comedy group from Norfolk, VA.</p><p>In early 2015, Andrea Bourguignon, Matt Cole, Brian Garraty, and Drew Richard decided to join forces as The Bright Side! Their particular brand of comedy is a celebration of the absurd world in which we all must exist. Audiences at a Bright Side show can expect to see smart, polished comedy that reflects the group members’ personal life experiences and optimistic perspectives. Look on The Bright Side!</p><p><strong>The Bright Side Sketch &amp; Improv presents Spring Break Forever!!!</strong><br>Saturday, March 5th, 8:00 PM<br>Push Comedy Theater</p><p>Come out to see and support one of Hampton Road's own sketch comedy groups at the intimate Push Comedy Theater in the heart of Norfolk's new Neon Arts District.</p><p>Free parking available behind Virginia Furniture Company (745 Granby Street) and at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-03-05T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-03-05T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8fb838f5-71b6-4924-b274-a061d53fe0b4",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8fb838f5-71b6-4924-b274-a061d53fe0b4",
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
    name: "Ticket for ​The Bright Side Presents: Spring Break Forever",
    status: "available",
    description: "Ticket for ​The Bright Side Presents: Spring Break Forever",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-02-27T00:50:14.729Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event ​The Bright Side Presents: Spring Break Forever ==========="
Logger.info "=========== BEGIN Processing Universe Event Sketchmageddon ==========="

Logger.info "=========== Writing Event Sketchmageddon ==========="
event = SeedHelpers.create_event(
  %{
    slug: "4173V0",
    title: "Sketchmageddon",
    description: """
    <p><strong>Get ready for a sketch comedy show like no other!!!</strong></p><p>   <strong>SKETCHMAGEDDON</strong> takes 3 groups and forces them to compete in an all-out comedy, death-match!  <br>  Each team will be given 15 minutes to dazzle you with their comedy prowess. </p><p><strong>  It's Saturday Night Live meets Thunderdome!!!! </strong></p><p> <br>  Unlike it's improvised sister show IMPROVAGEDDON, SKETCHMAGEDDON will feature all written and rehearsed material.  Props, costumes and special effects are all legal in SKETCHMAGEDDON. </p><p> <br>    <strong>SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition </strong></p><p>Friday, May 6th at 10pm </p><p>Tickets are $5</p><p>------------</p><p><strong>The Push Comedy Theater </strong>only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p>
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
    slug: "4173V0",
    title: "Sketchmageddon",
    description: """
    <p><strong>Get ready for a sketch comedy show like no other!!!</strong></p><p>   <strong>SKETCHMAGEDDON</strong> takes 3 groups and forces them to compete in an all-out comedy, death-match!  <br>  Each team will be given 15 minutes to dazzle you with their comedy prowess. </p><p><strong>  It's Saturday Night Live meets Thunderdome!!!! </strong></p><p> <br>  Unlike it's improvised sister show IMPROVAGEDDON, SKETCHMAGEDDON will feature all written and rehearsed material.  Props, costumes and special effects are all legal in SKETCHMAGEDDON. </p><p> <br>    <strong>SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition </strong></p><p>Friday, May 6th at 10pm </p><p>Tickets are $5</p><p>------------</p><p><strong>The Push Comedy Theater </strong>only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-05-06T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-05-06T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-25T22:34:56.967Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Sketchmageddon ==========="
Logger.info "=========== BEGIN Processing Universe Event Harold Night ==========="

Logger.info "=========== Writing Event Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "WL3TB9",
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
<p>Friday, August 25th at 10:00pm
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
    slug: "WL3TB9",
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
<p>Friday, August 25th at 10:00pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-08-25T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-08-25T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-08-15T19:48:39.024Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Harold Night ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improvised Ghost Story ==========="

Logger.info "=========== Writing Event The Improvised Ghost Story ==========="
event = SeedHelpers.create_event(
  %{
    slug: "ZPXKRY",
    title: "The Improvised Ghost Story",
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
<p>Saturday, June 3rd at 8pm
</p>
<p>Tickets are $5
</p>
<p>I ain't afraid of no ghost!
</p>
<p>---<br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br><br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.<br><br>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.<br>
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
    slug: "ZPXKRY",
    title: "The Improvised Ghost Story",
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
<p>Saturday, June 3rd at 8pm
</p>
<p>Tickets are $5
</p>
<p>I ain't afraid of no ghost!
</p>
<p>---<br><br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br><br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.<br><br>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.<br>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-06-03T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-06-03T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-31T03:02:32.355Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improvised Ghost Story ==========="
Logger.info "=========== BEGIN Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="

Logger.info "=========== Writing Event Who Dunnit? ...The Improvised Murder Mystery ==========="
event = SeedHelpers.create_event(
  %{
    slug: "3BWSV6",
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
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, November 12th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $10
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
    slug: "3BWSV6",
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
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, November 12th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $10
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
    start_at:  NaiveDateTime.from_iso8601!("2016-11-12T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-11-12T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-10-15T20:37:44.834Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="
Logger.info "=========== BEGIN Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="

Logger.info "=========== Writing Event Who Dunnit? ...The Improvised Murder Mystery ==========="
event = SeedHelpers.create_event(
  %{
    slug: "HM8WP2",
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
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, March 11th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $10
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
    slug: "HM8WP2",
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
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, March 11th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $10
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
    start_at:  NaiveDateTime.from_iso8601!("2017-03-11T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-11T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-01-20T15:37:11.946Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="
Logger.info "=========== BEGIN Processing Universe Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="

Logger.info "=========== Writing Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
event = SeedHelpers.create_event(
  %{
    slug: "FP1D9G",
    title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    description: """
    <p><strong>The Push Comedy Theater's Experimental Sketch Comedy Showcase is back with a vengeance!!!!</strong>
</p>
<p>Last month a new champion was crowned... but a new challenger is lurking in the wings to strick.
</p>
<p>Don't miss this epic sketch comedy showdown!!!!
</p>
<p><strong>SKETCHMAGEDDON... with special guest house Adam Paine.</strong>
</p>
<p>--
</p>
<p>Get ready for a sketch comedy show like no other!!!
</p>
<p><strong>SKETCHMAGEDDON</strong> takes three groups and forces them to compete in an all-out comedy deathmatch!
</p>
<p>Each team will be given 15 minutes to dazzle you with their comedy prowess. It's Saturday Night Live meets Thunderdome!!!!
</p>
<p>Unlike its improvised sister show IMPROVAGEDDON, SKETCHMAGEDDON features all written and rehearsed material.  Props, costumes, and special effects are all legal in SKETCHMAGEDDON.
</p>
<p>This is a completely experimental show.  You never know what you are going to see.
</p>
<p><strong>SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition</strong>
</p>
<p>Friday, February 3rd at 10pm
</p>
<p>Tickets are $5
</p>
<p>------------
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
Logger.info "=========== Writing Event Listing SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "FP1D9G",
    title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    description: """
    <p><strong>The Push Comedy Theater's Experimental Sketch Comedy Showcase is back with a vengeance!!!!</strong>
</p>
<p>Last month a new champion was crowned... but a new challenger is lurking in the wings to strick.
</p>
<p>Don't miss this epic sketch comedy showdown!!!!
</p>
<p><strong>SKETCHMAGEDDON... with special guest house Adam Paine.</strong>
</p>
<p>--
</p>
<p>Get ready for a sketch comedy show like no other!!!
</p>
<p><strong>SKETCHMAGEDDON</strong> takes three groups and forces them to compete in an all-out comedy deathmatch!
</p>
<p>Each team will be given 15 minutes to dazzle you with their comedy prowess. It's Saturday Night Live meets Thunderdome!!!!
</p>
<p>Unlike its improvised sister show IMPROVAGEDDON, SKETCHMAGEDDON features all written and rehearsed material.  Props, costumes, and special effects are all legal in SKETCHMAGEDDON.
</p>
<p>This is a completely experimental show.  You never know what you are going to see.
</p>
<p><strong>SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition</strong>
</p>
<p>Friday, February 3rd at 10pm
</p>
<p>Tickets are $5
</p>
<p>------------
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-02-03T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-02-03T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/83a0c1e9-fd2e-4b82-9e5b-a1edaf6416c9",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/83a0c1e9-fd2e-4b82-9e5b-a1edaf6416c9",
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
    name: "Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    status: "available",
    description: "Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-02-02T16:27:21.949Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
Logger.info "=========== BEGIN Processing Universe Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="

Logger.info "=========== Writing Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
event = SeedHelpers.create_event(
  %{
    slug: "CFM4YG",
    title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    description: """
    <p><strong>Don't miss this epic sketch comedy showdown, where truly anything can happen.</strong><br>
</p>
<p>And we do mean anything!!!  Sometimes it's funny, sometimes it's weird, it's always entertaining.
</p>
<p>SKETCHMAGEDDON
</p>
<p>Last month... we crowned an unexpected new champ, A Lone.  But know they'll be going up against 2 powerhouse teams... Sk3l3ton Cr3w and the Pre Madonnas.  Can the rookie champ keep their crown? <br>
</p>
<p>--
</p>
<p>Get ready for a sketch comedy show like no other!!!
</p>
<p><strong>SKETCHMAGEDDON</strong> takes three groups and forces them to compete in an all-out comedy deathmatch!
</p>
<p>Each team will be given 15 minutes to dazzle you with their comedy prowess. It's Saturday Night Live meets Thunderdome!!!!
</p>
<p>Unlike its improvised sister show IMPROVAGEDDON, SKETCHMAGEDDON features all written and rehearsed material.  Props, costumes, and special effects are all legal in SKETCHMAGEDDON.
</p>
<p>This is a completely experimental show.  You never know what you are going to see.
</p>
<p><strong>SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition</strong>
</p>
<p>Friday, December 1st at 10pm
</p>
<p>Tickets are $5
</p>
<p>------------
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
Logger.info "=========== Writing Event Listing SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "CFM4YG",
    title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    description: """
    <p><strong>Don't miss this epic sketch comedy showdown, where truly anything can happen.</strong><br>
</p>
<p>And we do mean anything!!!  Sometimes it's funny, sometimes it's weird, it's always entertaining.
</p>
<p>SKETCHMAGEDDON
</p>
<p>Last month... we crowned an unexpected new champ, A Lone.  But know they'll be going up against 2 powerhouse teams... Sk3l3ton Cr3w and the Pre Madonnas.  Can the rookie champ keep their crown? <br>
</p>
<p>--
</p>
<p>Get ready for a sketch comedy show like no other!!!
</p>
<p><strong>SKETCHMAGEDDON</strong> takes three groups and forces them to compete in an all-out comedy deathmatch!
</p>
<p>Each team will be given 15 minutes to dazzle you with their comedy prowess. It's Saturday Night Live meets Thunderdome!!!!
</p>
<p>Unlike its improvised sister show IMPROVAGEDDON, SKETCHMAGEDDON features all written and rehearsed material.  Props, costumes, and special effects are all legal in SKETCHMAGEDDON.
</p>
<p>This is a completely experimental show.  You never know what you are going to see.
</p>
<p><strong>SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition</strong>
</p>
<p>Friday, December 1st at 10pm
</p>
<p>Tickets are $5
</p>
<p>------------
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-12-01T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-12-01T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/83a0c1e9-fd2e-4b82-9e5b-a1edaf6416c9",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/83a0c1e9-fd2e-4b82-9e5b-a1edaf6416c9",
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
    name: "Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    status: "available",
    description: "Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-21T05:07:00.374Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
Logger.info "=========== BEGIN Processing Universe Event The Dudes: Dude-A-Palooza ==========="

Logger.info "=========== Writing Event The Dudes: Dude-A-Palooza ==========="
event = SeedHelpers.create_event(
  %{
    slug: "N2VXTP",
    title: "The Dudes: Dude-A-Palooza",
    description: """
    <p>It's a new year, which means new adventures for The Dudes! And starting the year off is a trip to South Carolina for the annual Charleston Comedy Festival... but before we go, YOU can catch a preview of the type of off-road nonsense we'll be getting into. Come out for some loud, honest laughs at The Push Comedy Theater in Norfolk's NEON Arts District!
</p>
<p><br><br>The Dudes are bunch of guys, often laid back, but sometimes high-strung, who like to drink beer, talk about dude things, and perfom improv comedy. They're multi-IMPROVAGEDDON champions and have performed up and down I-64... and soon, I-95.
</p>
<p><br><br>Don't miss a night of Dude-inspired comedy, featuring "The Rant" (a.k.a. The Walter) longform-style improv!
</p>
<p><br><br>Featuring substiDUDE, Angel Sanchez.
</p>
<p><br><br>The Dudes Improvisational Comedy are:
</p>
<p><br><br>Rafael <br>Adam <br>James <br>Matt <br>Brian <br>Anthony
</p>
<p><br><br>The Dudes present... Dude-A-Palooza<br>Saturday, January 14th at 10pm<br>Tickets are $5
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
<p><br><br>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Dudes: Dude-A-Palooza ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "N2VXTP",
    title: "The Dudes: Dude-A-Palooza",
    description: """
    <p>It's a new year, which means new adventures for The Dudes! And starting the year off is a trip to South Carolina for the annual Charleston Comedy Festival... but before we go, YOU can catch a preview of the type of off-road nonsense we'll be getting into. Come out for some loud, honest laughs at The Push Comedy Theater in Norfolk's NEON Arts District!
</p>
<p><br><br>The Dudes are bunch of guys, often laid back, but sometimes high-strung, who like to drink beer, talk about dude things, and perfom improv comedy. They're multi-IMPROVAGEDDON champions and have performed up and down I-64... and soon, I-95.
</p>
<p><br><br>Don't miss a night of Dude-inspired comedy, featuring "The Rant" (a.k.a. The Walter) longform-style improv!
</p>
<p><br><br>Featuring substiDUDE, Angel Sanchez.
</p>
<p><br><br>The Dudes Improvisational Comedy are:
</p>
<p><br><br>Rafael <br>Adam <br>James <br>Matt <br>Brian <br>Anthony
</p>
<p><br><br>The Dudes present... Dude-A-Palooza<br>Saturday, January 14th at 10pm<br>Tickets are $5
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
<p><br><br>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-01-14T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-01-14T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/d9939828-5c3a-4fa9-a98f-9e6b1462555c",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/d9939828-5c3a-4fa9-a98f-9e6b1462555c",
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
    name: "Ticket for The Dudes: Dude-A-Palooza",
    status: "available",
    description: "Ticket for The Dudes: Dude-A-Palooza",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-01-06T20:02:41.352Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Dudes: Dude-A-Palooza ==========="
