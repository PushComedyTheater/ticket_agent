require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding camps"
Logger.info "=========== BEGIN Processing Universe Event Teen Improv and Sketch Comedy Summer Camp ==========="

Logger.info "=========== Writing Event Teen Improv and Sketch Comedy Summer Camp ==========="
event = SeedHelpers.create_event(
  %{
    slug: "Y10DLV",
    title: "Teen Improv and Sketch Comedy Summer Camp",
    description: """
    <p><strong>Jump head first into the wonderful world of improv and sketch comedy. This camp is open to teens from the age of 13 to 18, and absolutely no experience is needed.</strong>
</p>
<p>Students will explore the key tools behind both long and short form improvisation. We will play numerous improv games which will help to sharpen your mind and strengthen your public-speaking, social and team-building skills.
</p>
<p>Students will also explore the fundamentals of creating a written and rehearsed sketch comedy show!
</p>
<p>We strive to create a safe, non-judgmental environment where teens can build confidence, make friends, and most importantly ... have fun.
</p>
<p>At the end of camp, all students will take part in a graduation show on the Push Comedy Theater stage on July 22nd at 6pm.
</p>
<p>Students will also be eligible to perform in the 5th Annual Norfolk Comedy Festival in September 2017.
</p>
<p><strong>The Teen Improv and Sketch Comedy Summer Camp will be July 17th through 21st from 10am to 2pm.</strong>
</p>
<p>Tutition: $300
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Teen Improv and Sketch Comedy Summer Camp ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "Y10DLV",
    title: "Teen Improv and Sketch Comedy Summer Camp",
    description: """
    <p><strong>Jump head first into the wonderful world of improv and sketch comedy. This camp is open to teens from the age of 13 to 18, and absolutely no experience is needed.</strong>
</p>
<p>Students will explore the key tools behind both long and short form improvisation. We will play numerous improv games which will help to sharpen your mind and strengthen your public-speaking, social and team-building skills.
</p>
<p>Students will also explore the fundamentals of creating a written and rehearsed sketch comedy show!
</p>
<p>We strive to create a safe, non-judgmental environment where teens can build confidence, make friends, and most importantly ... have fun.
</p>
<p>At the end of camp, all students will take part in a graduation show on the Push Comedy Theater stage on July 22nd at 6pm.
</p>
<p>Students will also be eligible to perform in the 5th Annual Norfolk Comedy Festival in September 2017.
</p>
<p><strong>The Teen Improv and Sketch Comedy Summer Camp will be July 17th through 21st from 10am to 2pm.</strong>
</p>
<p>Tutition: $300
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-07-17T10:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-21T14:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/247dfa5c-424f-4af3-bc04-bb54efc000f2",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/247dfa5c-424f-4af3-bc04-bb54efc000f2",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert workshop
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "workshop"
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

# Insert camp
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "camp"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Teen Improv and Sketch Comedy Summer Camp",
    status: "available",
    description: "Ticket for Teen Improv and Sketch Comedy Summer Camp",
    price: 30000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-28T18:26:09.463Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Teen Improv and Sketch Comedy Summer Camp ==========="
Logger.info "=========== BEGIN Processing Universe Event Pre-Teen Improv Camp (session 2) ==========="

Logger.info "=========== Writing Event Pre-Teen Improv Camp (session 2) ==========="
event = SeedHelpers.create_event(
  %{
    slug: "VQ9B5S",
    title: "Pre-Teen Improv Camp (session 2)",
    description: """
    <p><strong>Pre-Teen Improv Summer Camp (session 2)</strong>
</p>
<p>This camp is open to children ages 7 to 12.
</p>
<p>Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public speaking, social, and team-building skills.
</p>
<p>The camp is conducted in a non-judgmental environment where the students build confidence, make friends, and most importantly… have fun.
</p>
<p><strong>Camp runs from 9:00 AM - 4:00 PM, Monday through Friday, with graduation performances at 4:00 PM on Friday afternoon.</strong>
</p>
<p>Each student will receive a "Pullers/Push Comedy" t-shirt that they (will keep and) wear at the graduation show.
</p>
<p>Snacks and beverages will be provided every day during the morning and afternoon breaks, but from Monday through Thursday, children should bring their own lunches. The theater will provide lunch at a pizza party on Friday.
</p>
<p>These are all beginner level sessions, no experience is necessary.
</p>
<p><strong>Registration </strong><strong>is $350 per student.</strong>
</p>
<p><strong><br></strong>
</p>
<p><strong>Pre-Teen Improv Camp (session 1)</strong>
</p>
<p>June 26th thru 30th, 9am to 4pm
</p>
<p>Graduation Show - June 30th at 4pm
</p>
<p><br>
</p>
<p><strong>Pre-Teen Improv Camp (session 2)</strong>
</p>
<p>July 24th thru 28th, 9am to 4pm
</p>
<p>Graduation Show - July 28th at 4pm
</p>
<p><br>
</p>
<p><strong>Summer Camps are limited to 20 students.</strong>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Pre-Teen Improv Camp (session 2) ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "VQ9B5S",
    title: "Pre-Teen Improv Camp (session 2)",
    description: """
    <p><strong>Pre-Teen Improv Summer Camp (session 2)</strong>
</p>
<p>This camp is open to children ages 7 to 12.
</p>
<p>Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public speaking, social, and team-building skills.
</p>
<p>The camp is conducted in a non-judgmental environment where the students build confidence, make friends, and most importantly… have fun.
</p>
<p><strong>Camp runs from 9:00 AM - 4:00 PM, Monday through Friday, with graduation performances at 4:00 PM on Friday afternoon.</strong>
</p>
<p>Each student will receive a "Pullers/Push Comedy" t-shirt that they (will keep and) wear at the graduation show.
</p>
<p>Snacks and beverages will be provided every day during the morning and afternoon breaks, but from Monday through Thursday, children should bring their own lunches. The theater will provide lunch at a pizza party on Friday.
</p>
<p>These are all beginner level sessions, no experience is necessary.
</p>
<p><strong>Registration </strong><strong>is $350 per student.</strong>
</p>
<p><strong><br></strong>
</p>
<p><strong>Pre-Teen Improv Camp (session 1)</strong>
</p>
<p>June 26th thru 30th, 9am to 4pm
</p>
<p>Graduation Show - June 30th at 4pm
</p>
<p><br>
</p>
<p><strong>Pre-Teen Improv Camp (session 2)</strong>
</p>
<p>July 24th thru 28th, 9am to 4pm
</p>
<p>Graduation Show - July 28th at 4pm
</p>
<p><br>
</p>
<p><strong>Summer Camps are limited to 20 students.</strong>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-07-24T09:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-28T16:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bc026387-0fc7-4a5b-85ca-df84c16c9689",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bc026387-0fc7-4a5b-85ca-df84c16c9689",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert workshop
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "workshop"
})
Logger.info "=========== Wrote tag ==========="

# Insert session
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "session"
})
Logger.info "=========== Wrote tag ==========="

# Insert teen
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "teen"
})
Logger.info "=========== Wrote tag ==========="

# Insert 4pm
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "4pm"
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

# Insert camp
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "camp"
})
Logger.info "=========== Wrote tag ==========="

# Insert graduation
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "graduation"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Pre-Teen Improv Camp (session 2)",
    status: "available",
    description: "Ticket for Pre-Teen Improv Camp (session 2)",
    price: 32500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-02T00:23:30.509Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Pre-Teen Improv Camp (session 2) ==========="
Logger.info "=========== BEGIN Processing Universe Event Pre-Teen Improv Camp (session 1) ==========="

Logger.info "=========== Writing Event Pre-Teen Improv Camp (session 1) ==========="
event = SeedHelpers.create_event(
  %{
    slug: "D4PT16",
    title: "Pre-Teen Improv Camp (session 1)",
    description: """
    <p><strong>Pre-Teen Improv Summer Camp (session 1)</strong>
</p>
<p>This camp is open to children ages 7 to 12.
</p>
<p>Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public speaking, social, and team-building skills.
</p>
<p>The camp is conducted in a non-judgmental environment where the students build confidence, make friends, and most importantly… have fun.
</p>
<p><strong>Camp runs from 9:00 AM - 4:00 PM, Monday through Friday, with graduation performances at 4:00 PM on Friday afternoon.</strong>
</p>
<p>Each student will receive a "Pullers/Push Comedy" t-shirt that they (will keep and) wear at the graduation show.
</p>
<p>Snacks and beverages will be provided every day during the morning and afternoon breaks, but from Monday through Thursday, children should bring their own lunches. The theater will provide lunch at a pizza party on Friday.
</p>
<p>These are all beginner level sessions, no experience is necessary.
</p>
<p><strong>"Early bird" registration is $325 on or before May 15th.  </strong>
</p>
<p><strong>Afterward, the tuition is $350 per student.</strong>
</p>
<p><strong><br></strong>
</p>
<p><strong>Pre-Teen Improv Camp (session 1)</strong>
</p>
<p>June 26th thru 30th, 9am to 4pm
</p>
<p>Graduation Show - June 30th at 4pm
</p>
<p><br>
</p>
<p><strong>Pre-Teen Improv Camp (session 2)</strong>
</p>
<p>July 24th thru 28th, 9am to 4pm
</p>
<p>Graduation Show - July 28th at 4pm
</p>
<p><br>
</p>
<p><strong>Summer Camps are limited to 20 students.</strong>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Pre-Teen Improv Camp (session 1) ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "D4PT16",
    title: "Pre-Teen Improv Camp (session 1)",
    description: """
    <p><strong>Pre-Teen Improv Summer Camp (session 1)</strong>
</p>
<p>This camp is open to children ages 7 to 12.
</p>
<p>Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public speaking, social, and team-building skills.
</p>
<p>The camp is conducted in a non-judgmental environment where the students build confidence, make friends, and most importantly… have fun.
</p>
<p><strong>Camp runs from 9:00 AM - 4:00 PM, Monday through Friday, with graduation performances at 4:00 PM on Friday afternoon.</strong>
</p>
<p>Each student will receive a "Pullers/Push Comedy" t-shirt that they (will keep and) wear at the graduation show.
</p>
<p>Snacks and beverages will be provided every day during the morning and afternoon breaks, but from Monday through Thursday, children should bring their own lunches. The theater will provide lunch at a pizza party on Friday.
</p>
<p>These are all beginner level sessions, no experience is necessary.
</p>
<p><strong>"Early bird" registration is $325 on or before May 15th.  </strong>
</p>
<p><strong>Afterward, the tuition is $350 per student.</strong>
</p>
<p><strong><br></strong>
</p>
<p><strong>Pre-Teen Improv Camp (session 1)</strong>
</p>
<p>June 26th thru 30th, 9am to 4pm
</p>
<p>Graduation Show - June 30th at 4pm
</p>
<p><br>
</p>
<p><strong>Pre-Teen Improv Camp (session 2)</strong>
</p>
<p>July 24th thru 28th, 9am to 4pm
</p>
<p>Graduation Show - July 28th at 4pm
</p>
<p><br>
</p>
<p><strong>Summer Camps are limited to 20 students.</strong>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-06-26T09:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-06-30T16:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bc026387-0fc7-4a5b-85ca-df84c16c9689",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bc026387-0fc7-4a5b-85ca-df84c16c9689",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert workshop
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "workshop"
})
Logger.info "=========== Wrote tag ==========="

# Insert session
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "session"
})
Logger.info "=========== Wrote tag ==========="

# Insert teen
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "teen"
})
Logger.info "=========== Wrote tag ==========="

# Insert 4pm
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "4pm"
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

# Insert camp
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "camp"
})
Logger.info "=========== Wrote tag ==========="

# Insert graduation
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "graduation"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Pre-Teen Improv Camp (session 1)",
    status: "available",
    description: "Ticket for Pre-Teen Improv Camp (session 1)",
    price: 32500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-02T00:16:23.553Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Pre-Teen Improv Camp (session 1) ==========="
Logger.info "=========== BEGIN Processing Universe Event Teen Improv Camp ==========="

Logger.info "=========== Writing Event Teen Improv Camp ==========="
event = SeedHelpers.create_event(
  %{
    slug: "5FTZV0",
    title: "Teen Improv Camp",
    description: """
    <p><strong>Jump head first into the wonderful world of improv comedy. </strong></p><p>This camp is open to teens from the age of 13 to 18, and absolutely no experience is needed. Students will explore the key tools behind both long and short form improvisation. </p><p>We will play numerous improv games which will help to sharpen your mind and strengthen your public-speaking, social and team-building skills. </p><p>We strive to create a safe, non-judgmental environment where teens can build confidence, make friends, and most importantly ... have fun.</p><p>At the end of camp, all students will take part in a graduation show on the Push Comedy Theater stage.</p><p>Students will also be eligible to perform in the 5th Annual Norfolk Comedy Festival in late September 2016.</p><p><strong><br>The Teen Improv Summer Camp will be July 11 thru 15 from 1pm to 3pm.</strong></p><p>Tutition: $200</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Teen Improv Camp ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "5FTZV0",
    title: "Teen Improv Camp",
    description: """
    <p><strong>Jump head first into the wonderful world of improv comedy. </strong></p><p>This camp is open to teens from the age of 13 to 18, and absolutely no experience is needed. Students will explore the key tools behind both long and short form improvisation. </p><p>We will play numerous improv games which will help to sharpen your mind and strengthen your public-speaking, social and team-building skills. </p><p>We strive to create a safe, non-judgmental environment where teens can build confidence, make friends, and most importantly ... have fun.</p><p>At the end of camp, all students will take part in a graduation show on the Push Comedy Theater stage.</p><p>Students will also be eligible to perform in the 5th Annual Norfolk Comedy Festival in late September 2016.</p><p><strong><br>The Teen Improv Summer Camp will be July 11 thru 15 from 1pm to 3pm.</strong></p><p>Tutition: $200</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-07-11T13:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-15T15:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/247dfa5c-424f-4af3-bc04-bb54efc000f2",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/247dfa5c-424f-4af3-bc04-bb54efc000f2",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert workshop
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "workshop"
})
Logger.info "=========== Wrote tag ==========="

# Insert students
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "students"
})
Logger.info "=========== Wrote tag ==========="

# Insert camp
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "camp"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Teen Improv Camp",
    status: "available",
    description: "Ticket for Teen Improv Camp",
    price: 20000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-05T17:28:40.035Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Teen Improv Camp ==========="
Logger.info "=========== BEGIN Processing Universe Event Pre-teen Improvisation Comedy Camp ==========="

Logger.info "=========== Writing Event Pre-teen Improvisation Comedy Camp ==========="
event = SeedHelpers.create_event(
  %{
    slug: "2V5BQ6",
    title: "Pre-teen Improvisation Comedy Camp",
    description: """
    <p>This camp is open to children ages 7 to 12.  </p><p> Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public-speaking, social, and team-building skills. </p><p> <br>This camp will be conducted in a non-judgmental environment where the students will build confidence, make friends, and most importantly… have fun. Snacks will be provided on a daily basis and there will be a pizza-party for lunch on Friday.   The camp concludes on Saturday with all students performing in a graduation show on the stage of the Push Comedy Theater. </p><p> <br> Each student will receive a Push Comedy Theater T-shirt and be eligible to perform in the 5th Annual Norfolk Comedy Festival in late September 2016. </p><p> <br>   We will have 3 sessions throughout the summer. </p><p><strong>Session1:</strong> July 11th - 15th, 9:30am to noon  <br>  <strong>Session 2:</strong> August 1st - 5th, 9:30 to noon </p><p>  <strong>Session 3:</strong> August 22nd - 26th, 9:30 to noon </p><p> <br>  These are all beginner level sessions, no experience is necessary.    Tuition is $200 for new students (includes a t-shirt), $190 for returning students.                    
</p><p><strong></strong></p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Pre-teen Improvisation Comedy Camp ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "2V5BQ6",
    title: "Pre-teen Improvisation Comedy Camp",
    description: """
    <p>This camp is open to children ages 7 to 12.  </p><p> Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public-speaking, social, and team-building skills. </p><p> <br>This camp will be conducted in a non-judgmental environment where the students will build confidence, make friends, and most importantly… have fun. Snacks will be provided on a daily basis and there will be a pizza-party for lunch on Friday.   The camp concludes on Saturday with all students performing in a graduation show on the stage of the Push Comedy Theater. </p><p> <br> Each student will receive a Push Comedy Theater T-shirt and be eligible to perform in the 5th Annual Norfolk Comedy Festival in late September 2016. </p><p> <br>   We will have 3 sessions throughout the summer. </p><p><strong>Session1:</strong> July 11th - 15th, 9:30am to noon  <br>  <strong>Session 2:</strong> August 1st - 5th, 9:30 to noon </p><p>  <strong>Session 3:</strong> August 22nd - 26th, 9:30 to noon </p><p> <br>  These are all beginner level sessions, no experience is necessary.    Tuition is $200 for new students (includes a t-shirt), $190 for returning students.                    
</p><p><strong></strong></p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-07-11T09:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-15T12:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/a826e5c0-fa1e-4bc1-89f9-7059e3cc4876",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/a826e5c0-fa1e-4bc1-89f9-7059e3cc4876",
  type: "cover"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert workshop
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "workshop"
})
Logger.info "=========== Wrote tag ==========="

# Insert students
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "students"
})
Logger.info "=========== Wrote tag ==========="

# Insert camp
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "camp"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Pre-teen Improvisation Comedy Camp",
    status: "available",
    description: "Ticket for Pre-teen Improvisation Comedy Camp",
    price: 20000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-05T17:04:54.625Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Pre-teen Improvisation Comedy Camp ==========="
