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
Logger.info "=========== BEGIN Processing Universe Event Musical Improv 101 ==========="

Logger.info "=========== Writing Class Listing Musical Improv 101 ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: music_improv101.id,
    slug: "ZGNK5R",
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
<p><strong>This class is held on Saturday afternoons, 11am-2pm, July 29th through September 9th.</strong>
</p>
<p><strong>***There will be no class on Labor Day Weekend***</strong>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-07-29T11:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-09T14:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/23e6339b-5e4c-4e6b-9a88-98524c89699d",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/23e6339b-5e4c-4e6b-9a88-98524c89699d",
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-11T21:54:53.236Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Musical Improv 101 ==========="
Logger.info "=========== BEGIN Processing Universe Event Sketch Comedy Writing 101 ==========="

Logger.info "=========== Writing Class Listing Sketch Comedy Writing 101 ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: sketch101.id,
    slug: "82H6KN",
    title: "Sketch Comedy Writing 101",
    description: """
    <p>Sketch Comedy Writing 101</p><p>Dive head first into the wonderful world of sketch comedy! Whether you're a seasoned writer or someone who rarely picks up a pen, this class will teach how to get the funny ideas out of your head and onto the page. </p><p>In this class we will examine the various types of sketches, learn how to generate funny ideas and then turn them into a sketches ready for the stage. </p><p>This class is open to everyone, no writing or comedy experience is ready.</p><p>At the end of the session, students sketches will appear in their own SNL-style show</p><p>Prerequisites: none <br>Cost: $190 </p><p>This class will be held on Thursday nights from 6:30-9:30 pm, June 30th thru August 4th at the Push Comedy Theater.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-30T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-04T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-06-01T02:47:22.094Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Sketch Comedy Writing 101 ==========="
Logger.info "=========== BEGIN Processing Universe Event Improv 101 with Brad McMurran ==========="

Logger.info "=========== Writing Class Listing Improv 101 with Brad McMurran ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv101.id,
    slug: "XSJ9W3",
    title: "Improv 101 with Brad McMurran",
    description: """
    <p><b style="background-color: initial;">Jump into the wonderful and wild world of improv comedy!!!</b></p><p><br>Learn the beginnings of Chicago-based, long form improv. Students will learn how to create scenes based off of audience suggestions. They will learn the fundamentals of 'Yes, And,' how to support scene partners' ideas and energy, and how to make strong character choices. </p><p>Absolutely no experience in acting or comedy is needed. The Push Comedy Theater strives to create a fun, safe and supportive experience for all students.</p><p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.</p><p>This class is 6 weeks long and is held on Tuesday evenings from 6:30pm to 9:30pm. June 28th through August 2nd.</p><p>Cost: $190</p><p><br>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-28T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-02T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-18T16:38:47.671Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Improv 101 with Brad McMurran ==========="
Logger.info "=========== BEGIN Processing Universe Event ​Improv 401: Advanced Harold ==========="

Logger.info "=========== Writing Class Listing ​Improv 401: Advanced Harold ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv401.id,
    slug: "PYLGMD",
    title: "​Improv 401: Advanced Harold",
    description: """
    <p style="text-align: center;"><strong></strong><strong>Improv 401: Advanced Harold</strong></p><p style="text-align: center;">Now we put it all together. Students will combine the skills learned in the previous courses for an in depth study of The Harold. This course will delve deeper into the form, focusing on editing scenes, individual and group commitment, as well as the components of 2-person, 3-person, and group scenes.</p><p style="text-align: center;">At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.</p><p style="text-align: center;">Prerequisites: Improv 301 </p><p style="text-align: center;">Improv 401: Advanced Harold is a 6 week course, held Monday nights from November 16th thru December 21st.</p><p style="text-align: center;">The price of this course is $190.</p><p style="text-align: center;"><img src="https://s3.amazonaws.com/uniiverse_production/attachments/095e9589f4f6167ad0eb60b22a8f4825-401.png" alt="" style="display: block; margin: auto;"></p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-11-16T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-12-21T22:00:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-03T04:19:16.323Z")
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
    slug: "8WNSBH",
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
<p>This class meets six times from 6:30pm-9:30pm on Tuesday nights from November 28th through December 26th.
</p>
<p>Cost: $190
</p>
<p><br>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-11-28T18:30:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-12-26T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-05T05:07:12.175Z")
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
    slug: "M4JV2N",
    title: "KidProv at the Push Comedy Theater",
    description: """
    <p>Don't miss out on the fun!!! Sign up your kids, grand kids, nieces, nephews, even the stinky neighbor kid from down the street for <strong>KidProv at the Push Comedy Theater</strong>.
</p>
<p>This class is open to children ages 7 to 12. Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public-speaking, social and team-building skills.
</p>
<p>This class will be conducted in a non-judgmental environment where the students will build confidence, make friends and most importantly ... have fun
</p>
<p>The session concludes with the students performing in a graduation show on the Push Comedy Theater Stage.
</p>
<p><strong>This class will be held from 1:00pm-3:00pm on Sunday afternoons September 25th, October 2nd, October 9th, October 16th, October 23rd and October 30th, with a graduation show on the Push Theater stage October 30th at 3:30pm</strong>
</p>
<p>This is class is<strong> $150 </strong>for new students and <strong>$140</strong> for returning students.
</p>
<p> <strong>New students also receive a free tshirt</strong>.
</p>
<p>---
</p>
<p>Mary and Jim Veverka collectively have over eight years experience studying and performing improv. Mary, a former children's librarian, has been a professional storyteller for 20+ years. During that time, Jim assisted Mary by playing a variety of characters at holiday events. Prior to moving to the Hampton Roads area, Mary was selected as an adjudicated artist by the Indiana Arts Commission. Mary has also taught storytelling to adults and children of all ages at schools, libraries and other venues.
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
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-01-10T13:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-02-14T15:00:00.000-05:00")
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
    name: "Ticket for KidProv at the Push Comedy Theater",
    status: "available",
    description: "Ticket for KidProv at the Push Comedy Theater",
    price: 14000,
    sale_start:  NaiveDateTime.from_iso8601!("2015-10-30T03:30:26.714Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event KidProv at the Push Comedy Theater ==========="
Logger.info "=========== BEGIN Processing Universe Event Improv 501: Improv Studio ==========="

Logger.info "=========== Writing Class Listing Improv 501: Improv Studio ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv501.id,
    slug: "564TC8",
    title: "Improv 501: Improv Studio",
    description: """
    <p>This course focuses on giving students individual attention to their strengths and weaknesses. We will also break down the different components of improv scenes and the choices that improvisers have and make within those scenes.
</p>
<p>This course will focus primarily on giving the students a deeper understanding of the Harold.
</p>
<p>Improv 501 is a 6 week course.<br>Thursdays, 6:30pm, September 15th thru October 20th
</p>
<p><strong><br></strong>
</p>
<p><strong>This course is limited to 16 students.</strong>
</p>
<p><br>Prerequisites: Improv 401 <br>Cost: $190
</p>
<p><strong></strong>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-15T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-10-20T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-05T04:42:16.396Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Improv 501: Improv Studio ==========="
Logger.info "=========== BEGIN Processing Universe Event ​Improv 201 at the Push Comedy Theater ==========="

Logger.info "=========== Writing Class Listing ​Improv 201 at the Push Comedy Theater ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv201.id,
    slug: "4DPJ7R",
    title: "​Improv 201 at the Push Comedy Theater",
    description: """
    <p><strong></strong><strong>Improv 201 at the Push Comedy Theater</strong></p><p>This course builds upon the fundamentals and skills learned in 101. Students will learn the beginnings 'The Harold' a long form improvisation structure developed by Del Close. They will learn how to identify the 'game' of a scene and how to heighten these games to develop 'second beats'.</p><p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.</p><p>This is a 6 week class.<br>Cost $190</p><p><strong>Sessions will be held from 6:30 - 9:30pm on Wednesday nights from January 20th thru February 24th.</strong> </p><p><br>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-01-20T18:30:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-02-24T21:30:00.000-05:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2015-12-19T23:29:35.042Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event ​Improv 201 at the Push Comedy Theater ==========="
Logger.info "=========== BEGIN Processing Universe Event Musical Improv 201 ==========="

Logger.info "=========== Writing Class Listing Musical Improv 201 ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: improv201.id,
    slug: "HC9563",
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
<p>This class is held on Saturday afternoons, 3pm-6pm, July 29th through September 9th.
</p>
<p><strong>***There will be no class on Labor Day Weekend***</strong>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-07-29T15:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-09T18:00:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-14T02:16:09.577Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Musical Improv 201 ==========="
Logger.info "=========== BEGIN Processing Universe Event Improv for Teens at the Push Comedy Theater ==========="

Logger.info "=========== Writing Class Listing Improv for Teens at the Push Comedy Theater ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: teen_improv.id,
    slug: "W15SH2",
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
<p><strong>This class will be held from 1pm-3pm on Saturday afternoons from September 30th through November 4th. </strong>
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
    start_at:  NaiveDateTime.from_iso8601!("2017-09-30T13:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-04T15:00:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-13T18:19:21.088Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Improv for Teens at the Push Comedy Theater ==========="
