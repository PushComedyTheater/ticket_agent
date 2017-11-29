require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event Harold Night ==========="

Logger.info "=========== Writing Event Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "V2J6H8",
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
<p>Friday, March 24th at 10:00pm
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
    slug: "V2J6H8",
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
<p>Friday, March 24th at 10:00pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-03-24T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-24T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-04T18:56:08.184Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Harold Night ==========="
Logger.info "=========== BEGIN Processing Universe Event These Are The Droids You're Looking For ==========="

Logger.info "=========== Writing Event These Are The Droids You're Looking For ==========="
event = SeedHelpers.create_event(
  %{
    slug: "KQFL4B",
    title: "These Are The Droids You're Looking For",
    description: """
    <h1 style="text-align: center;">These Are The Droids You're Looking For </h1><h1 style="text-align: center;"> <br>A Star Wars Sketch Comedy Show</h1><p style="text-align: center;">A Long Time Ago In A Comedy Theater, Not That Far Away...</p><p style="text-align: center;">The new Star Wars movie is finally here!!! To celebrate this momentous occasion we have a brand, new Star Wars sketch comedy show.</p><p style="text-align: center;"><strong>These Are The Droids You're Looking For</strong><br>A comedy show for Star Wars fans, by Star Wars fans.</p><p style="text-align: center;">2 Nights of Womp Rats, Ugnauts, Protocol Droids and more. Don't miss this hilarious take on the Star Wars Universe.</p><p style="text-align: center;">Go see The Force Awakens, then come see our show.  Or see our show, then go see The Force Awakens.  It doesn't matter... just get your Star Wars lovin' butt to this show!!!!</p><p style="text-align: center;"><strong>These Are The Droids You're Looking For: A Star Wars Sketch Comedy Show</strong><br>Friday and Saturday, December 18 &amp; 19 at 10pm<br><strong><a href="https://www.universe.com/events/these-are-the-droids-youre-looking-for-tickets-norfolk-KQFL4B" rel="nofollow" target="_blank">Tickets are $10</a></strong></p><p style="text-align: center;"><a href="https://www.universe.com/events/these-are-the-droids-youre-looking-for-tickets-norfolk-KQFL4B" rel="nofollow" target="_blank"><img align="center" height="250" src="https://ci3.googleusercontent.com/proxy/puF6EiS4iDPxB47SWQoCl64Xjj1wgdbOc7P2jBQ7RNnclxkZhtnOQRn167kIKQhWkpmoQCsAE4KewFwh4hENWmwVeHR9FjK6fPPcS1hdVaeLO52GqvVgc_XYo94vQSWg-pGbF75B3LM9GkIahc1PnHZkhiwqIci4jzhsFZI=s0-d-e1-ft#https://gallery.mailchimp.com/a008a12cd5bd8fff31f243c70/images/b3bba533-9152-44b8-8494-7f9926c5b4e7.jpg" width="580" style="width: 580px; min-height: 250px; margin: 0px; outline: none; text-decoration: none;"></a><br>--</p><p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p style="text-align: center;">The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturdaynights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing These Are The Droids You're Looking For ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "KQFL4B",
    title: "These Are The Droids You're Looking For",
    description: """
    <h1 style="text-align: center;">These Are The Droids You're Looking For </h1><h1 style="text-align: center;"> <br>A Star Wars Sketch Comedy Show</h1><p style="text-align: center;">A Long Time Ago In A Comedy Theater, Not That Far Away...</p><p style="text-align: center;">The new Star Wars movie is finally here!!! To celebrate this momentous occasion we have a brand, new Star Wars sketch comedy show.</p><p style="text-align: center;"><strong>These Are The Droids You're Looking For</strong><br>A comedy show for Star Wars fans, by Star Wars fans.</p><p style="text-align: center;">2 Nights of Womp Rats, Ugnauts, Protocol Droids and more. Don't miss this hilarious take on the Star Wars Universe.</p><p style="text-align: center;">Go see The Force Awakens, then come see our show.  Or see our show, then go see The Force Awakens.  It doesn't matter... just get your Star Wars lovin' butt to this show!!!!</p><p style="text-align: center;"><strong>These Are The Droids You're Looking For: A Star Wars Sketch Comedy Show</strong><br>Friday and Saturday, December 18 &amp; 19 at 10pm<br><strong><a href="https://www.universe.com/events/these-are-the-droids-youre-looking-for-tickets-norfolk-KQFL4B" rel="nofollow" target="_blank">Tickets are $10</a></strong></p><p style="text-align: center;"><a href="https://www.universe.com/events/these-are-the-droids-youre-looking-for-tickets-norfolk-KQFL4B" rel="nofollow" target="_blank"><img align="center" height="250" src="https://ci3.googleusercontent.com/proxy/puF6EiS4iDPxB47SWQoCl64Xjj1wgdbOc7P2jBQ7RNnclxkZhtnOQRn167kIKQhWkpmoQCsAE4KewFwh4hENWmwVeHR9FjK6fPPcS1hdVaeLO52GqvVgc_XYo94vQSWg-pGbF75B3LM9GkIahc1PnHZkhiwqIci4jzhsFZI=s0-d-e1-ft#https://gallery.mailchimp.com/a008a12cd5bd8fff31f243c70/images/b3bba533-9152-44b8-8494-7f9926c5b4e7.jpg" width="580" style="width: 580px; min-height: 250px; margin: 0px; outline: none; text-decoration: none;"></a><br>--</p><p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p style="text-align: center;">The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturdaynights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-12-18T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-12-18T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/88cfecd5-7ec9-4533-9474-233f1ecb39fa",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/88cfecd5-7ec9-4533-9474-233f1ecb39fa",
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

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for These Are The Droids You're Looking For",
    status: "available",
    description: "Ticket for These Are The Droids You're Looking For",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2015-12-08T06:24:03.028Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event These Are The Droids You're Looking For ==========="
Logger.info "=========== BEGIN Processing Universe Event Teacher's Pet ==========="

Logger.info "=========== Writing Event Teacher's Pet ==========="
event = SeedHelpers.create_event(
  %{
    slug: "VL7Q51",
    title: "Teacher's Pet",
    description: """
    <p>The Students Become The Masters!!!</p><p>Teachers and students join forces for a good old fashioned improv jam!!!</p><p>Don't miss it some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!</p><p>Teachers Pet<br>Friday, April 8th, 10pm<br>Tickets are $5</p><p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "VL7Q51",
    title: "Teacher's Pet",
    description: """
    <p>The Students Become The Masters!!!</p><p>Teachers and students join forces for a good old fashioned improv jam!!!</p><p>Don't miss it some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!</p><p>Teachers Pet<br>Friday, April 8th, 10pm<br>Tickets are $5</p><p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-08T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-08T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-06T21:29:28.533Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Teacher's Pet ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Musical Improv 201 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Musical Improv 201 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "62XKVZ",
    title: "Class Dismissed: The Musical Improv 201 Graduation Show",
    description: """
    <p>Check out the Musical Improv 201 Class as they create 2 full length musicals right before your very eyes!
</p>
<p>These melodic and masterful improvisers have been honing their skills for 6 weeks in the arts of song, rap, and even dance! So come out and see what happens when Music and Improv collide!!!
</p>
<p>Class Dismissed: The Musical Improv 201 Graduation Show
</p>
<p>Sunday, September 10th at 8pm
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
Logger.info "=========== Writing Event Listing Class Dismissed: The Musical Improv 201 Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "62XKVZ",
    title: "Class Dismissed: The Musical Improv 201 Graduation Show",
    description: """
    <p>Check out the Musical Improv 201 Class as they create 2 full length musicals right before your very eyes!
</p>
<p>These melodic and masterful improvisers have been honing their skills for 6 weeks in the arts of song, rap, and even dance! So come out and see what happens when Music and Improv collide!!!
</p>
<p>Class Dismissed: The Musical Improv 201 Graduation Show
</p>
<p>Sunday, September 10th at 8pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-09-10T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-10T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b04b05c0-95bd-401c-b55a-87812d9ab7cd",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b04b05c0-95bd-401c-b55a-87812d9ab7cd",
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
    name: "Ticket for Class Dismissed: The Musical Improv 201 Graduation Show",
    status: "available",
    description: "Ticket for Class Dismissed: The Musical Improv 201 Graduation Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-07T01:52:35.572Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Musical Improv 201 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More Storytelling ==========="

Logger.info "=========== Writing Event Tell Me More Storytelling ==========="
event = SeedHelpers.create_event(
  %{
    slug: "YT7SX8",
    title: "Tell Me More Storytelling",
    description: """
    <p>Yesterday is but today’s memory, and tomorrow is today’s dream. – Khalil Gibran
</p>
<p>THEME
</p>
<p>Dream
</p>
<p>FEATURED STORYTELLERS
</p>
<p>To be decided. Interested in telling a story? Tell us about it, (757) 785-5590.
</p>
<p>HOST
</p>
<p>Brendan Kennedy is a comedian, storyteller, and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”
</p>
<p>EVENT DETAILS
</p>
<p>Time: 7 p.m.
</p>
<p>Date: Sunday, April 16, 2017
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
    slug: "YT7SX8",
    title: "Tell Me More Storytelling",
    description: """
    <p>Yesterday is but today’s memory, and tomorrow is today’s dream. – Khalil Gibran
</p>
<p>THEME
</p>
<p>Dream
</p>
<p>FEATURED STORYTELLERS
</p>
<p>To be decided. Interested in telling a story? Tell us about it, (757) 785-5590.
</p>
<p>HOST
</p>
<p>Brendan Kennedy is a comedian, storyteller, and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”
</p>
<p>EVENT DETAILS
</p>
<p>Time: 7 p.m.
</p>
<p>Date: Sunday, April 16, 2017
</p>
<p>Location: Push Comedy Theater, 763 Granby Street, Norfolk
</p>
<p>Admission: $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-04-16T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-04-16T20:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/282953ea-0059-4a8a-811d-eb7affc7064a",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/282953ea-0059-4a8a-811d-eb7affc7064a",
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-28T15:29:50.067Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More Storytelling ==========="
Logger.info "=========== BEGIN Processing Universe Event Stand Up: Cystic Fibrosis Fundraising Show at PUSH ==========="

Logger.info "=========== Writing Event Stand Up: Cystic Fibrosis Fundraising Show at PUSH ==========="
event = SeedHelpers.create_event(
  %{
    slug: "PH5WMF",
    title: "Stand Up: Cystic Fibrosis Fundraising Show at PUSH",
    description: """
    <p>The folks at PUSH Comedy Theater in Norfolk are hosting a night of comedy to benefit Lauren Roberts' fundraising for the Cystic Fibrosis Foundation!
</p>
<p><br><br>The following comedians have also generously agreed to donate their time to make you laugh for a great cause:
</p>
<p><br><br>Jerry Sheely<br>Jounte Ferguson <br>Tom Holaday<br>Joy Julian <br>JT Mouton<br>Robert Taylor<br>Vince Pilato <br>and Hatton Jordan as the evening's MC
</p>
<p>Tickets are $10
</p>
<p>Bring your friends and come on out for a night of laughs benefiting the CFF!
</p>
<p><br><br>For more information about Lauren Roberts' fundraising: <br>
</p>
<p><a href="https://finest.cff.org/lauren-robertss-finest" rel="nofollow" target="_blank">https://finest.cff.org/<wbr>lauren-robertss-finest</wbr></a>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Stand Up: Cystic Fibrosis Fundraising Show at PUSH ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "PH5WMF",
    title: "Stand Up: Cystic Fibrosis Fundraising Show at PUSH",
    description: """
    <p>The folks at PUSH Comedy Theater in Norfolk are hosting a night of comedy to benefit Lauren Roberts' fundraising for the Cystic Fibrosis Foundation!
</p>
<p><br><br>The following comedians have also generously agreed to donate their time to make you laugh for a great cause:
</p>
<p><br><br>Jerry Sheely<br>Jounte Ferguson <br>Tom Holaday<br>Joy Julian <br>JT Mouton<br>Robert Taylor<br>Vince Pilato <br>and Hatton Jordan as the evening's MC
</p>
<p>Tickets are $10
</p>
<p>Bring your friends and come on out for a night of laughs benefiting the CFF!
</p>
<p><br><br>For more information about Lauren Roberts' fundraising: <br>
</p>
<p><a href="https://finest.cff.org/lauren-robertss-finest" rel="nofollow" target="_blank">https://finest.cff.org/<wbr>lauren-robertss-finest</wbr></a>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-10-23T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-10-23T20:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/2e6474e8-c491-4a0d-9ef0-349343c7d0f2",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/2e6474e8-c491-4a0d-9ef0-349343c7d0f2",
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
    name: "Ticket for Stand Up: Cystic Fibrosis Fundraising Show at PUSH",
    status: "available",
    description: "Ticket for Stand Up: Cystic Fibrosis Fundraising Show at PUSH",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-10-15T20:25:14.295Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Stand Up: Cystic Fibrosis Fundraising Show at PUSH ==========="
Logger.info "=========== BEGIN Processing Universe Event The First Timers Club: A Sketch Comedy Show ==========="

Logger.info "=========== Writing Event The First Timers Club: A Sketch Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "K9C3Q6",
    title: "The First Timers Club: A Sketch Comedy Show",
    description: """
    <p><strong>Get ready to laugh your butts off!!!</strong>
</p>
<p>It's <strong>The First Timers Club: A Brand New Comedy Show</strong> from the minds of the Push Comedy Theater's Sketch Comedy Writing Class.
</p>
<p>The writers of our Sketch 101 Writing Class have been slaving away for months (under our expert and somewhat drunken tutelage)... and they've come up with a kick ass show full of Walmart shoppers, Caribbean witch doctors, furries (or are they plushies), bathroom etiquette, vapes for kids, aunt Flo, Billy Jack and more!!!<br>
</p>
<p><br>
</p>
<p>Don't miss this hilarious show from some amazing first time writers...
</p>
<p><strong>The First Timers Club: A Sketch Comedy Show</strong>
</p>
<p>Thursday, December 15th
</p>
<p>The show starts at 7pm
</p>
<p>Tickets are $5
</p>
<p><br>
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
    slug: "K9C3Q6",
    title: "The First Timers Club: A Sketch Comedy Show",
    description: """
    <p><strong>Get ready to laugh your butts off!!!</strong>
</p>
<p>It's <strong>The First Timers Club: A Brand New Comedy Show</strong> from the minds of the Push Comedy Theater's Sketch Comedy Writing Class.
</p>
<p>The writers of our Sketch 101 Writing Class have been slaving away for months (under our expert and somewhat drunken tutelage)... and they've come up with a kick ass show full of Walmart shoppers, Caribbean witch doctors, furries (or are they plushies), bathroom etiquette, vapes for kids, aunt Flo, Billy Jack and more!!!<br>
</p>
<p><br>
</p>
<p>Don't miss this hilarious show from some amazing first time writers...
</p>
<p><strong>The First Timers Club: A Sketch Comedy Show</strong>
</p>
<p>Thursday, December 15th
</p>
<p>The show starts at 7pm
</p>
<p>Tickets are $5
</p>
<p><br>
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
    start_at:  NaiveDateTime.from_iso8601!("2016-12-15T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-12-15T20:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-25T05:32:07.179Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The First Timers Club: A Sketch Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Conversations with Body Language: Wordless Comedy ==========="

Logger.info "=========== Writing Event Conversations with Body Language: Wordless Comedy ==========="
event = SeedHelpers.create_event(
  %{
    slug: "RD5MS0",
    title: "Conversations with Body Language: Wordless Comedy",
    description: """
    <p><img style="display: block; margin: auto;" alt="" src="https://s3.amazonaws.com/uniiverse_production/attachments/123f1208e86d59aa8ec0e1a68edf190e-conversations1.jpg"></p><p style="text-align: center;">Conversation with Body Language is wordless solo sketch comedy. <br> <br>  Started as a loving update to Charlie Chaplin and Buster Keaton, Mike  Spara combines silent film sensibility with modern music and absurdity  into a mix-tape for your imagination. <br> <br> The Push Comedy  Theater is proud to present Conversations with Body Language, by visiting artist Mike Spara.<br> <br>  Mike is a co-founder of<strong> The New Movement New Orleans</strong>, and tours the  country with TNM, his sketch group Stupid Time Machine, and now  Conversations with Body Language. Body Language has been performed at  <strong>SoundOff Fest</strong>, <strong>New Orleans Fringe</strong>, <strong>Hell Yes Fest</strong>, <strong>Charm City Comedy  Festival</strong> and Richmond's<strong> 2nd Best Comedy Fest</strong>, and will perform  throughout the east coast in 2016. <br> <br> "Mike Spara's face is one of my favorite thing in comedy." - Coalition Theater (RVA)<br> <br> <strong>Conversations with Body Language: A Wordless Sketch Comedy Show</strong><br> Sunday, November 22nd at 7pm<br> Tickets are $10<br> </p><p><img style="display: block; margin: auto;" alt="" src="https://s3.amazonaws.com/uniiverse_production/attachments/ab46941511799363c1b39b2c5c1509e3-Conversations%20in%20Body%20Language.jpg"></p><p></p><p style="text-align: center;"> The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br> <br>  Free parking available at Slone Chiropractic (111 W Virginia Beach)  just one block from the theater. There is also limited parking on the  street</p><p style="text-align: center;"></p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Conversations with Body Language: Wordless Comedy ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "RD5MS0",
    title: "Conversations with Body Language: Wordless Comedy",
    description: """
    <p><img style="display: block; margin: auto;" alt="" src="https://s3.amazonaws.com/uniiverse_production/attachments/123f1208e86d59aa8ec0e1a68edf190e-conversations1.jpg"></p><p style="text-align: center;">Conversation with Body Language is wordless solo sketch comedy. <br> <br>  Started as a loving update to Charlie Chaplin and Buster Keaton, Mike  Spara combines silent film sensibility with modern music and absurdity  into a mix-tape for your imagination. <br> <br> The Push Comedy  Theater is proud to present Conversations with Body Language, by visiting artist Mike Spara.<br> <br>  Mike is a co-founder of<strong> The New Movement New Orleans</strong>, and tours the  country with TNM, his sketch group Stupid Time Machine, and now  Conversations with Body Language. Body Language has been performed at  <strong>SoundOff Fest</strong>, <strong>New Orleans Fringe</strong>, <strong>Hell Yes Fest</strong>, <strong>Charm City Comedy  Festival</strong> and Richmond's<strong> 2nd Best Comedy Fest</strong>, and will perform  throughout the east coast in 2016. <br> <br> "Mike Spara's face is one of my favorite thing in comedy." - Coalition Theater (RVA)<br> <br> <strong>Conversations with Body Language: A Wordless Sketch Comedy Show</strong><br> Sunday, November 22nd at 7pm<br> Tickets are $10<br> </p><p><img style="display: block; margin: auto;" alt="" src="https://s3.amazonaws.com/uniiverse_production/attachments/ab46941511799363c1b39b2c5c1509e3-Conversations%20in%20Body%20Language.jpg"></p><p></p><p style="text-align: center;"> The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br> <br>  Free parking available at Slone Chiropractic (111 W Virginia Beach)  just one block from the theater. There is also limited parking on the  street</p><p style="text-align: center;"></p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-11-22T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-11-22T21:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/4c7fa90e-893a-49f9-bba3-75417d49d997",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/4c7fa90e-893a-49f9-bba3-75417d49d997",
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
    name: "Ticket for Conversations with Body Language: Wordless Comedy",
    status: "available",
    description: "Ticket for Conversations with Body Language: Wordless Comedy",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-07T01:52:25.330Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Conversations with Body Language: Wordless Comedy ==========="
Logger.info "=========== BEGIN Processing Universe Event Teacher's Pet ==========="

Logger.info "=========== Writing Event Teacher's Pet ==========="
event = SeedHelpers.create_event(
  %{
    slug: "VTF75W",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Friday, November 10th, 10pm<br>Tickets are $5
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
    slug: "VTF75W",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Friday, November 10th, 10pm<br>Tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2017-11-10T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-10T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-16T19:59:32.165Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Teacher's Pet ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 201 Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 201 Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "DH7L0Y",
    title: "Class Dismissed: The Improv 201 Graduation Show",
    description: """
    <p><strong></strong><strong>Dust off those caps and gowns... because it's graduation time at the Push.</strong></p><p>Check out the Push Comedy Theater's Improv 201 class as they show off their comedy chops.</p><p>Watch as these brave 201 souls dive head first into the wonderful world of The Harold. So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p><strong>Class Dismissed: The Improv 201 Graduation Show </strong><br>Thursday, June 16h at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p>
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
    slug: "DH7L0Y",
    title: "Class Dismissed: The Improv 201 Graduation Show",
    description: """
    <p><strong></strong><strong>Dust off those caps and gowns... because it's graduation time at the Push.</strong></p><p>Check out the Push Comedy Theater's Improv 201 class as they show off their comedy chops.</p><p>Watch as these brave 201 souls dive head first into the wonderful world of The Harold. So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p><strong>Class Dismissed: The Improv 201 Graduation Show </strong><br>Thursday, June 16h at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-16T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-16T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-25T21:30:40.654Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 201 Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Second Saturday Stand-Up ==========="

Logger.info "=========== Writing Event Second Saturday Stand-Up ==========="
event = SeedHelpers.create_event(
  %{
    slug: "VDZJ2R",
    title: "Second Saturday Stand-Up",
    description: """
    <p><strong>Second Saturday Stand-Up</strong>
</p>
<p>This once-a-month show is brought to you by almost-jaded veteran comic, <strong>Hatton Jordan </strong>who sets the lineup with proven comedians delivering road-tested jokes while they squeeze in new material.
</p>
<p>This is NOT a "open mic" .....it's selected talent working on their craft. Every month is a new seasoned lineup.
</p>
<p><br>
</p>
<p>Host: Hatton Jordan
</p>
<p>Line-Up TBA
</p>
<p><strong><br></strong>
</p>
<p><strong>Second Saturday Stand-Up</strong>
</p>
<p>Saturday, November 11th at 10pm
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
    slug: "VDZJ2R",
    title: "Second Saturday Stand-Up",
    description: """
    <p><strong>Second Saturday Stand-Up</strong>
</p>
<p>This once-a-month show is brought to you by almost-jaded veteran comic, <strong>Hatton Jordan </strong>who sets the lineup with proven comedians delivering road-tested jokes while they squeeze in new material.
</p>
<p>This is NOT a "open mic" .....it's selected talent working on their craft. Every month is a new seasoned lineup.
</p>
<p><br>
</p>
<p>Host: Hatton Jordan
</p>
<p>Line-Up TBA
</p>
<p><strong><br></strong>
</p>
<p><strong>Second Saturday Stand-Up</strong>
</p>
<p>Saturday, November 11th at 10pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-11-11T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-11T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-16T20:06:45.310Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Second Saturday Stand-Up ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improvised Movie ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improvised Movie ==========="
event = SeedHelpers.create_event(
  %{
    slug: "B1DWM4",
    title: "Class Dismissed: The Improvised Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong>
</p>
<p>Who needs Hollywood! With a single audience suggestion an entire blockbuster movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.
</p>
<p><strong>Double Feature: The Totally Improvised Movie</strong><br>Saturday, May 28th at 8pm
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
Logger.info "=========== Writing Event Listing Class Dismissed: The Improvised Movie ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "B1DWM4",
    title: "Class Dismissed: The Improvised Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong>
</p>
<p>Who needs Hollywood! With a single audience suggestion an entire blockbuster movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.
</p>
<p><strong>Double Feature: The Totally Improvised Movie</strong><br>Saturday, May 28th at 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-05-28T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-28T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c8278476-37f2-4aab-b6a8-e54510c8ff0e",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c8278476-37f2-4aab-b6a8-e54510c8ff0e",
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
    name: "Ticket for Class Dismissed: The Improvised Movie",
    status: "available",
    description: "Ticket for Class Dismissed: The Improvised Movie",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-26T21:16:52.171Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improvised Movie ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="

Logger.info "=========== Writing Event The Improv Riot: The Short Form Improv Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "54J8D9",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.</p><p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.</p><p><strong style="background-color: initial;">The Improv Riot: The Short Form Improv Show</strong></p><p>Friday, November 27th, 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the parking lot directly across from the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "54J8D9",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.</p><p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.</p><p><strong style="background-color: initial;">The Improv Riot: The Short Form Improv Show</strong></p><p>Friday, November 27th, 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the parking lot directly across from the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-01-29T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-01-29T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-01-26T17:12:26.630Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Andy has Friends! + The Pushers (Saturday) ==========="

Logger.info "=========== Writing Event Andy has Friends! + The Pushers (Saturday) ==========="
event = SeedHelpers.create_event(
  %{
    slug: "H3TC0F",
    title: "Andy has Friends! + The Pushers (Saturday)",
    description: """
    <h3 style="text-align: center;"><strong>Andy has Friends!</strong></h3>
<p style="text-align: center;">The improv equivalent of a roulette wheel, Andy has Friends! is a show where the cast is always a surprise. Not content to just perform in his regular improv shows, Andy Livengood wants to play with ALL of his friends. In each Andy has Friends! show, Andy is joined by a special guest. Every performance features an improviser, an actor, a comic, or even a random audience member.
</p>
<p style="text-align: center;">You never know who’s gonna drop in; you never know what’s gonna happen. Andy has Friends!, unpredictable improv at it’s finest.
</p>
<p style="text-align: center;"><em>Andy Livengood wandered into an improv theatre to see a friend's</em><em> show and became hooked for life. He is a graduate of the Theatre 99 training program (Charleston, SC) and has studied at the Upright Citizen’s Brigade Theatre (NY) and The Annoyance Theatre (Chicago).</em>
</p>
<p style="text-align: center;"><em>For over a decade he regularly performed and taught at Theatre 99. He was voted Charleston’s Best Comic and has written for the sketch comedy groups Maximum Brain Squad and This is Chucktown. His one man show, The Christmas will be Televised, was voted Best Play in Charleston in 2011 and has been performed in theaters all over the south east.</em>
</p>
<p style="text-align: center;"><em><img src="https://s3.amazonaws.com/uniiverse_production/attachments/8feeaa81d10a9c2fa122a5e26c4b0ba2-Andy.jpg" style="display: block; margin: auto;" alt=""><br></em>
</p>
<p style="text-align: center;">_________________________________________
</p>
<h3 style="text-align: center;"><strong>The Pushers</strong></h3>
<p style="text-align: center;"><strong>The Pushers</strong> are Virginia's premiere sketch and improv comedy group.  For more than a decade they've had audiences howling with laughter.  The group is known for their racy, high-octane show that's utterly unpredictable.
</p>
<p style="text-align: center;">If you've never seen a Pushers' show... you're in for a wild ride.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Pushers.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Pushers.jpg" alt="Pushers"></a>
</p>
<p style="text-align: center;">The Pushers are the creators and producers of <strong>Panties in a Twist: The All Female Sketch Comedy Show</strong> and <strong>The Norfolk Comedy Festival </strong>and owners of the<strong> Push Comedy Theater</strong>.  Members of The Pushers co-wrote the Off-Broadway hit, <strong>Cuff Me: The Fifty Shades of Grey Musical Parody</strong>.
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
Logger.info "=========== Writing Event Listing Andy has Friends! + The Pushers (Saturday) ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "H3TC0F",
    title: "Andy has Friends! + The Pushers (Saturday)",
    description: """
    <h3 style="text-align: center;"><strong>Andy has Friends!</strong></h3>
<p style="text-align: center;">The improv equivalent of a roulette wheel, Andy has Friends! is a show where the cast is always a surprise. Not content to just perform in his regular improv shows, Andy Livengood wants to play with ALL of his friends. In each Andy has Friends! show, Andy is joined by a special guest. Every performance features an improviser, an actor, a comic, or even a random audience member.
</p>
<p style="text-align: center;">You never know who’s gonna drop in; you never know what’s gonna happen. Andy has Friends!, unpredictable improv at it’s finest.
</p>
<p style="text-align: center;"><em>Andy Livengood wandered into an improv theatre to see a friend's</em><em> show and became hooked for life. He is a graduate of the Theatre 99 training program (Charleston, SC) and has studied at the Upright Citizen’s Brigade Theatre (NY) and The Annoyance Theatre (Chicago).</em>
</p>
<p style="text-align: center;"><em>For over a decade he regularly performed and taught at Theatre 99. He was voted Charleston’s Best Comic and has written for the sketch comedy groups Maximum Brain Squad and This is Chucktown. His one man show, The Christmas will be Televised, was voted Best Play in Charleston in 2011 and has been performed in theaters all over the south east.</em>
</p>
<p style="text-align: center;"><em><img src="https://s3.amazonaws.com/uniiverse_production/attachments/8feeaa81d10a9c2fa122a5e26c4b0ba2-Andy.jpg" style="display: block; margin: auto;" alt=""><br></em>
</p>
<p style="text-align: center;">_________________________________________
</p>
<h3 style="text-align: center;"><strong>The Pushers</strong></h3>
<p style="text-align: center;"><strong>The Pushers</strong> are Virginia's premiere sketch and improv comedy group.  For more than a decade they've had audiences howling with laughter.  The group is known for their racy, high-octane show that's utterly unpredictable.
</p>
<p style="text-align: center;">If you've never seen a Pushers' show... you're in for a wild ride.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Pushers.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Pushers.jpg" alt="Pushers"></a>
</p>
<p style="text-align: center;">The Pushers are the creators and producers of <strong>Panties in a Twist: The All Female Sketch Comedy Show</strong> and <strong>The Norfolk Comedy Festival </strong>and owners of the<strong> Push Comedy Theater</strong>.  Members of The Pushers co-wrote the Off-Broadway hit, <strong>Cuff Me: The Fifty Shades of Grey Musical Parody</strong>.
</p>
<p style="text-align: center;">In September you can catch The Pushers every week on Channel 3's new show,<strong> Coast Live</strong>.
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Our-Theater.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Our-Theater.jpg" alt="Our Theater"></a>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-09-16T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-16T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/af2a377c-0415-4086-b10b-1e0dbebac7fd",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/af2a377c-0415-4086-b10b-1e0dbebac7fd",
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

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Andy has Friends! + The Pushers (Saturday)",
    status: "available",
    description: "Ticket for Andy has Friends! + The Pushers (Saturday)",
    price: 1500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-08-10T04:29:07.952Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Andy has Friends! + The Pushers (Saturday) ==========="
Logger.info "=========== BEGIN Processing Universe Event Double Feature: The Totally Improvised Movie ==========="

Logger.info "=========== Writing Event Double Feature: The Totally Improvised Movie ==========="
event = SeedHelpers.create_event(
  %{
    slug: "HZJPF2",
    title: "Double Feature: The Totally Improvised Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong></p><p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.</p><p><strong>Double Feature: The Totally Improvised Movie</strong><br>Friday, January 8th, 10pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.</p><p><br>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "HZJPF2",
    title: "Double Feature: The Totally Improvised Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong></p><p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.</p><p><strong>Double Feature: The Totally Improvised Movie</strong><br>Friday, January 8th, 10pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and the lot directly across from the theater.</p><p><br>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-01-08T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-01-08T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2015-12-31T00:52:14.927Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Double Feature: The Totally Improvised Movie ==========="
Logger.info "=========== BEGIN Processing Universe Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="

Logger.info "=========== Writing Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
event = SeedHelpers.create_event(
  %{
    slug: "GKS3HF",
    title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    description: """
    <p><strong>Don't miss this epic sketch comedy showdown, where truly anything can happen.</strong><br>
</p>
<p>And we do mean anything!!!  Sometimes it's funny, sometimes it's weird, it's always entertaining.
</p>
<p>SKETCHMAGEDDON
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
<p>Friday, July 7th at 10pm
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
    slug: "GKS3HF",
    title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    description: """
    <p><strong>Don't miss this epic sketch comedy showdown, where truly anything can happen.</strong><br>
</p>
<p>And we do mean anything!!!  Sometimes it's funny, sometimes it's weird, it's always entertaining.
</p>
<p>SKETCHMAGEDDON
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
<p>Friday, July 7th at 10pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-07-07T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-07T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-06-30T18:04:22.826Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: Teen Improv Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: Teen Improv Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "DV5W02",
    title: "Class Dismissed: Teen Improv Graduation Show",
    description: """
    <p><strong></strong><strong>Get ready for Hampton Roads' newest generation of comedy superstars... Fictional Pants!</strong>
</p>
<p>It's the Teen Improv Graduation Show!!! Don't miss this group of talented teenage improvisers as they put on a funny and fast paced 'Who's Line Is It Anyway' style show.
</p>
<p><br>
</p>
<p><strong>FREE FOR EVERYONE 17 AND UNDER!!!!</strong>
</p>
<p><strong>Class Dismissed: Teen Improv Graduation</strong><br>Saturday, July 16th at 1:30pm<br>Tickets are $5
</p>
<p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=IAQFXbWK-&amp;enc=AZOPL4oGCU8KwLS1ULzXIGkAlp390nUXmKxOesT9vjgB6P5g9tvKt2_4aOrkgku0E98&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a>
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Class Dismissed: Teen Improv Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "DV5W02",
    title: "Class Dismissed: Teen Improv Graduation Show",
    description: """
    <p><strong></strong><strong>Get ready for Hampton Roads' newest generation of comedy superstars... Fictional Pants!</strong>
</p>
<p>It's the Teen Improv Graduation Show!!! Don't miss this group of talented teenage improvisers as they put on a funny and fast paced 'Who's Line Is It Anyway' style show.
</p>
<p><br>
</p>
<p><strong>FREE FOR EVERYONE 17 AND UNDER!!!!</strong>
</p>
<p><strong>Class Dismissed: Teen Improv Graduation</strong><br>Saturday, July 16th at 1:30pm<br>Tickets are $5
</p>
<p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=IAQFXbWK-&amp;enc=AZOPL4oGCU8KwLS1ULzXIGkAlp390nUXmKxOesT9vjgB6P5g9tvKt2_4aOrkgku0E98&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a>
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-07-16T13:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-16T14:30:00.000-04:00")
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
    name: "Ticket for Class Dismissed: Teen Improv Graduation Show",
    status: "available",
    description: "Ticket for Class Dismissed: Teen Improv Graduation Show",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-12T16:19:26.232Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: Teen Improv Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="

Logger.info "=========== Writing Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "HVPC6Y",
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
<p><strong>TOO FAR: The Dirtiest, Most Inappropriate Comedy Show... EVER!</strong><br>Saturday, July 15th <br>Tickets are $10, Show starts at 10:00pm
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
    slug: "HVPC6Y",
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
<p><strong>TOO FAR: The Dirtiest, Most Inappropriate Comedy Show... EVER!</strong><br>Saturday, July 15th <br>Tickets are $10, Show starts at 10:00pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-07-15T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-15T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-08T17:52:23.151Z")
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
    slug: "68LRD5",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, August 26th
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
    slug: "68LRD5",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, August 26th
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
    start_at:  NaiveDateTime.from_iso8601!("2017-08-26T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-08-26T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-08-21T13:52:12.631Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
Logger.info "=========== BEGIN Processing Universe Event Couples Therapy ==========="

Logger.info "=========== Writing Event Couples Therapy ==========="
event = SeedHelpers.create_event(
  %{
    slug: "1LJYSB",
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
    slug: "1LJYSB",
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
    start_at:  NaiveDateTime.from_iso8601!("2017-02-25T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-02-25T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-02-17T18:48:17.896Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Couples Therapy ==========="
