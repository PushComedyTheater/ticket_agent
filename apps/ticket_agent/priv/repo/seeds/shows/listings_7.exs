require Logger

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
Logger.info "Seeding shows"
Logger.info "=========== BEGIN Processing Universe Event FREE SHOW! Ask the Audience: Your life in Improv ==========="

Logger.info "=========== Writing Event FREE SHOW! Ask the Audience: Your life in Improv ==========="
event = SeedHelpers.create_event(
  %{
    slug: "41BHGY",
    title: "FREE SHOW! Ask the Audience: Your life in Improv",
    description: """
    <p>From the people who brought you "Getting to Know the Couple" comes Ask The Audience: Your life in Improv!</p><p>The performers will interview a lucky group of people about their lives and use the information gathered to make up an entire performance. That's right, completely made up on the spot, based off of the audience members lives! The best part- it's a free show!</p><p>Ask the Audience: Your life in Improv<br>Saturday, June 11th at 10pm<br>This is a Free Show</p><p><br>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing FREE SHOW! Ask the Audience: Your life in Improv ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "41BHGY",
    title: "FREE SHOW! Ask the Audience: Your life in Improv",
    description: """
    <p>From the people who brought you "Getting to Know the Couple" comes Ask The Audience: Your life in Improv!</p><p>The performers will interview a lucky group of people about their lives and use the information gathered to make up an entire performance. That's right, completely made up on the spot, based off of the audience members lives! The best part- it's a free show!</p><p>Ask the Audience: Your life in Improv<br>Saturday, June 11th at 10pm<br>This is a Free Show</p><p><br>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-11T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-11T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1615241c-23db-41c2-9c87-c5f3c3b0cdb7",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/1615241c-23db-41c2-9c87-c5f3c3b0cdb7",
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
    name: "Ticket for FREE SHOW! Ask the Audience: Your life in Improv",
    status: "available",
    description: "Ticket for FREE SHOW! Ask the Audience: Your life in Improv",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2016-06-05T20:35:54.799Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event FREE SHOW! Ask the Audience: Your life in Improv ==========="
Logger.info "=========== BEGIN Processing Universe Event The 666 Project: A Horror Anthology Show ==========="

Logger.info "=========== Writing Event The 666 Project: A Horror Anthology Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "RFGK1H",
    title: "The 666 Project: A Horror Anthology Show",
    description: """
    <p style="text-align: center;"><strong>HAMPTON ROADS NEWEST HALLOWEEN TRADITION IS BACK!!!</strong>
</p>
<p style="text-align: center;"><br><br>In the grand tradition of The Twilight Zone and Tales from the Crypt comes <strong>The 666 Project: A Horror Anthology Show.</strong> The Push Comedy Theater has gathered six writers, six directors and six actors to bring you six rib-tickling, tales of terror.
</p>
<p style="text-align: center;"><br><br>Now in its third year, The 666 Project has become one of Hampton Roads hottest, Halloween tickets. Don't miss these tales of terror. Six nights... only at the Push Comedy Theater
</p>
<p style="text-align: center;"><br><br><strong>The 666 Project: A Halloween Show<br>directed by:</strong><br>Matt Cole, Core Theatre Ensemble, Jill Sweetland, Brant Powell, Christopher Bernhardt, and Alba Woolard.
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><strong>written by:</strong>
</p>
<p style="text-align: center;">Sean Devereux, Brant Powell, Adam Paine, Hayley Daniels and Noelle Peterson, Matt Hollman, and Buddy Hallmark.
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><strong>starring:</strong>
</p>
<p style="text-align: center;">Jen Weir Edwards, Anna Sosa, Meghan Elizabeth Collins, Keys Wrenn, Kasey Kennedy and Patrick C Taylor.
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><strong>The Push Comedy Theater is proud to present The 666 Project: A Horror Anthology Show!</strong>
</p>
<p style="text-align: center;">October 21, 26, 27, and 28 at 8pm
</p>
<p style="text-align: center;">October 22, and 29 at 7pm
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;">Tickets are $15 and are available at the link above or at pushcomedytheater.com
</p>
<p style="text-align: center;"><br><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p style="text-align: center;"><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The 666 Project: A Horror Anthology Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "RFGK1H",
    title: "The 666 Project: A Horror Anthology Show",
    description: """
    <p style="text-align: center;"><strong>HAMPTON ROADS NEWEST HALLOWEEN TRADITION IS BACK!!!</strong>
</p>
<p style="text-align: center;"><br><br>In the grand tradition of The Twilight Zone and Tales from the Crypt comes <strong>The 666 Project: A Horror Anthology Show.</strong> The Push Comedy Theater has gathered six writers, six directors and six actors to bring you six rib-tickling, tales of terror.
</p>
<p style="text-align: center;"><br><br>Now in its third year, The 666 Project has become one of Hampton Roads hottest, Halloween tickets. Don't miss these tales of terror. Six nights... only at the Push Comedy Theater
</p>
<p style="text-align: center;"><br><br><strong>The 666 Project: A Halloween Show<br>directed by:</strong><br>Matt Cole, Core Theatre Ensemble, Jill Sweetland, Brant Powell, Christopher Bernhardt, and Alba Woolard.
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><strong>written by:</strong>
</p>
<p style="text-align: center;">Sean Devereux, Brant Powell, Adam Paine, Hayley Daniels and Noelle Peterson, Matt Hollman, and Buddy Hallmark.
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><strong>starring:</strong>
</p>
<p style="text-align: center;">Jen Weir Edwards, Anna Sosa, Meghan Elizabeth Collins, Keys Wrenn, Kasey Kennedy and Patrick C Taylor.
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><strong>The Push Comedy Theater is proud to present The 666 Project: A Horror Anthology Show!</strong>
</p>
<p style="text-align: center;">October 21, 26, 27, and 28 at 8pm
</p>
<p style="text-align: center;">October 22, and 29 at 7pm
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;">Tickets are $15 and are available at the link above or at pushcomedytheater.com
</p>
<p style="text-align: center;"><br><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p style="text-align: center;"><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-10-21T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-10-30T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/00d2eb9c-b488-4917-b4e3-578d11ef3c0a",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/00d2eb9c-b488-4917-b4e3-578d11ef3c0a",
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

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The 666 Project: A Horror Anthology Show",
    status: "available",
    description: "Ticket for The 666 Project: A Horror Anthology Show",
    price: 1500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-27T15:56:37.552Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The 666 Project: A Horror Anthology Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Couples Therapy ==========="

Logger.info "=========== Writing Event Couples Therapy ==========="
event = SeedHelpers.create_event(
  %{
    slug: "SR7N6W",
    title: "Couples Therapy",
    description: """
    <p><strong></strong><strong>You think your relationship has problems?!?</strong></p><p>In Couples Therapy you'll meet a couple on the rocks... be it newlyweds on a honeymoon from hell or an elderly couple at the end of their rope.<br>Based on an audience suggestion, Sean and Brittany take you through a roller coaster ride of emotions as they whisk you the trials and tribulations of couple they create right before your eyes.</p><p>Oh yeah, and they do it all in a single, 25 minute long improvised scene.</p><p>Two Improvisers... One Scene!!!</p><p><strong>Couples Therapy... is sometimes hilarious, sometimes poignant, always magical.</strong></p><p>Sean Devereux and Brittany Shearer are members of the improv group, Alan Johnson and the Johnson Quintet. The duo have dazzled audience members at Improvageddon, and now they're getting their own show.</p><p>When not performing with the Quintet, Sean is a member of The Pushers and Brittany performs with The Pre Madonnas.</p><p>Sean and Brittany are not a couple in real life, but occasionally they play one on stage.</p><p><strong>Couples Therapy with Alan Johnson and the Alan Johnson Quintet</strong><br>Saturday, June 25th at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "SR7N6W",
    title: "Couples Therapy",
    description: """
    <p><strong></strong><strong>You think your relationship has problems?!?</strong></p><p>In Couples Therapy you'll meet a couple on the rocks... be it newlyweds on a honeymoon from hell or an elderly couple at the end of their rope.<br>Based on an audience suggestion, Sean and Brittany take you through a roller coaster ride of emotions as they whisk you the trials and tribulations of couple they create right before your eyes.</p><p>Oh yeah, and they do it all in a single, 25 minute long improvised scene.</p><p>Two Improvisers... One Scene!!!</p><p><strong>Couples Therapy... is sometimes hilarious, sometimes poignant, always magical.</strong></p><p>Sean Devereux and Brittany Shearer are members of the improv group, Alan Johnson and the Johnson Quintet. The duo have dazzled audience members at Improvageddon, and now they're getting their own show.</p><p>When not performing with the Quintet, Sean is a member of The Pushers and Brittany performs with The Pre Madonnas.</p><p>Sean and Brittany are not a couple in real life, but occasionally they play one on stage.</p><p><strong>Couples Therapy with Alan Johnson and the Alan Johnson Quintet</strong><br>Saturday, June 25th at 8pm<br>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-06-25T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-06-25T21:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-05-28T01:07:18.632Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Couples Therapy ==========="
Logger.info "=========== BEGIN Processing Universe Event The Neon Festival at the Push (FREE SHOW!!!) ==========="

Logger.info "=========== Writing Event The Neon Festival at the Push (FREE SHOW!!!) ==========="
event = SeedHelpers.create_event(
  %{
    slug: "SHKGXQ",
    title: "The Neon Festival at the Push (FREE SHOW!!!)",
    description: """
    <p style="text-align: center;"><strong>The NEON Festival comes to the Push!!!</strong>
</p>
<p style="text-align: center;">In honor of this amazing celebration, the Push will be hosting free improv shows all night long.
</p>
<p style="text-align: center;">Starting at 6:30 we will have a free improv shows every half hour featuring The Pushers and some of the Push Comedy Theater's funniest improvisers.
</p>
<p style="text-align: center;"><strong>The Neon Festival at the Push (FREE SHOW!!!)</strong>
</p>
<p style="text-align: center;">Friday, September 16th.  Free shows every half hour starting at 6:30
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><img src="https://s3.amazonaws.com/uniiverse_production/attachments/eb08a8ea396db86e840725c96160b9e7-NEON%20District.jpg" alt="" style="display: block; margin: auto;"><br>
</p>
<p style="text-align: center;">____________________________________________________
</p>The *third* NEON Festival is coming back to NFK Thursday, October 19 and Friday, October 19, 2017! This free festival welcomes everyone to experience the NEON District through art exhibitions, local and national performances and mural tours.
<p><br><br>Presented by <a href="https://www.facebook.com/bcartsupport/" rel="nofollow" target="_blank">Business Consortium for Arts Support</a> in partnership with<a href="https://www.facebook.com/DowntownNorfolk/" rel="nofollow" target="_blank">Downtown Norfolk</a>, <a href="https://www.facebook.com/ChryslerMuseum/" rel="nofollow" target="_blank">The Chrysler Museum of Art</a>, <a href="https://www.facebook.com/madebysway/" rel="nofollow" target="_blank">Sway Creative Labs</a> and<a href="https://www.facebook.com/OConnorBrewing/" rel="nofollow" target="_blank">O'Connor Brewing Co.</a>
</p>
<p><br><br>Highlights of the 2017 celebration include:<br>*Third Thursday at the Chrysler Museum and Glass Studio and d'Art Center, 5-10 pm<br>*The Plot Beer Garden and entertainment Friday evening, 6-10 pm<br>* Norfolk Public Art Commission ribbon cutting Friday at 5:30 pm
</p>
<p><br><br>Visit this page for updates on all the performances, entertainment, food &amp; drinks and public art that will ignite the district. It's going to electric!
</p>
<p><br><br>Want to volunteer during the festival? Sign up for a spot here: <a href="https://l.facebook.com/l.php?u=https%3A%2F%2Fdowntownnorfolk.wufoo.com%2Fforms%2Fqq16bx31t2uin4%2F&amp;h=ATMCXSj2ABTBe__c_PyF0xJ0OElWnHe9tyeLI3a0uhyRq5wzVv3WtRkGlL_WSRnsD8MbIXSKxuRb23qwE4JBDic25UUBoKVdqpF-8zftalag_0gSGSpylvokowffqPE_c7iiKuaWVbE7Ac8N-rwyh_xfO-IyYg9E4T1Fn9aCl4W3fkrmPAmy" rel="nofollow" target="_blank">https://<wbr>downtownnorfolk.wufoo.com/<wbr>forms/qq16bx31t2uin4/</wbr></wbr></a>
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Neon Festival at the Push (FREE SHOW!!!) ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "SHKGXQ",
    title: "The Neon Festival at the Push (FREE SHOW!!!)",
    description: """
    <p style="text-align: center;"><strong>The NEON Festival comes to the Push!!!</strong>
</p>
<p style="text-align: center;">In honor of this amazing celebration, the Push will be hosting free improv shows all night long.
</p>
<p style="text-align: center;">Starting at 6:30 we will have a free improv shows every half hour featuring The Pushers and some of the Push Comedy Theater's funniest improvisers.
</p>
<p style="text-align: center;"><strong>The Neon Festival at the Push (FREE SHOW!!!)</strong>
</p>
<p style="text-align: center;">Friday, September 16th.  Free shows every half hour starting at 6:30
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><img src="https://s3.amazonaws.com/uniiverse_production/attachments/eb08a8ea396db86e840725c96160b9e7-NEON%20District.jpg" alt="" style="display: block; margin: auto;"><br>
</p>
<p style="text-align: center;">____________________________________________________
</p>The *third* NEON Festival is coming back to NFK Thursday, October 19 and Friday, October 19, 2017! This free festival welcomes everyone to experience the NEON District through art exhibitions, local and national performances and mural tours.
<p><br><br>Presented by <a href="https://www.facebook.com/bcartsupport/" rel="nofollow" target="_blank">Business Consortium for Arts Support</a> in partnership with<a href="https://www.facebook.com/DowntownNorfolk/" rel="nofollow" target="_blank">Downtown Norfolk</a>, <a href="https://www.facebook.com/ChryslerMuseum/" rel="nofollow" target="_blank">The Chrysler Museum of Art</a>, <a href="https://www.facebook.com/madebysway/" rel="nofollow" target="_blank">Sway Creative Labs</a> and<a href="https://www.facebook.com/OConnorBrewing/" rel="nofollow" target="_blank">O'Connor Brewing Co.</a>
</p>
<p><br><br>Highlights of the 2017 celebration include:<br>*Third Thursday at the Chrysler Museum and Glass Studio and d'Art Center, 5-10 pm<br>*The Plot Beer Garden and entertainment Friday evening, 6-10 pm<br>* Norfolk Public Art Commission ribbon cutting Friday at 5:30 pm
</p>
<p><br><br>Visit this page for updates on all the performances, entertainment, food &amp; drinks and public art that will ignite the district. It's going to electric!
</p>
<p><br><br>Want to volunteer during the festival? Sign up for a spot here: <a href="https://l.facebook.com/l.php?u=https%3A%2F%2Fdowntownnorfolk.wufoo.com%2Fforms%2Fqq16bx31t2uin4%2F&amp;h=ATMCXSj2ABTBe__c_PyF0xJ0OElWnHe9tyeLI3a0uhyRq5wzVv3WtRkGlL_WSRnsD8MbIXSKxuRb23qwE4JBDic25UUBoKVdqpF-8zftalag_0gSGSpylvokowffqPE_c7iiKuaWVbE7Ac8N-rwyh_xfO-IyYg9E4T1Fn9aCl4W3fkrmPAmy" rel="nofollow" target="_blank">https://<wbr>downtownnorfolk.wufoo.com/<wbr>forms/qq16bx31t2uin4/</wbr></wbr></a>
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-10-20T18:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-10-20T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/0fdb5dc1-f4ee-46ef-bc85-d5146fbeb64d",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/0fdb5dc1-f4ee-46ef-bc85-d5146fbeb64d",
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

# Insert neon
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "neon"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for The Neon Festival at the Push (FREE SHOW!!!)",
    status: "available",
    description: "Ticket for The Neon Festival at the Push (FREE SHOW!!!)",
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-03T20:02:45.660Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Neon Festival at the Push (FREE SHOW!!!) ==========="
Logger.info "=========== BEGIN Processing Universe Event NCF: Improv Explosion (Saturday) ==========="

Logger.info "=========== Writing Event NCF: Improv Explosion (Saturday) ==========="
event = SeedHelpers.create_event(
  %{
    slug: "BVL718",
    title: "NCF: Improv Explosion (Saturday)",
    description: """
    <h3><strong>Chris Trew +2</strong></h3>
<p>Trew + 2 is Chris Trew plus two strangers from the audience with no improv experience who get a very quick lesson (less than 3 minutes). The three of them do a montage, the final scene being the first and only scene featuring only the two strangers who, strangely enough, always seem to figure it out and make something killer and memorable happen.
</p>
<p>Trew + 2 is a big hit on the comedy festival circuit and is appearing at several festivals this year.
</p>
<p><strong>About Chris:  </strong>Chris Trew is a full time comedian (“Trew is out of his fucking mind” - The Austin Chronicle) and part time professional wrestling manager (“a performance artist at the highest level” - The Wrestling Blog) splitting his time between New Orleans and Austin where he is the Creative Director of <a href="http://tnmcomedy.com/" rel="nofollow" target="_blank">The New Movement</a>, a comedy theater and training center that's home to events like Hell Yes Fest and the Megaphone Marathons.
</p>
<p>Trew has headlined comedy festivals all over the U.S. and has been featured in <a href="http://www.gq.com/story/air-sex" rel="nofollow" target="_blank">GQ Magazine</a>, Splitsider, the Sturgis Motorcycle Rally, America’s Got Talent, and many other strange things.  He helped “start a comedy scene from scratch” (<a href="http://splitsider.com/2014/12/how-the-new-movement-built-a-comedy-scene-from-scratch-in-new-orleans/" rel="nofollow" target="_blank">Splitsider</a>) and is the co-host of Air Sex Battles on MTV, debuting later this year.
</p>
<p>He was named "one of 10 comedians you should know" by Paper Magazine and is the co-author of Improv Wins, a book about improv that serves as the textbook at The New Movement.
</p>
<p>For bearded, out of the box comedy, your aim is Trew - <a href="http://www.starnewsonline.com/article/20150429/ENT/150429677?Title=Cape-Fear-Comedy-Festival-to-feature-Trew" rel="nofollow" target="_blank">Star News Online, Wilmington, North Carolina</a>
</p>
<p>Chris Trew’s Unabashedly Weird Comedy Comes to the Scruffy City Comedy Festival - <a href="http://www.knoxmercury.com/2015/11/11/chris-trews-unabashedly-weird-comedy-comes-to-the-scruffy-city-comedy-festival/" rel="nofollow" target="_blank">Knoxville Mercury</a>
</p>
<p>What Not to Miss at This Year's Chicago Improv Festival - <a href="http://chicagoist.com/2016/04/29/our_picks_for_chicago_improv_festiv.php" rel="nofollow" target="_blank">The Chicagoist</a>
</p>
<p><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Chris-Trew-2.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Chris-Trew-2-300x150.jpg" alt="Chris Trew 2" style="display: block; margin: auto;"></a>
</p>
<hr>
<h3><strong>Jet Pack</strong></h3>
<p>Andy Livengood (Theatre 99, Charleston SC) has assembled an improv team from all over the east coast. Charleston, Norfolk, New York come together to create a one of a kind improv experience. Fast, unpredictable , and explosive; Jet Pack combines lightning quick improv with grounded characters and scenes. Strap yourself in, you never know where Jet Pack will take you!
</p>
<p>Jet Pack Improv: you'll laugh so hard, you'll wet somebody else's pants!!
</p>
<p><strong>About Andy:</strong> Andy has been performing improv for over a decade. In that time he has studied at Theatre 99 (Charleston, SC), The Annoyance Theatre (Chicago), and The Upright Citizens Brigade Theatre (NY).
</p>
<p>He regularly performs at Theatre 99 where he was a founding member of the groups CLUTCH and Cats Hugging Cats. In 2010 Andy was voted Charleston's best comic.
</p>
<p>He is a massive improv nerd and will always geek out with fellow improvisers at bars after shows.
</p>
<p><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/13884383_10208237038617896_381051755_n.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/13884383_10208237038617896_381051755_n-225x300.jpg" alt="Jet Pack" style="display: block; margin: auto;"></a>
</p>
<p>__________________________<wbr>__<br><br>Coalition TourCo<br><br>Coalition TourCo are a premium blend of performers from Richmond, Virginia’s Coalition Theater. Since 2009, the Coalition have been producing high-energy, physical, weird longform improv shows.<br><br>Coalition Theater is Richmond's home for live comedy shows and improv, sketch and stand-up classes. Find out more info at <a href="http://l.facebook.com/l.php?u=http%3A%2F%2Frvacomedy.com%2F&amp;h=iAQEivz7V&amp;enc=AZPl_ig-RgEm46ezdM8cHESq3ddDiR9AhqBNta1S406hSRDhdGYnxp_GQU_P54RZ2og&amp;s=1" rel="nofollow" target="_blank">rvacomedy.com.</a> <br><br>Live Comedy. Dead Serious.<br>
</wbr></p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing NCF: Improv Explosion (Saturday) ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "BVL718",
    title: "NCF: Improv Explosion (Saturday)",
    description: """
    <h3><strong>Chris Trew +2</strong></h3>
<p>Trew + 2 is Chris Trew plus two strangers from the audience with no improv experience who get a very quick lesson (less than 3 minutes). The three of them do a montage, the final scene being the first and only scene featuring only the two strangers who, strangely enough, always seem to figure it out and make something killer and memorable happen.
</p>
<p>Trew + 2 is a big hit on the comedy festival circuit and is appearing at several festivals this year.
</p>
<p><strong>About Chris:  </strong>Chris Trew is a full time comedian (“Trew is out of his fucking mind” - The Austin Chronicle) and part time professional wrestling manager (“a performance artist at the highest level” - The Wrestling Blog) splitting his time between New Orleans and Austin where he is the Creative Director of <a href="http://tnmcomedy.com/" rel="nofollow" target="_blank">The New Movement</a>, a comedy theater and training center that's home to events like Hell Yes Fest and the Megaphone Marathons.
</p>
<p>Trew has headlined comedy festivals all over the U.S. and has been featured in <a href="http://www.gq.com/story/air-sex" rel="nofollow" target="_blank">GQ Magazine</a>, Splitsider, the Sturgis Motorcycle Rally, America’s Got Talent, and many other strange things.  He helped “start a comedy scene from scratch” (<a href="http://splitsider.com/2014/12/how-the-new-movement-built-a-comedy-scene-from-scratch-in-new-orleans/" rel="nofollow" target="_blank">Splitsider</a>) and is the co-host of Air Sex Battles on MTV, debuting later this year.
</p>
<p>He was named "one of 10 comedians you should know" by Paper Magazine and is the co-author of Improv Wins, a book about improv that serves as the textbook at The New Movement.
</p>
<p>For bearded, out of the box comedy, your aim is Trew - <a href="http://www.starnewsonline.com/article/20150429/ENT/150429677?Title=Cape-Fear-Comedy-Festival-to-feature-Trew" rel="nofollow" target="_blank">Star News Online, Wilmington, North Carolina</a>
</p>
<p>Chris Trew’s Unabashedly Weird Comedy Comes to the Scruffy City Comedy Festival - <a href="http://www.knoxmercury.com/2015/11/11/chris-trews-unabashedly-weird-comedy-comes-to-the-scruffy-city-comedy-festival/" rel="nofollow" target="_blank">Knoxville Mercury</a>
</p>
<p>What Not to Miss at This Year's Chicago Improv Festival - <a href="http://chicagoist.com/2016/04/29/our_picks_for_chicago_improv_festiv.php" rel="nofollow" target="_blank">The Chicagoist</a>
</p>
<p><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Chris-Trew-2.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/Chris-Trew-2-300x150.jpg" alt="Chris Trew 2" style="display: block; margin: auto;"></a>
</p>
<hr>
<h3><strong>Jet Pack</strong></h3>
<p>Andy Livengood (Theatre 99, Charleston SC) has assembled an improv team from all over the east coast. Charleston, Norfolk, New York come together to create a one of a kind improv experience. Fast, unpredictable , and explosive; Jet Pack combines lightning quick improv with grounded characters and scenes. Strap yourself in, you never know where Jet Pack will take you!
</p>
<p>Jet Pack Improv: you'll laugh so hard, you'll wet somebody else's pants!!
</p>
<p><strong>About Andy:</strong> Andy has been performing improv for over a decade. In that time he has studied at Theatre 99 (Charleston, SC), The Annoyance Theatre (Chicago), and The Upright Citizens Brigade Theatre (NY).
</p>
<p>He regularly performs at Theatre 99 where he was a founding member of the groups CLUTCH and Cats Hugging Cats. In 2010 Andy was voted Charleston's best comic.
</p>
<p>He is a massive improv nerd and will always geek out with fellow improvisers at bars after shows.
</p>
<p><a href="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/13884383_10208237038617896_381051755_n.jpg" rel="nofollow" target="_blank"><img src="http://norfolkcomedyfestival.com/wp-content/uploads/2016/07/13884383_10208237038617896_381051755_n-225x300.jpg" alt="Jet Pack" style="display: block; margin: auto;"></a>
</p>
<p>__________________________<wbr>__<br><br>Coalition TourCo<br><br>Coalition TourCo are a premium blend of performers from Richmond, Virginia’s Coalition Theater. Since 2009, the Coalition have been producing high-energy, physical, weird longform improv shows.<br><br>Coalition Theater is Richmond's home for live comedy shows and improv, sketch and stand-up classes. Find out more info at <a href="http://l.facebook.com/l.php?u=http%3A%2F%2Frvacomedy.com%2F&amp;h=iAQEivz7V&amp;enc=AZPl_ig-RgEm46ezdM8cHESq3ddDiR9AhqBNta1S406hSRDhdGYnxp_GQU_P54RZ2og&amp;s=1" rel="nofollow" target="_blank">rvacomedy.com.</a> <br><br>Live Comedy. Dead Serious.<br>
</wbr></p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-09-10T21:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-09-10T22:45:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8caef2a3-2bd6-44e1-870b-56d9426f40eb",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/8caef2a3-2bd6-44e1-870b-56d9426f40eb",
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

# Insert ncf
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "ncf"
})
Logger.info "=========== Wrote tag ==========="

# Insert norfolk
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "norfolk"
})
Logger.info "=========== Wrote tag ==========="

# Insert comedy
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "comedy"
})
Logger.info "=========== Wrote tag ==========="

# Insert festival
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "festival"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for NCF: Improv Explosion (Saturday)",
    status: "available",
    description: "Ticket for NCF: Improv Explosion (Saturday)",
    price: 1200,
    sale_start:  NaiveDateTime.from_iso8601!("2016-08-01T04:47:50.185Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event NCF: Improv Explosion (Saturday) ==========="
Logger.info "=========== BEGIN Processing Universe Event New Harold Night ==========="

Logger.info "=========== Writing Event New Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "WQX9T8",
    title: "New Harold Night",
    description: """
    <p><strong>It's New Harold Night at the Push Comedy Theater!</strong></p><p>Don't miss it as we unveil our brand, new house teams... <strong>The Cahoots </strong>and <strong>Third Choice</strong>!!!</p><p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p><strong>New Harold Night</strong> </p><p>Friday, February 26th at 10:00pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "WQX9T8",
    title: "New Harold Night",
    description: """
    <p><strong>It's New Harold Night at the Push Comedy Theater!</strong></p><p>Don't miss it as we unveil our brand, new house teams... <strong>The Cahoots </strong>and <strong>Third Choice</strong>!!!</p><p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?</p><p>The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.</p><p><strong>New Harold Night</strong> </p><p>Friday, February 26th at 10:00pm</p><p>Tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. </p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-02-26T22:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-02-26T23:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/6b3f3352-7942-44cf-b985-f0769f7b558d",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/6b3f3352-7942-44cf-b985-f0769f7b558d",
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
    price: 0,
    sale_start:  NaiveDateTime.from_iso8601!("2016-02-04T05:25:09.109Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event New Harold Night ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 101 Grad Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 101 Grad Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "LHDNK4",
    title: "Class Dismissed: The Improv 101 Grad Show",
    description: """
    <p>Dust off those caps and gowns... because it's graduation time at the Push.
</p>
<p>Check out the Push Comedy Theater's Improv 101 class as they show off their comedy chops.
</p>
<p>You won't believe what these improv newcomers have in store for you!!!
</p>
<p>Class Dismissed: The Improv 101 Graduation Show<br>Tuesday, September 5th at 8pm<br>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts will host live sketch and improv comedy on Friday and Saturday nights. During the week classes are offered in sketch writing, improv comedy and acting.
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
Logger.info "=========== Writing Event Listing Class Dismissed: The Improv 101 Grad Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "LHDNK4",
    title: "Class Dismissed: The Improv 101 Grad Show",
    description: """
    <p>Dust off those caps and gowns... because it's graduation time at the Push.
</p>
<p>Check out the Push Comedy Theater's Improv 101 class as they show off their comedy chops.
</p>
<p>You won't believe what these improv newcomers have in store for you!!!
</p>
<p>Class Dismissed: The Improv 101 Graduation Show<br>Tuesday, September 5th at 8pm<br>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts will host live sketch and improv comedy on Friday and Saturday nights. During the week classes are offered in sketch writing, improv comedy and acting.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-09-05T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-09-05T21:30:00.000-04:00")
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
    name: "Ticket for Class Dismissed: The Improv 101 Grad Show",
    status: "available",
    description: "Ticket for Class Dismissed: The Improv 101 Grad Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-08-29T20:07:45.976Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 101 Grad Show ==========="
Logger.info "=========== BEGIN Processing Universe Event Harold Night ==========="

Logger.info "=========== Writing Event Harold Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "PCKVD4",
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
<p>Friday, May 26th at 10:00pm
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
    slug: "PCKVD4",
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
<p>Friday, May 26th at 10:00pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-05-26T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-05-26T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-04-25T00:56:21.183Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Harold Night ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 101 Grad Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 101 Grad Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "W5ZHBK",
    title: "Class Dismissed: The Improv 101 Grad Show",
    description: """
    <p>Dust off those caps and gowns... because it's graduation time at the Push.
</p>
<p>Check out the Push Comedy Theater's Improv 101 class as they show off their comedy chops.
</p>
<p>You won't believe what these improv newcomers have in store for you!!!
</p>
<p>Class Dismissed: The Improv 101 Graduation Show<br>Tuesday, April 25th at 8pm<br>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts will host live sketch and improv comedy on Friday and Saturday nights. During the week classes are offered in sketch writing, improv comedy and acting.
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
Logger.info "=========== Writing Event Listing Class Dismissed: The Improv 101 Grad Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "W5ZHBK",
    title: "Class Dismissed: The Improv 101 Grad Show",
    description: """
    <p>Dust off those caps and gowns... because it's graduation time at the Push.
</p>
<p>Check out the Push Comedy Theater's Improv 101 class as they show off their comedy chops.
</p>
<p>You won't believe what these improv newcomers have in store for you!!!
</p>
<p>Class Dismissed: The Improv 101 Graduation Show<br>Tuesday, April 25th at 8pm<br>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts will host live sketch and improv comedy on Friday and Saturday nights. During the week classes are offered in sketch writing, improv comedy and acting.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-04-25T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-04-25T21:30:00.000-04:00")
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
    name: "Ticket for Class Dismissed: The Improv 101 Grad Show",
    status: "available",
    description: "Ticket for Class Dismissed: The Improv 101 Grad Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-04-18T22:50:55.173Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 101 Grad Show ==========="
Logger.info "=========== BEGIN Processing Universe Event 3 on 3 Improv Tournament - Sweet 16 Eastern Region ==========="

Logger.info "=========== Writing Event 3 on 3 Improv Tournament - Sweet 16 Eastern Region ==========="
event = SeedHelpers.create_event(
  %{
    slug: "QJH450",
    title: "3 on 3 Improv Tournament - Sweet 16 Eastern Region",
    description: """
    <p><strong></strong><strong>IT'S MARCH MADNESS AT THE PUSH!!!</strong>
</p>
<p>We're proud to announce the return of the Push Comedy Theater 3 on 3 Improv Tournament.
</p>
<p>Don't miss it as 16 teams battle it out in an elimination style competition for 3 on 3 improv supremacy! Will one of the improv powerhouses be crowned champion, or will a Cinderella story take it all?
</p>
<p>It all starts with the sweet 16! <br>Each team will be given just five minutes to dazzle both the audience and our secret panel of judges with their improv skills.
</p>
<p>Don't miss these great match ups:
</p>
<p><strong>Eastern Region </strong><br>Line Up TBA
</p>
<p><strong>3 on 3 Improv Tournament - Sweet 16 Eastern Region</strong><br>Friday, 8pm at the Push Comedy Theater<br>Tickets are $5
</p>
<p>This event is going to be huge, so get your tickets now.
</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing 3 on 3 Improv Tournament - Sweet 16 Eastern Region ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "QJH450",
    title: "3 on 3 Improv Tournament - Sweet 16 Eastern Region",
    description: """
    <p><strong></strong><strong>IT'S MARCH MADNESS AT THE PUSH!!!</strong>
</p>
<p>We're proud to announce the return of the Push Comedy Theater 3 on 3 Improv Tournament.
</p>
<p>Don't miss it as 16 teams battle it out in an elimination style competition for 3 on 3 improv supremacy! Will one of the improv powerhouses be crowned champion, or will a Cinderella story take it all?
</p>
<p>It all starts with the sweet 16! <br>Each team will be given just five minutes to dazzle both the audience and our secret panel of judges with their improv skills.
</p>
<p>Don't miss these great match ups:
</p>
<p><strong>Eastern Region </strong><br>Line Up TBA
</p>
<p><strong>3 on 3 Improv Tournament - Sweet 16 Eastern Region</strong><br>Friday, 8pm at the Push Comedy Theater<br>Tickets are $5
</p>
<p>This event is going to be huge, so get your tickets now.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-03-10T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-10T21:30:00.000-05:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/70fe8a03-210d-4c0e-b849-b3182f8402e4",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/70fe8a03-210d-4c0e-b849-b3182f8402e4",
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

# Insert tournament
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "tournament"
})
Logger.info "=========== Wrote tag ==========="

Logger.info "=========== Writing 80 tickets for #{listing.id} ==========="
Enum.each(1..80, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    user_id: nil,
    name: "Ticket for 3 on 3 Improv Tournament - Sweet 16 Eastern Region",
    status: "available",
    description: "Ticket for 3 on 3 Improv Tournament - Sweet 16 Eastern Region",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-02-07T06:02:21.328Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event 3 on 3 Improv Tournament - Sweet 16 Eastern Region ==========="
Logger.info "=========== BEGIN Processing Universe Event The Improvised Apocalypse ==========="

Logger.info "=========== Writing Event The Improvised Apocalypse ==========="
event = SeedHelpers.create_event(
  %{
    slug: "T3JDL4",
    title: "The Improvised Apocalypse",
    description: """
    <p><strong>The End Is Here!!!</strong></p><p>Armageddon is upon us... and it's hilarious. <br>The Improvised Apocalypse is a brand new show detailing the end of the world... and it's all made up on the spot. </p><p>It starts with a single audience suggestion and from there it's a wild and chaotic, madcap romp as the world goes to hell in a handbasket.</p><p>From zombies to robots, Mayan curses to an army of chickens, the end of the world has never been so fun! </p><p>Don't miss the Push Comedy Theater debut of The Improvised Apocalypse!!!</p><p><strong style="background-color: initial;"></strong></p><p><strong>The Improvised Apocalypse</strong><br>Friday, August 15 at 10pm.<br>Tickets are $5</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing The Improvised Apocalypse ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "T3JDL4",
    title: "The Improvised Apocalypse",
    description: """
    <p><strong>The End Is Here!!!</strong></p><p>Armageddon is upon us... and it's hilarious. <br>The Improvised Apocalypse is a brand new show detailing the end of the world... and it's all made up on the spot. </p><p>It starts with a single audience suggestion and from there it's a wild and chaotic, madcap romp as the world goes to hell in a handbasket.</p><p>From zombies to robots, Mayan curses to an army of chickens, the end of the world has never been so fun! </p><p>Don't miss the Push Comedy Theater debut of The Improvised Apocalypse!!!</p><p><strong style="background-color: initial;"></strong></p><p><strong>The Improvised Apocalypse</strong><br>Friday, August 15 at 10pm.<br>Tickets are $5</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-15T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-15T23:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/cab78257-94c7-4b8f-8f0a-b95244c0c721",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/cab78257-94c7-4b8f-8f0a-b95244c0c721",
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
    name: "Ticket for The Improvised Apocalypse",
    status: "available",
    description: "Ticket for The Improvised Apocalypse",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-01T00:50:04.978Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event The Improvised Apocalypse ==========="
Logger.info "=========== BEGIN Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="

Logger.info "=========== Writing Event Girl-Prov: The Girls' Night of Improv ==========="
event = SeedHelpers.create_event(
  %{
    slug: "Y32H8G",
    title: "Girl-Prov: The Girls' Night of Improv",
    description: """
    <p><strong></strong><strong>GET READY FOR GIRL'S NIGHT!</strong></p><p>Move over, gentleman! <br>The ladies are taking over for a girls' night!</p><p>GirlProv is an all-female improv group, making audiences lose it with laughter at the Push Comedy Theater.</p><p>It's slumber party meets night out on the town meet sorority house party! </p><p>Don't miss this night of comedy- all made up on the spot from the audience's suggestion!</p><p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, May 13th at the Push Comedy Theater<br>The show starts at 10, tickets are $5</p><p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">pushcomedytheater.com</a></p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
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
    slug: "Y32H8G",
    title: "Girl-Prov: The Girls' Night of Improv",
    description: """
    <p><strong></strong><strong>GET READY FOR GIRL'S NIGHT!</strong></p><p>Move over, gentleman! <br>The ladies are taking over for a girls' night!</p><p>GirlProv is an all-female improv group, making audiences lose it with laughter at the Push Comedy Theater.</p><p>It's slumber party meets night out on the town meet sorority house party! </p><p>Don't miss this night of comedy- all made up on the spot from the audience's suggestion!</p><p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, May 13th at the Push Comedy Theater<br>The show starts at 10, tickets are $5</p><p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">pushcomedytheater.com</a></p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street and in the lot directly behind the theater.</p><p>---</p><p>The Pushers are Virginia's premiere sketch and improv comedy group. For nearly ten years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. This fall they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.</p><p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country. </p><p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.</p><p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.</p><p>--</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting. </p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-05-13T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-05-13T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2016-04-29T23:24:53.515Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Girl-Prov: The Girls' Night of Improv ==========="
Logger.info "=========== BEGIN Processing Universe Event Double Feature: The Made Up Movie ==========="

Logger.info "=========== Writing Event Double Feature: The Made Up Movie ==========="
event = SeedHelpers.create_event(
  %{
    slug: "B2RWVD",
    title: "Double Feature: The Made Up Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong>
</p>
<p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.
</p>
<p><strong>Double Feature: The Totally Improvised Movie</strong><br>Friday, March 31st at 10pm
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
Logger.info "=========== Writing Event Listing Double Feature: The Made Up Movie ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "B2RWVD",
    title: "Double Feature: The Made Up Movie",
    description: """
    <p><strong></strong><strong>Double Feature is back for another round of made up, movie mayhem!!!!</strong>
</p>
<p>Who needs Hollywood! With a single audience suggestion an entire movie is created right before your eyes. Courageous heroes... dastardly villains... mind blowing special effects... you'll see it all and more crammed into two 25 minutes sets of improv magic.
</p>
<p><strong>Double Feature: The Totally Improvised Movie</strong><br>Friday, March 31st at 10pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-03-31T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-31T23:30:00.000-04:00")
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
    name: "Ticket for Double Feature: The Made Up Movie",
    status: "available",
    description: "Ticket for Double Feature: The Made Up Movie",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-27T00:07:21.861Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Double Feature: The Made Up Movie ==========="
Logger.info "=========== BEGIN Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="

Logger.info "=========== Writing Event Who Dunnit? ...The Improvised Murder Mystery ==========="
event = SeedHelpers.create_event(
  %{
    slug: "2160QL",
    title: "Who Dunnit? ...The Improvised Murder Mystery",
    description: """
    <p><strong></strong><strong>Get ready for a spine tingling murder mystery!!!</strong>
</p>
<p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.
</p>
<p>...And it will all be made up on the spot!!!
</p>
<p>Don't miss this exciting mystery, all based off the audience's suggestion.
</p>
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, July 9th at the Push Comedy Theater<br>The show starts at 8, tickets are $5
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
Logger.info "=========== Writing Event Listing Who Dunnit? ...The Improvised Murder Mystery ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "2160QL",
    title: "Who Dunnit? ...The Improvised Murder Mystery",
    description: """
    <p><strong></strong><strong>Get ready for a spine tingling murder mystery!!!</strong>
</p>
<p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.
</p>
<p>...And it will all be made up on the spot!!!
</p>
<p>Don't miss this exciting mystery, all based off the audience's suggestion.
</p>
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, July 9th at the Push Comedy Theater<br>The show starts at 8, tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2016-07-09T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-07-09T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/7d572d4b-55ee-4ddc-a041-0e9f94cd8ba6",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/7d572d4b-55ee-4ddc-a041-0e9f94cd8ba6",
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

# Insert murder-mystery
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "murder-mystery"
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
    name: "Ticket for Who Dunnit? ...The Improvised Murder Mystery",
    status: "available",
    description: "Ticket for Who Dunnit? ...The Improvised Murder Mystery",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-06-20T02:12:34.573Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="
Logger.info "=========== BEGIN Processing Universe Event Teacher's Pet ==========="

Logger.info "=========== Writing Event Teacher's Pet ==========="
event = SeedHelpers.create_event(
  %{
    slug: "KMSBPR",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Friday, October 13th, 10pm<br>Tickets are $5
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
    slug: "KMSBPR",
    title: "Teacher's Pet",
    description: """
    <p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Friday, October 13th, 10pm<br>Tickets are $5
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
    start_at:  NaiveDateTime.from_iso8601!("2017-10-13T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-10-13T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-07T00:31:26.057Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Teacher's Pet ==========="
Logger.info "=========== BEGIN Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery - October ==========="

Logger.info "=========== Writing Event Who Dunnit? ...The Improvised Murder Mystery - October ==========="
event = SeedHelpers.create_event(
  %{
    slug: "S6CJ9N",
    title: "Who Dunnit? ...The Improvised Murder Mystery - October",
    description: """
    <p><strong>Get ready for a spine tingling murder mystery!!!</strong><br>
</p>
<p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.
</p>
<p>...And it will all be made up on the spot!!!
</p>
<p>Don't miss this exciting mystery, all based off the audience's suggestion.
</p>
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, October 14th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $10
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
Logger.info "=========== Writing Event Listing Who Dunnit? ...The Improvised Murder Mystery - October ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "S6CJ9N",
    title: "Who Dunnit? ...The Improvised Murder Mystery - October",
    description: """
    <p><strong>Get ready for a spine tingling murder mystery!!!</strong><br>
</p>
<p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.
</p>
<p>...And it will all be made up on the spot!!!
</p>
<p>Don't miss this exciting mystery, all based off the audience's suggestion.
</p>
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, October 14th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $10
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
    start_at:  NaiveDateTime.from_iso8601!("2017-10-14T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-10-14T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/e736e2a2-4950-4b7c-b606-f0ce63e26dff",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/e736e2a2-4950-4b7c-b606-f0ce63e26dff",
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

# Insert murder-mystery
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "murder-mystery"
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
    name: "Ticket for Who Dunnit? ...The Improvised Murder Mystery - October",
    status: "available",
    description: "Ticket for Who Dunnit? ...The Improvised Murder Mystery - October",
    price: 1000,
    sale_start:  NaiveDateTime.from_iso8601!("2017-09-08T22:52:28.566Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery - October ==========="
Logger.info "=========== BEGIN Processing Universe Event Class Dismissed: The Improv 101 Grad Show ==========="

Logger.info "=========== Writing Event Class Dismissed: The Improv 101 Grad Show ==========="
event = SeedHelpers.create_event(
  %{
    slug: "MS85Z7",
    title: "Class Dismissed: The Improv 101 Grad Show",
    description: """
    <p>Dust off those caps and gowns... because it's graduation time at the Push.
</p>
<p>Check out the Push Comedy Theater's Improv 101 class as they show off their comedy chops.
</p>
<p>You won't believe what these improv newcomers have in store for you!!!
</p>
<p>Class Dismissed: The Improv 101 Graduation Show<br>Tuesday, March 7th at 8pm<br>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts will host live sketch and improv comedy on Friday and Saturday nights. During the week classes are offered in sketch writing, improv comedy and acting.
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
Logger.info "=========== Writing Event Listing Class Dismissed: The Improv 101 Grad Show ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "MS85Z7",
    title: "Class Dismissed: The Improv 101 Grad Show",
    description: """
    <p>Dust off those caps and gowns... because it's graduation time at the Push.
</p>
<p>Check out the Push Comedy Theater's Improv 101 class as they show off their comedy chops.
</p>
<p>You won't believe what these improv newcomers have in store for you!!!
</p>
<p>Class Dismissed: The Improv 101 Graduation Show<br>Tuesday, March 7th at 8pm<br>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts will host live sketch and improv comedy on Friday and Saturday nights. During the week classes are offered in sketch writing, improv comedy and acting.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2017-03-07T20:00:00.000-05:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-03-07T21:30:00.000-05:00")
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
    name: "Ticket for Class Dismissed: The Improv 101 Grad Show",
    status: "available",
    description: "Ticket for Class Dismissed: The Improv 101 Grad Show",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-03-06T01:38:20.133Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Class Dismissed: The Improv 101 Grad Show ==========="
Logger.info "=========== BEGIN Processing Universe Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="

Logger.info "=========== Writing Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
event = SeedHelpers.create_event(
  %{
    slug: "7CPZWX",
    title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    description: """
    <p><strong>Don't miss this epic sketch comedy showdown, where truly anything can happen.</strong><br>
</p>
<p>And we do mean anything!!!  Sometimes it's funny, sometimes it's weird, it's always entertaining.
</p>
<p>SKETCHMAGEDDON
</p>
<p>Last month... the champ, 3 Star Review was taken down by the rookies, Congratulatory BJs!  Will the BJs be able to hold onto their crown... or will a new team claim the thrown?!?!?<br>
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
<p>Friday, November 13th at 10pm
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
    slug: "7CPZWX",
    title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
    description: """
    <p><strong>Don't miss this epic sketch comedy showdown, where truly anything can happen.</strong><br>
</p>
<p>And we do mean anything!!!  Sometimes it's funny, sometimes it's weird, it's always entertaining.
</p>
<p>SKETCHMAGEDDON
</p>
<p>Last month... the champ, 3 Star Review was taken down by the rookies, Congratulatory BJs!  Will the BJs be able to hold onto their crown... or will a new team claim the thrown?!?!?<br>
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
<p>Friday, November 13th at 10pm
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
    start_at:  NaiveDateTime.from_iso8601!("2017-11-03T22:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-11-03T23:30:00.000-04:00")
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
    sale_start:  NaiveDateTime.from_iso8601!("2017-10-13T20:25:14.389Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition ==========="
Logger.info "=========== BEGIN Processing Universe Event Date Night ==========="

Logger.info "=========== Writing Event Date Night ==========="
event = SeedHelpers.create_event(
  %{
    slug: "MNVYG3",
    title: "Date Night",
    description: """
    <p><strong>Get ready as we improvise your relationship.</strong>
</p>
<p>It's the most fun you'll ever have on date night!
</p>
<p>Two lucky couples will see their love unfold on stage through the interpretation of 2 of Hampton Roads' wackiest improvisers!
</p>
<p>The couples will be selected at random and interviewed on stage in front of the audience. Using the information they learn, and their imagination, Brad and Alba will show the story of the couples' love.
</p>
<p>For years, The Pushers have been getting to know diverse couples all across Hampton Roads with this signature piece. Normally this is a piece within a larger show. This time, Brad and Alba are out to explore as much as possible by bringing it to you as its own show!
</p>
<p><br>
</p>
<p><strong>Date Night: With Brad and Alba</strong>
</p>
<p>Friday, July 7th at 8pm
</p>
<p>Tickets are $5
</p>
<p>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For more than 11 years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In November of 2014, they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
</p>
<p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.
</p>
<p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.
</p>
<p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.
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
Logger.info "=========== Writing Event Listing Date Night ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "MNVYG3",
    title: "Date Night",
    description: """
    <p><strong>Get ready as we improvise your relationship.</strong>
</p>
<p>It's the most fun you'll ever have on date night!
</p>
<p>Two lucky couples will see their love unfold on stage through the interpretation of 2 of Hampton Roads' wackiest improvisers!
</p>
<p>The couples will be selected at random and interviewed on stage in front of the audience. Using the information they learn, and their imagination, Brad and Alba will show the story of the couples' love.
</p>
<p>For years, The Pushers have been getting to know diverse couples all across Hampton Roads with this signature piece. Normally this is a piece within a larger show. This time, Brad and Alba are out to explore as much as possible by bringing it to you as its own show!
</p>
<p><br>
</p>
<p><strong>Date Night: With Brad and Alba</strong>
</p>
<p>Friday, July 7th at 8pm
</p>
<p>Tickets are $5
</p>
<p>---
</p>
<p>The Pushers are Virginia's premiere sketch and improv comedy group. For more than 11 years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In November of 2014, they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.
</p>
<p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.
</p>
<p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.
</p>
<p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.
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
    start_at:  NaiveDateTime.from_iso8601!("2017-07-07T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2017-07-07T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bf63f02d-8d84-498a-a366-80c9f1ebe22f",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/bf63f02d-8d84-498a-a366-80c9f1ebe22f",
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

# Insert date-night
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "date-night"
})
Logger.info "=========== Wrote tag ==========="

# Insert sketch
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "sketch"
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
    name: "Ticket for Date Night",
    status: "available",
    description: "Ticket for Date Night",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2017-07-03T16:19:53.134Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Date Night ==========="
Logger.info "=========== BEGIN Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="

Logger.info "=========== Writing Event Who Dunnit? ...The Improvised Murder Mystery ==========="
event = SeedHelpers.create_event(
  %{
    slug: "QVP9CT",
    title: "Who Dunnit? ...The Improvised Murder Mystery",
    description: """
    <p><strong></strong><strong>Get ready for a spine tingling murder mystery!!!</strong></p><p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.</p><p>...And it will all be made up on the spot!!!</p><p>Don't miss this exciting mystery, all based off the audience's suggestion.</p><p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, April 9th at the Push Comedy Theater<br>The show starts at 8, tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "normal",
    account_id: account.id,
    user_id: user.id
  }
)
Logger.info "=========== Inserted Event #{event.id} ==========="
Logger.info "=========== Writing Event Listing Who Dunnit? ...The Improvised Murder Mystery ==========="
listing = SeedHelpers.create_listing(
  %{
    user_id: user.id,
    event_id: event.id,
    class_id: nil,
    slug: "QVP9CT",
    title: "Who Dunnit? ...The Improvised Murder Mystery",
    description: """
    <p><strong></strong><strong>Get ready for a spine tingling murder mystery!!!</strong></p><p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.</p><p>...And it will all be made up on the spot!!!</p><p>Don't miss this exciting mystery, all based off the audience's suggestion.</p><p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, April 9th at the Push Comedy Theater<br>The show starts at 8, tickets are $5</p><p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.</p><p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.</p><p>---</p><p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.</p><p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.</p><p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.</p>
    """,
    status: "active",
    start_at:  NaiveDateTime.from_iso8601!("2016-04-09T20:00:00.000-04:00"),
    end_at:  NaiveDateTime.from_iso8601!("2016-04-09T21:30:00.000-04:00")
  }
)
Logger.info "=========== Inserted Event Listing #{listing.id} ==========="

Logger.info "=========== Writing social photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/7d572d4b-55ee-4ddc-a041-0e9f94cd8ba6",
  type: "social"
})
Logger.info "=========== Inserted social photo for #{listing.id} ==========="
Logger.info "=========== Writing cover photo for #{listing.id} ==========="
SeedHelpers.create_image(%{
  listing_id: listing.id,
  url: "https://res.cloudinary.com/push-comedy-theater/image/upload/7d572d4b-55ee-4ddc-a041-0e9f94cd8ba6",
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

# Insert murder-mystery
Logger.info "=========== Writing tag ==========="
SeedHelpers.create_tag(%{
  listing_id: listing.id,
  tag: "murder-mystery"
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
    name: "Ticket for Who Dunnit? ...The Improvised Murder Mystery",
    status: "available",
    description: "Ticket for Who Dunnit? ...The Improvised Murder Mystery",
    price: 500,
    sale_start:  NaiveDateTime.from_iso8601!("2016-03-12T23:06:55.646Z")
  }
  |> TicketAgent.Repo.insert!
  Logger.info "=========== Inserted ticket ##{x} for #{listing.id} ==========="
end)
Logger.info "=========== Inserted 80 tickets for #{listing.id} ==========="
Logger.info "=========== END Processing Universe Event Who Dunnit? ...The Improvised Murder Mystery ==========="
