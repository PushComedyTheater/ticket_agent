require Logger
alias TicketAgent.Random

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
card = SeedHelpers.create_credit_card(user)
user = SeedHelpers.create_user("concierge@veverka.net", account, "concierge")
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
Logger.info "=========== BEGIN Processing Universe Event Improv for Teens at the Push Comedy Theater ==========="

Logger.info "=========== Writing Class Listing Improv for Teens at the Push Comedy Theater ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: teen_improv.id,
    slug: "9HFNQK",
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
<p><strong>This class will be held from 1pm-3pm on Saturday afternoons from January 13th through February 17th. </strong>
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
    start_at:  NaiveDateTime.from_iso8601!("2018-01-13 18:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-02-17 20:00:00Z")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/02e47add-c2da-4f40-a319-78867643f4b6"
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

Logger.info "=========== Writing 12 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..12, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Improv for Teens at the Push Comedy Theater",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for Improv for Teens at the Push Comedy Theater",
        price: 15000,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-13T04:17:25.431Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Improv for Teens at the Push Comedy Theater",
        status: "available",
        description: "Ticket for Improv for Teens at the Push Comedy Theater",
        price: 15000,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-13T04:17:25.431Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="

Logger.info "=========== END Processing Universe Event Improv for Teens at the Push Comedy Theater ==========="
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
    start_at:  NaiveDateTime.from_iso8601!("2017-11-18 20:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-06 23:00:00Z")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/20f01bb1-d774-4ecd-8ac0-00dca64a153f"
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

Logger.info "=========== Writing 12 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..12, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Musical Improv 201",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for Musical Improv 201",
        price: 21000,
        sale_start:  NaiveDateTime.from_iso8601!("2017-09-10T21:07:26.636Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Musical Improv 201",
        status: "available",
        description: "Ticket for Musical Improv 201",
        price: 21000,
        sale_start:  NaiveDateTime.from_iso8601!("2017-09-10T21:07:26.636Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="

Logger.info "=========== END Processing Universe Event Musical Improv 201 ==========="
Logger.info "=========== BEGIN Processing Universe Event KidProv Studio at the Push Comedy Theater ==========="

Logger.info "=========== Writing Class Listing KidProv Studio at the Push Comedy Theater ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: kidprov101.id,
    slug: "GZ5BJR",
    title: "KidProv Studio at the Push Comedy Theater",
    description: """
    <p>Don't miss out on the fun!!! Sign up your kids, grand kids, nieces, nephews, even the stinky neighbor kid from down the street for KidProv at the Push Comedy Theater.
</p>
<p>This class is open to children ages 7 to 12 who have taken Kid Prov 101 classes or camps a minimum of 3 times.
</p>
<p>Students will explore the key elements of both long and short form improvisation and will learn how to improvise various styles of improv, including a Murder Mystery and Improvised Ghost Stories. The children will play numerous improv games which will serve to develop and enhance their public-speaking, social and team-building skills.
</p>
<p>This class will be conducted in a non-judgmental environment where the students will build confidence, make friends and most importantly ... have fun
</p>
<p>The session concludes with the students performing in a graduation show on the Push Comedy Theater Stage.
</p>
<p>This class will be held from 1pm-3pm on Sunday mornings from January 14th through February 18th.
</p>
<p>This is class is $150.
</p>
<p>This class has an 8 Student Minimum
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
    start_at:  NaiveDateTime.from_iso8601!("2018-01-14 18:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-02-18 20:00:00Z")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9052b361-b187-4963-aaa8-d59d95a2a381"
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

Logger.info "=========== Writing 12 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..12, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for KidProv Studio at the Push Comedy Theater",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for KidProv Studio at the Push Comedy Theater",
        price: 15000,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-13T04:00:05.903Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for KidProv Studio at the Push Comedy Theater",
        status: "available",
        description: "Ticket for KidProv Studio at the Push Comedy Theater",
        price: 15000,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-13T04:00:05.903Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="

Logger.info "=========== END Processing Universe Event KidProv Studio at the Push Comedy Theater ==========="
Logger.info "=========== BEGIN Processing Universe Event KidProv at the Push Comedy Theater ==========="

Logger.info "=========== Writing Class Listing KidProv at the Push Comedy Theater ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: nil,
    class_id: kidprov101.id,
    slug: "5SWHN0",
    title: "KidProv at the Push Comedy Theater",
    description: """
    <p>Don't miss out on the fun!!! Sign up your kids, grand kids, nieces, nephews, even the stinky neighbor kid from down the street for KidProv at the Push Comedy Theater.
</p>
<p>This class is open to children ages 7 to 12. Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public-speaking, social and team-building skills.
</p>
<p>This class will be conducted in a non-judgmental environment where the students will build confidence, make friends and most importantly ... have fun
</p>
<p>The session concludes with the students performing in a graduation show on the Push Comedy Theater Stage.
</p>
<p>This class will be held from 10am-12pm on Saturday mornings from January 13th through February 17th.
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
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2018-01-13 15:00:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-02-17 17:00:00Z")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/9052b361-b187-4963-aaa8-d59d95a2a381"
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

Logger.info "=========== Writing 12 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..12, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for KidProv at the Push Comedy Theater",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for KidProv at the Push Comedy Theater",
        price: 14000,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-13T03:44:13.284Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for KidProv at the Push Comedy Theater",
        status: "available",
        description: "Ticket for KidProv at the Push Comedy Theater",
        price: 14000,
        sale_start:  NaiveDateTime.from_iso8601!("2017-12-13T03:44:13.284Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="

Logger.info "=========== END Processing Universe Event KidProv at the Push Comedy Theater ==========="
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
    start_at:  NaiveDateTime.from_iso8601!("2017-11-27 23:30:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-01-09 02:30:00Z")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/c76ccb66-c7a5-4a89-95c4-c9c20824e139"
})
Logger.info "=========== Inserted cover photo for #{listing.id} ==========="

# Insert class
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "class"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 12 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..12, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for ​Improv 201 at the Push Comedy Theater",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for ​Improv 201 at the Push Comedy Theater",
        price: 19000,
        sale_start:  NaiveDateTime.from_iso8601!("2017-11-14T23:04:38.502Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for ​Improv 201 at the Push Comedy Theater",
        status: "available",
        description: "Ticket for ​Improv 201 at the Push Comedy Theater",
        price: 19000,
        sale_start:  NaiveDateTime.from_iso8601!("2017-11-14T23:04:38.502Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
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
    slug: "8BDW4V",
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
    start_at:  NaiveDateTime.from_iso8601!("2018-01-23 23:30:00Z"),
    end_at:  NaiveDateTime.from_iso8601!("2018-02-28 02:30:00Z")
  }
)
Logger.info "=========== Inserted Class Listing #{listing.id} ==========="

Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/988155d3-5ef5-494c-a005-0fabeb97240d"
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

Logger.info "=========== Writing 12 tickets for #{listing.id} ==========="
order = SeedHelpers.create_order(
  %{
    user_id: user.id, 
    credit_card_id: card.id,
    slug: Random.generate_slug(),
    status: "completed", 
    subtotal: 5000,
    credit_card_fee: 500,
    processing_fee: 500,
    total_price: 6000,
    completed_at: NaiveDateTime.utc_now()
  }
)

Enum.each(1..12, fn(x) ->
  ticket = case TicketAgent.Random.sample([true, true, false, true, false, true, true]) do
    true ->
      name = FakerElixir.Name.name()
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Improv 101 with Brad McMurran",
        status: TicketAgent.Random.sample(["purchased", "emailed"]),
        guest_name: FakerElixir.Name.name(),
        guest_email: FakerElixir.Internet.email(:popular, name),
        order_id: order.id,
        description: "Ticket for Improv 101 with Brad McMurran",
        price: 19000,
        sale_start:  NaiveDateTime.from_iso8601!("2017-11-24T05:44:08.919Z")
      }   
    false -> 
      %TicketAgent.Ticket{
        listing_id: listing.id,
        slug: Random.generate_slug(),
        name: "Ticket for Improv 101 with Brad McMurran",
        status: "available",
        description: "Ticket for Improv 101 with Brad McMurran",
        price: 19000,
        sale_start:  NaiveDateTime.from_iso8601!("2017-11-24T05:44:08.919Z")
      }
  end
  TicketAgent.Repo.insert!(ticket)
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="

Logger.info "=========== END Processing Universe Event Improv 101 with Brad McMurran ==========="
