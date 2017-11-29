require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding workshops"
Logger.info "=========== BEGIN Processing Universe Event Workshop: Composition/Viewpoints with Deborah Wallace ==========="

Logger.info "=========== Writing Event Workshop: Composition/Viewpoints with Deborah Wallace ==========="
event = SeedHelpers.create_event(
  %{
    slug: "X6JWL7",
    title: "Workshop: Composition/Viewpoints with Deborah Wallace",
    description: """
    <p>Composition/Viewpoints with Deborah Wallace
</p>
<p>Participants will be introduced to the principles of Composition and Viewpoints work. Participants will explore the fundamental elements of the Viewpoints of time and space focusing on building a stronger ensemble and creating movement for the stage. We will then create short compositions working from a unified theme. Participants will gain an understanding of an approach that gives performers greater agency in creating work and an ability to work quickly to achieve dynamic results. Our work will culminate in an open showing of our composition work at the end of the day followed by an open Viewpoints session for experienced practitioners.
</p>
<p>Workshop will run from 12-5PM with a 1 hour lunch break, Sunday July 30th.
</p>
<p>Workshop Price: $50<br>
</p>
<p>_______<br>
</p>
<p>Instructor: Deborah Wallace
</p>
<p>Deborah Wallace is an Emmy-nominated Producer, Director, Writer and Performer working in both film and theatre. As Co-Artistic Director of the multi award-winning International WOW Company she collaborated on the production of more than 20 works for the stage and screen including the Academy Award nominated, Emmy winning documentary film, GASLAND. Wallace produced its sequel GASLAND, Part II for HBO, for which she received an Emmy nomination. Wallace has also produced several documentary short films including: THE SKY IS PINK, and OCCUPY SANDY. Wallace recently completed the documentary film BLOOD ON THE MOUNTAIN which premiered on Netflix in May 2017 and is currently at work directing and producing the documentary features AMERICAN PSYCHE, THE BREAK-EVEN, THE LAST CLOUD FACTORY, BRAVE GIRLS and THE DAY WILL COME. In the theater, Wallace is honored to work as a performer with some of the most acclaimed artists in the world including: Anne Bogart/SITI Company (Radio Macbeth, Café Variations, The Event Of A Thread), Ann Hamilton and Richard Foreman (Astronome). Next, Wallace will perform Object Collection’s It’s All True in London. As a Director and Playwright, Wallace’s work has been presented at HERE Arts (Psyche), New Dance Group (Agnes/ Martha), Ars Nova, The Ohio Theater (Psyche, Homesick) and The Incubator Arts Project (The Void, The Red Book).
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Workshop: Composition/Viewpoints with Deborah Wallace ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "X6JWL7",
    title: "Workshop: Composition/Viewpoints with Deborah Wallace",
    description: """
    <p>Composition/Viewpoints with Deborah Wallace
</p>
<p>Participants will be introduced to the principles of Composition and Viewpoints work. Participants will explore the fundamental elements of the Viewpoints of time and space focusing on building a stronger ensemble and creating movement for the stage. We will then create short compositions working from a unified theme. Participants will gain an understanding of an approach that gives performers greater agency in creating work and an ability to work quickly to achieve dynamic results. Our work will culminate in an open showing of our composition work at the end of the day followed by an open Viewpoints session for experienced practitioners.
</p>
<p>Workshop will run from 12-5PM with a 1 hour lunch break, Sunday July 30th.
</p>
<p>Workshop Price: $50<br>
</p>
<p>_______<br>
</p>
<p>Instructor: Deborah Wallace
</p>
<p>Deborah Wallace is an Emmy-nominated Producer, Director, Writer and Performer working in both film and theatre. As Co-Artistic Director of the multi award-winning International WOW Company she collaborated on the production of more than 20 works for the stage and screen including the Academy Award nominated, Emmy winning documentary film, GASLAND. Wallace produced its sequel GASLAND, Part II for HBO, for which she received an Emmy nomination. Wallace has also produced several documentary short films including: THE SKY IS PINK, and OCCUPY SANDY. Wallace recently completed the documentary film BLOOD ON THE MOUNTAIN which premiered on Netflix in May 2017 and is currently at work directing and producing the documentary features AMERICAN PSYCHE, THE BREAK-EVEN, THE LAST CLOUD FACTORY, BRAVE GIRLS and THE DAY WILL COME. In the theater, Wallace is honored to work as a performer with some of the most acclaimed artists in the world including: Anne Bogart/SITI Company (Radio Macbeth, Café Variations, The Event Of A Thread), Ann Hamilton and Richard Foreman (Astronome). Next, Wallace will perform Object Collection’s It’s All True in London. As a Director and Playwright, Wallace’s work has been presented at HERE Arts (Psyche), New Dance Group (Agnes/ Martha), Ars Nova, The Ohio Theater (Psyche, Homesick) and The Incubator Arts Project (The Void, The Red Book).
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-07-30T12:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-30T17:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/59bb5cba-8f4f-4ec6-85c0-c58c81881a44",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/59bb5cba-8f4f-4ec6-85c0-c58c81881a44",
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

# Insert emmy
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "emmy"
})
Logger.info "=========== Wrote tag ==========="

# Insert participants
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "participants"
})
Logger.info "=========== Wrote tag ==========="

# Insert film
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "film"
})
Logger.info "=========== Wrote tag ==========="

# Insert composition
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "composition"
})
Logger.info "=========== Wrote tag ==========="

# Insert including
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "including"
})
Logger.info "=========== Wrote tag ==========="

# Insert psyche
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "psyche"
})
Logger.info "=========== Wrote tag ==========="

# Insert director
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "director"
})
Logger.info "=========== Wrote tag ==========="

# Insert documentary
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "documentary"
})
Logger.info "=========== Wrote tag ==========="

# Insert deborah
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "deborah"
})
Logger.info "=========== Wrote tag ==========="

# Insert wallace
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "wallace"
})
Logger.info "=========== Wrote tag ==========="

# Insert viewpoints
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "viewpoints"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Workshop: Composition/Viewpoints with Deborah Wallace",
    status: "available",
    description: "Ticket for Workshop: Composition/Viewpoints with Deborah Wallace",
    price: 5000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-07T15:01:06.957Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Workshop: Composition/Viewpoints with Deborah Wallace ==========="
Logger.info "=========== BEGIN Processing Universe Event Workshop: Viewpoints Intensive ==========="

Logger.info "=========== Writing Event Workshop: Viewpoints Intensive ==========="
event = SeedHelpers.create_event(
  %{
    slug: "LTPDBQ",
    title: "Workshop: Viewpoints Intensive",
    description: """
    <p>Composition/Viewpoints
</p>
<p>Participants will be introduced to the principles of Composition and Viewpoints work. Participants will explore the fundamental elements of the Viewpoints of time and space focusing on building a stronger ensemble and creating movement for the stage. We will then create short compositions working from a unified theme. Participants will gain an understanding of an approach that gives performers greater agency in creating work and an ability to work quickly to achieve dynamic results. Our work will culminate in an open showing of our composition work at the end of the day followed by an open Viewpoints session for experienced practitioners.<strong></strong>
</p>
<p>Workshop will run from 12-5PM, Sunday July 30th.
</p>
<p>Workshop Price: $50
</p>
<p>________
</p>
<p>Instructor: Deborah Wallace
</p>
<p>Deborah Wallace is an Emmy-nominated Producer, Director, Writer and Performer working in both film and theatre. As Co-Artistic Director of the multi award-winning International WOW Company she collaborated on the production of more than 20 works for the stage and screen including the Academy Award nominated, Emmy winning documentary film, GASLAND. Wallace produced its sequel GASLAND, Part II for HBO, for which she received an Emmy nomination. Wallace has also produced several documentary short films including: THE SKY IS PINK, and OCCUPY SANDY. Wallace recently completed the documentary film BLOOD ON THE MOUNTAIN which premiered on Netflix in May 2017 and is currently at work directing and producing the documentary features AMERICAN PSYCHE, THE BREAK-EVEN, THE LAST CLOUD FACTORY, BRAVE GIRLS and THE DAY WILL COME. In the theater, Wallace is honored to work as a performer with some of the most acclaimed artists in the world including: Anne Bogart/SITI Company (Radio Macbeth, Café Variations, The Event Of A Thread), Ann Hamilton and Richard Foreman (Astronome). Next, Wallace will perform Object Collection’s It’s All True in London. As a Director and Playwright, Wallace’s work has been presented at HERE Arts (Psyche), New Dance Group (Agnes/ Martha), Ars Nova, The Ohio Theater (Psyche, Homesick) and The Incubator Arts Project (The Void, The Red Book).
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Workshop: Viewpoints Intensive ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "LTPDBQ",
    title: "Workshop: Viewpoints Intensive",
    description: """
    <p>Composition/Viewpoints
</p>
<p>Participants will be introduced to the principles of Composition and Viewpoints work. Participants will explore the fundamental elements of the Viewpoints of time and space focusing on building a stronger ensemble and creating movement for the stage. We will then create short compositions working from a unified theme. Participants will gain an understanding of an approach that gives performers greater agency in creating work and an ability to work quickly to achieve dynamic results. Our work will culminate in an open showing of our composition work at the end of the day followed by an open Viewpoints session for experienced practitioners.<strong></strong>
</p>
<p>Workshop will run from 12-5PM, Sunday July 30th.
</p>
<p>Workshop Price: $50
</p>
<p>________
</p>
<p>Instructor: Deborah Wallace
</p>
<p>Deborah Wallace is an Emmy-nominated Producer, Director, Writer and Performer working in both film and theatre. As Co-Artistic Director of the multi award-winning International WOW Company she collaborated on the production of more than 20 works for the stage and screen including the Academy Award nominated, Emmy winning documentary film, GASLAND. Wallace produced its sequel GASLAND, Part II for HBO, for which she received an Emmy nomination. Wallace has also produced several documentary short films including: THE SKY IS PINK, and OCCUPY SANDY. Wallace recently completed the documentary film BLOOD ON THE MOUNTAIN which premiered on Netflix in May 2017 and is currently at work directing and producing the documentary features AMERICAN PSYCHE, THE BREAK-EVEN, THE LAST CLOUD FACTORY, BRAVE GIRLS and THE DAY WILL COME. In the theater, Wallace is honored to work as a performer with some of the most acclaimed artists in the world including: Anne Bogart/SITI Company (Radio Macbeth, Café Variations, The Event Of A Thread), Ann Hamilton and Richard Foreman (Astronome). Next, Wallace will perform Object Collection’s It’s All True in London. As a Director and Playwright, Wallace’s work has been presented at HERE Arts (Psyche), New Dance Group (Agnes/ Martha), Ars Nova, The Ohio Theater (Psyche, Homesick) and The Incubator Arts Project (The Void, The Red Book).
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-04T13:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-04T17:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/e8027781-45fe-41f0-9a20-593299228d09",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/e8027781-45fe-41f0-9a20-593299228d09",
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

# Insert emmy
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "emmy"
})
Logger.info "=========== Wrote tag ==========="

# Insert participants
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "participants"
})
Logger.info "=========== Wrote tag ==========="

# Insert film
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "film"
})
Logger.info "=========== Wrote tag ==========="

# Insert composition
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "composition"
})
Logger.info "=========== Wrote tag ==========="

# Insert including
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "including"
})
Logger.info "=========== Wrote tag ==========="

# Insert psyche
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "psyche"
})
Logger.info "=========== Wrote tag ==========="

# Insert director
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "director"
})
Logger.info "=========== Wrote tag ==========="

# Insert documentary
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "documentary"
})
Logger.info "=========== Wrote tag ==========="

# Insert wallace
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "wallace"
})
Logger.info "=========== Wrote tag ==========="

# Insert viewpoints
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "viewpoints"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Workshop: Viewpoints Intensive",
    status: "available",
    description: "Ticket for Workshop: Viewpoints Intensive",
    price: 8000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-22T03:20:18.525Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Workshop: Viewpoints Intensive ==========="
Logger.info "=========== BEGIN Processing Universe Event Workshop: Improv Workout ==========="

Logger.info "=========== Writing Event Workshop: Improv Workout ==========="
event = SeedHelpers.create_event(
  %{
    slug: "8ZNP03",
    title: "Workshop: Improv Workout",
    description: """
    <p><strong>Improv Workout with Andy Livengood</strong>
</p>
<p>Are you new to improv?  This is the workshop for you!
</p>
<p>Have you been doing improv for years? This is the workshop for you!
</p>
<p>This workshop is jam packed with tons of exercises to help you get better at improv.
</p>
<p>Topics include: listening,  justification,  hightening,  and so much more!
</p>
<p>This class will use fun exercises and personalized feedback to improv your improv, no matter your skill level.
</p>
<p>----
</p>
<p><strong>Workshop: Improv Workout with Andy Livengood</strong>
</p>
<p>Saturday, July 9th from 1 to 3pm
</p>
<p>Cost of workshop: $40
</p>
<p>----
</p>
<p><strong>Andy Livengood</strong> wandered into an improv theatre to see a friends show and became hooked for life. He is a graduate of the Theatre 99 training program (Charleston, SC) and has studied at the Upright Citizen’s Brigade Theatre (NY) and The Annoyance Theatre (Chicago).
</p>
<p>For 10 years he regularly performed at Theatre 99 with the groups CATS HUGGING CATS, Human Fireworks, and Clutch. He was voted Charleston’s Best Comic in 2010 and has written for the sketch comedy groups Maximum Brain Squad and This is Chucktown.
</p>
<p>His one man show, The Christmas will be Televised, was voted Best Play in Charleston in 2011 and has been performed in theaters all over the south east.
</p>
<p>Andy has performed and taught in theaters and festivals all over the US. He is also a big comic book nerd. (Bring up Batman in a workshop and you’ll make a friend for life)
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Workshop: Improv Workout ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "8ZNP03",
    title: "Workshop: Improv Workout",
    description: """
    <p><strong>Improv Workout with Andy Livengood</strong>
</p>
<p>Are you new to improv?  This is the workshop for you!
</p>
<p>Have you been doing improv for years? This is the workshop for you!
</p>
<p>This workshop is jam packed with tons of exercises to help you get better at improv.
</p>
<p>Topics include: listening,  justification,  hightening,  and so much more!
</p>
<p>This class will use fun exercises and personalized feedback to improv your improv, no matter your skill level.
</p>
<p>----
</p>
<p><strong>Workshop: Improv Workout with Andy Livengood</strong>
</p>
<p>Saturday, July 9th from 1 to 3pm
</p>
<p>Cost of workshop: $40
</p>
<p>----
</p>
<p><strong>Andy Livengood</strong> wandered into an improv theatre to see a friends show and became hooked for life. He is a graduate of the Theatre 99 training program (Charleston, SC) and has studied at the Upright Citizen’s Brigade Theatre (NY) and The Annoyance Theatre (Chicago).
</p>
<p>For 10 years he regularly performed at Theatre 99 with the groups CATS HUGGING CATS, Human Fireworks, and Clutch. He was voted Charleston’s Best Comic in 2010 and has written for the sketch comedy groups Maximum Brain Squad and This is Chucktown.
</p>
<p>His one man show, The Christmas will be Televised, was voted Best Play in Charleston in 2011 and has been performed in theaters all over the south east.
</p>
<p>Andy has performed and taught in theaters and festivals all over the US. He is also a big comic book nerd. (Bring up Batman in a workshop and you’ll make a friend for life)
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-07-09T13:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-09T15:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/eb4b300b-6ce7-4bd5-bd69-23a85f3ba73e",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/eb4b300b-6ce7-4bd5-bd69-23a85f3ba73e",
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

# Insert livengood
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "livengood"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Workshop: Improv Workout",
    status: "available",
    description: "Ticket for Workshop: Improv Workout",
    price: 4000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-07-01T22:39:37.639Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Workshop: Improv Workout ==========="
Logger.info "=========== BEGIN Processing Universe Event Workshop: Fear of Commitment with Andy Livengood ==========="

Logger.info "=========== Writing Event Workshop: Fear of Commitment with Andy Livengood ==========="
event = SeedHelpers.create_event(
  %{
    slug: "K1VG3C",
    title: "Workshop: Fear of Commitment with Andy Livengood",
    description: """
    <h3 style="text-align: center;">Fear of Commitment</h3>
<p style="text-align: center;">This workshop will up your commitment game in your scenes. The ability to “hit the gas” and commit to what’s going on in your scene is the skill that separates good improv from great improv. This workshop will use tons of scene work exercises and will focus on; identifying the choices we subconsciously make in improv, committing to your scenes even if you have no idea what’s going on, and finding new ways to heighten by recommitting to your choices. Oh yeah, and it will be a lot of fun!
</p>
<p style="text-align: center;"><strong>Andy Livengood</strong>
</p>
<p style="text-align: center;"><em>Andy Livengood wandered into an improv theatre to see a friend’s</em><em> show and became hooked for life. He is a graduate of the Theatre 99 training program (Charleston, SC) and has studied at the Upright Citizen’s Brigade Theatre (NY) and The Annoyance Theatre (Chicago).</em>
</p>
<p style="text-align: center;"><em>For over a decade he regularly performed and taught at Theatre 99. He was voted Charleston’s Best Comic and has written for the sketch comedy groups Maximum Brain Squad and This is Chucktown. His one man show, The Christmas will be Televised, was voted Best Play in Charleston in 2011 and has been performed in theaters all over the south east.</em>
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Andy.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Andy-1024x732.jpg" alt=""></a>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Workshop: Fear of Commitment with Andy Livengood ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "K1VG3C",
    title: "Workshop: Fear of Commitment with Andy Livengood",
    description: """
    <h3 style="text-align: center;">Fear of Commitment</h3>
<p style="text-align: center;">This workshop will up your commitment game in your scenes. The ability to “hit the gas” and commit to what’s going on in your scene is the skill that separates good improv from great improv. This workshop will use tons of scene work exercises and will focus on; identifying the choices we subconsciously make in improv, committing to your scenes even if you have no idea what’s going on, and finding new ways to heighten by recommitting to your choices. Oh yeah, and it will be a lot of fun!
</p>
<p style="text-align: center;"><strong>Andy Livengood</strong>
</p>
<p style="text-align: center;"><em>Andy Livengood wandered into an improv theatre to see a friend’s</em><em> show and became hooked for life. He is a graduate of the Theatre 99 training program (Charleston, SC) and has studied at the Upright Citizen’s Brigade Theatre (NY) and The Annoyance Theatre (Chicago).</em>
</p>
<p style="text-align: center;"><em>For over a decade he regularly performed and taught at Theatre 99. He was voted Charleston’s Best Comic and has written for the sketch comedy groups Maximum Brain Squad and This is Chucktown. His one man show, The Christmas will be Televised, was voted Best Play in Charleston in 2011 and has been performed in theaters all over the south east.</em>
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Andy.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2017/08/Andy-1024x732.jpg" alt=""></a>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-09-17T11:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-17T13:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9e091af0-bc74-49e1-ba20-d9f8e6273c4e",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9e091af0-bc74-49e1-ba20-d9f8e6273c4e",
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

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Workshop: Fear of Commitment with Andy Livengood",
    status: "available",
    description: "Ticket for Workshop: Fear of Commitment with Andy Livengood",
    price: 3500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-07T21:39:39.294Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Workshop: Fear of Commitment with Andy Livengood ==========="
Logger.info "=========== BEGIN Processing Universe Event Workshop: Tales from the Campfire ==========="

Logger.info "=========== Writing Event Workshop: Tales from the Campfire ==========="
event = SeedHelpers.create_event(
  %{
    slug: "4S3FRH",
    title: "Workshop: Tales from the Campfire",
    description: """
    <p><strong>***This Workshop is for only for students who've completed 301***</strong>
</p>
<p>I ain't afraid of no ghosts!
</p>
<p>Tales from the Campfire: The Improvised Ghost Story has quickly become one of the Push Comedy Theater' hottest new show.
</p>
<p>With a combination of cut to's and character work, it's a high energy and extremely fun form of improv.  And now you get a chance to learn it for yourself.
</p>
<p>This is a two day workshop, with a graduation show.
</p>
<p><strong>Workshop: Tales from the Campfire</strong>
</p>
<p><strong>Thursday, December 7th. 6:30pm to 9:30pm</strong>
</p>
<p><strong>Thursday, December 14th. 6:30pm to 8:30pm</strong>
</p>
<p><strong>Class Dismissed: Tales from the Campfire Graduation Show</strong>
</p>
<p><strong>Thursday, December 14th.  9pm.</strong>
</p>
<p>Tales from the Campfire has quickly become the Push's signature show.  It is the show we bring to events and festivals.  Here's your chance to join in the fun.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Workshop: Tales from the Campfire ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "4S3FRH",
    title: "Workshop: Tales from the Campfire",
    description: """
    <p><strong>***This Workshop is for only for students who've completed 301***</strong>
</p>
<p>I ain't afraid of no ghosts!
</p>
<p>Tales from the Campfire: The Improvised Ghost Story has quickly become one of the Push Comedy Theater' hottest new show.
</p>
<p>With a combination of cut to's and character work, it's a high energy and extremely fun form of improv.  And now you get a chance to learn it for yourself.
</p>
<p>This is a two day workshop, with a graduation show.
</p>
<p><strong>Workshop: Tales from the Campfire</strong>
</p>
<p><strong>Thursday, December 7th. 6:30pm to 9:30pm</strong>
</p>
<p><strong>Thursday, December 14th. 6:30pm to 8:30pm</strong>
</p>
<p><strong>Class Dismissed: Tales from the Campfire Graduation Show</strong>
</p>
<p><strong>Thursday, December 14th.  9pm.</strong>
</p>
<p>Tales from the Campfire has quickly become the Push's signature show.  It is the show we bring to events and festivals.  Here's your chance to join in the fun.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-12-07T18:30:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-12-14T20:30:00.000-05:00")
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

# Insert workshop
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "workshop"
})
Logger.info "=========== Wrote tag ==========="

# Insert campfire
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "campfire"
})
Logger.info "=========== Wrote tag ==========="

# Insert thursday
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "thursday"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Workshop: Tales from the Campfire",
    status: "available",
    description: "Ticket for Workshop: Tales from the Campfire",
    price: 7500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-11-24T05:23:58.470Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Workshop: Tales from the Campfire ==========="
Logger.info "=========== BEGIN Processing Universe Event Workshop: Writing Funny Songs w/ Reformed Whores ==========="

Logger.info "=========== Writing Event Workshop: Writing Funny Songs w/ Reformed Whores ==========="
event = SeedHelpers.create_event(
  %{
    slug: "LXKNQM",
    title: "Workshop: Writing Funny Songs w/ Reformed Whores",
    description: """
    <h3 style="text-align: center;">Writing Funny Songs w/ Reformed Whores</h3>
<p style="text-align: center;">Do you have an inner "Weird Al" Yankovic or Flight of the Conchords just waiting to burst out of you? Do you want to enhance your sketch comedy with funny songs? Are you looking for a new, fun way to get your ideas out into the world, but don't know where to begin? Well then, this comedy workshop is for you!
</p>
<p style="text-align: center;">Whether you are musically proficient or a novice, country/comedy duo Reformed Whores are here to help! In this workshop, Katy &amp; Marie will teach you some of their tried and true songwriting techniques! You'll learn song structure, rhyming basics, as well as how to mine your own brain for comedy gold without judgment.
</p>
<p style="text-align: center;">If you play a musical instrument, feel free to bring it! A guitar will be provided. Also if you have a way of recording sound on a device or phone, please bring it to class as well. Yee-haw!
</p>
<p style="text-align: center;"><strong>The Reformed Whores</strong>
</p>
<p style="text-align: center;">If Dolly Parton &amp; Flight of the Conchords got drunk and had a baby, you’d get the hilariously irreverent musical comedy duo Reformed Whores! These All-American gals don’t beat around the bush as they skewer and celebrate country music at their rib-tickling hoedown. Southern bred, but NYC based, Katy Frame &amp; Marie Cecile Anderson have been featured on IFC, PBS, CBS, and many other three-letter networks.
</p>
<p style="text-align: center;">They’ve toured the country opening for the likes of musical parodist “Weird Al” Yankovic, bassist extraordinaire Les Claypool, guitar hero Dweezil Zappa and rockabilly vets Reverend Horton Heat. Their sophomore album “Don’t Beat Around the Bush” debuted in March 2016 on the top 20 iTunes comedy chart and their YouTube Channel just hit over a million views!
</p>
<p style="text-align: center;">For more info, visit www.reformedwhores.com!
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/reformed-whores-Mindy-Tucker-e1502251289170.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/reformed-whores-Mindy-Tucker-683x1024.jpg" alt=""></a>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Workshop: Writing Funny Songs w/ Reformed Whores ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "LXKNQM",
    title: "Workshop: Writing Funny Songs w/ Reformed Whores",
    description: """
    <h3 style="text-align: center;">Writing Funny Songs w/ Reformed Whores</h3>
<p style="text-align: center;">Do you have an inner "Weird Al" Yankovic or Flight of the Conchords just waiting to burst out of you? Do you want to enhance your sketch comedy with funny songs? Are you looking for a new, fun way to get your ideas out into the world, but don't know where to begin? Well then, this comedy workshop is for you!
</p>
<p style="text-align: center;">Whether you are musically proficient or a novice, country/comedy duo Reformed Whores are here to help! In this workshop, Katy &amp; Marie will teach you some of their tried and true songwriting techniques! You'll learn song structure, rhyming basics, as well as how to mine your own brain for comedy gold without judgment.
</p>
<p style="text-align: center;">If you play a musical instrument, feel free to bring it! A guitar will be provided. Also if you have a way of recording sound on a device or phone, please bring it to class as well. Yee-haw!
</p>
<p style="text-align: center;"><strong>The Reformed Whores</strong>
</p>
<p style="text-align: center;">If Dolly Parton &amp; Flight of the Conchords got drunk and had a baby, you’d get the hilariously irreverent musical comedy duo Reformed Whores! These All-American gals don’t beat around the bush as they skewer and celebrate country music at their rib-tickling hoedown. Southern bred, but NYC based, Katy Frame &amp; Marie Cecile Anderson have been featured on IFC, PBS, CBS, and many other three-letter networks.
</p>
<p style="text-align: center;">They’ve toured the country opening for the likes of musical parodist “Weird Al” Yankovic, bassist extraordinaire Les Claypool, guitar hero Dweezil Zappa and rockabilly vets Reverend Horton Heat. Their sophomore album “Don’t Beat Around the Bush” debuted in March 2016 on the top 20 iTunes comedy chart and their YouTube Channel just hit over a million views!
</p>
<p style="text-align: center;">For more info, visit www.reformedwhores.com!
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/reformed-whores-Mindy-Tucker-e1502251289170.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/reformed-whores-Mindy-Tucker-683x1024.jpg" alt=""></a>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-09-16T14:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-16T17:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c9258baf-749f-4fbd-89a5-bcc42dbdb77c",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c9258baf-749f-4fbd-89a5-bcc42dbdb77c",
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

# Insert musical
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "musical"
})
Logger.info "=========== Wrote tag ==========="

# Insert whores
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "whores"
})
Logger.info "=========== Wrote tag ==========="

# Insert country
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "country"
})
Logger.info "=========== Wrote tag ==========="

# Insert reformed
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "reformed"
})
Logger.info "=========== Wrote tag ==========="

# Insert well
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "well"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Workshop: Writing Funny Songs w/ Reformed Whores",
    status: "available",
    description: "Ticket for Workshop: Writing Funny Songs w/ Reformed Whores",
    price: 3500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-07T16:43:33.446Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Workshop: Writing Funny Songs w/ Reformed Whores ==========="
Logger.info "=========== BEGIN Processing Universe Event Workshop: Musical Comedy ==========="

Logger.info "=========== Writing Event Workshop: Musical Comedy ==========="
event = SeedHelpers.create_event(
  %{
    slug: "JMSZHB",
    title: "Workshop: Musical Comedy",
    description: """
    <p>Are you the kind of person who changes the lyrics to songs to make your friends giggle? Have you ever wanted to turn one of those into a full piece?</p><p>In this workshop, students will learn the basics of taking an idea for a song parody or musical sketch and turning it into an audience-ready sketch!</p><p>Students will get individual attention working with their ideas and the process for developing them. These ideas can be as simple as "what (insert action) were happening with (insert music) playing in the background," or as complex as "I have written all of these lyrics but I just don't feel like the song is quite there yet!"</p><p>Each student will have the opportunity to perform his or her piece in front of a live audience for the graduation show!</p><p><strong>No prior musical, acting, or comedic experience necessary.</strong> </p><p>Students may bring their own instruments, or we can provide playback of audio, or basic guitar accompaniment. </p><p>Students are asked to email which songs they plan to use and what kind of sound accompaniment they will be using prior to the first class so we can appropriately prepare.</p><p><strong>Workshop: Musical Comedy</strong><br>Tuesday and Wednesday, December 1 &amp; 2, 7pm to 10pm<br>Thursday, December 3, 6pm to 7pm</p><p>Graduation Show: Thursday, December 3, 8pm</p><p><strong>Teachers:<br>Brad McMurran</strong> (co-writer of Cuff Me: The 50 Shades of Grey musical Parody (script and lyrics),Co- Founder of The Push Comedy Theater)</p><p><strong>Alba Woolard</strong> (co-creator of Panties in a Twist, Co-Founder of The Push Comedy Theater)</p><p>This class will be experimenting with anything music based. All sketch/improvisation comedy through music. The class will be two and a half sessions with a graduation show to showcase your musical sketch or piece. </p><p>Brad and Alba have been co-writing song parodies, dance numbers, and silent scenes through sketch and improvisation comedy for over 11 years and are excited to see what their students bring to the table to workshop. </p><p>Classes are December 2nd and December 3rd from 7-10pm and on December 3rd from 6-7pm followed by their grad show. </p><p>In essence if you have ever wanted to do musical parodies, dance parodies, made up songs, karaoke, you play the flute, you sing in the shower, etc...COME OUT!!!!!</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Workshop: Musical Comedy ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "JMSZHB",
    title: "Workshop: Musical Comedy",
    description: """
    <p>Are you the kind of person who changes the lyrics to songs to make your friends giggle? Have you ever wanted to turn one of those into a full piece?</p><p>In this workshop, students will learn the basics of taking an idea for a song parody or musical sketch and turning it into an audience-ready sketch!</p><p>Students will get individual attention working with their ideas and the process for developing them. These ideas can be as simple as "what (insert action) were happening with (insert music) playing in the background," or as complex as "I have written all of these lyrics but I just don't feel like the song is quite there yet!"</p><p>Each student will have the opportunity to perform his or her piece in front of a live audience for the graduation show!</p><p><strong>No prior musical, acting, or comedic experience necessary.</strong> </p><p>Students may bring their own instruments, or we can provide playback of audio, or basic guitar accompaniment. </p><p>Students are asked to email which songs they plan to use and what kind of sound accompaniment they will be using prior to the first class so we can appropriately prepare.</p><p><strong>Workshop: Musical Comedy</strong><br>Tuesday and Wednesday, December 1 &amp; 2, 7pm to 10pm<br>Thursday, December 3, 6pm to 7pm</p><p>Graduation Show: Thursday, December 3, 8pm</p><p><strong>Teachers:<br>Brad McMurran</strong> (co-writer of Cuff Me: The 50 Shades of Grey musical Parody (script and lyrics),Co- Founder of The Push Comedy Theater)</p><p><strong>Alba Woolard</strong> (co-creator of Panties in a Twist, Co-Founder of The Push Comedy Theater)</p><p>This class will be experimenting with anything music based. All sketch/improvisation comedy through music. The class will be two and a half sessions with a graduation show to showcase your musical sketch or piece. </p><p>Brad and Alba have been co-writing song parodies, dance numbers, and silent scenes through sketch and improvisation comedy for over 11 years and are excited to see what their students bring to the table to workshop. </p><p>Classes are December 2nd and December 3rd from 7-10pm and on December 3rd from 6-7pm followed by their grad show. </p><p>In essence if you have ever wanted to do musical parodies, dance parodies, made up songs, karaoke, you play the flute, you sing in the shower, etc...COME OUT!!!!!</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-12-01T19:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-12-03T19:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c7de3de4-c13d-400d-970c-cac0f46afbcf",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c7de3de4-c13d-400d-970c-cac0f46afbcf",
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

# Insert musical
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "musical"
})
Logger.info "=========== Wrote tag ==========="

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "sketch"
})
Logger.info "=========== Wrote tag ==========="

# Insert parodies
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "parodies"
})
Logger.info "=========== Wrote tag ==========="

# Insert songs
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "songs"
})
Logger.info "=========== Wrote tag ==========="

# Insert lyrics
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "lyrics"
})
Logger.info "=========== Wrote tag ==========="

# Insert class
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "class"
})
Logger.info "=========== Wrote tag ==========="

# Insert music
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "music"
})
Logger.info "=========== Wrote tag ==========="

# Insert students
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "students"
})
Logger.info "=========== Wrote tag ==========="

# Insert song
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "song"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Workshop: Musical Comedy",
    status: "available",
    description: "Ticket for Workshop: Musical Comedy",
    price: 9000,
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-25T06:50:20.004Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Workshop: Musical Comedy ==========="
Logger.info "=========== BEGIN Processing Universe Event Workshop: The End of the World ==========="

Logger.info "=========== Writing Event Workshop: The End of the World ==========="
event = SeedHelpers.create_event(
  %{
    slug: "5JY0ZC",
    title: "Workshop: The End of the World",
    description: """
    <p><strong></strong><strong>A longform about the end of it all.</strong></p><p>In this workshop you’ll learn “The Apocalypse.” This form combines elements from the Eventé and a Monoscene and uses scenework to show how it all is going to end. </p><p>From zombies to robots, Mayan curses to an army of chickens, the end of the world has never been so fun! </p><p><strong>The End of the World with Andy Livengood</strong><br>Wednesday, April 13 at 6:30<br>Price: $30</p><p>This workshop is for students who have completed Improv 201 and up<br><br><strong>_____________<br>Andy Livengood</strong></p><p><strong><br></strong></p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/f4370ae0054daccd86ac283c644a58e3-Andy%20Livengood%20%28TBL%29%20051.jpg" alt="" style="float: left; margin: 0px 10px 10px 0px;"></p><p>Andy Livengood wandered into an improv theatre to see a friends show and became hooked for life. He is a graduate of the Theatre 99 training program (Charleston, SC) and has studied at the Upright Citizen’s Brigade Theatre (NY) and The Annoyance Theatre (Chicago).</p><p>For 10 years he regularly performed at Theatre 99 with the groups CATS HUGGING CATS, Human Fireworks, and Clutch. He was voted Charleston’s Best Comic in 2010 and has written for the sketch comedy groups Maximum Brain Squad and This is Chucktown. His one man show, The Christmas will be Televised, was voted Best Play in Charleston in 2011 and has been performed in theaters all over the south east. </p><p>Andy has performed and taught in theaters and festivals all over the US. He is also a big comic book nerd. (Bring up Batman in a workshop and you’ll make a friend for life)</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Workshop: The End of the World ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "5JY0ZC",
    title: "Workshop: The End of the World",
    description: """
    <p><strong></strong><strong>A longform about the end of it all.</strong></p><p>In this workshop you’ll learn “The Apocalypse.” This form combines elements from the Eventé and a Monoscene and uses scenework to show how it all is going to end. </p><p>From zombies to robots, Mayan curses to an army of chickens, the end of the world has never been so fun! </p><p><strong>The End of the World with Andy Livengood</strong><br>Wednesday, April 13 at 6:30<br>Price: $30</p><p>This workshop is for students who have completed Improv 201 and up<br><br><strong>_____________<br>Andy Livengood</strong></p><p><strong><br></strong></p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/f4370ae0054daccd86ac283c644a58e3-Andy%20Livengood%20%28TBL%29%20051.jpg" alt="" style="float: left; margin: 0px 10px 10px 0px;"></p><p>Andy Livengood wandered into an improv theatre to see a friends show and became hooked for life. He is a graduate of the Theatre 99 training program (Charleston, SC) and has studied at the Upright Citizen’s Brigade Theatre (NY) and The Annoyance Theatre (Chicago).</p><p>For 10 years he regularly performed at Theatre 99 with the groups CATS HUGGING CATS, Human Fireworks, and Clutch. He was voted Charleston’s Best Comic in 2010 and has written for the sketch comedy groups Maximum Brain Squad and This is Chucktown. His one man show, The Christmas will be Televised, was voted Best Play in Charleston in 2011 and has been performed in theaters all over the south east. </p><p>Andy has performed and taught in theaters and festivals all over the US. He is also a big comic book nerd. (Bring up Batman in a workshop and you’ll make a friend for life)</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-13T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-13T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/02900d80-4c2b-47e6-8f77-9164ab18b3c3",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/02900d80-4c2b-47e6-8f77-9164ab18b3c3",
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

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Workshop: The End of the World",
    status: "available",
    description: "Ticket for Workshop: The End of the World",
    price: 3000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-07T17:03:15.888Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Workshop: The End of the World ==========="
Logger.info "=========== BEGIN Processing Universe Event Workshop: You Are Not The Scene ==========="

Logger.info "=========== Writing Event Workshop: You Are Not The Scene ==========="
event = SeedHelpers.create_event(
  %{
    slug: "YHRJ91",
    title: "Workshop: You Are Not The Scene",
    description: """
    <p><strong></strong><strong>You are not the scene.</strong>
</p>
<p>Somewhere around 10 or 15 years ago improvisers started calling themselves comics.  They stopped thinking of themselves as actors and started thinking they were “doing comedy.”  This fucked everything up because this focus on comedy is egocentrically, it is product oriented and it makes the performer think that they are the scene.
</p>
<p>You are not the scene.  The scene is something your character is experiencing.  It is what you are doing, how you feel about it, why you want to do it.  You are not the scene; the character’s experience is the scene.  In this class, we are going to work on you experiencing stuff in the scene – touching stuff, seeing stuff, feeling the emotions that that experience causes.  You may walk in a comic, but you will walk out an actor.
</p>
<p><strong>Workshop: You Are Not The Scene</strong>
</p>
<p><strong>with Greg Tavares</strong>
</p>
<p><strong><br></strong>
</p>
<p>Thursday, October 26th at the Generic Theater
</p>
<p>The workshop starts at 6:30pm and costs $45.
</p>
<p><br>
</p>
<p>This workshop is open to all.  The Generic Theater is located undertneath Scope.
</p>
<p><br>
</p>
<p>Greg Tavares acts, teaches, and directs in Charleston, South Carolina. He did his first improv show in 1985 and has never stopped. In 1995, he co-founded The Have Nots! with Brandy Sullivan and some other friends. He co-founded Theatre 99 in Charleston with Brandy and Timmy Finch in 2000.
</p>
<p>He wrote the curriculum taught in Theatre 99s training program and gets as much out of teaching as he does from being on stage. He performs and teaches at improv festivals all over the country. He has a BFA in acting from the University of South Carolina and an MFA in directing from the University of Nebraska. He is the co-artistic director of Theatre 99 and the Charleston Comedy Festival.
</p>
<p>He wrote an improv book called Improv For Everyone.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Workshop: You Are Not The Scene ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "YHRJ91",
    title: "Workshop: You Are Not The Scene",
    description: """
    <p><strong></strong><strong>You are not the scene.</strong>
</p>
<p>Somewhere around 10 or 15 years ago improvisers started calling themselves comics.  They stopped thinking of themselves as actors and started thinking they were “doing comedy.”  This fucked everything up because this focus on comedy is egocentrically, it is product oriented and it makes the performer think that they are the scene.
</p>
<p>You are not the scene.  The scene is something your character is experiencing.  It is what you are doing, how you feel about it, why you want to do it.  You are not the scene; the character’s experience is the scene.  In this class, we are going to work on you experiencing stuff in the scene – touching stuff, seeing stuff, feeling the emotions that that experience causes.  You may walk in a comic, but you will walk out an actor.
</p>
<p><strong>Workshop: You Are Not The Scene</strong>
</p>
<p><strong>with Greg Tavares</strong>
</p>
<p><strong><br></strong>
</p>
<p>Thursday, October 26th at the Generic Theater
</p>
<p>The workshop starts at 6:30pm and costs $45.
</p>
<p><br>
</p>
<p>This workshop is open to all.  The Generic Theater is located undertneath Scope.
</p>
<p><br>
</p>
<p>Greg Tavares acts, teaches, and directs in Charleston, South Carolina. He did his first improv show in 1985 and has never stopped. In 1995, he co-founded The Have Nots! with Brandy Sullivan and some other friends. He co-founded Theatre 99 in Charleston with Brandy and Timmy Finch in 2000.
</p>
<p>He wrote the curriculum taught in Theatre 99s training program and gets as much out of teaching as he does from being on stage. He performs and teaches at improv festivals all over the country. He has a BFA in acting from the University of South Carolina and an MFA in directing from the University of Nebraska. He is the co-artistic director of Theatre 99 and the Charleston Comedy Festival.
</p>
<p>He wrote an improv book called Improv For Everyone.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-10-26T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-10-26T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/2e837c92-6ace-47c7-8dff-9bd38d67ecf8",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/2e837c92-6ace-47c7-8dff-9bd38d67ecf8",
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

# Insert stuff
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "stuff"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Workshop: You Are Not The Scene",
    status: "available",
    description: "Ticket for Workshop: You Are Not The Scene",
    price: 4500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-16T15:53:54.045Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Workshop: You Are Not The Scene ==========="
Logger.info "=========== BEGIN Processing Universe Event Murder Mystery Workshop ==========="

Logger.info "=========== Writing Event Murder Mystery Workshop ==========="
event = SeedHelpers.create_event(
  %{
    slug: "NW15QL",
    title: "Murder Mystery Workshop",
    description: """
    <p><strong>Get ready for a spine tingling murder mystery!!!</strong>
</p>
<p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!
</p>
<p>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.
</p>
<p>...And it will all be made up on the spot!!!
</p>
<p>The Muder Mystery has become one of the Push's biggest hits.  Now is your chance to learn from the sleuth master himself, Brad McMurran.
</p>
<p>The workshop will be held from 6:30 to 9:30 Tuesday and Wednesday nights (August 23rd and 24th).
</p>
<p>There will be a perfromance of the Murder Mystery at 9:30, Wednesday the 24.
</p>
<p>Open for 301 students on up.
</p>
<p>The workshop is limited to 20 people, so sign up now.
</p>
<p>This workshop cost $90.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Murder Mystery Workshop ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "NW15QL",
    title: "Murder Mystery Workshop",
    description: """
    <p><strong>Get ready for a spine tingling murder mystery!!!</strong>
</p>
<p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!
</p>
<p>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.
</p>
<p>...And it will all be made up on the spot!!!
</p>
<p>The Muder Mystery has become one of the Push's biggest hits.  Now is your chance to learn from the sleuth master himself, Brad McMurran.
</p>
<p>The workshop will be held from 6:30 to 9:30 Tuesday and Wednesday nights (August 23rd and 24th).
</p>
<p>There will be a perfromance of the Murder Mystery at 9:30, Wednesday the 24.
</p>
<p>Open for 301 students on up.
</p>
<p>The workshop is limited to 20 people, so sign up now.
</p>
<p>This workshop cost $90.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-08-23T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-08-24T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/7b36b331-7661-49d2-b1bd-f48cfac56fa5",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/7b36b331-7661-49d2-b1bd-f48cfac56fa5",
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
    name: "Ticket for Murder Mystery Workshop",
    status: "available",
    description: "Ticket for Murder Mystery Workshop",
    price: 9000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-06T00:09:04.353Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Murder Mystery Workshop ==========="
Logger.info "=========== BEGIN Processing Universe Event Workshop: Give a S*** with Andy Livengood ==========="

Logger.info "=========== Writing Event Workshop: Give a S*** with Andy Livengood ==========="
event = SeedHelpers.create_event(
  %{
    slug: "546SH0",
    title: "Workshop: Give a S*** with Andy Livengood",
    description: """
    <p>Ever get caught in a scene where you don’t know where to go next?</p><p>You finish the scene and think “Eh….that could have been better.” <br>The solution is really simple; your characters need to care about something.</p><p>This workshop will give you simple solutions and skills that will deepen your characters and your scenework. Give your characters something to care about and you give yourself something to drive the scene. </p><p>Give a S*** with Andy Livengood<br>Thursday, April 14 at 6:30<br>Price: $30</p><p>This workshop is open to students of all levels.</p><p>_____________<br>Andy Livengood</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/0924fc4ba408ee5a2a999e66834f3369-Andy%20Livengood%20%28TBL%29%20051.jpg" alt="" style="float: left; margin: 0px 10px 10px 0px;"></p><p>Andy Livengood wandered into an improv theatre to see a friends show and became hooked for life. He is a graduate of the Theatre 99 training program (Charleston, SC) and has studied at the Upright Citizen’s Brigade Theatre (NY) and The Annoyance Theatre (Chicago).</p><p>For 10 years he regularly performed at Theatre 99 with the groups CATS HUGGING CATS, Human Fireworks, and Clutch. He was voted Charleston’s Best Comic in 2010 and has written for the sketch comedy groups Maximum Brain Squad and This is Chucktown. His one man show, The Christmas will be Televised, was voted Best Play in Charleston in 2011 and has been performed in theaters all over the south east. </p><p>Andy has performed and taught in theaters and festivals all over the US. He is also a big comic book nerd. (Bring up Batman in a workshop and you’ll make a friend for life)</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Workshop: Give a S*** with Andy Livengood ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "546SH0",
    title: "Workshop: Give a S*** with Andy Livengood",
    description: """
    <p>Ever get caught in a scene where you don’t know where to go next?</p><p>You finish the scene and think “Eh….that could have been better.” <br>The solution is really simple; your characters need to care about something.</p><p>This workshop will give you simple solutions and skills that will deepen your characters and your scenework. Give your characters something to care about and you give yourself something to drive the scene. </p><p>Give a S*** with Andy Livengood<br>Thursday, April 14 at 6:30<br>Price: $30</p><p>This workshop is open to students of all levels.</p><p>_____________<br>Andy Livengood</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/0924fc4ba408ee5a2a999e66834f3369-Andy%20Livengood%20%28TBL%29%20051.jpg" alt="" style="float: left; margin: 0px 10px 10px 0px;"></p><p>Andy Livengood wandered into an improv theatre to see a friends show and became hooked for life. He is a graduate of the Theatre 99 training program (Charleston, SC) and has studied at the Upright Citizen’s Brigade Theatre (NY) and The Annoyance Theatre (Chicago).</p><p>For 10 years he regularly performed at Theatre 99 with the groups CATS HUGGING CATS, Human Fireworks, and Clutch. He was voted Charleston’s Best Comic in 2010 and has written for the sketch comedy groups Maximum Brain Squad and This is Chucktown. His one man show, The Christmas will be Televised, was voted Best Play in Charleston in 2011 and has been performed in theaters all over the south east. </p><p>Andy has performed and taught in theaters and festivals all over the US. He is also a big comic book nerd. (Bring up Batman in a workshop and you’ll make a friend for life)</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-14T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-14T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/5f21438e-d199-43ae-8e8f-2653bd4bed12",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/5f21438e-d199-43ae-8e8f-2653bd4bed12",
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

# Insert give
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "give"
})
Logger.info "=========== Wrote tag ==========="

# Insert characters
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "characters"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Workshop: Give a S*** with Andy Livengood",
    status: "available",
    description: "Ticket for Workshop: Give a S*** with Andy Livengood",
    price: 3000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-07T17:29:32.531Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Workshop: Give a S*** with Andy Livengood ==========="
Logger.info "=========== BEGIN Processing Universe Event Workshop: Curve Balls and Breaking the Rules ==========="

Logger.info "=========== Writing Event Workshop: Curve Balls and Breaking the Rules ==========="
event = SeedHelpers.create_event(
  %{
    slug: "D26VF5",
    title: "Workshop: Curve Balls and Breaking the Rules",
    description: """
    <p><strong>“There are no rules in improv.” </strong></p><p>We’ve all heard this, but then we get so hung up on not breaking these nonexistent rules. <br>This workshop will put you in scenes that “you’re not supposed to do.” Transaction scenes, stranger scenes, teaching scenes; we’ll cover them all.</p><p>This fun class will teach you how to playfully throw curve balls at your scene partner, and what to do when you get a curve ball thrown at you. <br>Your scene turning into a fight? No problem! <br>Are you begging for an add-on that just isn’t coming? Don’t worry! </p><p>You’ll learn that your scene isn’t going off the rails. it’s just getting started. </p><p><strong>Curve Balls and Breaking the Rules with Andy Livengood</strong><br>Saturday, April 16 at 10am<br>Price: $30</p><p>This workshop is for students who have completed Improv 201 and up.</p><p>_____________<br><strong>Andy Livengood</strong></p><p><strong><br></strong></p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/4128b8c916028412c87855dd70b9fdf2-Andy%20Livengood%20%28TBL%29%20051.jpg" alt="" style="float: left; margin: 0px 10px 10px 0px;"></p><p>Andy Livengood wandered into an improv theatre to see a friends show and became hooked for life. He is a graduate of the Theatre 99 training program (Charleston, SC) and has studied at the Upright Citizen’s Brigade Theatre (NY) and The Annoyance Theatre (Chicago).</p><p>For 10 years he regularly performed at Theatre 99 with the groups CATS HUGGING CATS, Human Fireworks, and Clutch. He was voted Charleston’s Best Comic in 2010 and has written for the sketch comedy groups Maximum Brain Squad and This is Chucktown. His one man show, The Christmas will be Televised, was voted Best Play in Charleston in 2011 and has been performed in theaters all over the south east. </p><p>Andy has performed and taught in theaters and festivals all over the US. He is also a big comic book nerd. (Bring up Batman in a workshop and you’ll make a friend for life)</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Workshop: Curve Balls and Breaking the Rules ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "D26VF5",
    title: "Workshop: Curve Balls and Breaking the Rules",
    description: """
    <p><strong>“There are no rules in improv.” </strong></p><p>We’ve all heard this, but then we get so hung up on not breaking these nonexistent rules. <br>This workshop will put you in scenes that “you’re not supposed to do.” Transaction scenes, stranger scenes, teaching scenes; we’ll cover them all.</p><p>This fun class will teach you how to playfully throw curve balls at your scene partner, and what to do when you get a curve ball thrown at you. <br>Your scene turning into a fight? No problem! <br>Are you begging for an add-on that just isn’t coming? Don’t worry! </p><p>You’ll learn that your scene isn’t going off the rails. it’s just getting started. </p><p><strong>Curve Balls and Breaking the Rules with Andy Livengood</strong><br>Saturday, April 16 at 10am<br>Price: $30</p><p>This workshop is for students who have completed Improv 201 and up.</p><p>_____________<br><strong>Andy Livengood</strong></p><p><strong><br></strong></p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/4128b8c916028412c87855dd70b9fdf2-Andy%20Livengood%20%28TBL%29%20051.jpg" alt="" style="float: left; margin: 0px 10px 10px 0px;"></p><p>Andy Livengood wandered into an improv theatre to see a friends show and became hooked for life. He is a graduate of the Theatre 99 training program (Charleston, SC) and has studied at the Upright Citizen’s Brigade Theatre (NY) and The Annoyance Theatre (Chicago).</p><p>For 10 years he regularly performed at Theatre 99 with the groups CATS HUGGING CATS, Human Fireworks, and Clutch. He was voted Charleston’s Best Comic in 2010 and has written for the sketch comedy groups Maximum Brain Squad and This is Chucktown. His one man show, The Christmas will be Televised, was voted Best Play in Charleston in 2011 and has been performed in theaters all over the south east. </p><p>Andy has performed and taught in theaters and festivals all over the US. He is also a big comic book nerd. (Bring up Batman in a workshop and you’ll make a friend for life)</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-16T10:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-16T12:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/a0e4242b-a236-45c6-a712-089cf07298e2",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/a0e4242b-a236-45c6-a712-089cf07298e2",
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

# Insert rules
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "rules"
})
Logger.info "=========== Wrote tag ==========="

# Insert curve
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "curve"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Workshop: Curve Balls and Breaking the Rules",
    status: "available",
    description: "Ticket for Workshop: Curve Balls and Breaking the Rules",
    price: 3000,
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-07T17:45:56.686Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Workshop: Curve Balls and Breaking the Rules ==========="
Logger.info "=========== BEGIN Processing Universe Event Workshop: Introduction to Sketch Writing ==========="

Logger.info "=========== Writing Event Workshop: Introduction to Sketch Writing ==========="
event = SeedHelpers.create_event(
  %{
    slug: "W97CH4",
    title: "Workshop: Introduction to Sketch Writing",
    description: """
    <h3 style="text-align: center;"><strong>INTRODUCTION TO SKETCH WRITING</strong></h3>
<p style="text-align: center;"><i>Always wanted to learn how to take a funny idea and mold it into a comedy sketch? Always enjoyed writing but wanted to give comedy a try? Well check out, INTRODUCTION TO SKETCH WRITING an introduction to the basics of writing sketch comedy. Using in class writing exercises and video clips, students will come away with a basic understanding of sketch structure and brainstorming techniques. <br></i>
</p>
<p style="text-align: center;"><i><br></i>
</p>
<p style="text-align: center;"><i>Mark first got into comedy while studying film at Northwestern University. He had a chance to work at Comedy Central through the Chris Rock Summer School Program for up and coming comedy writers of color. During his time at Comedy Central, he got to pitch jokes to the writing staffs of “The Daily Show” and “The Colbert Report.” Mark performs comedy in Atlanta at Dad’s Garage Theatre Company and Highwire Comedy. He also teaches improv and sketch writing. He is currently touring with his one man show “The Magic Negro and Other Blackness” a sketch show that examines the depiction of black men in the media. For his work with the show, he was named “Best Professional Funny Man” by Creative Loafing Atlanta.</i>
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/magic-negro-3-faces.png" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/magic-negro-3-faces.png" alt=""></a>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Workshop: Introduction to Sketch Writing ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "W97CH4",
    title: "Workshop: Introduction to Sketch Writing",
    description: """
    <h3 style="text-align: center;"><strong>INTRODUCTION TO SKETCH WRITING</strong></h3>
<p style="text-align: center;"><i>Always wanted to learn how to take a funny idea and mold it into a comedy sketch? Always enjoyed writing but wanted to give comedy a try? Well check out, INTRODUCTION TO SKETCH WRITING an introduction to the basics of writing sketch comedy. Using in class writing exercises and video clips, students will come away with a basic understanding of sketch structure and brainstorming techniques. <br></i>
</p>
<p style="text-align: center;"><i><br></i>
</p>
<p style="text-align: center;"><i>Mark first got into comedy while studying film at Northwestern University. He had a chance to work at Comedy Central through the Chris Rock Summer School Program for up and coming comedy writers of color. During his time at Comedy Central, he got to pitch jokes to the writing staffs of “The Daily Show” and “The Colbert Report.” Mark performs comedy in Atlanta at Dad’s Garage Theatre Company and Highwire Comedy. He also teaches improv and sketch writing. He is currently touring with his one man show “The Magic Negro and Other Blackness” a sketch show that examines the depiction of black men in the media. For his work with the show, he was named “Best Professional Funny Man” by Creative Loafing Atlanta.</i>
</p>
<p style="text-align: center;"><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/magic-negro-3-faces.png" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/magic-negro-3-faces.png" alt=""></a>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-09-16T11:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-16T13:00:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9405e927-7eba-4f57-9b9f-37a1a0a984ef",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9405e927-7eba-4f57-9b9f-37a1a0a984ef",
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

# Insert introduction
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "introduction"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Workshop: Introduction to Sketch Writing",
    status: "available",
    description: "Ticket for Workshop: Introduction to Sketch Writing",
    price: 3500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-07T02:51:51.778Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Workshop: Introduction to Sketch Writing ==========="
Logger.info "=========== BEGIN Processing Universe Event Workshop: Silence and Sincerity in Improvisation ==========="

Logger.info "=========== Writing Event Workshop: Silence and Sincerity in Improvisation ==========="
event = SeedHelpers.create_event(
  %{
    slug: "V3Q4W5",
    title: "Workshop: Silence and Sincerity in Improvisation",
    description: """
    <p><strong>Silence and Sincerity in Improvisation</strong><br> There's  more said on stage than dialogue.  This workshop will focus on using  both those unspoken endowments (words, motivations, history, among  others) and emotion to bring more wonder and depth to your improv and  sketch. Voted Best Class by Students of Improv Wins Conference &amp;  Festival in 2014. <br> <br> Mike Spara is an actor, comedian and writer.   He is a founding member of TNM NOLA. He has trained with UCB, Second  City, iO, Annoyance, and Under the Gun Theater.  He performs comedy  around the country with Stupid Time Machine and his wordless sketch  comedy project Conversations with Body Language.</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/36b9f73f1ca6574cd52522172fac9151-conversations1.jpg"></p><p><strong>Workshop: Silence and Sincerity in Improvisation</strong></p><p>Sunday, November 22nd from noon to 3pm.</p><p>Tickets are $30</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/c54fab212d03dba88f75ac1ca066db82-Conversations%20in%20Body%20Language.jpg"></p><p><br><strong></strong></p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Workshop: Silence and Sincerity in Improvisation ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "V3Q4W5",
    title: "Workshop: Silence and Sincerity in Improvisation",
    description: """
    <p><strong>Silence and Sincerity in Improvisation</strong><br> There's  more said on stage than dialogue.  This workshop will focus on using  both those unspoken endowments (words, motivations, history, among  others) and emotion to bring more wonder and depth to your improv and  sketch. Voted Best Class by Students of Improv Wins Conference &amp;  Festival in 2014. <br> <br> Mike Spara is an actor, comedian and writer.   He is a founding member of TNM NOLA. He has trained with UCB, Second  City, iO, Annoyance, and Under the Gun Theater.  He performs comedy  around the country with Stupid Time Machine and his wordless sketch  comedy project Conversations with Body Language.</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/36b9f73f1ca6574cd52522172fac9151-conversations1.jpg"></p><p><strong>Workshop: Silence and Sincerity in Improvisation</strong></p><p>Sunday, November 22nd from noon to 3pm.</p><p>Tickets are $30</p><p><img src="https://s3.amazonaws.com/uniiverse_production/attachments/c54fab212d03dba88f75ac1ca066db82-Conversations%20in%20Body%20Language.jpg"></p><p><br><strong></strong></p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2015-11-22T12:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2015-11-22T15:00:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/143e7755-0650-478e-87e3-adb7d63cfede",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/143e7755-0650-478e-87e3-adb7d63cfede",
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

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Workshop: Silence and Sincerity in Improvisation",
    status: "available",
    description: "Ticket for Workshop: Silence and Sincerity in Improvisation",
    price: 3000,
    sale_start:  NaiveDateTime.from_iso8601!("2015-11-08T04:05:13.010Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Workshop: Silence and Sincerity in Improvisation ==========="
Logger.info "=========== BEGIN Processing Universe Event Character Workshop ==========="

Logger.info "=========== Writing Event Character Workshop ==========="
event = SeedHelpers.create_event(
  %{
    slug: "3SQLDP",
    title: "Character Workshop",
    description: """
    <p>Explore how to expand your characters in improvisation.
</p>
<p>This workshop will concentrate on how to make your characters and character choices fuller and more in depth.
</p>
<p>We will work on "if this is true, then what else is true," how to solidify the straight man/crazy man dynamic, framing, and more importantly how to create characters on the spot.
</p>
<p>This workshop will be limited to 16 people.
</p>
<p>Character Workshop
</p>
<p>Tuesday, May 9th from 6:30 to 9:30
</p>
<p>Tuition is $35
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Character Workshop ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "3SQLDP",
    title: "Character Workshop",
    description: """
    <p>Explore how to expand your characters in improvisation.
</p>
<p>This workshop will concentrate on how to make your characters and character choices fuller and more in depth.
</p>
<p>We will work on "if this is true, then what else is true," how to solidify the straight man/crazy man dynamic, framing, and more importantly how to create characters on the spot.
</p>
<p>This workshop will be limited to 16 people.
</p>
<p>Character Workshop
</p>
<p>Tuesday, May 9th from 6:30 to 9:30
</p>
<p>Tuition is $35
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-05-09T18:30:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-09T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/2f338a76-67c7-455a-82db-6ba80ac35af5",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/2f338a76-67c7-455a-82db-6ba80ac35af5",
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

# Insert characters
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "characters"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for Character Workshop",
    status: "available",
    description: "Ticket for Character Workshop",
    price: 3500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-05-01T17:49:55.934Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Character Workshop ==========="
