require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event The 666 Project: A Horror Anthology Show (Oct 23) ==========="

Logger.info "=========== Writing Event The 666 Project: A Horror Anthology Show (Oct 23) ==========="
event = SeedHelpers.create_event(
  %{
    slug: "J8XPYZ",
    title: "The 666 Project: A Horror Anthology Show (Oct 23)",
    description: """
    <p style="text-align: center;">In the grand tradition of The Twilight Zone and Tales from the Crypt comes The 666 Project. The Push Comedy Theater has gathered six writers, six directors and six actors to bring you six rib-tickling, tales of terror. i</p><p style="text-align: center;"><strong>The Push Comedy Theater is proud to present The 666 Project: A Horror Anthology Show!</strong></p><p style="text-align: center;">October 17, 22, 23, 24, 30 and 31 at The Push Comedy Theater</p><p style="text-align: center;">The show starts at 8pm.</p><p style="text-align: center;">Tickets are $15 and are available at the links below or at pushcomedytheater.com</p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-oct-17-tickets-norfolk-71PMGS" rel="nofollow" target="_blank">Saturday, October 17</a></p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-oct-22-tickets-norfolk-2KFD07" rel="nofollow" target="_blank">Thursday, October 22</a> </p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-tickets-norfolk-J8XPYZ" rel="nofollow" target="_blank">Friday, October 23</a></p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-oct-24-tickets-norfolk-GFP4M5" rel="nofollow" target="_blank">Saturday, October 24</a></p><p style="text-align: center;">Friday, October 30</p><p style="text-align: center;">Saturday, October 31</p><p style="text-align: center;">The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p><a href="https://www.facebook.com/events/862223163884514/" rel="nofollow" target="_blank"><img src="https://s3.amazonaws.com/uniiverse_production/attachments/43c3d62c11efcf26daa282c90c0d7692-Push%20Halloween%20Project%20White%20Poster.jpg" alt="" style="display: block; margin: auto;"></a></p><p style="text-align: center;">Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p style="text-align: center;">---</p><p style="text-align: center;">The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p style="text-align: center;">In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p style="text-align: center;">The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p style="text-align: center;">Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p style="text-align: center;">--</p><p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p style="text-align: center;">The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The 666 Project: A Horror Anthology Show (Oct 23) ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "J8XPYZ",
    title: "The 666 Project: A Horror Anthology Show (Oct 23)",
    description: """
    <p style="text-align: center;">In the grand tradition of The Twilight Zone and Tales from the Crypt comes The 666 Project. The Push Comedy Theater has gathered six writers, six directors and six actors to bring you six rib-tickling, tales of terror. i</p><p style="text-align: center;"><strong>The Push Comedy Theater is proud to present The 666 Project: A Horror Anthology Show!</strong></p><p style="text-align: center;">October 17, 22, 23, 24, 30 and 31 at The Push Comedy Theater</p><p style="text-align: center;">The show starts at 8pm.</p><p style="text-align: center;">Tickets are $15 and are available at the links below or at pushcomedytheater.com</p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-oct-17-tickets-norfolk-71PMGS" rel="nofollow" target="_blank">Saturday, October 17</a></p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-oct-22-tickets-norfolk-2KFD07" rel="nofollow" target="_blank">Thursday, October 22</a> </p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-tickets-norfolk-J8XPYZ" rel="nofollow" target="_blank">Friday, October 23</a></p><p style="text-align: center;"><a href="https://www.universe.com/events/the-666-project-a-horror-anthology-show-oct-24-tickets-norfolk-GFP4M5" rel="nofollow" target="_blank">Saturday, October 24</a></p><p style="text-align: center;">Friday, October 30</p><p style="text-align: center;">Saturday, October 31</p><p style="text-align: center;">The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p><a href="https://www.facebook.com/events/862223163884514/" rel="nofollow" target="_blank"><img src="https://s3.amazonaws.com/uniiverse_production/attachments/43c3d62c11efcf26daa282c90c0d7692-Push%20Halloween%20Project%20White%20Poster.jpg" alt="" style="display: block; margin: auto;"></a></p><p style="text-align: center;">Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p style="text-align: center;">---</p><p style="text-align: center;">The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p style="text-align: center;">In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p style="text-align: center;">The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p style="text-align: center;">Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p style="text-align: center;">--</p><p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p style="text-align: center;">The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-10-23T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-10-23T22:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/a5fadff8-5099-4455-ba21-56e4cb6d269e",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/a5fadff8-5099-4455-ba21-56e4cb6d269e",
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

# Insert 666
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "666"
})
Logger.info "=========== Wrote tag ==========="

# Insert project
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "project"
})
Logger.info "=========== Wrote tag ==========="

# Insert halloween
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "halloween"
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
    name: "Ticket for The 666 Project: A Horror Anthology Show (Oct 23)",
    status: "available",
    description: "Ticket for The 666 Project: A Horror Anthology Show (Oct 23)",
    price: 1500,
    sale_start:  NaiveDateTime.from_iso8601!("2015-09-30T16:35:17.114Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The 666 Project: A Horror Anthology Show (Oct 23) ==========="
Logger.info "=========== BEGIN Processing Universe Event Harold Night ==========="

Logger.info "=========== Writing Event Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "Q97SBW",
    title: "Harold Night",
    description: """
    <p style="text-align: center;">It's Harold Night at the Push Comedy Theater!</p><p style="text-align: center;">So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p style="text-align: center;">The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p style="text-align: center;">Don't miss Harold Night. We'll be unveiling the new Push Comedy Theater house teams.</p><p style="text-align: center;">Harold Night </p><p style="text-align: center;">Friday, October 30th, 10pm</p><p style="text-align: center;">Tickets are $5.</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/61eace64c95aefdd9264938db030a89c-Harold.jpg" alt="" style="display: block; margin: auto;"></p><p style="text-align: center;">The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p style="text-align: center;">Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p style="text-align: center;">--</p><p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p style="text-align: center;">The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting. </p><p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "Q97SBW",
    title: "Harold Night",
    description: """
    <p style="text-align: center;">It's Harold Night at the Push Comedy Theater!</p><p style="text-align: center;">So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p style="text-align: center;">The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p style="text-align: center;">Don't miss Harold Night. We'll be unveiling the new Push Comedy Theater house teams.</p><p style="text-align: center;">Harold Night </p><p style="text-align: center;">Friday, October 30th, 10pm</p><p style="text-align: center;">Tickets are $5.</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/61eace64c95aefdd9264938db030a89c-Harold.jpg" alt="" style="display: block; margin: auto;"></p><p style="text-align: center;">The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p style="text-align: center;">Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p style="text-align: center;">--</p><p style="text-align: center;">The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p style="text-align: center;">The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting. </p><p style="text-align: center;">Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-10-30T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-10-30T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/18e1e0f6-ed43-485f-87bc-fefc09067da2",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/18e1e0f6-ed43-485f-87bc-fefc09067da2",
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
    sale_start:  NaiveDateTime.from_iso8601!("2015-10-12T04:22:10.464Z")
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
    slug: "7J9LNK",
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
<p>Saturday, June 3rd at 8pm
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
    slug: "7J9LNK",
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
<p>Saturday, June 3rd at 8pm
</p>
<p>Tickets are $5
</p>
<p><br>
</p>
<p>I ain't afraid of no ghost!
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
    name: "Ticket for Tales from the Campfire: The Improvised Ghost Story",
    status: "available",
    description: "Ticket for Tales from the Campfire: The Improvised Ghost Story",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-31T03:07:35.228Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Tales from the Campfire: The Improvised Ghost Story ==========="
Logger.info "=========== BEGIN Processing Universe Event The Pushie Awards Show ==========="

Logger.info "=========== Writing Event The Pushie Awards Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "C2ZSMG",
    title: "The Pushie Awards Show",
    description: """
    <p>Imagine the Oscars, the Emmys, the Tonys and Nickelodeon Kid's Choice Awards all rolled into one!
</p>
<p>Well imagine no more... because the Push Comedy Theater is proud to announce The Second Annual Pushie Awards!!!
</p>
<p>The Pushie Awards are our chance to honor some of the funniest performers, shows and moments of 2017.
</p>
<p>Stay tuned for the full list of awards and nominees.
</p>
<p>Like all award shows, this night will be full of pomp and circumstance, surprise guest stars, wonderful food and amazing performances.
</p>
<p>The Pushie Awards will be held on Sunday, December 31st from 6 to 9pm.
</p>
<p>Don't miss on of the biggest comedy events of the year!!!
</p>
<p>*********************************
</p>
<p>The Pushie Awards Show
</p>
<p>Sunday, December 31st at 6pm
</p>
<p>Tickets are $20 in advance, $25 the night of the show.
</p>
<p>Free buffet will be provided
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
    slug: "C2ZSMG",
    title: "The Pushie Awards Show",
    description: """
    <p>Imagine the Oscars, the Emmys, the Tonys and Nickelodeon Kid's Choice Awards all rolled into one!
</p>
<p>Well imagine no more... because the Push Comedy Theater is proud to announce The Second Annual Pushie Awards!!!
</p>
<p>The Pushie Awards are our chance to honor some of the funniest performers, shows and moments of 2017.
</p>
<p>Stay tuned for the full list of awards and nominees.
</p>
<p>Like all award shows, this night will be full of pomp and circumstance, surprise guest stars, wonderful food and amazing performances.
</p>
<p>The Pushie Awards will be held on Sunday, December 31st from 6 to 9pm.
</p>
<p>Don't miss on of the biggest comedy events of the year!!!
</p>
<p>*********************************
</p>
<p>The Pushie Awards Show
</p>
<p>Sunday, December 31st at 6pm
</p>
<p>Tickets are $20 in advance, $25 the night of the show.
</p>
<p>Free buffet will be provided
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
    start_at:  NaiveDateTime.from_iso8601!("2017-12-31T18:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-12-31T21:30:00.000-05:00")
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
    price: 2000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-22T03:42:15.845Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Pushie Awards Show ==========="
Logger.info "=========== BEGIN Processing Universe Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="

Logger.info "=========== Writing Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
event = SeedHelpers.create_event(
  %{
    slug: "K64JZB",
    title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    description: """
    <p><strong>The Push Comedy Theater's Experimental Sketch Comedy Showcase is back with a vengeance!!!!</strong>
</p>
<p>2 time champ On the House will be going for a three-peat... but a new challenger is lurking in the wings to strike.
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
<p>Friday, March 3rd at 10pm
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
    slug: "K64JZB",
    title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    description: """
    <p><strong>The Push Comedy Theater's Experimental Sketch Comedy Showcase is back with a vengeance!!!!</strong>
</p>
<p>2 time champ On the House will be going for a three-peat... but a new challenger is lurking in the wings to strike.
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
<p>Friday, March 3rd at 10pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-03-03T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-03T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-02-22T23:54:55.491Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
Logger.info "=========== BEGIN Processing Universe Event Harold Night ==========="

Logger.info "=========== Writing Event Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "DVBGX2",
    title: "Harold Night",
    description: """
    <p>It's Harold Night at the Push Comedy Theater!<br> <br> So who the heck is Harold? More accurately the question should be... what the heck is a Harold?<br> <br>  The Harold is the big, bad grand daddy of all long form improv! It  starts with an audience suggestion, then improvisers weave together  scenes, characters and group games to create a seamless piece. It can be  bizarre and magical, baffling and amazing... it definitely needs to be  seen.<br> This month don't miss house teams The Cahoots and Third Choice<br> <br> Harold Night<br> <br> Friday, May 27th at 10:00pm<br> <br> Tickets are $5<br> <br> The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br> <br>  Free parking available at Slone Chiropractic (111 W Virginia Beach)  just one block from the theater. There is also limited parking on the  street.<br> <br> --<br> <br> The Push Comedy Theater is a 99 seat venue  in the heart of Norfolk's brand new Arts District. Founded by local  comedy group The Pushers, the Push Comedy Theater is dedicated to  bringing you live comedy from the best local and national acts.<br> <br>  The Push Comedy Theater hosts live sketch, improv and stand-up comedy  on Friday and Saturday nights. During the week classesare offered in  stand-up, sketch and improv comedy as well as acting.<br> <br></p><p>Whether  you're a die-hard comedy lover or a casual fan... a seasoned performer  or someone who's never stepped foot on stage... the Push Comedy Theater  has something for you.</p>
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
    slug: "DVBGX2",
    title: "Harold Night",
    description: """
    <p>It's Harold Night at the Push Comedy Theater!<br> <br> So who the heck is Harold? More accurately the question should be... what the heck is a Harold?<br> <br>  The Harold is the big, bad grand daddy of all long form improv! It  starts with an audience suggestion, then improvisers weave together  scenes, characters and group games to create a seamless piece. It can be  bizarre and magical, baffling and amazing... it definitely needs to be  seen.<br> This month don't miss house teams The Cahoots and Third Choice<br> <br> Harold Night<br> <br> Friday, May 27th at 10:00pm<br> <br> Tickets are $5<br> <br> The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.<br> <br>  Free parking available at Slone Chiropractic (111 W Virginia Beach)  just one block from the theater. There is also limited parking on the  street.<br> <br> --<br> <br> The Push Comedy Theater is a 99 seat venue  in the heart of Norfolk's brand new Arts District. Founded by local  comedy group The Pushers, the Push Comedy Theater is dedicated to  bringing you live comedy from the best local and national acts.<br> <br>  The Push Comedy Theater hosts live sketch, improv and stand-up comedy  on Friday and Saturday nights. During the week classesare offered in  stand-up, sketch and improv comedy as well as acting.<br> <br></p><p>Whether  you're a die-hard comedy lover or a casual fan... a seasoned performer  or someone who's never stepped foot on stage... the Push Comedy Theater  has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-05-27T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-05-27T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/3cfcf9ab-ac14-45eb-8a9e-f4b165ba7615",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/3cfcf9ab-ac14-45eb-8a9e-f4b165ba7615",
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-01T20:35:57.354Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Harold Night ==========="
Logger.info "=========== BEGIN Processing Universe Event Couples Therapy ==========="

Logger.info "=========== Writing Event Couples Therapy ==========="
event = SeedHelpers.create_event(
  %{
    slug: "4JS7KW",
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
<p><br><br>Couples Therapy with Alan Johnson and the Alan Johnson Quintet<br>Friday, December 30th at 8pm<br>Tickets are $5
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
    slug: "4JS7KW",
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
<p><br><br>Couples Therapy with Alan Johnson and the Alan Johnson Quintet<br>Friday, December 30th at 8pm<br>Tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2016-12-30T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-12-30T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-12-16T01:49:59.311Z")
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
    slug: "VN3PK5",
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
<p><strong>TOO FAR: The Dirtiest, Most Inappropriate Comedy Show... EVER!</strong><br>Saturday, December 17th <br>Tickets are $10, Show starts at 10:00pm
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
    slug: "VN3PK5",
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
<p><strong>TOO FAR: The Dirtiest, Most Inappropriate Comedy Show... EVER!</strong><br>Saturday, December 17th <br>Tickets are $10, Show starts at 10:00pm
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
    start_at:  NaiveDateTime.from_iso8601!("2016-12-17T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-12-17T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-12-06T02:35:13.457Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event TOO FAR: The Dirty, Inappropriate Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="

Logger.info "=========== Writing Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
event = SeedHelpers.create_event(
  %{
    slug: "Y0HDT5",
    title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    description: """
    <p><strong>The Push Comedy Theater's Experimental Sketch Comedy Showcase is back with a vengeance!!!!</strong>
</p>
<p>Last time...
</p>
<p>Champions <strong>On the House</strong> scored their first ever 3-peat.  But now a new challenger is lurking in the wings to strike.
</p>
<p><strong>Don't miss this epic sketch comedy showdown, where truly anything can happen.</strong>
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
<p>Friday, April 7th at 10pm
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
    slug: "Y0HDT5",
    title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    description: """
    <p><strong>The Push Comedy Theater's Experimental Sketch Comedy Showcase is back with a vengeance!!!!</strong>
</p>
<p>Last time...
</p>
<p>Champions <strong>On the House</strong> scored their first ever 3-peat.  But now a new challenger is lurking in the wings to strike.
</p>
<p><strong>Don't miss this epic sketch comedy showdown, where truly anything can happen.</strong>
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
<p>Friday, April 7th at 10pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-04-07T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-04-07T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-15T21:24:13.554Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
Logger.info "=========== BEGIN Processing Universe Event How the West was Improvised: The Made Up Western ==========="

Logger.info "=========== Writing Event How the West was Improvised: The Made Up Western ==========="
event = SeedHelpers.create_event(
  %{
    slug: "0G83DL",
    title: "How the West was Improvised: The Made Up Western",
    description: """
    <p>Howdy there, partner!
</p>
<p>Get ready for the Improvised Western.<br><br>Don't miss the gun slinger with a heart of gold, the damsel in distress, the villain dressed in black... bank heists, shoot outs, horse chases and more.<br><br>It's everything you love about the good old fashioned western... made up right before your eyes.<br><br>From John Wayne to Clint Eastwood, Tombstone to True Grit... if you're a fan of westerns (or just a fan of comedy), you'll love How the West was Improvised.<br><br>How the West was Improvised: The Made Up Western<br>Friday, November 17th at 8pm<br>Tickets are $10
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
    slug: "0G83DL",
    title: "How the West was Improvised: The Made Up Western",
    description: """
    <p>Howdy there, partner!
</p>
<p>Get ready for the Improvised Western.<br><br>Don't miss the gun slinger with a heart of gold, the damsel in distress, the villain dressed in black... bank heists, shoot outs, horse chases and more.<br><br>It's everything you love about the good old fashioned western... made up right before your eyes.<br><br>From John Wayne to Clint Eastwood, Tombstone to True Grit... if you're a fan of westerns (or just a fan of comedy), you'll love How the West was Improvised.<br><br>How the West was Improvised: The Made Up Western<br>Friday, November 17th at 8pm<br>Tickets are $10
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-11-17T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-17T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/5c2916c4-1c98-4369-9021-88aee9b5519c",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/5c2916c4-1c98-4369-9021-88aee9b5519c",
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
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-26T02:12:50.299Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event How the West was Improvised: The Made Up Western ==========="
Logger.info "=========== BEGIN Processing Universe Event Teacher's Pet ==========="

Logger.info "=========== Writing Event Teacher's Pet ==========="
event = SeedHelpers.create_event(
  %{
    slug: "D2CR0B",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Friday, May 12th, 10pm<br>Tickets are $5
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
    slug: "D2CR0B",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Friday, May 12th, 10pm<br>Tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2017-05-12T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-12T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-03T19:16:38.394Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Teacher's Pet ==========="
Logger.info "=========== BEGIN Processing Universe Event The First Timers Club: A Sketch Comedy Show ==========="

Logger.info "=========== Writing Event The First Timers Club: A Sketch Comedy Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "24FLB9",
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
<p>Sunday, December 4th
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
    slug: "24FLB9",
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
<p>Sunday, December 4th
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
    start_at:  NaiveDateTime.from_iso8601!("2016-09-01T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-01T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-23T03:28:50.432Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The First Timers Club: A Sketch Comedy Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Short Stack presents: Rebirth of the Stack! ==========="

Logger.info "=========== Writing Event Short Stack presents: Rebirth of the Stack! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "KQWVMN",
    title: "Short Stack presents: Rebirth of the Stack!",
    description: """
    <p><strong>REBIRTH OF THE STACK!</strong>
</p>
<p>Join Shortstack on a spiritual, emotional, sensual, and wholesome journey to discover true enlightenment.<br>
</p>
<p>Shortstack is the petite powerhouse of the 757 specializing in sketch and improv comedy.
</p>
<p>These abnormal hobbits specialize in sketch and improv comedy. They are 6 time  IMPROVAGEDDON Champions
</p>
<p><strong>Shortstack presents: Rebirth of the Stack!</strong>
</p>
<p><strong>Friday, May 19th at 8pm</strong>
</p>
<p><strong>Tickets are $5</strong>
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
Logger.info "=========== Writing Event Listing Short Stack presents: Rebirth of the Stack! ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "KQWVMN",
    title: "Short Stack presents: Rebirth of the Stack!",
    description: """
    <p><strong>REBIRTH OF THE STACK!</strong>
</p>
<p>Join Shortstack on a spiritual, emotional, sensual, and wholesome journey to discover true enlightenment.<br>
</p>
<p>Shortstack is the petite powerhouse of the 757 specializing in sketch and improv comedy.
</p>
<p>These abnormal hobbits specialize in sketch and improv comedy. They are 6 time  IMPROVAGEDDON Champions
</p>
<p><strong>Shortstack presents: Rebirth of the Stack!</strong>
</p>
<p><strong>Friday, May 19th at 8pm</strong>
</p>
<p><strong>Tickets are $5</strong>
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
    start_at:  NaiveDateTime.from_iso8601!("2017-05-19T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-19T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8787546b-c6a6-4b7d-a7c0-cad37ed1e0f1",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8787546b-c6a6-4b7d-a7c0-cad37ed1e0f1",
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

# Insert shortstack
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "shortstack"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Short Stack presents: Rebirth of the Stack!",
    status: "available",
    description: "Ticket for Short Stack presents: Rebirth of the Stack!",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-16T02:51:12.132Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Short Stack presents: Rebirth of the Stack! ==========="
Logger.info "=========== BEGIN Processing Universe Event Double Treble: 2 Women, 2 Musicals, All Improv! ==========="

Logger.info "=========== Writing Event Double Treble: 2 Women, 2 Musicals, All Improv! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "TF6ZHB",
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
<p>Saturday, June 17th at 8pm
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
    slug: "TF6ZHB",
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
<p>Saturday, June 17th at 8pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-06-17T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-06-17T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-06-08T19:39:30.167Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Double Treble: 2 Women, 2 Musicals, All Improv! ==========="
Logger.info "=========== BEGIN Processing Universe Event Sketchmageddon ==========="

Logger.info "=========== Writing Event Sketchmageddon ==========="
event = SeedHelpers.create_event(
  %{
    slug: "86HCQS",
    title: "Sketchmageddon",
    description: """
    <p><strong>The Push Comedy Theater's Sketch Comedy Showcase is back with a Vengeance!!!!</strong>
</p>
<p>This is the show where anything goes... and we do mean anything.
</p>
<p><br>
</p>
<p>Last month's show was crazy!!!
</p>
<p>Who knows what surprises we have in store for this show!!!
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
<p>Friday, August 5th at 10pm
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
    slug: "86HCQS",
    title: "Sketchmageddon",
    description: """
    <p><strong>The Push Comedy Theater's Sketch Comedy Showcase is back with a Vengeance!!!!</strong>
</p>
<p>This is the show where anything goes... and we do mean anything.
</p>
<p><br>
</p>
<p>Last month's show was crazy!!!
</p>
<p>Who knows what surprises we have in store for this show!!!
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
<p>Friday, August 5th at 10pm
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
    start_at:  NaiveDateTime.from_iso8601!("2016-08-05T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-05T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-19T02:17:21.520Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Sketchmageddon ==========="
Logger.info "=========== BEGIN Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="

Logger.info "=========== Writing Event Girl-Prov: The Girls' Night of Improv ==========="
event = SeedHelpers.create_event(
  %{
    slug: "NTV2S3",
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
<p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, December 9th at the Push Comedy Theater<br>The show starts at 10, tickets are $5
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
    slug: "NTV2S3",
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
<p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, December 9th at the Push Comedy Theater<br>The show starts at 10, tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2016-12-09T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-12-09T23:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-12-02T16:33:54.205Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="
Logger.info "=========== BEGIN Processing Universe Event The Pushers go to Charleston ==========="

Logger.info "=========== Writing Event The Pushers go to Charleston ==========="
event = SeedHelpers.create_event(
  %{
    slug: "2DH75Q",
    title: "The Pushers go to Charleston",
    description: """
    <p>Next weekend, The Pushers will be performing at the Charleston Comedy Festival. But you can catch them before they go... Saturday Night, 8pm at the Push.</p><p>The Pushers have been called the 'darlings of the Charleston Comedy Festival'. Granted, they've also been called 'the deviants of the Charleston Comedy Festival.</p><p>See what has made the so famous and/or infamous. It's only 5 bucks.</p><p>All money from this show will go towards gas money, hotels and most likely bail.</p><p><strong>The Pushers go to Charleston</strong><br>Saturday, January 16th at 8pm<br>Tickets are $5</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Pushers go to Charleston ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "2DH75Q",
    title: "The Pushers go to Charleston",
    description: """
    <p>Next weekend, The Pushers will be performing at the Charleston Comedy Festival. But you can catch them before they go... Saturday Night, 8pm at the Push.</p><p>The Pushers have been called the 'darlings of the Charleston Comedy Festival'. Granted, they've also been called 'the deviants of the Charleston Comedy Festival.</p><p>See what has made the so famous and/or infamous. It's only 5 bucks.</p><p>All money from this show will go towards gas money, hotels and most likely bail.</p><p><strong>The Pushers go to Charleston</strong><br>Saturday, January 16th at 8pm<br>Tickets are $5</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-01-16T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-01-16T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/cdf8b47f-0f42-4f20-964b-0340b240eed6",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/cdf8b47f-0f42-4f20-964b-0340b240eed6",
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
    name: "Ticket for The Pushers go to Charleston",
    status: "available",
    description: "Ticket for The Pushers go to Charleston",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-01-15T19:19:04.050Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Pushers go to Charleston ==========="
Logger.info "=========== BEGIN Processing Universe Event The Dudes: Little Urban Achievers ==========="

Logger.info "=========== Writing Event The Dudes: Little Urban Achievers ==========="
event = SeedHelpers.create_event(
  %{
    slug: "B758Y3",
    title: "The Dudes: Little Urban Achievers",
    description: """
    <p><strong></strong><strong>Here come The Dudes, again!</strong></p><p>You haven't heard of The Dudes?!?!</p><p>The Dudes are bunch of easygoing guys who like to drink, talk about dude things, and perfom comedy. They're 5-time<strong> IMPROVAGEDDON</strong> champions and they have an oscillating fan for some reason.</p><p>Don't miss a night of Dude-inspired comedy!!! With an appearance from a special, secret guest Dude, and featuring the hilarious ladies of Girl-Prov!</p><p>The Dudes Improvasitional Comedy are:</p><p>Rafael <br>Adam Paine<br>James Roach<br>Matt Cole <br>Brian Garraty<br>Anthony Nobles</p><p><strong>The Dudes: Little Urban Achievers</strong><br>Saturday, March 5th at 10pm<br>Tickets are $5</p><p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Dudes: Little Urban Achievers ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "B758Y3",
    title: "The Dudes: Little Urban Achievers",
    description: """
    <p><strong></strong><strong>Here come The Dudes, again!</strong></p><p>You haven't heard of The Dudes?!?!</p><p>The Dudes are bunch of easygoing guys who like to drink, talk about dude things, and perfom comedy. They're 5-time<strong> IMPROVAGEDDON</strong> champions and they have an oscillating fan for some reason.</p><p>Don't miss a night of Dude-inspired comedy!!! With an appearance from a special, secret guest Dude, and featuring the hilarious ladies of Girl-Prov!</p><p>The Dudes Improvasitional Comedy are:</p><p>Rafael <br>Adam Paine<br>James Roach<br>Matt Cole <br>Brian Garraty<br>Anthony Nobles</p><p><strong>The Dudes: Little Urban Achievers</strong><br>Saturday, March 5th at 10pm<br>Tickets are $5</p><p><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-03-05T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-03-05T23:45:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b98a5d6d-ca91-4b8d-b630-eb8a3095b0e6",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/b98a5d6d-ca91-4b8d-b630-eb8a3095b0e6",
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
    name: "Ticket for The Dudes: Little Urban Achievers",
    status: "available",
    description: "Ticket for The Dudes: Little Urban Achievers",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-02-29T00:32:37.097Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Dudes: Little Urban Achievers ==========="
Logger.info "=========== BEGIN Processing Universe Event Kerry Kruk's Improv Jam Extravaganza! ==========="

Logger.info "=========== Writing Event Kerry Kruk's Improv Jam Extravaganza! ==========="
event = SeedHelpers.create_event(
  %{
    slug: "ST8K2M",
    title: "Kerry Kruk's Improv Jam Extravaganza!",
    description: """
    <p>***FREE SHOW***
</p>
<p>Kerry Kruk is gathering some of the finest improvisers to host a completely free Improv Jam!
</p>
<p>These amazing performers will make up 2 whole acts right before your very eyes, all based on an audience suggestion! Don't miss it!
</p>
<p>Kerry Kruk's Improv Jam Extravaganza!
</p>
<p>Friday, January 20th, 10pm
</p>
<p>THIS IS A FREE SHOW!
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
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
Logger.info "=========== Writing Event Listing Kerry Kruk's Improv Jam Extravaganza! ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "ST8K2M",
    title: "Kerry Kruk's Improv Jam Extravaganza!",
    description: """
    <p>***FREE SHOW***
</p>
<p>Kerry Kruk is gathering some of the finest improvisers to host a completely free Improv Jam!
</p>
<p>These amazing performers will make up 2 whole acts right before your very eyes, all based on an audience suggestion! Don't miss it!
</p>
<p>Kerry Kruk's Improv Jam Extravaganza!
</p>
<p>Friday, January 20th, 10pm
</p>
<p>THIS IS A FREE SHOW!
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
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
    start_at:  NaiveDateTime.from_iso8601!("2017-01-20T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-01-20T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1bdb04a8-b5f2-4371-88b3-73a50cb5388b",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1bdb04a8-b5f2-4371-88b3-73a50cb5388b",
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
    name: "Ticket for Kerry Kruk's Improv Jam Extravaganza!",
    status: "available",
    description: "Ticket for Kerry Kruk's Improv Jam Extravaganza!",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2017-01-17T20:08:08.288Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Kerry Kruk's Improv Jam Extravaganza! ==========="
Logger.info "=========== BEGIN Processing Universe Event Mom Jeans' Post Mother's Day Bash ==========="

Logger.info "=========== Writing Event Mom Jeans' Post Mother's Day Bash ==========="
event = SeedHelpers.create_event(
  %{
    slug: "TJ8YP9",
    title: "Mom Jeans' Post Mother's Day Bash",
    description: """
    <p>Think it's a man's world?  Nope.  It's a mom's world.
</p>
<p>But believe us... you have never seen mom's like these.
</p>
<p>The Push Comedy Theater is proud to present Mom Jeans, in their first full length show!!!
</p>
<p>When these ladies get together it's guaranteed to be a hilarious and raucous good time.<br>
</p>
<p>This is a special matinee show... but leave the kids at home.
</p>
<p><br>
</p>
<p>Get ready for the mother of all sketch shows from the mother of all sketch groups.<br>
</p>
<p>Mom Jean's Post Mother's Day Bash
</p>
<p>Sunday, May 21st at noon.
</p>
<p>Tickets are $10
</p>
<p><br>
</p>
<p>Mom Jeans are Courtney Wolter-Grilli, Erin Lindstrom, Lucy Hall, Jessa Gaul, Jen Weir-Edwards and Andrea Bourguignon.
</p>
<p><br>
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
Logger.info "=========== Writing Event Listing Mom Jeans' Post Mother's Day Bash ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "TJ8YP9",
    title: "Mom Jeans' Post Mother's Day Bash",
    description: """
    <p>Think it's a man's world?  Nope.  It's a mom's world.
</p>
<p>But believe us... you have never seen mom's like these.
</p>
<p>The Push Comedy Theater is proud to present Mom Jeans, in their first full length show!!!
</p>
<p>When these ladies get together it's guaranteed to be a hilarious and raucous good time.<br>
</p>
<p>This is a special matinee show... but leave the kids at home.
</p>
<p><br>
</p>
<p>Get ready for the mother of all sketch shows from the mother of all sketch groups.<br>
</p>
<p>Mom Jean's Post Mother's Day Bash
</p>
<p>Sunday, May 21st at noon.
</p>
<p>Tickets are $10
</p>
<p><br>
</p>
<p>Mom Jeans are Courtney Wolter-Grilli, Erin Lindstrom, Lucy Hall, Jessa Gaul, Jen Weir-Edwards and Andrea Bourguignon.
</p>
<p><br>
</p>
<p><br>
</p>
<p><br>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-05-21T12:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-21T14:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1c737d7d-30a4-4f0b-a22e-c8ccf51d9079",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1c737d7d-30a4-4f0b-a22e-c8ccf51d9079",
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

# Insert mother
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "mother"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Mom Jeans' Post Mother's Day Bash",
    status: "available",
    description: "Ticket for Mom Jeans' Post Mother's Day Bash",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-02T15:36:10.056Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Mom Jeans' Post Mother's Day Bash ==========="
