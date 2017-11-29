require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event How the West was Improvised: The Made Up Western ==========="

Logger.info "=========== Writing Event How the West was Improvised: The Made Up Western ==========="
event = SeedHelpers.create_event(
  %{
    slug: "20BMR5",
    title: "How the West was Improvised: The Made Up Western",
    description: """
    <p>Howdy there, partner!
</p>
<p>Get ready for the Improvised Western.<br><br>Don't miss the gun slinger with a heart of gold, the damsel in distress, the villain dressed in black... bank heists, shoot outs, horse chases and more.<br><br>It's everything you love about the good old fashioned western... made up right before your eyes.<br><br>From John Wayne to Clint Eastwood, Tombstone to True Grit... if you're a fan of westerns (or just a fan of comedy), you'll love How the West was Improvised.<br><br>How the West was Improvised: The Made Up Western<br>Saturday, July 22nd at 8pm<br>Tickets are $5
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing How the West was Improvised: The Made Up Western ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "20BMR5",
    title: "How the West was Improvised: The Made Up Western",
    description: """
    <p>Howdy there, partner!
</p>
<p>Get ready for the Improvised Western.<br><br>Don't miss the gun slinger with a heart of gold, the damsel in distress, the villain dressed in black... bank heists, shoot outs, horse chases and more.<br><br>It's everything you love about the good old fashioned western... made up right before your eyes.<br><br>From John Wayne to Clint Eastwood, Tombstone to True Grit... if you're a fan of westerns (or just a fan of comedy), you'll love How the West was Improvised.<br><br>How the West was Improvised: The Made Up Western<br>Saturday, July 22nd at 8pm<br>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-07-22T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-22T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/ede18078-282b-4d44-9da2-35e79ef80318",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/ede18078-282b-4d44-9da2-35e79ef80318",
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

# Insert improvised
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "improvised"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for How the West was Improvised: The Made Up Western",
    status: "available",
    description: "Ticket for How the West was Improvised: The Made Up Western",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-17T21:57:45.666Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event How the West was Improvised: The Made Up Western ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="

Logger.info "=========== Writing Event The Improv Riot: The Short Form Improv Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "24RZJM",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.</p><p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.</p><p><strong style="background-color: initial;">The Improv Riot: The Short Form Improv Show</strong></p><p>Friday, June 24th, 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the parking lot directly across from the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "24RZJM",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.</p><p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.</p><p><strong style="background-color: initial;">The Improv Riot: The Short Form Improv Show</strong></p><p>Friday, June 24th, 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the parking lot directly across from the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-24T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-24T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-06-06T03:00:48.459Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 101 Grad Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 101 Grad Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "KZ0RCQ",
    title: "Class Dismissed: The Improv 101 Grad Show",
    description: """
    <p>Dust off those caps and gowns... because it's graduation time at the Push.
</p>
<p>Check out the Push Comedy Theater's Improv 101 class as they show off their comedy chops.
</p>
<p>You won't believe what these improv newcomers have in store for you!!!
</p>
<p>Class Dismissed: The Improv 101 Graduation Show<br>Thursday, December 29th at 8pm<br>Tickets are $5
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
    slug: "KZ0RCQ",
    title: "Class Dismissed: The Improv 101 Grad Show",
    description: """
    <p>Dust off those caps and gowns... because it's graduation time at the Push.
</p>
<p>Check out the Push Comedy Theater's Improv 101 class as they show off their comedy chops.
</p>
<p>You won't believe what these improv newcomers have in store for you!!!
</p>
<p>Class Dismissed: The Improv 101 Graduation Show<br>Thursday, December 29th at 8pm<br>Tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2016-12-29T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-12-29T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-12-23T06:41:36.979Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 101 Grad Show ==========="
Logger.info "=========== BEGIN Processing Universe Event From Justin to Kelly + Glassworks + The Pushers ==========="

Logger.info "=========== Writing Event From Justin to Kelly + Glassworks + The Pushers ==========="
event = SeedHelpers.create_event(
  %{
    slug: "WPVKT3",
    title: "From Justin to Kelly + Glassworks + The Pushers",
    description: """
    <p style="text-align: center;"><strong></strong><strong>Get ready for a great night of comedy as the Push Comedy Theater presents a comedy invasion!!!</strong></p><p style="text-align: center;">3 acclaimed groups!  1 night of kick ass improv!!!!</p><p style="text-align: center;"><strong>Glassworks:</strong></p><p style="text-align: center;">Glassworks, based out of Eau Claire, Wisconsin, is the comedy trio of Alex Raney, Mack Hastings, and Elliot Heinz. Focusing on relationships, honesty, and the present moment, Glassworks crafts truly unique comedy. With over six years of rehearsals, shows, and 12-hour van rides on any of their six national tours, the performers share an infectious synergy. It's truth in comedy, but not like you've seen it before.</p><p style="text-align: center;"><strong>From Justin to Kelly:</strong></p><p style="text-align: center;">Acclaimed as one of the best improv duos in the nation, longtime New York City comedians Justin Peters and Kelly Buttermore perform fully improvised one-act plays that are usually funny, sometimes disturbing, and always memorable. Whether they’re playing two lonely old ladies sunning themselves at a deserted public pool, or a down-on-their-luck married couple celebrating their anniversary with a furtive tryst in their kids’ treehouse, Peters and Buttermore emphasize high-stakes scenework that embraces the terror and potential of the present tense.</p><p style="text-align: center;"><strong>The Pushers:</strong></p><p style="text-align: center;">The Pushers are Virginia's premiere sketch and improv comedy group.  For ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage.  The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter.   </p><p style="text-align: center;">The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival.  In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p style="text-align: center;">From Justin to Kelly (NYC) + Glassworks (WI) + The Pushers (NFK)</p><p style="text-align: center;">Thursday, November 19th at the Push Comedy Theater</p><p style="text-align: center;">The show start at 8pm and costs $10</p><p style="text-align: center;"> <strong>Acclaimed Improv Groups to Tour East Coast </strong></p><p style="text-align: center;">On November 13, 2015, the New York City-based improv duo From Justin to Kelly and the Eau Claire, Wisconsin-based improv trio Glassworks will make improv history by hitting the road for a nine-day, nine-show tour of East Coast comedy theaters. <br>It is the first time that two independent improv groups have embarked on a joint tour of this magnitude. Barring catastrophe, it will not be the last. </p><p style="text-align: center;"><br><strong>The First-Ever Tour of its Kind </strong><br>Improv comedy groups are traditionally tied to specific theaters, and will only leave those theaters to perform at comedy festivals, if at all. Glassworks and From Justin to Kelly are among the very few established improv groups nationwide that have decided to flip this model and make the road their “home theater.” In doing so, Glassworks and From Justin to Kelly hope to blaze a path that other groups can follow. They have patterned themselves on the many independent musicians who build their audiences through regular, DIY touring. <br>This East Coast tour will mark Glassworks’ seventh national improv tour, and From Justin to Kelly’s fourth. </p><p style="text-align: center;"><strong>Tour Dates </strong><br>Friday, November 13 - Arcade Comedy Theater <br>Pittsburgh, Pa. </p><p style="text-align: center;">Saturday, November - 14 Harrisburg Improv Theatre <br>Harrisburg, Pa. </p><p style="text-align: center;">Sunday, November 15 - House Show <br>Brooklyn, N.Y. </p><p style="text-align: center;"><br>Monday, November 16 - House Show <br>Brooklyn, N.Y. </p><p style="text-align: center;"><br>Tuesday, November 17 - Muchmore’s <br>Brooklyn, N.Y. </p><p style="text-align: center;">Wednesday, November 18 - DSI Comedy Theater <br>Chapel Hill, N.C. </p><p style="text-align: center;"><br>Thursday,November 19 - Push Comedy Theater <br>Norfolk, Va. </p><p style="text-align: center;">Friday, November 20 - Coalition Theater <br>Richmond, Va. </p><p style="text-align: center;"><br>Saturday, November 21 - Charm City Comedy Project <br>Baltimore, Md. </p><p style="text-align: center;"><img src="https://s3.amazonaws.com/uniiverse_production/attachments/3f9222a5822b7b6462e58765bfca2527-Justin%20and%20Kelly.jpg" alt="" style="display: block; margin: auto;"></p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing From Justin to Kelly + Glassworks + The Pushers ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "WPVKT3",
    title: "From Justin to Kelly + Glassworks + The Pushers",
    description: """
    <p style="text-align: center;"><strong></strong><strong>Get ready for a great night of comedy as the Push Comedy Theater presents a comedy invasion!!!</strong></p><p style="text-align: center;">3 acclaimed groups!  1 night of kick ass improv!!!!</p><p style="text-align: center;"><strong>Glassworks:</strong></p><p style="text-align: center;">Glassworks, based out of Eau Claire, Wisconsin, is the comedy trio of Alex Raney, Mack Hastings, and Elliot Heinz. Focusing on relationships, honesty, and the present moment, Glassworks crafts truly unique comedy. With over six years of rehearsals, shows, and 12-hour van rides on any of their six national tours, the performers share an infectious synergy. It's truth in comedy, but not like you've seen it before.</p><p style="text-align: center;"><strong>From Justin to Kelly:</strong></p><p style="text-align: center;">Acclaimed as one of the best improv duos in the nation, longtime New York City comedians Justin Peters and Kelly Buttermore perform fully improvised one-act plays that are usually funny, sometimes disturbing, and always memorable. Whether they’re playing two lonely old ladies sunning themselves at a deserted public pool, or a down-on-their-luck married couple celebrating their anniversary with a furtive tryst in their kids’ treehouse, Peters and Buttermore emphasize high-stakes scenework that embraces the terror and potential of the present tense.</p><p style="text-align: center;"><strong>The Pushers:</strong></p><p style="text-align: center;">The Pushers are Virginia's premiere sketch and improv comedy group.  For ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage.  The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter.   </p><p style="text-align: center;">The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival.  In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p style="text-align: center;">From Justin to Kelly (NYC) + Glassworks (WI) + The Pushers (NFK)</p><p style="text-align: center;">Thursday, November 19th at the Push Comedy Theater</p><p style="text-align: center;">The show start at 8pm and costs $10</p><p style="text-align: center;"> <strong>Acclaimed Improv Groups to Tour East Coast </strong></p><p style="text-align: center;">On November 13, 2015, the New York City-based improv duo From Justin to Kelly and the Eau Claire, Wisconsin-based improv trio Glassworks will make improv history by hitting the road for a nine-day, nine-show tour of East Coast comedy theaters. <br>It is the first time that two independent improv groups have embarked on a joint tour of this magnitude. Barring catastrophe, it will not be the last. </p><p style="text-align: center;"><br><strong>The First-Ever Tour of its Kind </strong><br>Improv comedy groups are traditionally tied to specific theaters, and will only leave those theaters to perform at comedy festivals, if at all. Glassworks and From Justin to Kelly are among the very few established improv groups nationwide that have decided to flip this model and make the road their “home theater.” In doing so, Glassworks and From Justin to Kelly hope to blaze a path that other groups can follow. They have patterned themselves on the many independent musicians who build their audiences through regular, DIY touring. <br>This East Coast tour will mark Glassworks’ seventh national improv tour, and From Justin to Kelly’s fourth. </p><p style="text-align: center;"><strong>Tour Dates </strong><br>Friday, November 13 - Arcade Comedy Theater <br>Pittsburgh, Pa. </p><p style="text-align: center;">Saturday, November - 14 Harrisburg Improv Theatre <br>Harrisburg, Pa. </p><p style="text-align: center;">Sunday, November 15 - House Show <br>Brooklyn, N.Y. </p><p style="text-align: center;"><br>Monday, November 16 - House Show <br>Brooklyn, N.Y. </p><p style="text-align: center;"><br>Tuesday, November 17 - Muchmore’s <br>Brooklyn, N.Y. </p><p style="text-align: center;">Wednesday, November 18 - DSI Comedy Theater <br>Chapel Hill, N.C. </p><p style="text-align: center;"><br>Thursday,November 19 - Push Comedy Theater <br>Norfolk, Va. </p><p style="text-align: center;">Friday, November 20 - Coalition Theater <br>Richmond, Va. </p><p style="text-align: center;"><br>Saturday, November 21 - Charm City Comedy Project <br>Baltimore, Md. </p><p style="text-align: center;"><img src="https://s3.amazonaws.com/uniiverse_production/attachments/3f9222a5822b7b6462e58765bfca2527-Justin%20and%20Kelly.jpg" alt="" style="display: block; margin: auto;"></p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-11-19T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-11-19T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/00aed0a9-4371-408e-b879-e18b18ec2fd6",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/00aed0a9-4371-408e-b879-e18b18ec2fd6",
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

# Insert groups
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "groups"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for From Justin to Kelly + Glassworks + The Pushers",
    status: "available",
    description: "Ticket for From Justin to Kelly + Glassworks + The Pushers",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-04T23:03:29.676Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event From Justin to Kelly + Glassworks + The Pushers ==========="
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="

Logger.info "=========== Writing Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
event = SeedHelpers.create_event(
  %{
    slug: "7NLVC2",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, February 25th
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
    slug: "7NLVC2",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, February 25th
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
    start_at:  NaiveDateTime.from_iso8601!("2017-02-25T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-02-25T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-02-17T19:59:28.401Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
Logger.info "=========== BEGIN Processing Universe Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="

Logger.info "=========== Writing Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
event = SeedHelpers.create_event(
  %{
    slug: "7PW92R",
    title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    description: """
    <p><strong>Don't miss this epic sketch comedy showdown, where truly anything can happen.</strong><br>
</p>
<p>And we do mean anything!!!  Sometimes it's funny, sometimes it's weird, it's always entertaining.
</p>
<p>SKETCHMAGEDDON
</p>
<p>Last month, newcomers 3 Star Review took down 2 veteran powerhouses!  This month they're the vets going against two brand new teams.  Will they repeat?<br>
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
<p>Friday, October 6th at 10pm
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
    slug: "7PW92R",
    title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    description: """
    <p><strong>Don't miss this epic sketch comedy showdown, where truly anything can happen.</strong><br>
</p>
<p>And we do mean anything!!!  Sometimes it's funny, sometimes it's weird, it's always entertaining.
</p>
<p>SKETCHMAGEDDON
</p>
<p>Last month, newcomers 3 Star Review took down 2 veteran powerhouses!  This month they're the vets going against two brand new teams.  Will they repeat?<br>
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
<p>Friday, October 6th at 10pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-10-06T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-10-06T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-26T03:31:40.420Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
Logger.info "=========== BEGIN Processing Universe Event Getting to Know the Couple: with Brad and Alba ==========="

Logger.info "=========== Writing Event Getting to Know the Couple: with Brad and Alba ==========="
event = SeedHelpers.create_event(
  %{
    slug: "GFBQYX",
    title: "Getting to Know the Couple: with Brad and Alba",
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
<p><strong>Getting to Know the Couple: With Brad and Alba</strong>
</p>
<p>Friday, March 3rd at 8pm
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
    slug: "GFBQYX",
    title: "Getting to Know the Couple: with Brad and Alba",
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
<p><strong>Getting to Know the Couple: With Brad and Alba</strong>
</p>
<p>Friday, March 3rd at 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-03-03T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-03T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-02-22T23:25:58.715Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Getting to Know the Couple: with Brad and Alba ==========="
Logger.info "=========== BEGIN Processing Universe Event Locals Only featuring Musical Riot and The Dudes ==========="

Logger.info "=========== Writing Event Locals Only featuring Musical Riot and The Dudes ==========="
event = SeedHelpers.create_event(
  %{
    slug: "CBYVW1",
    title: "Locals Only featuring Musical Riot and The Dudes",
    description: """
    <h2 style="text-align: center;">Don't miss Hampton Roads' finest comedy Super Stars!!!</h2>
<h3 style="text-align: center;">Monocle</h3>
<p style="text-align: center;">Style. Glamour. Sophistication. Comedy.
</p>
<p style="text-align: center;">Monocle is a 2x (and current) IMPROVAGEDDON champion.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Monocole.jpg" rel="nofollow" target="_blank"><br> </a><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Monocole1.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Monocole1-683x1024.jpg" alt=""></a>
</p>
<h3 style="text-align: center;">Musical Riot</h3>
<p style="text-align: center;">Get ready for a comedy and music mash up, as the gang from Musical Riot brings you a night of comedy served with a healthy dose of song.  It's Whose Line is it Anyway-style improv, only with a lot more singing.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Musical-Riot.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Musical-Riot.jpg" alt=""></a>
</p>
<h3 style="text-align: center;">The Dudes</h3>
<p style="text-align: center;">The Dudes are bunch of guys, often laid back, sometimes high-strung, who do nonsensical improv comedy. They're a resident group at The Push Comedy Theater and have also performed up and down the lower-Atlantic seaboard.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Dudes.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Dudes.jpg" alt=""></a>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Locals Only featuring Musical Riot and The Dudes ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "CBYVW1",
    title: "Locals Only featuring Musical Riot and The Dudes",
    description: """
    <h2 style="text-align: center;">Don't miss Hampton Roads' finest comedy Super Stars!!!</h2>
<h3 style="text-align: center;">Monocle</h3>
<p style="text-align: center;">Style. Glamour. Sophistication. Comedy.
</p>
<p style="text-align: center;">Monocle is a 2x (and current) IMPROVAGEDDON champion.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Monocole.jpg" rel="nofollow" target="_blank"><br> </a><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Monocole1.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Monocole1-683x1024.jpg" alt=""></a>
</p>
<h3 style="text-align: center;">Musical Riot</h3>
<p style="text-align: center;">Get ready for a comedy and music mash up, as the gang from Musical Riot brings you a night of comedy served with a healthy dose of song.  It's Whose Line is it Anyway-style improv, only with a lot more singing.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Musical-Riot.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Musical-Riot.jpg" alt=""></a>
</p>
<h3 style="text-align: center;">The Dudes</h3>
<p style="text-align: center;">The Dudes are bunch of guys, often laid back, sometimes high-strung, who do nonsensical improv comedy. They're a resident group at The Push Comedy Theater and have also performed up and down the lower-Atlantic seaboard.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Dudes.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Dudes.jpg" alt=""></a>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-09-14T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-14T20:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/16fe38fc-dc00-4c98-ae50-788aff85014f",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/16fe38fc-dc00-4c98-ae50-788aff85014f",
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

# Insert the-dudes
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "the-dudes"
})
Logger.info "=========== Wrote tag ==========="

# Insert locals-only
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "locals-only"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Locals Only featuring Musical Riot and The Dudes",
    status: "available",
    description: "Ticket for Locals Only featuring Musical Riot and The Dudes",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-08-16T02:56:43.714Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Locals Only featuring Musical Riot and The Dudes ==========="
Logger.info "=========== BEGIN Processing Universe Event April Fools' Day Improv All Stars ==========="

Logger.info "=========== Writing Event April Fools' Day Improv All Stars ==========="
event = SeedHelpers.create_event(
  %{
    slug: "W2N8S5",
    title: "April Fools' Day Improv All Stars",
    description: """
    <p>Ever been pranked on April Fools' Day? Ever pulled off an amazing feat of April Fools' Day pranking? We want to hear about it! <br> <br> This April Fools' Day the Push Comedy Theater will be doing improv based on real April Fools' Day pranks!<br> Don't miss it! <br> <br> April Fools' Day Improv<br> Saturday, April 1st, 8pm<br> Tickets are $5<br> <br> <br> The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br> <br>  Free parking available at Slone Chiropractic (111 W Virginia Beach)  just one block from the theater. There is also limited parking on the  street.<br> <br> ---<br> <br> The Pushers are Virginia's premiere sketch  and improv comedy group. For nearly ten years they have thrilled (and  shocked) audiences with their wild antics both on and off stage. The  group puts on a racy, high-octane, energetic show that is guaranteed to  have audiences howling with laughter. In November of 2014, they opened their own  theater, The Push Comedy Theater, located in the Norfolk Arts  District.<br> <br> In 2013 The Pushers' Off-Broadway musical Cuff Me:  The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York  City. It ran for over a year in both New York and Chicago. A third  production is currently touring the country.<br> <br> The Pushers have  appeared at both The Charleston Comedy Festival and The North Carolina  Comedy Arts Festival. In New York, they have performed at The People's  Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater  in New York's East Village.<br> <br> Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.<br> <br> --<br> <br>  The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's  brand new Arts District. Founded by local comedy group The Pushers, the  Push Comedy Theater is dedicated to bringing you live comedy from the  best local and national acts.<br> <br> The Push Comedy Theater will host  live sketch, improv and stand-up comedy on Friday and Saturday nights.  During the week classes will be offered in stand-up, sketch and improv  comedy as well as acting and film production.<br> <br> Whether you're a  die-hard comedy lover or a casual fan... a seasoned performer or someone  who's never stepped foot on stage... the Push Comedy Theater has  something for you.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing April Fools' Day Improv All Stars ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "W2N8S5",
    title: "April Fools' Day Improv All Stars",
    description: """
    <p>Ever been pranked on April Fools' Day? Ever pulled off an amazing feat of April Fools' Day pranking? We want to hear about it! <br> <br> This April Fools' Day the Push Comedy Theater will be doing improv based on real April Fools' Day pranks!<br> Don't miss it! <br> <br> April Fools' Day Improv<br> Saturday, April 1st, 8pm<br> Tickets are $5<br> <br> <br> The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br> <br>  Free parking available at Slone Chiropractic (111 W Virginia Beach)  just one block from the theater. There is also limited parking on the  street.<br> <br> ---<br> <br> The Pushers are Virginia's premiere sketch  and improv comedy group. For nearly ten years they have thrilled (and  shocked) audiences with their wild antics both on and off stage. The  group puts on a racy, high-octane, energetic show that is guaranteed to  have audiences howling with laughter. In November of 2014, they opened their own  theater, The Push Comedy Theater, located in the Norfolk Arts  District.<br> <br> In 2013 The Pushers' Off-Broadway musical Cuff Me:  The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York  City. It ran for over a year in both New York and Chicago. A third  production is currently touring the country.<br> <br> The Pushers have  appeared at both The Charleston Comedy Festival and The North Carolina  Comedy Arts Festival. In New York, they have performed at The People's  Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater  in New York's East Village.<br> <br> Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.<br> <br> --<br> <br>  The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's  brand new Arts District. Founded by local comedy group The Pushers, the  Push Comedy Theater is dedicated to bringing you live comedy from the  best local and national acts.<br> <br> The Push Comedy Theater will host  live sketch, improv and stand-up comedy on Friday and Saturday nights.  During the week classes will be offered in stand-up, sketch and improv  comedy as well as acting and film production.<br> <br> Whether you're a  die-hard comedy lover or a casual fan... a seasoned performer or someone  who's never stepped foot on stage... the Push Comedy Theater has  something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-04-01T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-04-01T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/f764d5c0-2be3-4d22-8256-85f89c5c9195",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/f764d5c0-2be3-4d22-8256-85f89c5c9195",
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
    name: "Ticket for April Fools' Day Improv All Stars",
    status: "available",
    description: "Ticket for April Fools' Day Improv All Stars",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-27T01:25:28.759Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event April Fools' Day Improv All Stars ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improvised Ghost Story ==========="

Logger.info "=========== Writing Event The Improvised Ghost Story ==========="
event = SeedHelpers.create_event(
  %{
    slug: "YW3TFK",
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
<p>Saturday, August 20th at 8pm
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
    slug: "YW3TFK",
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
<p>Saturday, August 20th at 8pm
</p>
<p>Tickets are $5
</p>
<p><br>
</p>
<p>I ain't afraid of no ghost!
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-17T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-17T21:30:00.000-04:00")
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

# Insert free
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "free"
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
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2016-09-05T03:12:45.309Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improvised Ghost Story ==========="
Logger.info "=========== BEGIN Processing Universe Event The Push Comedy Theater Anniversary Bash ==========="

Logger.info "=========== Writing Event The Push Comedy Theater Anniversary Bash ==========="
event = SeedHelpers.create_event(
  %{
    slug: "JV8367",
    title: "The Push Comedy Theater Anniversary Bash",
    description: """
    <p>They said it couldn't be done...  They said it shouldn't be done...
</p>
<p>Despite the odds (and it's dipsh*tty owners), the Push Comedy Theater is turning 2 years old!!!!
</p>
<p>To celebrate the fact that we're still open, we are throwing the anniversary bash to end all anniversary bashes!!!
</p>
<p>Get ready for a night of sketch comedy with <strong>The Pushers </strong>and members of <strong>The Bright Side</strong>, <strong>Short Stack</strong>, <strong>The Pre Madonnas</strong>, the <strong>Upright Senior Citizens Brigade</strong>, <strong>The Party Crashers</strong> and more.
</p>
<p>We're cramming a year's worth of comedy into one amazing show and the best part is you, the audience will choose what sketches we perform!!!
</p>
<p>How exactly will this work, you ask... you're going to have to come to the show to find out.
</p>
<p><strong>The Push Comedy Theater Anniversary Bash</strong>
</p>
<p>Friday, November 18th at 8pm.
</p>
<p>Tickets are $10.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Push Comedy Theater Anniversary Bash ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "JV8367",
    title: "The Push Comedy Theater Anniversary Bash",
    description: """
    <p>They said it couldn't be done...  They said it shouldn't be done...
</p>
<p>Despite the odds (and it's dipsh*tty owners), the Push Comedy Theater is turning 2 years old!!!!
</p>
<p>To celebrate the fact that we're still open, we are throwing the anniversary bash to end all anniversary bashes!!!
</p>
<p>Get ready for a night of sketch comedy with <strong>The Pushers </strong>and members of <strong>The Bright Side</strong>, <strong>Short Stack</strong>, <strong>The Pre Madonnas</strong>, the <strong>Upright Senior Citizens Brigade</strong>, <strong>The Party Crashers</strong> and more.
</p>
<p>We're cramming a year's worth of comedy into one amazing show and the best part is you, the audience will choose what sketches we perform!!!
</p>
<p>How exactly will this work, you ask... you're going to have to come to the show to find out.
</p>
<p><strong>The Push Comedy Theater Anniversary Bash</strong>
</p>
<p>Friday, November 18th at 8pm.
</p>
<p>Tickets are $10.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-11-18T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-11-18T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/63dd978b-089d-482e-a217-1b504191958d",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/63dd978b-089d-482e-a217-1b504191958d",
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

# Insert anniversary
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "anniversary"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Push Comedy Theater Anniversary Bash",
    status: "available",
    description: "Ticket for The Push Comedy Theater Anniversary Bash",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-14T19:45:10.615Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Push Comedy Theater Anniversary Bash ==========="
Logger.info "=========== BEGIN Processing Universe Event Sketchmageddon ==========="

Logger.info "=========== Writing Event Sketchmageddon ==========="
event = SeedHelpers.create_event(
  %{
    slug: "YR9NZ0",
    title: "Sketchmageddon",
    description: """
    <p><strong>The Push Comedy Theater's Sketch Comedy Showcase is back with a vengeance!!!!</strong>
</p>
<p>This is the show where anything goes ... and we do mean anything.
</p>
<p>Last month the champions, <strong>Hug Box</strong> were unceremoniously dethroned by newcomers <strong>Adam and Evil</strong>.  Will the new champs be able to hang onto the title???
</p>
<p>Find out at Sketchmageddon!!!
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
    slug: "YR9NZ0",
    title: "Sketchmageddon",
    description: """
    <p><strong>The Push Comedy Theater's Sketch Comedy Showcase is back with a vengeance!!!!</strong>
</p>
<p>This is the show where anything goes ... and we do mean anything.
</p>
<p>Last month the champions, <strong>Hug Box</strong> were unceremoniously dethroned by newcomers <strong>Adam and Evil</strong>.  Will the new champs be able to hang onto the title???
</p>
<p>Find out at Sketchmageddon!!!
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
    start_at:  NaiveDateTime.from_iso8601!("2016-09-02T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-02T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-18T02:38:09.354Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Sketchmageddon ==========="
Logger.info "=========== BEGIN Processing Universe Event The Upright Senior Citizens Brigade ==========="

Logger.info "=========== Writing Event The Upright Senior Citizens Brigade ==========="
event = SeedHelpers.create_event(
  %{
    slug: "QV2PYG",
    title: "The Upright Senior Citizens Brigade",
    description: """
    <p><strong></strong><strong>The Youth is Wasted on the Young!!!</strong></p><p> <br>The Upright Senior Citizens Brigade is a group of 50-year old and up individuals who perform both long and short-form improv as well as sketch comedy. They were trained by The Pushers and with more than 500 years of life experience, they bridge the generation gap in ways you cannot imagine!</p><p>These 50+ year old fogeys will have you in stitches and wishing you wore your depends. <br>Don't miss it!<br><strong><br>The Upright Senior Citizens Brigade</strong><br>Saturday, November 21st at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "QV2PYG",
    title: "The Upright Senior Citizens Brigade",
    description: """
    <p><strong></strong><strong>The Youth is Wasted on the Young!!!</strong></p><p> <br>The Upright Senior Citizens Brigade is a group of 50-year old and up individuals who perform both long and short-form improv as well as sketch comedy. They were trained by The Pushers and with more than 500 years of life experience, they bridge the generation gap in ways you cannot imagine!</p><p>These 50+ year old fogeys will have you in stitches and wishing you wore your depends. <br>Don't miss it!<br><strong><br>The Upright Senior Citizens Brigade</strong><br>Saturday, November 21st at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-11-21T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-11-21T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/42e41589-d01c-4dc2-9b3a-98713a95e2fd",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/42e41589-d01c-4dc2-9b3a-98713a95e2fd",
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
    name: "Ticket for The Upright Senior Citizens Brigade",
    status: "available",
    description: "Ticket for The Upright Senior Citizens Brigade",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-05T19:06:27.409Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Upright Senior Citizens Brigade ==========="
Logger.info "=========== BEGIN Processing Universe Event Jedi Mind Tricks: A Star Wars Improv Show ==========="

Logger.info "=========== Writing Event Jedi Mind Tricks: A Star Wars Improv Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "YGRNJ7",
    title: "Jedi Mind Tricks: A Star Wars Improv Show",
    description: """
    <p><strong>That's no moon... It's a space station!!!</strong>
</p>
<p>We love Star Wars!  We've always loved Star Wars!!!!  So to celebrate the upcoming release of <strong>Rogue One: A Star Wars Story</strong>, The Pushers have gathered some of our Star Wars loving improv friends for a night of Star Wars Shenanigans!
</p>
<p>May the Force be With You
</p>
<p><br><strong>Jedi Mind Tricks: A Star Wars Improv Show</strong><br>Saturday, December 3rd at 8pm<br>Tickets are $5
</p>
<p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/3cf481e738a00f2724afaa89040257cb-star%20wars.jpg" alt="" style="display: block; margin: auto;"><br>
</p>
<p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/1266f9cc0a756422c92268196220be26-droids.jpg" alt="" style="display: block; margin: auto;"><br>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Jedi Mind Tricks: A Star Wars Improv Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "YGRNJ7",
    title: "Jedi Mind Tricks: A Star Wars Improv Show",
    description: """
    <p><strong>That's no moon... It's a space station!!!</strong>
</p>
<p>We love Star Wars!  We've always loved Star Wars!!!!  So to celebrate the upcoming release of <strong>Rogue One: A Star Wars Story</strong>, The Pushers have gathered some of our Star Wars loving improv friends for a night of Star Wars Shenanigans!
</p>
<p>May the Force be With You
</p>
<p><br><strong>Jedi Mind Tricks: A Star Wars Improv Show</strong><br>Saturday, December 3rd at 8pm<br>Tickets are $5
</p>
<p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/3cf481e738a00f2724afaa89040257cb-star%20wars.jpg" alt="" style="display: block; margin: auto;"><br>
</p>
<p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/1266f9cc0a756422c92268196220be26-droids.jpg" alt="" style="display: block; margin: auto;"><br>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-12-03T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-12-03T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/ef13d71c-12e8-46b3-b378-d313351d43d3",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/ef13d71c-12e8-46b3-b378-d313351d43d3",
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
    name: "Ticket for Jedi Mind Tricks: A Star Wars Improv Show",
    status: "available",
    description: "Ticket for Jedi Mind Tricks: A Star Wars Improv Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-30T03:49:52.725Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Jedi Mind Tricks: A Star Wars Improv Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improvised Ghost Story ==========="

Logger.info "=========== Writing Event The Improvised Ghost Story ==========="
event = SeedHelpers.create_event(
  %{
    slug: "CXVHKP",
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
<p>Friday, July 15 at 10pm
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
    slug: "CXVHKP",
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
<p>Friday, July 15 at 10pm
</p>
<p>Tickets are $5
</p>
<p><br>
</p>
<p>I ain't afraid of no ghost!
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-07-15T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-15T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-13T17:03:08.561Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improvised Ghost Story ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More Storytelling ==========="

Logger.info "=========== Writing Event Tell Me More Storytelling ==========="
event = SeedHelpers.create_event(
  %{
    slug: "JPF6TV",
    title: "Tell Me More Storytelling",
    description: """
    <p>Suggested theme: ELECTRICITY<br><br>Want to tell a story? Visit <a href="https://l.facebook.com/l.php?u=http%3A%2F%2Fwww.tellmemorelive.org%2Fpitch&amp;h=ATM8uKh5nwl4N69YVVQcgfhmXbyIqJ9-qdiBHnVpduAeOmAjz3xD871ArFwkw934424WfZ2a4g84y1k1rZTVTRk499fyK0bjmtQOw4hRuThkTGhdX9FJlvZ4v4P1cWdEveFskkNFp46qZ0HUqo-qJPjCWg&amp;enc=AZMUEFm0cXrM5DbqWWyXul5gE-gMcpnAn1uNpQoCtjY2_BLzEOg5v4uJpUbtQ5cegoY&amp;s=1" rel="nofollow" target="_blank">www.tellmemorelive.org/<wbr>pitch</wbr></a>. Call (757) 785-5590. Or email submit@tellmemorelive.org.<br><br>Time: 7 p.m.<br>Date: Sunday, July 16, 2017<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $5
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
    slug: "JPF6TV",
    title: "Tell Me More Storytelling",
    description: """
    <p>Suggested theme: ELECTRICITY<br><br>Want to tell a story? Visit <a href="https://l.facebook.com/l.php?u=http%3A%2F%2Fwww.tellmemorelive.org%2Fpitch&amp;h=ATM8uKh5nwl4N69YVVQcgfhmXbyIqJ9-qdiBHnVpduAeOmAjz3xD871ArFwkw934424WfZ2a4g84y1k1rZTVTRk499fyK0bjmtQOw4hRuThkTGhdX9FJlvZ4v4P1cWdEveFskkNFp46qZ0HUqo-qJPjCWg&amp;enc=AZMUEFm0cXrM5DbqWWyXul5gE-gMcpnAn1uNpQoCtjY2_BLzEOg5v4uJpUbtQ5cegoY&amp;s=1" rel="nofollow" target="_blank">www.tellmemorelive.org/<wbr>pitch</wbr></a>. Call (757) 785-5590. Or email submit@tellmemorelive.org.<br><br>Time: 7 p.m.<br>Date: Sunday, July 16, 2017<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-07-16T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-16T20:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/819e7b44-0f69-4f9e-8d0f-be478a7af698",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/819e7b44-0f69-4f9e-8d0f-be478a7af698",
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-08T18:06:44.254Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More Storytelling ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More Storytelling ==========="

Logger.info "=========== Writing Event Tell Me More Storytelling ==========="
event = SeedHelpers.create_event(
  %{
    slug: "6MQNXH",
    title: "Tell Me More Storytelling",
    description: """
    Suggested theme: DEADLINE<br><br>Want to tell a story? Visit <a href="http://www.tellmemorelive.org/pitch" rel="nofollow" target="_blank">www.tellmemorelive.org/<wbr>pitch</wbr></a>. Call (757) 785-5590. Or email submit@tellmemorelive.org.<br><br>Time: 7 p.m.<br>Date: Sunday, June 18, 2017<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $
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
    slug: "6MQNXH",
    title: "Tell Me More Storytelling",
    description: """
    Suggested theme: DEADLINE<br><br>Want to tell a story? Visit <a href="http://www.tellmemorelive.org/pitch" rel="nofollow" target="_blank">www.tellmemorelive.org/<wbr>pitch</wbr></a>. Call (757) 785-5590. Or email submit@tellmemorelive.org.<br><br>Time: 7 p.m.<br>Date: Sunday, June 18, 2017<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-06-18T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-06-18T20:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1e9c2234-15be-4e23-9b29-73a36d6ca1ff",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1e9c2234-15be-4e23-9b29-73a36d6ca1ff",
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-06-13T20:04:18.485Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More Storytelling ==========="
Logger.info "=========== BEGIN Processing Universe Event Sketch 101 at the Push Comedy Theater ==========="

Logger.info "=========== Writing Event Sketch 101 at the Push Comedy Theater ==========="
event = SeedHelpers.create_event(
  %{
    slug: "K1XS74",
    title: "Sketch 101 at the Push Comedy Theater",
    description: """
    <p>Sketch Comedy Writing 101</p><p>Dive head first into the wonderful world of sketch comedy! Whether you're a seasoned writer or someone who rarely picks up a pen, this class will teach how to get the funny ideas out of your head and onto the page. </p><p>In this class we will examine the various types of sketches, learn how to generate funny ideas and then turn them into a sketches ready for the stage. </p><p>This class is open to everyone, no writing or comedy experience is ready.</p><p>At the end of the session, students sketches will appear in their own SNL-style show</p><p>Prerequisites: none <br>Cost: $190 </p><p>This class will be held on Monday nights from 6:30-9:30 pm, May 5th thru June 9th at the Push Comedy Theater.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Sketch 101 at the Push Comedy Theater ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "K1XS74",
    title: "Sketch 101 at the Push Comedy Theater",
    description: """
    <p>Sketch Comedy Writing 101</p><p>Dive head first into the wonderful world of sketch comedy! Whether you're a seasoned writer or someone who rarely picks up a pen, this class will teach how to get the funny ideas out of your head and onto the page. </p><p>In this class we will examine the various types of sketches, learn how to generate funny ideas and then turn them into a sketches ready for the stage. </p><p>This class is open to everyone, no writing or comedy experience is ready.</p><p>At the end of the session, students sketches will appear in their own SNL-style show</p><p>Prerequisites: none <br>Cost: $190 </p><p>This class will be held on Monday nights from 6:30-9:30 pm, May 5th thru June 9th at the Push Comedy Theater.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-05-05T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-16T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/118a9c8b-e0f4-4b6d-b3ee-c2be59410624",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/118a9c8b-e0f4-4b6d-b3ee-c2be59410624",
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
    name: "Ticket for Sketch 101 at the Push Comedy Theater",
    status: "available",
    description: "Ticket for Sketch 101 at the Push Comedy Theater",
    price: 19000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-01T01:08:00.259Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Sketch 101 at the Push Comedy Theater ==========="
Logger.info "=========== BEGIN Processing Universe Event The Dudes ==========="

Logger.info "=========== Writing Event The Dudes ==========="
event = SeedHelpers.create_event(
  %{
    slug: "P4SJZT",
    title: "The Dudes",
    description: """
    <p>The Dudes Abide!</p><p>Last month at Improvageddon: The Battle of Samhain, The Dudes lost their Improvageddon Championship and the right to wield the Hammer of Lowell in a narrow defeat by the Naughty Nauticals. However, these Dudes are not done. Not by a long shot. Get ready for a special exhibition show, where The Dudes will be showing you exactly why they were two time Improvageddon champs. It'll be some good old fashioned Big Lebowski inspired improv comedy that you won't want to miss! </p><p>The Dudes<br>Saturday, November 21st at 10pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Dudes ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "P4SJZT",
    title: "The Dudes",
    description: """
    <p>The Dudes Abide!</p><p>Last month at Improvageddon: The Battle of Samhain, The Dudes lost their Improvageddon Championship and the right to wield the Hammer of Lowell in a narrow defeat by the Naughty Nauticals. However, these Dudes are not done. Not by a long shot. Get ready for a special exhibition show, where The Dudes will be showing you exactly why they were two time Improvageddon champs. It'll be some good old fashioned Big Lebowski inspired improv comedy that you won't want to miss! </p><p>The Dudes<br>Saturday, November 21st at 10pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-11-21T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-11-21T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/5ba1d8ff-0d21-46cf-a443-7e8f32fc9534",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/5ba1d8ff-0d21-46cf-a443-7e8f32fc9534",
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

# Insert improvageddon
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "improvageddon"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Dudes",
    status: "available",
    description: "Ticket for The Dudes",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-12T02:33:23.287Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Dudes ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 401 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 401 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "KBWQJH",
    title: "Class Dismissed: The Improv 401 Graduation Show",
    description: """
    <p><strong></strong><strong>It's Harold Time!!!</strong>
</p>
<p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?
</p>
<p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.
</p>
<p>The Push Comedy Theater's 401 students take the Harold head on! Don't miss it.
</p>
<p><strong>Class Dismissed: The 401 Graduation Show</strong><br>Wednesday, August 10th at 8pm<br>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>--
</p>
<p><strong>The Push Comedy Theater </strong>is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in sketch and improv comedy.
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
Logger.info "=========== Writing Event Listing Class Dismissed: The Improv 401 Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "KBWQJH",
    title: "Class Dismissed: The Improv 401 Graduation Show",
    description: """
    <p><strong></strong><strong>It's Harold Time!!!</strong>
</p>
<p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?
</p>
<p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.
</p>
<p>The Push Comedy Theater's 401 students take the Harold head on! Don't miss it.
</p>
<p><strong>Class Dismissed: The 401 Graduation Show</strong><br>Wednesday, August 10th at 8pm<br>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>--
</p>
<p><strong>The Push Comedy Theater </strong>is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in sketch and improv comedy.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-08-10T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-10T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-03T15:52:24.685Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 401 Graduation Show ==========="
