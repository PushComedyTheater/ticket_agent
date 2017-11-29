require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event The First Timers Club: A Sketch Comedy Show ==========="

Logger.info "=========== Writing Event The First Timers Club: A Sketch Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "P90ZLM",
    title: "The First Timers Club: A Sketch Comedy Show",
    description: """
    <p><strong>Get ready to laugh your butts off!!!</strong>
</p>
<p>It's <strong>The First Timers Club: A Brand New Comedy Show</strong> from the minds of the Push Comedy Theater's Sketch Comedy Writing Class.
</p>
<p>The writers of our Sketch 101 Writing Class have been slaving away and they've come up with a kick ass show!!!<br>
</p>
<p><br>
</p>
<p>Don't miss this hilarious show from some amazing first time writers...
</p>
<p><strong>The First Timers Club: A Sketch Comedy Show</strong>
</p>
<p>Thursday, November 30th
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
    slug: "P90ZLM",
    title: "The First Timers Club: A Sketch Comedy Show",
    description: """
    <p><strong>Get ready to laugh your butts off!!!</strong>
</p>
<p>It's <strong>The First Timers Club: A Brand New Comedy Show</strong> from the minds of the Push Comedy Theater's Sketch Comedy Writing Class.
</p>
<p>The writers of our Sketch 101 Writing Class have been slaving away and they've come up with a kick ass show!!!<br>
</p>
<p><br>
</p>
<p>Don't miss this hilarious show from some amazing first time writers...
</p>
<p><strong>The First Timers Club: A Sketch Comedy Show</strong>
</p>
<p>Thursday, November 30th
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
    start_at:  NaiveDateTime.from_iso8601!("2017-11-30T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-30T22:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b076c002-a48f-4e38-ab08-b8e2f848fcd3",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b076c002-a48f-4e38-ab08-b8e2f848fcd3",
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-22T03:06:24.306Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The First Timers Club: A Sketch Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improvised Ghost Story ==========="

Logger.info "=========== Writing Event The Improvised Ghost Story ==========="
event = SeedHelpers.create_event(
  %{
    slug: "Q1V354",
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
<p>Saturday, January 7th at 8pm
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
    slug: "Q1V354",
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
<p>Saturday, January 7th at 8pm
</p>
<p>Tickets are $5
</p>
<p><br>
</p>
<p>I ain't afraid of no ghost!
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-01-07T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-01-07T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-01-02T19:40:32.020Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improvised Ghost Story ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More... Storytelling Nights: Disguises ==========="

Logger.info "=========== Writing Event Tell Me More... Storytelling Nights: Disguises ==========="
event = SeedHelpers.create_event(
  %{
    slug: "V935SG",
    title: "Tell Me More... Storytelling Nights: Disguises",
    description: """
    <p>Join Tell Me More… for our storytelling night on Oct. 18 at the Push Comedy Theater in Norfolk, Va., where we tell stories inspired by one word and song.</p><p>Put on a costume. Wear a mask. Reveal yourself.</p><p>Theme: Disguises<br>Theme song: “The Mask,” Danger Doom<br>Possibly inspiring stories of: Masking our fears of the unknown</p><p>FEATURED STORYTELLERS<br>To be announced at the beginning of October. Visit<a href="http://tellmemorelive.org/" rel="nofollow" target="_blank">http://tellmemorelive.org/</a> for updates.</p><p>OUR HOST<br>Brendan Kennedy</p><p>RECORDINGS<br>If all goes as planned, all stories will be recorded and posted individually as an episode for the Tell Me More… Live podcast.</p><p>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, October 18, 2015<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $5</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Tell Me More... Storytelling Nights: Disguises ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "V935SG",
    title: "Tell Me More... Storytelling Nights: Disguises",
    description: """
    <p>Join Tell Me More… for our storytelling night on Oct. 18 at the Push Comedy Theater in Norfolk, Va., where we tell stories inspired by one word and song.</p><p>Put on a costume. Wear a mask. Reveal yourself.</p><p>Theme: Disguises<br>Theme song: “The Mask,” Danger Doom<br>Possibly inspiring stories of: Masking our fears of the unknown</p><p>FEATURED STORYTELLERS<br>To be announced at the beginning of October. Visit<a href="http://tellmemorelive.org/" rel="nofollow" target="_blank">http://tellmemorelive.org/</a> for updates.</p><p>OUR HOST<br>Brendan Kennedy</p><p>RECORDINGS<br>If all goes as planned, all stories will be recorded and posted individually as an episode for the Tell Me More… Live podcast.</p><p>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, October 18, 2015<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $5</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-10-18T07:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-10-18T21:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/f6f50a28-5cfa-4408-846a-ddce2c5dee37",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/f6f50a28-5cfa-4408-846a-ddce2c5dee37",
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
    name: "Ticket for Tell Me More... Storytelling Nights: Disguises",
    status: "available",
    description: "Ticket for Tell Me More... Storytelling Nights: Disguises",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2015-10-02T04:09:37.370Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More... Storytelling Nights: Disguises ==========="
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="

Logger.info "=========== Writing Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
event = SeedHelpers.create_event(
  %{
    slug: "2F8MD3",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, June 24th
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
    slug: "2F8MD3",
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, June 24th
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
    start_at:  NaiveDateTime.from_iso8601!("2017-06-24T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-06-24T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-06-19T20:41:34.281Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
Logger.info "=========== BEGIN Processing Universe Event New Harold Night ==========="

Logger.info "=========== Writing Event New Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "WX69HB",
    title: "New Harold Night",
    description: """
    <p><strong></strong><strong>It's New Harold Night at the Push Comedy Theater!</strong></p><p>Don't miss it as we unveil our brand, new house teams!!!</p><p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p><strong>New Harold Night </strong><br>Friday, November 27th, 10pm<br>Tickets are $5.</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "WX69HB",
    title: "New Harold Night",
    description: """
    <p><strong></strong><strong>It's New Harold Night at the Push Comedy Theater!</strong></p><p>Don't miss it as we unveil our brand, new house teams!!!</p><p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p><strong>New Harold Night </strong><br>Friday, November 27th, 10pm<br>Tickets are $5.</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-11-27T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-11-27T23:45:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c28b5549-c9e4-4c58-96ea-83ad386d5509",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c28b5549-c9e4-4c58-96ea-83ad386d5509",
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
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-16T05:13:30.487Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event New Harold Night ==========="
Logger.info "=========== BEGIN Processing Universe Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="

Logger.info "=========== Writing Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "QGRH75",
    title: "TOO FAR: The Dirty, Inappropriate Comedy Show",
    description: """
    <p><strong></strong><strong>Are you ready to get dirty!?!</strong></p><p>Brad and Sean of the Pushers have assembled a twisted team of writers and actors to bring you the dirtiest, most offensive show Hampton Roads has ever seen.</p><p>It's a show we're calling Too Far.</p><p>WARNING: This show isn't for everyone. If you're not a fan of foul, sophomoric, potty humor... then this is not the show for you.</p><p>Join The Pushers and the Too Far crew... and let's get dirty!!!</p><p><strong>TOO FAR: The Dirtiest, Most Inappropriate Comedy Show... EVER!</strong><br>Saturday, May 21st<br>Tickets are $10, Show starts at 10:00pm</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "QGRH75",
    title: "TOO FAR: The Dirty, Inappropriate Comedy Show",
    description: """
    <p><strong></strong><strong>Are you ready to get dirty!?!</strong></p><p>Brad and Sean of the Pushers have assembled a twisted team of writers and actors to bring you the dirtiest, most offensive show Hampton Roads has ever seen.</p><p>It's a show we're calling Too Far.</p><p>WARNING: This show isn't for everyone. If you're not a fan of foul, sophomoric, potty humor... then this is not the show for you.</p><p>Join The Pushers and the Too Far crew... and let's get dirty!!!</p><p><strong>TOO FAR: The Dirtiest, Most Inappropriate Comedy Show... EVER!</strong><br>Saturday, May 21st<br>Tickets are $10, Show starts at 10:00pm</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-05-21T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-05-21T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-11T04:37:44.058Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 101 Mega Show part 2 ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 101 Mega Show part 2 ==========="
event = SeedHelpers.create_event(
  %{
    slug: "JT4VKX",
    title: "Class Dismissed: The Improv 101 Mega Show part 2",
    description: """
    <p>Dust off those caps and gowns... because it's graduation time at the Push.</p><p>Check out the Push Comedy Theater's Improv 101 class as they show off their comedy chops.</p><p>You won't believe what these improv newcomers have in store for you!!!</p><p>Class Dismissed: The Improv 101 Mega Graduation Show part 2<br>Tuesday, June 14th at 9pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts will host live sketch and improv comedy on Friday and Saturday nights. During the week classes are offered in sketch writing, improv comedy and acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Class Dismissed: The Improv 101 Mega Show part 2 ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "JT4VKX",
    title: "Class Dismissed: The Improv 101 Mega Show part 2",
    description: """
    <p>Dust off those caps and gowns... because it's graduation time at the Push.</p><p>Check out the Push Comedy Theater's Improv 101 class as they show off their comedy chops.</p><p>You won't believe what these improv newcomers have in store for you!!!</p><p>Class Dismissed: The Improv 101 Mega Graduation Show part 2<br>Tuesday, June 14th at 9pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts will host live sketch and improv comedy on Friday and Saturday nights. During the week classes are offered in sketch writing, improv comedy and acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-14T21:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-14T22:30:00.000-04:00")
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
    name: "Ticket for Class Dismissed: The Improv 101 Mega Show part 2",
    status: "available",
    description: "Ticket for Class Dismissed: The Improv 101 Mega Show part 2",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-23T22:09:09.868Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 101 Mega Show part 2 ==========="
Logger.info "=========== BEGIN Processing Universe Event Sketchmageddon ==========="

Logger.info "=========== Writing Event Sketchmageddon ==========="
event = SeedHelpers.create_event(
  %{
    slug: "KRCTWM",
    title: "Sketchmageddon",
    description: """
    <p><strong>The Push Comedy Theater's Sketch Comedy Showcase is back with a Vengeance!!!!</strong></p><p>This is the show where anything goes... and we do mean anything. </p><p><br>Last month gave us one of the rawest, most bizarre shows ever. It's a show people are still talking about.</p><p>Who knows what surprises we have in store for this show!!!</p><p>--</p><p><strong>Get ready for a sketch comedy show like no other!!!</strong></p><p>   <strong>SKETCHMAGEDDON</strong> takes 3 groups and forces them to compete in an all-out comedy, death-match!  <br>  Each team will be given 15 minutes to dazzle you with their comedy prowess. </p><p><strong>  It's Saturday Night Live meets Thunderdome!!!! </strong></p><p> <br>  Unlike it's improvised sister show IMPROVAGEDDON, SKETCHMAGEDDON will feature all written and rehearsed material.  Props, costumes and special effects are all legal in SKETCHMAGEDDON. </p><p> <br>    <strong>SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition </strong></p><p>Friday, May 6th at 10pm </p><p>Tickets are $5</p><p>------------</p><p><strong>The Push Comedy Theater </strong>only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p>
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
    slug: "KRCTWM",
    title: "Sketchmageddon",
    description: """
    <p><strong>The Push Comedy Theater's Sketch Comedy Showcase is back with a Vengeance!!!!</strong></p><p>This is the show where anything goes... and we do mean anything. </p><p><br>Last month gave us one of the rawest, most bizarre shows ever. It's a show people are still talking about.</p><p>Who knows what surprises we have in store for this show!!!</p><p>--</p><p><strong>Get ready for a sketch comedy show like no other!!!</strong></p><p>   <strong>SKETCHMAGEDDON</strong> takes 3 groups and forces them to compete in an all-out comedy, death-match!  <br>  Each team will be given 15 minutes to dazzle you with their comedy prowess. </p><p><strong>  It's Saturday Night Live meets Thunderdome!!!! </strong></p><p> <br>  Unlike it's improvised sister show IMPROVAGEDDON, SKETCHMAGEDDON will feature all written and rehearsed material.  Props, costumes and special effects are all legal in SKETCHMAGEDDON. </p><p> <br>    <strong>SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition </strong></p><p>Friday, May 6th at 10pm </p><p>Tickets are $5</p><p>------------</p><p><strong>The Push Comedy Theater </strong>only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-04T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-04T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-19T21:45:02.866Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Sketchmageddon ==========="
Logger.info "=========== BEGIN Processing Universe Event Spartacus Fartacus: An Idiotic Journey Through History ==========="

Logger.info "=========== Writing Event Spartacus Fartacus: An Idiotic Journey Through History ==========="
event = SeedHelpers.create_event(
  %{
    slug: "0CL8HW",
    title: "Spartacus Fartacus: An Idiotic Journey Through History",
    description: """
    <p>Let's get historical!
</p>
<p>Spartacus Fartacus is an idiotic and hilarious romp through history. With an audience suggestion of a historical event or figure, Spartacus Fartacus (Brad McMurran, Sean Devereux and Ed Carden) takes you on a trek through the ages, with only their knowledge (or lack of knowledge) as a guide.
</p>
<p>A wise man once said...  the pageant of history is a rich tapestry of both people and events, a journey from the then to the now. Its importance cannot be discounted, for those who fail to acknowledge and learn from the mistakes of history shall be forever doomed to repeat them. Or some shit like that.
</p>
<p><br>
</p>
<p>Spartacus Fartacus: An Idiotic Journey Through History
</p>
<p>Saturday, June 23rd at 10pm
</p>
<p>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>---
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Spartacus Fartacus: An Idiotic Journey Through History ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "0CL8HW",
    title: "Spartacus Fartacus: An Idiotic Journey Through History",
    description: """
    <p>Let's get historical!
</p>
<p>Spartacus Fartacus is an idiotic and hilarious romp through history. With an audience suggestion of a historical event or figure, Spartacus Fartacus (Brad McMurran, Sean Devereux and Ed Carden) takes you on a trek through the ages, with only their knowledge (or lack of knowledge) as a guide.
</p>
<p>A wise man once said...  the pageant of history is a rich tapestry of both people and events, a journey from the then to the now. Its importance cannot be discounted, for those who fail to acknowledge and learn from the mistakes of history shall be forever doomed to repeat them. Or some shit like that.
</p>
<p><br>
</p>
<p>Spartacus Fartacus: An Idiotic Journey Through History
</p>
<p>Saturday, June 23rd at 10pm
</p>
<p>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
<p>---
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-06-23T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-06-23T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/655664dc-b431-4a80-862c-2eedc8ce18a5",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/655664dc-b431-4a80-862c-2eedc8ce18a5",
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

# Insert fartacus
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "fartacus"
})
Logger.info "=========== Wrote tag ==========="

# Insert history
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "history"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Spartacus Fartacus: An Idiotic Journey Through History",
    status: "available",
    description: "Ticket for Spartacus Fartacus: An Idiotic Journey Through History",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-06-20T04:52:23.140Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Spartacus Fartacus: An Idiotic Journey Through History ==========="
Logger.info "=========== BEGIN Processing Universe Event Stand-Up for Veterans ==========="

Logger.info "=========== Writing Event Stand-Up for Veterans ==========="
event = SeedHelpers.create_event(
  %{
    slug: "BRYF5V",
    title: "Stand-Up for Veterans",
    description: """
    <p>Join the Armed Services Arts Partnership (ASAP) and the Push Comedy Theater for an evening of stand-up comedy to support the Hampton Roads military community. The show will feature a cast of talented veteran comics, all graduates of ASAP’s nationally recognized Comedy Bootcamp program. It will be a tremendous evening with lots of laughs.
</p>
<p>The event will take place at 6pm on Sunday, August 14th at the Push Comedy Theater in Norfolk, VA. Over 50% of proceeds help benefit the local community and support ASAP’s mission of serving veterans through the arts.
</p>
<p><strong>Line-Up --</strong>
</p>
<p>Isaura Ramirez
</p>
<p>Mike Lake
</p>
<p>Sharon Kang
</p>
<p>Maurice Johnson
</p>
<p>Mae Brayton
</p>
<p>Jose Roman
</p>
<p>Jim King
</p>
<p>Ty Bratton
</p>
<p><br>
</p>
<p><strong>Stand-Up for Veterans</strong>
</p>
<p>Sunday, August 14th at 6pm
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
    slug: "BRYF5V",
    title: "Stand-Up for Veterans",
    description: """
    <p>Join the Armed Services Arts Partnership (ASAP) and the Push Comedy Theater for an evening of stand-up comedy to support the Hampton Roads military community. The show will feature a cast of talented veteran comics, all graduates of ASAP’s nationally recognized Comedy Bootcamp program. It will be a tremendous evening with lots of laughs.
</p>
<p>The event will take place at 6pm on Sunday, August 14th at the Push Comedy Theater in Norfolk, VA. Over 50% of proceeds help benefit the local community and support ASAP’s mission of serving veterans through the arts.
</p>
<p><strong>Line-Up --</strong>
</p>
<p>Isaura Ramirez
</p>
<p>Mike Lake
</p>
<p>Sharon Kang
</p>
<p>Maurice Johnson
</p>
<p>Mae Brayton
</p>
<p>Jose Roman
</p>
<p>Jim King
</p>
<p>Ty Bratton
</p>
<p><br>
</p>
<p><strong>Stand-Up for Veterans</strong>
</p>
<p>Sunday, August 14th at 6pm
</p>
<p>Tickets are $5
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-08-14T18:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-14T19:00:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-08T19:45:39.264Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Stand-Up for Veterans ==========="
Logger.info "=========== BEGIN Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="

Logger.info "=========== Writing Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
event = SeedHelpers.create_event(
  %{
    slug: "7RXWFB",
    title: "IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION",
    description: """
    <p>Prepare for Glory!!
</p>
<p><br>Prepare for IMPROVAGEDDON: The Ultimate Improv Competition!!!
</p>
<p><br>We stand before the dawn of a new world!!!
</p>
<p><br>Last month, The Party Crashers earned their second championship! Now they will defend their title against two hungry challenging teams!
</p>
<p><br>Can the Party Crashers hang on to become the 2nd ever 3x Champions? Will another brand new team emerge to take them down? Will a team of Improvageddon vets re-enter the fray?
</p>
<p><br>Who will raise the Hammer of Lowell in final victory? <br><br>You'll have to come to this month's show to find out!
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, August 27th
</p>
<p><br><br>The show starts at 10pm
</p>
<p><br><br>Tickets are $5
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
    slug: "7RXWFB",
    title: "IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION",
    description: """
    <p>Prepare for Glory!!
</p>
<p><br>Prepare for IMPROVAGEDDON: The Ultimate Improv Competition!!!
</p>
<p><br>We stand before the dawn of a new world!!!
</p>
<p><br>Last month, The Party Crashers earned their second championship! Now they will defend their title against two hungry challenging teams!
</p>
<p><br>Can the Party Crashers hang on to become the 2nd ever 3x Champions? Will another brand new team emerge to take them down? Will a team of Improvageddon vets re-enter the fray?
</p>
<p><br>Who will raise the Hammer of Lowell in final victory? <br><br>You'll have to come to this month's show to find out!
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, August 27th
</p>
<p><br><br>The show starts at 10pm
</p>
<p><br><br>Tickets are $5
</p>
<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-08-27T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-27T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-13T03:32:09.062Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION ==========="
Logger.info "=========== BEGIN Processing Universe Event Painties in a Twist Silent Auction ==========="

Logger.info "=========== Writing Event Painties in a Twist Silent Auction ==========="
event = SeedHelpers.create_event(
  %{
    slug: "NJVR4C",
    title: "Painties in a Twist Silent Auction",
    description: """
    <p><strong></strong><strong>Panties in a Twist is almost here... and to get you ready for the big event, we're hosting a night of comedy for a great cause.</strong></p><p>Come out to the Push Comedy Theater on Friday, February 12 to meet the women of Panties in a Twist, enjoy some great entertainment, and to take part in our silent auction... offering anything from beautiful, hand-crafted items to gift certificates, and so much more! The auction begins at 7 pm and the winners will be announced at 9:30. </p><p>Every year, Panties in a Twist holds a silent auction with proceeds benefiting local organizations that give back to the community. This year’s proceeds will go to The Muse Writers Center and the H.E.R Shelter. </p><p>Panties in a Twist is entirely comprised of local female comedic talent, from the writers to the directors to the actors. We feel strongly in using this showcase to benefit others as much as we can. </p><p>Our silent auction beneficiaries: <br><strong>The Muse Writing Center:</strong><br>The Muse Writers Center in Norfolk, Virginia is an organization for Hampton Roads writers, new and experienced, to come together in creative writing classes, readings, and special events.<br>General Fund: We're a 501(c)3 nonprofit organization, and a General Fund donation helps us with our day-to-day expenses (rent, utilities, supplies, and other operating expenses) as well as building for our future. We definitely appreciate—and use wisely—all general fund donations. We are also working on a scholarship fund to benefit a female student interested in classes. </p><p><strong>The H.E.R. Shelter: </strong><br>The H.E.R. Shelter has existed for 30 years and sre dedicated to breaking the cycle of domestic violence by providing resources to victims through emergency shelter, 24-hour crisis hotline, counseling and support groups, children’s programs, legal advocacy, and education in the community. <br>Less than 12% of their funds are spent on administrative costs, so you can be sure that your donations are going to help where they are most needed! </p><p><strong>About Panties in a Twist</strong><br>Panties In A Twist is a sketch comedy show written by women... directed by women... and starring women.<br>The Push Comedy Theater has gathered Hampton Roads' finest and funniest female writers, actresses and comedians for the most kick ass comedy show ever seen!!!</p><p>This year we are proud to be celebrating the 5th Anniversary of Panties in a Twist. In honor of this momentous occasion, the show will be held at the historic Wells Theater.</p><p><strong>Panties In A Twist : The All Female Sketch Comedy Show</strong><br>Saturday, February 13th at 8pm.</p><p>Sunday, February 14th at 2pm.<br>Tickets are $20.</p><p>The Wells Theater<br>108 E Tazewell St, Norfolk</p><p>---<br><strong>Panties in a Twist is produced by The Pushers.</strong></p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For over ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In 2014, they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Painties in a Twist Silent Auction ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "NJVR4C",
    title: "Painties in a Twist Silent Auction",
    description: """
    <p><strong></strong><strong>Panties in a Twist is almost here... and to get you ready for the big event, we're hosting a night of comedy for a great cause.</strong></p><p>Come out to the Push Comedy Theater on Friday, February 12 to meet the women of Panties in a Twist, enjoy some great entertainment, and to take part in our silent auction... offering anything from beautiful, hand-crafted items to gift certificates, and so much more! The auction begins at 7 pm and the winners will be announced at 9:30. </p><p>Every year, Panties in a Twist holds a silent auction with proceeds benefiting local organizations that give back to the community. This year’s proceeds will go to The Muse Writers Center and the H.E.R Shelter. </p><p>Panties in a Twist is entirely comprised of local female comedic talent, from the writers to the directors to the actors. We feel strongly in using this showcase to benefit others as much as we can. </p><p>Our silent auction beneficiaries: <br><strong>The Muse Writing Center:</strong><br>The Muse Writers Center in Norfolk, Virginia is an organization for Hampton Roads writers, new and experienced, to come together in creative writing classes, readings, and special events.<br>General Fund: We're a 501(c)3 nonprofit organization, and a General Fund donation helps us with our day-to-day expenses (rent, utilities, supplies, and other operating expenses) as well as building for our future. We definitely appreciate—and use wisely—all general fund donations. We are also working on a scholarship fund to benefit a female student interested in classes. </p><p><strong>The H.E.R. Shelter: </strong><br>The H.E.R. Shelter has existed for 30 years and sre dedicated to breaking the cycle of domestic violence by providing resources to victims through emergency shelter, 24-hour crisis hotline, counseling and support groups, children’s programs, legal advocacy, and education in the community. <br>Less than 12% of their funds are spent on administrative costs, so you can be sure that your donations are going to help where they are most needed! </p><p><strong>About Panties in a Twist</strong><br>Panties In A Twist is a sketch comedy show written by women... directed by women... and starring women.<br>The Push Comedy Theater has gathered Hampton Roads' finest and funniest female writers, actresses and comedians for the most kick ass comedy show ever seen!!!</p><p>This year we are proud to be celebrating the 5th Anniversary of Panties in a Twist. In honor of this momentous occasion, the show will be held at the historic Wells Theater.</p><p><strong>Panties In A Twist : The All Female Sketch Comedy Show</strong><br>Saturday, February 13th at 8pm.</p><p>Sunday, February 14th at 2pm.<br>Tickets are $20.</p><p>The Wells Theater<br>108 E Tazewell St, Norfolk</p><p>---<br><strong>Panties in a Twist is produced by The Pushers.</strong></p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For over ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In 2014, they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-02-12T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-02-12T22:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/4629892e-7e85-4b2e-a17d-44ce6dfd1bc2",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/4629892e-7e85-4b2e-a17d-44ce6dfd1bc2",
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

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "sketch"
})
Logger.info "=========== Wrote tag ==========="

# Insert muse
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "muse"
})
Logger.info "=========== Wrote tag ==========="

# Insert panties
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "panties"
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

# Insert general
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "general"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Painties in a Twist Silent Auction",
    status: "available",
    description: "Ticket for Painties in a Twist Silent Auction",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2016-02-08T17:05:28.088Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Painties in a Twist Silent Auction ==========="
Logger.info "=========== BEGIN Processing Universe Event Double Treble: 2 Women, 2 Musicals, All Improv! ==========="

Logger.info "=========== Writing Event Double Treble: 2 Women, 2 Musicals, All Improv! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "4LWC1M",
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
<p>Saturday, July 15th at 8pm
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
    slug: "4LWC1M",
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
<p>Saturday, July 15th at 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-07-15T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-15T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-08T17:24:20.478Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Double Treble: 2 Women, 2 Musicals, All Improv! ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The KidProv Graduation Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The KidProv Graduation Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "BT20L1",
    title: "Class Dismissed: The KidProv Graduation Show",
    description: """
    <p>You've heard of Generation X and Gen Y. Now get ready for the funniest, silliest, cutest generation of them all as The Pushers bring to you... <strong>The Pre-Teen Improv Superstars!</strong>!!
</p>
<p>Don't miss this group of talented tween-boppers as they put on a funny and fast paced 'Who's Line Is It Anyway' style show.
</p>
<p>The group is coached by local comedy couple, Jim and Mary Veverka, and local comedy giants, The Pushers.
</p>
<p><strong>Class Dismissed: The KidProv Graduation Show</strong>
</p>
<p>Saturday, February 25th at 11:30am
</p>
<p><strong>This is a free show.</strong>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Class Dismissed: The KidProv Graduation Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "BT20L1",
    title: "Class Dismissed: The KidProv Graduation Show",
    description: """
    <p>You've heard of Generation X and Gen Y. Now get ready for the funniest, silliest, cutest generation of them all as The Pushers bring to you... <strong>The Pre-Teen Improv Superstars!</strong>!!
</p>
<p>Don't miss this group of talented tween-boppers as they put on a funny and fast paced 'Who's Line Is It Anyway' style show.
</p>
<p>The group is coached by local comedy couple, Jim and Mary Veverka, and local comedy giants, The Pushers.
</p>
<p><strong>Class Dismissed: The KidProv Graduation Show</strong>
</p>
<p>Saturday, February 25th at 11:30am
</p>
<p><strong>This is a free show.</strong>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-02-25T11:30:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-02-25T13:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1d8cb615-959d-44b8-8731-9db2f3d1573a",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1d8cb615-959d-44b8-8731-9db2f3d1573a",
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
    name: "Ticket for Class Dismissed: The KidProv Graduation Show",
    status: "available",
    description: "Ticket for Class Dismissed: The KidProv Graduation Show",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2017-02-22T16:41:26.748Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The KidProv Graduation Show ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improv Riot: The Short Form Improv Show ==========="

Logger.info "=========== Writing Event The Improv Riot: The Short Form Improv Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "3L652N",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.</p><p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.</p><p>Don't miss Improv Riot on a special night!!!</p><p><strong style="background-color: initial;">The Improv Riot: The Short Form Improv Show</strong></p><p>Saturday, March 26th, 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the parking lot directly across from the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "3L652N",
    title: "The Improv Riot: The Short Form Improv Show",
    description: """
    <p>Get ready for short form (Whose Line is it Anyway?) improv at the Push Comedy Theater.</p><p>You demanded it! So now it's here!!! Our very own short form improv show. All the fun of Whose Line is it Anyway... right here in Downtown Norfolk.</p><p>Don't miss Improv Riot on a special night!!!</p><p><strong style="background-color: initial;">The Improv Riot: The Short Form Improv Show</strong></p><p>Saturday, March 26th, 8pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the parking lot directly across from the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-03-26T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-03-26T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-15T22:50:18.564Z")
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
    slug: "SC46X3",
    title: "Girl-Prov: The Girls' Night of Improv",
    description: """
    <p><strong></strong><strong>GET READY FOR GIRL'S NIGHT!</strong></p><p>Move over, gentleman! <br>The ladies are taking over for a girls' night!</p><p>GirlProv is an all-female improv group, making audiences lose it with laughter at the Push Comedy Theater.</p><p>It's slumber party meets night out on the town meet sorority house party! </p><p>Don't miss this night of comedy- all made up on the spot from the audience's suggestion!</p><p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, June 10th at the Push Comedy Theater<br>The show starts at 10, tickets are $5</p><p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">pushcomedytheater.com</a></p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "SC46X3",
    title: "Girl-Prov: The Girls' Night of Improv",
    description: """
    <p><strong></strong><strong>GET READY FOR GIRL'S NIGHT!</strong></p><p>Move over, gentleman! <br>The ladies are taking over for a girls' night!</p><p>GirlProv is an all-female improv group, making audiences lose it with laughter at the Push Comedy Theater.</p><p>It's slumber party meets night out on the town meet sorority house party! </p><p>Don't miss this night of comedy- all made up on the spot from the audience's suggestion!</p><p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, June 10th at the Push Comedy Theater<br>The show starts at 10, tickets are $5</p><p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">pushcomedytheater.com</a></p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-10T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-10T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-20T20:56:06.695Z")
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
    slug: "02BSRN",
    title: "Couples Therapy",
    description: """
    <p><strong></strong><strong>You think your relationship has problems?!?</strong></p><p>In Couples Therapy you'll meet a couple on the rocks... be it newlyweds on a honeymen from hell or an elderly couple at the end of their rope.<br>Based on an audience suggestion, Sean and Brittany take you through a roller coaster ride of emotions as they whisk you the trials and tribulations of couple they create right before your eyes.</p><p>Oh yeah, and they do it all in a single, 25 minute long improvised scene.</p><p>Two Improvisers... One Scene!!!</p><p><strong>Couples Therapy... is sometimes hilarious, sometimes poignant, always magical.</strong></p><p>Sean Devereux and Brittany Shearer are members of the improv group, Alan Johnson and the Johnson Quintet. The duo have dazzled audience members at Improvageddon, and now they're getting their own show.</p><p>When not performing with the Quintet, Sean is a member of The Pushers and Brittany performs with The Pre Madonnas.</p><p>Sean and Brittany are not a couple in real life, but occasionally they play one on stage.</p><p><strong>Couples Therapy with Alan Johnson and the Alan Johnson Quintet</strong><br>Saturday, January 30th at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "02BSRN",
    title: "Couples Therapy",
    description: """
    <p><strong></strong><strong>You think your relationship has problems?!?</strong></p><p>In Couples Therapy you'll meet a couple on the rocks... be it newlyweds on a honeymen from hell or an elderly couple at the end of their rope.<br>Based on an audience suggestion, Sean and Brittany take you through a roller coaster ride of emotions as they whisk you the trials and tribulations of couple they create right before your eyes.</p><p>Oh yeah, and they do it all in a single, 25 minute long improvised scene.</p><p>Two Improvisers... One Scene!!!</p><p><strong>Couples Therapy... is sometimes hilarious, sometimes poignant, always magical.</strong></p><p>Sean Devereux and Brittany Shearer are members of the improv group, Alan Johnson and the Johnson Quintet. The duo have dazzled audience members at Improvageddon, and now they're getting their own show.</p><p>When not performing with the Quintet, Sean is a member of The Pushers and Brittany performs with The Pre Madonnas.</p><p>Sean and Brittany are not a couple in real life, but occasionally they play one on stage.</p><p><strong>Couples Therapy with Alan Johnson and the Alan Johnson Quintet</strong><br>Saturday, January 30th at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-01-30T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-01-30T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-01-18T02:49:25.695Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Couples Therapy ==========="
Logger.info "=========== BEGIN Processing Universe Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="

Logger.info "=========== Writing Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "KVH89N",
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
<p><strong>TOO FAR: The Dirtiest, Most Inappropriate Comedy Show... EVER!</strong><br>Saturday, May 20th <br>Tickets are $10, Show starts at 10:00pm
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
    slug: "KVH89N",
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
<p><strong>TOO FAR: The Dirtiest, Most Inappropriate Comedy Show... EVER!</strong><br>Saturday, May 20th <br>Tickets are $10, Show starts at 10:00pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-05-20T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-20T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-11T03:12:32.540Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Teacher's Pet ==========="

Logger.info "=========== Writing Event Teacher's Pet ==========="
event = SeedHelpers.create_event(
  %{
    slug: "9W1PCR",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Friday, April 14th, 10pm<br>Tickets are $5
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
    slug: "9W1PCR",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Friday, April 14th, 10pm<br>Tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2017-04-14T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-04-14T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-04-07T15:20:37.135Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Teacher's Pet ==========="
Logger.info "=========== BEGIN Processing Universe Event Tell Me More… Storytelling Night: Adaptations ==========="

Logger.info "=========== Writing Event Tell Me More… Storytelling Night: Adaptations ==========="
event = SeedHelpers.create_event(
  %{
    slug: "Y6ZR0F",
    title: "Tell Me More… Storytelling Night: Adaptations",
    description: """
    <p><strong></strong><strong>Come out and join us 7 p.m. April 17 to hear about change and flexiblity.</strong></p><p>Theme: Adaptations<br>Song: “Delicate,” by Damien Rice<br>Possibly inspiring stories of: Flexibility and change</p><p>FEATURED STORYTELLERS<br>Storytellers to be announced. If you’re interested in telling a story, tell us about it: <a href="http://tellmemorelive.org/sign-up/" rel="nofollow" target="_blank">http://tellmemorelive.org/<wbr>sign-up/</wbr></a></p><p>OUR HOST<br>Brendan Kennedy, is a comedian, storyteller and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”<br><br>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, April 17, 2016<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $5</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Tell Me More… Storytelling Night: Adaptations ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "Y6ZR0F",
    title: "Tell Me More… Storytelling Night: Adaptations",
    description: """
    <p><strong></strong><strong>Come out and join us 7 p.m. April 17 to hear about change and flexiblity.</strong></p><p>Theme: Adaptations<br>Song: “Delicate,” by Damien Rice<br>Possibly inspiring stories of: Flexibility and change</p><p>FEATURED STORYTELLERS<br>Storytellers to be announced. If you’re interested in telling a story, tell us about it: <a href="http://tellmemorelive.org/sign-up/" rel="nofollow" target="_blank">http://tellmemorelive.org/<wbr>sign-up/</wbr></a></p><p>OUR HOST<br>Brendan Kennedy, is a comedian, storyteller and co-host of “What’s a Podcast with Brendan Kennedy and CB Wilkins.”<br><br>EVENT DETAILS<br>Time: 7 p.m.<br>Date: Sunday, April 17, 2016<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $5</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-17T19:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-17T21:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/e7b1aaf5-d622-4127-ad89-1c9a9558a294",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/e7b1aaf5-d622-4127-ad89-1c9a9558a294",
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
    name: "Ticket for Tell Me More… Storytelling Night: Adaptations",
    status: "available",
    description: "Ticket for Tell Me More… Storytelling Night: Adaptations",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-15T23:08:15.193Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tell Me More… Storytelling Night: Adaptations ==========="
