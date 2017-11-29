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
Logger.info "=========== BEGIN Processing Universe Event Improv 101 with Brad McMurran ==========="

Logger.info "=========== Writing Class Listing Improv 101 with Brad McMurran ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv101.id,
    slug: "QLZKC9",
    title: "Improv 101 with Brad McMurran",
    description: """
    <p><b style="background-color: initial;">Jump into the wonderful and wild world of improv comedy!!!</b></p><p><br>Learn the beginnings of Chicago-based, long form improv. Students will learn how to create scenes based off of audience suggestions. They will learn the fundamentals of 'Yes, And,' how to support scene partners' ideas and energy, and how to make strong character choices. </p><p>Absolutely no experience in acting or comedy is needed. The Push Comedy Theater strives to create a fun, safe and supportive experience for all students.</p><p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.</p><p>This class is 6 weeks long and is held on Tuesday evenings from 6:30pm to 9:30pm. March 1st through Aprtil 5th<br>Cost: $190</p><p><br>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-03-01T18:30:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-05T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-02-04T05:44:17.816Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Improv 101 with Brad McMurran ==========="
Logger.info "=========== BEGIN Processing Universe Event Improv 501: Improv Studio ==========="

Logger.info "=========== Writing Class Listing Improv 501: Improv Studio ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv501.id,
    slug: "XTPWF2",
    title: "Improv 501: Improv Studio",
    description: """
    <p><strong>***THIS COURSE WILL CAP AT 16 STUDENTS***</strong>
</p>
<p>This course focuses on giving students individual attention to their strengths and weaknesses. We will also break down the different components of improv scenes and the choices that improvisers have and make within those scenes.
</p>
<p>Improv 501 is a 6 week course.
</p>
<p>Prerequisites: Improv 401
</p>
<p>Cost: $190
</p>
<p><strong>This class will be held on Thursday nights from 6:30-9:30 pm, July 20th thru August 24th at the Push Comedy Theater.</strong>
</p>
<p>***This course is limited to 16 students***
</p>
<p><strong></strong>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-07-20T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-08-24T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/33f7dd64-a2b0-4505-acf6-056cd0fb4d72",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/33f7dd64-a2b0-4505-acf6-056cd0fb4d72",
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
    name: "Ticket for Improv 501: Improv Studio",
    status: "available",
    description: "Ticket for Improv 501: Improv Studio",
    price: 19000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-05T22:26:27.300Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Improv 501: Improv Studio ==========="
Logger.info "=========== BEGIN Processing Universe Event ​Improv 401: Advanced Harold ==========="

Logger.info "=========== Writing Class Listing ​Improv 401: Advanced Harold ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv401.id,
    slug: "1JP9BN",
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
<p><br><strong>Improv 401: Advanced Harold is a 6 week course.<br>Wednesday nights from November 16th through December 21st</strong>
</p>
<p><br><br>The price of this course is $190.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-11-16T18:30:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-12-21T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-11-04T18:34:08.274Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event ​Improv 401: Advanced Harold ==========="
Logger.info "=========== BEGIN Processing Universe Event ​Improv 301 : The Harold Openers and Group Games ==========="

Logger.info "=========== Writing Class Listing ​Improv 301 : The Harold Openers and Group Games ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv301.id,
    slug: "GPS031",
    title: "​Improv 301 : The Harold Openers and Group Games",
    description: """
    <p>***THIS COURSE WILL CAP AT 16 STUDENTS***
</p>
<p><strong></strong><strong>Improv 301 : The Harold Openers and Group Games</strong>
</p>
<p>This course continues the Harold work started in 201. Students will delve more deeply into 'The Harold' structure.
</p>
<p>They will learn a series of 'openers' and 'group games' that will complete the Harold format. Openers are used to derive inspiration from the audience's suggestion while group games are multi person scenes that break up the traditional 2 person scenes.
</p>
<p> This is a 6 week course.
</p>
<p>Cost: $190<br>
</p>
<p>This class will be held from 6:30-9:30pm on Wednesday nights from June 14th through July 19th
</p>
<p>***This course is limited to 16 students***
</p>
<p>  ---
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-06-14T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-19T21:30:00.000-04:00")
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
    name: "Ticket for ​Improv 301 : The Harold Openers and Group Games",
    status: "available",
    description: "Ticket for ​Improv 301 : The Harold Openers and Group Games",
    price: 19000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-21T17:51:31.162Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event ​Improv 301 : The Harold Openers and Group Games ==========="
Logger.info "=========== BEGIN Processing Universe Event Improv 501: Improv Studio ==========="

Logger.info "=========== Writing Class Listing Improv 501: Improv Studio ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv501.id,
    slug: "QC1PW4",
    title: "Improv 501: Improv Studio",
    description: """
    <p><strong>***THIS COURSE WILL CAP AT 16 STUDENTS***</strong>
</p>
<p>This course focuses on giving students individual attention to their strengths and weaknesses. We will also break down the different components of improv scenes and the choices that improvisers have and make within those scenes.
</p>
<p>Improv 501 is a 6 week course.
</p>
<p>Prerequisites: Improv 401
</p>
<p>Cost: $190
</p>
<p><strong>This class will be held on Thursday nights from 6:30-9:30 pm, January 12th thru March 2nd at the Push Comedy Theater. </strong>
</p>
<p><strong>There is no class January 19th and February 9th.</strong>
</p>
<p>***This course is limited to 16 students***
</p>
<p><strong></strong>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-01-12T18:30:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-02T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/33f7dd64-a2b0-4505-acf6-056cd0fb4d72",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/33f7dd64-a2b0-4505-acf6-056cd0fb4d72",
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
    name: "Ticket for Improv 501: Improv Studio",
    status: "available",
    description: "Ticket for Improv 501: Improv Studio",
    price: 19000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-12-21T21:07:06.551Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Improv 501: Improv Studio ==========="
Logger.info "=========== BEGIN Processing Universe Event Sketch Comedy Writing 101 ==========="

Logger.info "=========== Writing Class Listing Sketch Comedy Writing 101 ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: sketch101.id,
    slug: "F2Z9W1",
    title: "Sketch Comedy Writing 101",
    description: """
    <p style="text-align: center;">Unleash your inner Will Ferrell, Tina Fey and Amy Poehler!!!<br>
</p>
<p style="text-align: center;"><strong><br>Sketch Comedy Writing 101</strong>
</p>
<p style="text-align: center;"><br>Here's your chance to dive head first into the wonderful world of sketch comedy! Whether you're a seasoned writer or someone who rarely (or never) picks up a pen, this class will teach how to get the funny ideas out of your head and onto the page.
</p>
<p style="text-align: center;"><br>We will examine the various types of sketches, learn how to generate funny ideas and then turn them into sketches ready for the stage. <br><br>This class is open to everyone, no writing or comedy experience is needed.
</p>
<p style="text-align: center;">The class will consist of 4 weeks of instruction followed by 3 weeks of rehearsal.<br>At the end of the session, students sketches will appear in their own SNL-style show<br><br><strong>Prerequisites: none <br>Cost: $220 </strong><br><br>This class will be held on Tuesday nights from 6:30-9:30 pm, Starting October 3rd at the Push Comedy Theater.<br>
</p>
<p style="text-align: center;">There will be no class on October 17th and 31st
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-10-03T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-28T18:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

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
    name: "Ticket for Sketch Comedy Writing 101",
    status: "available",
    description: "Ticket for Sketch Comedy Writing 101",
    price: 22000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-13T18:13:28.707Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Sketch Comedy Writing 101 ==========="
Logger.info "=========== BEGIN Processing Universe Event Sketch Comedy Writing 101 ==========="

Logger.info "=========== Writing Class Listing Sketch Comedy Writing 101 ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: sketch101.id,
    slug: "MHF1PY",
    title: "Sketch Comedy Writing 101",
    description: """
    <p>Sketch Comedy Writing 101
</p>
<p>Dive head first into the wonderful world of sketch comedy! Whether you're a seasoned writer or someone who rarely picks up a pen, this class will teach how to get the funny ideas out of your head and onto the page.
</p>
<p>In this class we will examine the various types of sketches, learn how to generate funny ideas and then turn them into a sketches ready for the stage.
</p>
<p>This class is open to everyone, no writing or comedy experience is ready.
</p>
<p>At the end of the session, students sketches will appear in their own SNL-style show
</p>
<p>Prerequisites: none <br>Cost: $190
</p>
<p>This class will be held on Thursday nights from 6:30-9:30 pm, September 29th thru November 3rd at the Push Comedy Theater.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-29T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-11-03T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

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
    name: "Ticket for Sketch Comedy Writing 101",
    status: "available",
    description: "Ticket for Sketch Comedy Writing 101",
    price: 19000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-26T15:19:13.162Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Sketch Comedy Writing 101 ==========="
Logger.info "=========== BEGIN Processing Universe Event ​Improv 201 at the Push Comedy Theater ==========="

Logger.info "=========== Writing Class Listing ​Improv 201 at the Push Comedy Theater ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv201.id,
    slug: "V5XCQ6",
    title: "​Improv 201 at the Push Comedy Theater",
    description: """
    <p><strong></strong><strong>Improv 201 at the Push Comedy Theater</strong></p><p>This course builds upon the fundamentals and skills learned in 101. Students will learn the beginnings 'The Harold' a long form improvisation structure developed by Del Close. They will learn how to identify the 'game' of a scene and how to heighten these games to develop 'second beats'.</p><p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.</p><p>This is a 6 week class.<br>Cost $190</p><p><strong>Sessions will be held from 3 - 6pm on Sunday afternoons from March 6th thru April 10th.</strong> </p><p><br>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-03-06T15:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-10T15:00:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-02-28T23:54:51.272Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event ​Improv 201 at the Push Comedy Theater ==========="
Logger.info "=========== BEGIN Processing Universe Event Musical Improv 101 ==========="

Logger.info "=========== Writing Class Listing Musical Improv 101 ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: music_improv101.id,
    slug: "FQ6XVB",
    title: "Musical Improv 101",
    description: """
    <p><strong>This is what you've been waiting for! The Push Comedy Theater brings you MUSICAL IMPROV!!!</strong>
</p>
<p>This course offers an introduction to long form musical improvisation. We will cover the basics of how to work with music while learning how to create two person musical numbers, placing them together to create a 15 minute thematic musical show.
</p>
<p>Additional focus will be on sound exploration, movement, stylization, and accessing voice. Prepare to challenge yourself while having a ton of fun! This course culminates with a graduation show.
</p>
<p>Prerequisites: Improv 101, Improv 201
</p>
<p>This course is 6 weeks long
</p>
<p>Cost $210
</p>
<p><strong>This class is held on Saturday afternoons, 3pm-6pm, April 1st through May 6th.</strong>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-04-01T15:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-06T18:00:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-02-26T23:23:38.570Z")
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
    slug: "XL6PS9",
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
<p><strong>This class will be held from 1pm-3pm on Saturday afternoons from April 1st through May 13th.  There will be no class on April 15 due to  the Easter holiday.</strong><strong></strong>
</p>
<p>This is class is $150 for new students and $140 for returning students.
</p>
<p>--<br>
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-04-01T13:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-13T15:00:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-02-10T18:57:12.426Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Improv for Teens at the Push Comedy Theater ==========="
