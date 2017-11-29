require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Loading classes"
improv101 = SeedHelpers.create_class(%{slug: "improv101"})
improv201 = SeedHelpers.create_class(%{slug: "improv201"})
improv301 = SeedHelpers.create_class(%{slug: "improv301"})
improv401 = SeedHelpers.create_class(%{slug: "improv401"})
improv501 = SeedHelpers.create_class(%{slug: "improv501"})
improv_studio = SeedHelpers.create_class(%{slug: "improv_studio"})
kidprov101 = SeedHelpers.create_class(%{slug: "kidprov101"})
kidprov201 = SeedHelpers.create_class(%{slug: "kidprov201"})
music_improv101 = SeedHelpers.create_class(%{slug: "music_improv101"})
music_improv201 = SeedHelpers.create_class(%{slug: "music_improv201"})
music_improv_studio = SeedHelpers.create_class(%{slug: "music_improv_studio"})
teen_improv = SeedHelpers.create_class(%{slug: "teen_improv"})
sketch101 = SeedHelpers.create_class(%{slug: "sketch101"})
sketch201 = SeedHelpers.create_class(%{slug: "sketch201"})
standup101 = SeedHelpers.create_class(%{slug: "standup101"})
acting101 = SeedHelpers.create_class(%{slug: "acting101"})
Logger.info "Seeding classes"
Logger.info "=========== BEGIN Processing Universe Event ​Improv 201 at the Push Comedy Theater ==========="

Logger.info "=========== Writing Class Listing ​Improv 201 at the Push Comedy Theater ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv201.id,
    slug: "8W6VBD",
    title: "​Improv 201 at the Push Comedy Theater",
    description: """
    <p><strong></strong><strong>Improv 201 at the Push Comedy Theater</strong>
</p>
<p>This course builds upon the fundamentals and skills learned in 101. Students will learn the beginnings 'The Harold' a long form improvisation structure developed by Del Close. They will learn how to identify the 'game' of a scene and how to heighten these games to develop 'second beats'.
</p>
<p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.
</p>
<p><strong>This is a 6 week class.<br>Cost $190</strong>
</p>
<p><strong>This class will be held from 6:30-9:30pm on Monday nights from August 7th through September 18th.</strong>
</p>
<p><strong>***There will be no class on Labor Day***<br></strong>
</p>
<p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-08-07T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-18T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c76ccb66-c7a5-4a89-95c4-c9c20824e139",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c76ccb66-c7a5-4a89-95c4-c9c20824e139",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

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
    name: "Ticket for ​Improv 201 at the Push Comedy Theater",
    status: "available",
    description: "Ticket for ​Improv 201 at the Push Comedy Theater",
    price: 19000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-11T22:42:53.997Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event ​Improv 201 at the Push Comedy Theater ==========="
Logger.info "=========== BEGIN Processing Universe Event Improv 101 with Brad McMurran ==========="

Logger.info "=========== Writing Class Listing Improv 101 with Brad McMurran ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv101.id,
    slug: "FLJNBC",
    title: "Improv 101 with Brad McMurran",
    description: """
    <p><strong>Jump into the wonderful and wild world of improv comedy!!!</strong>
</p>
<p><br>Learn the beginnings of Chicago-based, long form improv. Students will learn how to create scenes based off of audience suggestions. They will learn the fundamentals of 'Yes, And,' how to support scene partners' ideas and energy, and how to make strong character choices.
</p>
<p>Absolutely no experience in acting or comedy is needed. The Push Comedy Theater strives to create a fun, safe and supportive experience for all students.
</p>
<p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.
</p>
<p>This class meets from 6:30pm-9:30pm on Tuesday nights from July 25th through August 29th.
</p>
<p>Cost: $190
</p>
<p><br>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-07-25T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-08-29T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/988155d3-5ef5-494c-a005-0fabeb97240d",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/988155d3-5ef5-494c-a005-0fabeb97240d",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert class
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "class"
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
    name: "Ticket for Improv 101 with Brad McMurran",
    status: "available",
    description: "Ticket for Improv 101 with Brad McMurran",
    price: 19000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-06-19T16:22:03.375Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Improv 101 with Brad McMurran ==========="
Logger.info "=========== BEGIN Processing Universe Event Improv for Teens at the Push Comedy Theater ==========="

Logger.info "=========== Writing Class Listing Improv for Teens at the Push Comedy Theater ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: teen_improv.id,
    slug: "Y20RF9",
    title: "Improv for Teens at the Push Comedy Theater",
    description: """
    <p>Jump head first into the wonderful worlds of sketch and improv comedy. This class is open to teens from the ages of 13 to 18.</p><p>Absolutely no experience is needed. </p><p>Students will explore the key tools behind both long and short form improvisation. We will play numerous games to help you sharpen your mind. </p><p>We strive to create a safe, non-judgmental environment where teens can build confidence, make friends and most importantly... have fun.</p><p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.</p><p>Prerequisites: none</p><p>This class will be held from Noon-2pm on Saturday afternoons from April 9th thru May 14th.</p><p>This is class is $150 for new students and $140 fro returning students.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For more than ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-09T12:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-05-14T14:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/02e47add-c2da-4f40-a319-78867643f4b6",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/02e47add-c2da-4f40-a319-78867643f4b6",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert class
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "class"
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
    name: "Ticket for Improv for Teens at the Push Comedy Theater",
    status: "available",
    description: "Ticket for Improv for Teens at the Push Comedy Theater",
    price: 15000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-22T03:24:10.078Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Improv for Teens at the Push Comedy Theater ==========="
Logger.info "=========== BEGIN Processing Universe Event Stand-Up Comedy 101 with Hatton Jordan ==========="

Logger.info "=========== Writing Class Listing Stand-Up Comedy 101 with Hatton Jordan ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv301.id,
    slug: "DNC5LB",
    title: "Stand-Up Comedy 101 with Hatton Jordan",
    description: """
    <p><strong>Learn how to perform stand-up comedy!</strong>
</p>
<p>Stand-Up Comedy 101 class will teach you the basics of writing jokes and performing onstage in front of a live audience. Classes will concentrate on writing your own material, learning standup etiquette, and developing a stage presence.
</p>
<p>The class will be a 4 week course ending with a graduation show at the 90 seat Push Comedy Theater.
</p>
<p><strong>Class will be held Sundays from 3pm to 6pm, September 18th through October 23rd.</strong>
</p>
<p><strong>Tutition is $190</strong>
</p>
<p>This class is taught by local comedian Hatton Jordan.
</p>
<p>Hatton is a veteran stand-up comic who has kept his microphone in the comedy game for more than 25 years and has performed professionally in more than 15 states.
</p>
<p>Hatton started his comedy career at the ol' Thoroughgood Inn Comedy Club in Va Beach and since then has worked many hot comedy spots such as the Improv in Washington DC, The Comedy Cabana in South Carolina, JRs in Erie, Pennyslvania and the River Center Comedy Club in San Antonio.
</p>
<p> He even sold comedy material to Mad Magazine and, in this class, he'll tell you how he did it. Of course, he'll also tell you about his shitty shows, too.
</p>
<p>This class is for anyone wanting to know more about how to create an act, how to perform it, how get stage time and how not to piss off veteran comics.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-25T15:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-10-23T18:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8cbd6c61-9bf0-4489-9492-7caf0b2cc2d1",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8cbd6c61-9bf0-4489-9492-7caf0b2cc2d1",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

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
    name: "Ticket for Stand-Up Comedy 101 with Hatton Jordan",
    status: "available",
    description: "Ticket for Stand-Up Comedy 101 with Hatton Jordan",
    price: 19000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-02T22:38:47.840Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Stand-Up Comedy 101 with Hatton Jordan ==========="
Logger.info "=========== BEGIN Processing Universe Event KidProv 201 at the Push Comedy Theater ==========="

Logger.info "=========== Writing Class Listing KidProv 201 at the Push Comedy Theater ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: kidprov101.id,
    slug: "9HSJ0R",
    title: "KidProv 201 at the Push Comedy Theater",
    description: """
    <p>Don't miss out on the fun!!! Sign up your kids, grand kids, nieces, nephews, even the stinky neighbor kid from down the street for KidProv 201 at the Push Comedy Theater.</p><p>This class is open to children ages 8 to 12 <strong>who have previously taken at least 2 sessions of KidProv 101.</strong> </p><p>Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public-speaking, social and team-building skills.</p><p>This class will be conducted in a non-judgmental environment where the students will build confidence, make friends and most importantly ... have fun</p><p>This class will be held from 2:30pm-4:30pm on Sunday afternoons April 10th, 17th, 24th, May 1st, 15th, and 22nd.  (NO CLASS ON MAY 8TH FOR MOTHER'S DAY)</p><p>The session concludes with the students performing in a graduation show May 22nd on the Push Comedy Theater Stage.</p><p>This is class is $150.</p><p>---</p><p>Mary and Jim Veverka collectively have over eight years experience studying and performing improv. Mary, a former children's librarian, has been a professional storyteller for 20+ years. During that time, Jim assisted Mary by playing a variety of characters at holiday events. Prior to moving to the Hampton Roads area, Mary was selected as an adjudicated artist by the Indiana Arts Commission. Mary has also taught storytelling to adults and children of all ages at schools, libraries and other venues.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.</p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-10T14:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-05-22T16:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1ea2ed95-1f46-4a08-9603-748c70c40197",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1ea2ed95-1f46-4a08-9603-748c70c40197",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert class
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "class"
})
Logger.info "=========== Wrote tag ==========="

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "sketch"
})
Logger.info "=========== Wrote tag ==========="

# Insert children
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "children"
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
    name: "Ticket for KidProv 201 at the Push Comedy Theater",
    status: "available",
    description: "Ticket for KidProv 201 at the Push Comedy Theater",
    price: 15000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-02-29T15:08:36.024Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event KidProv 201 at the Push Comedy Theater ==========="
Logger.info "=========== BEGIN Processing Universe Event Musical Improv 201 ==========="

Logger.info "=========== Writing Class Listing Musical Improv 201 ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv201.id,
    slug: "CWRY6N",
    title: "Musical Improv 201",
    description: """
    <p>Musical Improv 201
</p>
<p>This class is focused on building a long form Musical Harold. It will improve upon the concepts and skills learned in Musical Improv 101, with a focus on finding deeper relationships and themes to bring to life through song.
</p>
<p>Be prepared to play with unique 2nd beats, duets, genres, and movement.
</p>
<p>This course culminates with a graduation show.
</p>
<p>Prerequisites: Musical Improv 101
</p>
<p>This course is 6 weeks long
</p>
<p>Cost $210
</p>
<p><strong>This class is held on Saturday afternoons, 3pm-6pm, November 18th through January 6th.</strong>
</p>
<p><strong></strong>
</p>
<p><strong>***There will be no class on November 25th or December 23rd. There will be class on December 30th***</strong>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-11-18T15:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-06T18:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/20f01bb1-d774-4ecd-8ac0-00dca64a153f",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/20f01bb1-d774-4ecd-8ac0-00dca64a153f",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert class
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "class"
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
    name: "Ticket for Musical Improv 201",
    status: "available",
    description: "Ticket for Musical Improv 201",
    price: 21000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-10T21:07:26.636Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Musical Improv 201 ==========="
Logger.info "=========== BEGIN Processing Universe Event ​Improv 301 : The Harold Openers and Group Games ==========="

Logger.info "=========== Writing Class Listing ​Improv 301 : The Harold Openers and Group Games ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv301.id,
    slug: "KLBYFQ",
    title: "​Improv 301 : The Harold Openers and Group Games",
    description: """
    <p><strong></strong><strong>Improv 301 : The Harold Openers and Group Games</strong>
</p>
<p>This course continues the Harold work started in 201. Students will delve more deeply into 'The Harold' structure.
</p>
<p>They will learn a series of 'openers' and 'group games' that will complete the Harold format. Openers are used to derive inspiration from the audience's suggestion while group games are multi person scenes that break up the traditional 2 person scenes.
</p>
<p> This is a 6 week course.
</p>
<p> This class will be held from 6:30-9:30pm on Wednesday nights from September 14th through October 19th
</p>
<p> Cost: $190
</p>
<p>  ---
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-14T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-10-19T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/ceb9c13a-f9ce-4272-bf08-82d8cb3686d6",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/ceb9c13a-f9ce-4272-bf08-82d8cb3686d6",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert class
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "class"
})
Logger.info "=========== Wrote tag ==========="

# Insert openers
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "openers"
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
    name: "Ticket for ​Improv 301 : The Harold Openers and Group Games",
    status: "available",
    description: "Ticket for ​Improv 301 : The Harold Openers and Group Games",
    price: 19000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-05T04:51:33.207Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event ​Improv 301 : The Harold Openers and Group Games ==========="
Logger.info "=========== BEGIN Processing Universe Event Musical Improv 101 ==========="

Logger.info "=========== Writing Class Listing Musical Improv 101 ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: music_improv101.id,
    slug: "DQXJ0P",
    title: "Musical Improv 101",
    description: """
    <p><strong>This is what you've been waiting for! The Push Comedy Theater brings you MUSICAL IMPROV!!!</strong>
</p>
<p>This course offers an introduction to long form musical improvisation. We will cover the basics of how to work with music while learning how to create two person musical numbers, placing them together to create a 15 minute thematic musical show.
</p>
<p>Additional focus will be on sound exploration, movement, stylization, and accessing voice. Prepare to challenge yourself while having a ton of fun! This course culminates with a graduation show.
</p>
<p>Prerequisites: Improv 101
</p>
<p>This course is 6 weeks long
</p>
<p>Cost $210
</p>
<p><strong>This class is held on Saturday afternoons, 3pm-6pm, January 14th through February 18th</strong>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-01-14T15:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-02-18T18:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/39722bd0-a407-476b-bda8-7acd99aed238",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/39722bd0-a407-476b-bda8-7acd99aed238",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert class
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "class"
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
    name: "Ticket for Musical Improv 101",
    status: "available",
    description: "Ticket for Musical Improv 101",
    price: 21000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-12-23T06:29:07.312Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Musical Improv 101 ==========="
Logger.info "=========== BEGIN Processing Universe Event Improv for Teens at the Push Comedy Theater ==========="

Logger.info "=========== Writing Class Listing Improv for Teens at the Push Comedy Theater ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: teen_improv.id,
    slug: "4BLX1G",
    title: "Improv for Teens at the Push Comedy Theater",
    description: """
    <p>Jump head first into the wonderful worlds of sketch and improv comedy. This class is open to teens from the ages of 13 to 18.
</p>
<p>Absolutely no experience is needed.
</p>
<p>Students will explore the key tools behind both long and short form improvisation. We will play numerous games to help you sharpen your mind.
</p>
<p>We strive to create a safe, non-judgmental environment where teens can build confidence, make friends and most importantly... have fun.
</p>
<p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.
</p>
<p>Prerequisites: none
</p>
<p>This class will be held from 1pm-3pm on Saturday afternoons from September 24th through October 29th.
</p>
<p>This is class is $150 for new students and $140 for returning students.
</p>
<p>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For more than ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
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
    start_at:  NaiveDateTime.from_iso8601!("2016-09-24T13:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-10-29T15:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/02e47add-c2da-4f40-a319-78867643f4b6",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/02e47add-c2da-4f40-a319-78867643f4b6",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert class
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "class"
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
    name: "Ticket for Improv for Teens at the Push Comedy Theater",
    status: "available",
    description: "Ticket for Improv for Teens at the Push Comedy Theater",
    price: 15000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-09-13T23:15:27.198Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Improv for Teens at the Push Comedy Theater ==========="
Logger.info "=========== BEGIN Processing Universe Event Improv 101 with Brad McMurran ==========="

Logger.info "=========== Writing Class Listing Improv 101 with Brad McMurran ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv101.id,
    slug: "TDRB31",
    title: "Improv 101 with Brad McMurran",
    description: """
    <p><strong>Jump into the wonderful and wild world of improv comedy!!!</strong>
</p>
<p><br>Learn the beginnings of Chicago-based, long form improv. Students will learn how to create scenes based off of audience suggestions. They will learn the fundamentals of 'Yes, And,' how to support scene partners' ideas and energy, and how to make strong character choices.
</p>
<p>Absolutely no experience in acting or comedy is needed. The Push Comedy Theater strives to create a fun, safe and supportive experience for all students.
</p>
<p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.
</p>
<p>This class is 6 weeks long and is held on Tuesday evenings from 6:30pm to 9:30pm. September 13th through October 18th.
</p>
<p>Cost: $190
</p>
<p><br>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-13T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-10-18T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/988155d3-5ef5-494c-a005-0fabeb97240d",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/988155d3-5ef5-494c-a005-0fabeb97240d",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert class
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "class"
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
    name: "Ticket for Improv 101 with Brad McMurran",
    status: "available",
    description: "Ticket for Improv 101 with Brad McMurran",
    price: 19000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-26T15:04:49.048Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Improv 101 with Brad McMurran ==========="
