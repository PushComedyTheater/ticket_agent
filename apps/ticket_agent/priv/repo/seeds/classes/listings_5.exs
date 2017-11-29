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
Logger.info "=========== BEGIN Processing Universe Event Stand-Up Comedy 101 with Jason Kypros ==========="

Logger.info "=========== Writing Class Listing Stand-Up Comedy 101 with Jason Kypros ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv301.id,
    slug: "R1F9N8",
    title: "Stand-Up Comedy 101 with Jason Kypros",
    description: """
    <p>Learn how to perform stand-up comedy!</p><p><strong>Stand-Up Comedy 101 </strong>class will teach you the basics of writing jokes and performing onstage in front of a live audience. Classes will concentrate on writing your own material, learning standup etiquette, and developing a stage presence.</p><p><b style="background-color: initial;">Stand-Up Comedy 101 with Jason Kypros</b></p><p>The class will be a 6 week course ending with a graduation show at the 90 seat Push Comedy Theater. </p><p>Class will be held Sundays from 3pm to 6pm, November 22nd  through December 20th (there will also be one Saturday class on December 19th).</p><p><strong>This class is taught by local comedian Jason Kypros</strong><br>Jason Kypros has been perfoming StandUp for 13 years. He began his comedy journey in Los Angeles where he also studied with the Groundlings. <br>Jason has seen it all; From open mics, to road gigs to the stage of the LA and DC Improvs. </p><p>There is more to being a Stand Up comedian than just being funny and Jason is ready to share his knowledge and experience on that subject. <br>Jason is a working actor with Film, TV, Stage and Commercial credits and currently he is the Spokesperson for the VA Lottery playing the role of the Game Guy.</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/a1f6280febbc2e0b35fcc4d339c379e3-kypros.jpg"></p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-11-22T15:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-12-20T18:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/f49f056a-dec3-4fd8-8775-933d2d42268d",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/f49f056a-dec3-4fd8-8775-933d2d42268d",
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
    name: "Ticket for Stand-Up Comedy 101 with Jason Kypros",
    status: "available",
    description: "Ticket for Stand-Up Comedy 101 with Jason Kypros",
    price: 19000,
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-06T23:02:34.355Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Stand-Up Comedy 101 with Jason Kypros ==========="
Logger.info "=========== BEGIN Processing Universe Event Improv 101 with Brad McMurran ==========="

Logger.info "=========== Writing Class Listing Improv 101 with Brad McMurran ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv101.id,
    slug: "W6FL85",
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
<p>This class meets from 6:30pm-9:30pm on Tuesday nights from March 14th through April 18th.
</p>
<p>Cost: $190
</p>
<p><br>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-03-14T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-04-18T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-02-10T19:40:55.964Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Improv 101 with Brad McMurran ==========="
Logger.info "=========== BEGIN Processing Universe Event Improv Studio: Lunchbreak Workshop ==========="

Logger.info "=========== Writing Class Listing Improv Studio: Lunchbreak Workshop ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv_studio.id,
    slug: "59BPXZ",
    title: "Improv Studio: Lunchbreak Workshop",
    description: """
    <p>This is a special 4 week workshop that will be held Wendesdays from noon to 3pm.</p><p>This will be an intensive class open to those who have completed Improv 201.</p><p>The class will focus on the core principals of improv and students will get individual attention to their strengths and weaknesses.</p><p><strong>Improv Studio: Lunchbreak Workshop</strong></p><p><strong>Wednesdays, November 18th  through December 9th, Noon to 3pm.</strong></p><p><strong>Class price: $150</strong></p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-11-18T12:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-12-09T15:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/82f4119d-9d7d-493d-96d7-0b0162023a2e",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/82f4119d-9d7d-493d-96d7-0b0162023a2e",
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
    name: "Ticket for Improv Studio: Lunchbreak Workshop",
    status: "available",
    description: "Ticket for Improv Studio: Lunchbreak Workshop",
    price: 15000,
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-03T23:12:31.846Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Improv Studio: Lunchbreak Workshop ==========="
Logger.info "=========== BEGIN Processing Universe Event ​Improv 401: Advanced Harold ==========="

Logger.info "=========== Writing Class Listing ​Improv 401: Advanced Harold ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv401.id,
    slug: "CYLSN3",
    title: "​Improv 401: Advanced Harold",
    description: """
    <p><strong></strong><strong></strong><strong></strong><strong>Improv 401: Advanced Harold</strong>
</p>
<p><br>Now we put it all together. Students will combine the skills learned in the previous courses for an in depth study of The Harold. This course will delve deeper into the form, focusing on editing scenes, individual and group commitment, as well as the components of 2-person, 3-person, and group scenes.
</p>
<p><br><br>At the end of the session, students will take part in a graduation show on the <strong>Push Comedy Theater </strong>stage.
</p>
<p><br>Prerequisites: Improv 301
</p>
<p><br><strong>Improv 401: Advanced Harold is a 6 week course.<br>Wednesday nights from June 29th thru April 3rd, 6:30pm to 9:30pm.</strong>
</p>
<p><br><br>The price of this course is $190.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-29T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-03T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bfd1f02d-be2f-443f-80a7-daad5f820060",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bfd1f02d-be2f-443f-80a7-daad5f820060",
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
    name: "Ticket for ​Improv 401: Advanced Harold",
    status: "available",
    description: "Ticket for ​Improv 401: Advanced Harold",
    price: 19000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-06-09T16:49:05.785Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event ​Improv 401: Advanced Harold ==========="
Logger.info "=========== BEGIN Processing Universe Event Stand-Up Comedy 101 with Hatton Jordan ==========="

Logger.info "=========== Writing Class Listing Stand-Up Comedy 101 with Hatton Jordan ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv301.id,
    slug: "RV143J",
    title: "Stand-Up Comedy 101 with Hatton Jordan",
    description: """
    <p><strong>Learn how to perform stand-up comedy!</strong>
</p>
<p>Stand-Up Comedy 101 class will teach you the basics of writing jokes and performing onstage in front of a live audience. Classes will concentrate on writing your own material, learning standup etiquette, and developing a stage presence.
</p>
<p>The class will be a 4 week course ending with a graduation show at the 90 seat Push Comedy Theater.
</p>
<p><strong>Class will be held Sundays from 3pm to 6pm,July 10th through July31st</strong>
</p>
<p><strong>Tutition is $140</strong>
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
    start_at:  NaiveDateTime.from_iso8601!("2016-07-10T15:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-31T18:00:00.000-04:00")
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
    price: 14000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-06-11T20:09:52.410Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Stand-Up Comedy 101 with Hatton Jordan ==========="
Logger.info "=========== BEGIN Processing Universe Event ​Improv 201 at the Push Comedy Theater ==========="

Logger.info "=========== Writing Class Listing ​Improv 201 at the Push Comedy Theater ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv201.id,
    slug: "Y0WVZK",
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
<p>This class is scheduled from 6:30-9:30pm on Tuesday nights from November 15th through December 13th. The 6th and final class is scheduled for Saturday December 17th from 3 to 6pm.
</p>
<p>The graduation show is scheduled for Tuesday Dec 20th at 8pm.
</p>
<p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-11-15T18:30:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-12-20T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-08T01:09:00.153Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event ​Improv 201 at the Push Comedy Theater ==========="
Logger.info "=========== BEGIN Processing Universe Event ​Improv 201 at the Push Comedy Theater ==========="

Logger.info "=========== Writing Class Listing ​Improv 201 at the Push Comedy Theater ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv201.id,
    slug: "WHDN79",
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
<p><strong>This class will be held from 6:30-9:30pm on Monday nights from November 27th through January 8th.</strong>
</p>
<p><strong>***There will be no class on Christmas Day***<br></strong>
</p>
<p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-11-27T18:30:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-08T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-14T23:04:38.502Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event ​Improv 201 at the Push Comedy Theater ==========="
Logger.info "=========== BEGIN Processing Universe Event ​Improv 401: Advanced Harold ==========="

Logger.info "=========== Writing Class Listing ​Improv 401: Advanced Harold ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv401.id,
    slug: "M3JPT1",
    title: "​Improv 401: Advanced Harold",
    description: """
    <p style="text-align: center;"><strong></strong><strong>Improv 401: Advanced Harold</strong></p><p style="text-align: center;">Now we put it all together. Students will combine the skills learned in the previous courses for an in depth study of The Harold. This course will delve deeper into the form, focusing on editing scenes, individual and group commitment, as well as the components of 2-person, 3-person, and group scenes.</p><p style="text-align: center;">At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.</p><p style="text-align: center;">Prerequisites: Improv 301 </p><p style="text-align: center;">Improv 401: Advanced Harold is a 6 week course, held Monday nights from April 6th thru May 11th.</p><p style="text-align: center;">The price of this course is $190.</p><p style="text-align: center;"><img src="https://s3.amazonaws.com/uniiverse_production/attachments/095e9589f4f6167ad0eb60b22a8f4825-401.png" alt="" style="display: block; margin: auto;"></p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-06T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-05-11T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/352f7f0d-af7f-4547-b04a-85811bcf9111",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/352f7f0d-af7f-4547-b04a-85811bcf9111",
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
    name: "Ticket for ​Improv 401: Advanced Harold",
    status: "available",
    description: "Ticket for ​Improv 401: Advanced Harold",
    price: 19000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-23T04:15:48.972Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event ​Improv 401: Advanced Harold ==========="
Logger.info "=========== BEGIN Processing Universe Event Improv 101 with Brad McMurran ==========="

Logger.info "=========== Writing Class Listing Improv 101 with Brad McMurran ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv101.id,
    slug: "SNF72G",
    title: "Improv 101 with Brad McMurran",
    description: """
    <p style="text-align: center;"><strong>***HOLIDAY SPECIAL***</strong></p><p style="text-align: center;"><strong>Sign up between now and January 1st for only $150!!!</strong></p><p style="text-align: center;"><strong>Give someone (or yourself) the gift of laughter this holiday season.  Sign them up for Improv 101 at the Push.</strong></p><p style="text-align: center;"><strong>***HOLIDAY SPECIAL***</strong></p><p style="text-align: center;"><strong><br></strong></p><p><strong></strong><strong>Jump into the wonderful and wild world of improv comedy!!!</strong></p><p>Learn the beginnings of Chicago-based, long form improv. Students will learn how to create scenes based off of audience suggestions. They will learn the fundamentals of 'Yes, And,' how to support scene partners' ideas and energy, and how to make strong character choices. </p><p>Absolutely no experience in acting or comedy is needed. The Push Comedy Theater strides to create a fun, safe and supportive experience for all students.</p><p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.</p><p><strong>This class is 6 weeks long and is held on Saturday afternoons from 6:30pm to 9:30pm. January 12 through February 16th.<br>Cost: $190</strong></p><p><br>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-01-12T18:30:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-02-16T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/981558cc-fa28-4216-8a4f-39c8e3d8488b",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/981558cc-fa28-4216-8a4f-39c8e3d8488b",
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
    price: 15000,
    sale_start:  NaiveDateTime.from_iso8601!("2015-12-12T23:30:05.802Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Improv 101 with Brad McMurran ==========="
Logger.info "=========== BEGIN Processing Universe Event KidProv at the Push Comedy Theater ==========="

Logger.info "=========== Writing Class Listing KidProv at the Push Comedy Theater ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: kidprov101.id,
    slug: "HXJ4F9",
    title: "KidProv at the Push Comedy Theater",
    description: """
    <p>Don't miss out on the fun!!! Sign up your kids, grand kids, nieces, nephews, even the stinky neighbor kid from down the street for KidProv at the Push Comedy Theater.
</p>
<p>***This class is open to children ages 7 to 9.***
</p>
<p>Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public-speaking, social and team-building skills.
</p>
<p>This class will be conducted in a non-judgmental environment where the students will build confidence, make friends and most importantly ... have fun
</p>
<p>The session concludes with the students performing in a graduation show on the Push Comedy Theater Stage.
</p>
<p>This class will be held from 10am-12pm on Saturday mornings from October 7th through November 11th.
</p>
<p>This is class is $150 for new students and $140 for returning students.
</p>
<p>New students also receive a free tshirt.
</p>
<p>---
</p>
<p>Mary and Jim Veverka collectively have over eight years experience studying and performing improv. Mary, a former children's librarian, has been a professional storyteller for 20+ years. During that time, Jim assisted Mary by playing a variety of characters at holiday events. Prior to moving to the Hampton Roads area, Mary was selected as an adjudicated artist by the Indiana Arts Commission. Mary has also taught storytelling to adults and children of all ages at schools, libraries and other venues.
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
    start_at:  NaiveDateTime.from_iso8601!("2017-10-07T10:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-11T12:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9052b361-b187-4963-aaa8-d59d95a2a381",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9052b361-b187-4963-aaa8-d59d95a2a381",
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
    name: "Ticket for KidProv at the Push Comedy Theater",
    status: "available",
    description: "Ticket for KidProv at the Push Comedy Theater",
    price: 14000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-13T17:29:27.141Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event KidProv at the Push Comedy Theater ==========="
