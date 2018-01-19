account = TicketAgent.Repo.one(from x in TicketAgent.Account, order_by: [desc: x.id], limit: 1)
user = TicketAgent.Repo.one(from x in TicketAgent.User, order_by: [desc: x.id], limit: 1)
description = """
<p><strong>Jump into the wonderful and wild world of improv comedy!!!</strong>
</p>
<p><br>Learn the beginnings of Chicago-based, long form improv. Students will learn how to create scenes based off of audience suggestions. They will learn the fundamentals of 'Yes, And,' how to support scene partners' ideas and energy, and how to make strong character choices.
</p>
<p>Absolutely no experience in acting or comedy is needed. The Push Comedy Theater strives to create a fun, safe and supportive experience for all students.
</p>
<p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.
</p>
<p>This class meets six times from 6:30pm-9:30pm on Tuesday nights from September 26th through November 7th. There will be no class on October 17th.
</p>
<p>Cost: $190
</p>
<p><br>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: improv101.id,
type: "class",
title: "Improv 101 with Brad McMurran",
slug: "TGK8D1",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-09-26T18:30:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-07T21:30:00.000-05:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/988155d3-5ef5-494c-a005-0fabeb97240d/-/resize/1200x/-/crop/1200x1200/0,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/988155d3-5ef5-494c-a005-0fabeb97240d/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!
description = """
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
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: teen_improv.id,
type: "class",
title: "Improv for Teens at the Push Comedy Theater",
slug: "W15SH2",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-09-30T13:00:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-04T15:00:00.000-04:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/02e47add-c2da-4f40-a319-78867643f4b6/-/resize/1200x/-/crop/900x900/162,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/02e47add-c2da-4f40-a319-78867643f4b6/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!
description = """
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
<p><strong>This class is held on Saturday afternoons, 3pm-6pm, September 30th through November 11th.</strong>
</p>
<p><strong>***There will be no class on October 21st***</strong>
</p>
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: music_improv101.id,
type: "class",
title: "Musical Improv 101",
slug: "29V7XQ",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-09-30T15:00:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-11T18:00:00.000-05:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/23e6339b-5e4c-4e6b-9a88-98524c89699d/-/resize/1200x/-/crop/750x750/0,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/23e6339b-5e4c-4e6b-9a88-98524c89699d/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!
description = """
<p>Don't miss out on the fun!!! Sign up your kids, grand kids, nieces, nephews, even the stinky neighbor kid from down the street for KidProv at the Push Comedy Theater.
</p>
<p>This class is open to children ages 7 to 12 who have taken Kid Prov 101 classes or camps a minimum of 3 times.
</p>
<p>Students will explore the key elements of both long and short form improvisation and will learn how to improvise a Murder Mystery. The children will play numerous improv games which will serve to develop and enhance their public-speaking, social and team-building skills.
</p>
<p>This class will be conducted in a non-judgmental environment where the students will build confidence, make friends and most importantly ... have fun
</p>
<p>The session concludes with the students performing a Murder Mystery in a graduation show on the Push Comedy Theater Stage.
</p>
<p>This class will be held from 1pm-3pm on Sunday mornings from October 1st through November 5th.
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
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: kidprov201.id,
type: "class",
title: "KidProv 201 at the Push Comedy Theater",
slug: "G0DC7L",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-10-01T13:00:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-05T15:00:00.000-05:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/9052b361-b187-4963-aaa8-d59d95a2a381/-/resize/1200x/-/crop/900x900/51,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/9052b361-b187-4963-aaa8-d59d95a2a381/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!
description = """
<p>This course builds on what is learned in Musical Improv 101 and 201. We will work together on creating new forms and building skills for more varied and interesting scenes and songs.
</p>
<p>Together, we will create a thematic musical form that will be the structure for our graduation show.
</p>
<p>Prerequisites: Musical Improv 101, Musical Improv 201
</p>
<p>This course is 6 weeks long
</p>
<p>Cost $210
</p>
<p><strong>This class is held on Sunday afternoons, 3pm-6pm, October 1st through November 12th.</strong>
</p>
<p><strong>***There will be no class on October 15th***</strong>
</p>
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: music_improv_studio.id,
type: "class",
title: "Musical Improv Studio",
slug: "NS8KFB",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-10-01T15:00:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-12T18:00:00.000-05:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/3c6b59d5-1728-4c8d-9329-1eadc79fa4ef/-/resize/1200x/-/crop/675x675/93,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/3c6b59d5-1728-4c8d-9329-1eadc79fa4ef/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!
description = """
<p><strong></strong><strong>Improv 201 at the Push Comedy Theater</strong>
</p>
<p>This course builds upon the fundamentals and skills learned in 101. Students will learn the beginnings 'The Harold' a long form improvisation structure developed by Del Close. They will learn how to identify the 'game' of a scene and how to heighten these games to develop 'second beats'.
</p>
<p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.
</p>
<p><strong>This is a 6 week class.<br>Cost $190</strong>
</p>
<p>This class will be held from 6:30-9:30pm on Monday nights from October 2nd through November 13th.
</p>
<p>There will be no class on October 16th.
</p>
<p>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: improv201.id,
type: "class",
title: "​Improv 201 at the Push Comedy Theater",
slug: "82FVB5",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-10-02T18:30:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-13T21:30:00.000-05:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/c76ccb66-c7a5-4a89-95c4-c9c20824e139/-/resize/1200x/-/crop/1155x1155/12,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/c76ccb66-c7a5-4a89-95c4-c9c20824e139/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!
description = """
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
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: sketch101.id,
type: "class",
title: "Sketch Comedy Writing 101",
slug: "F2Z9W1",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-10-03T18:30:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-28T18:30:00.000-05:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/118a9c8b-e0f4-4b6d-b3ee-c2be59410624/-/resize/1200x/-/crop/1200x1200/0,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/118a9c8b-e0f4-4b6d-b3ee-c2be59410624/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!
description = """
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
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: kidprov101.id,
type: "class",
title: "KidProv at the Push Comedy Theater",
slug: "HXJ4F9",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-10-07T10:00:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-11T12:00:00.000-05:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/9052b361-b187-4963-aaa8-d59d95a2a381/-/resize/1200x/-/crop/900x900/51,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/9052b361-b187-4963-aaa8-d59d95a2a381/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!
description = """
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
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "The Neon Festival at the Push (FREE SHOW!!!)",
slug: "SHKGXQ",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-10-20T18:00:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-10-20T21:30:00.000-04:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/0fdb5dc1-f4ee-46ef-bc85-d5146fbeb64d/-/resize/1200x/-/crop/1155x1155/45,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/0fdb5dc1-f4ee-46ef-bc85-d5146fbeb64d/-/resize/1200x/-/crop/1200x629/0,0/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!

%TicketAgent.EventTag{
listing_id: listing.id,
tag: "free"
}
|> TicketAgent.Repo.insert!

description = """
<p>Are you ready for this?
</p>
<p>The hit show from the Core Theater Ensemble and Push Comedy Theater returns!!!
</p>
<p><br>Nine contestants, four months, one Golden Mic! Core Theatre Ensemble and Push Comedy Theater present the most ultimate Lip Sync Competition in Hampton Roads!
</p>
<p><br><br>Each month three brave contestants will show off their Lip Syncing skills over three different rounds with loud music, sweet dance moves, trash talking, and a few surprises along the way!
</p>
<p><br><br>Round 1: Friday, August 18th @ 10PM<br>Featuring <a href="https://www.facebook.com/ashley.hall.925" rel="nofollow" target="_blank">Ashley Hall</a>, <a href="https://www.facebook.com/joeleone86" rel="nofollow" target="_blank">Joe Leone</a>, <a href="https://www.facebook.com/debmarkham" rel="nofollow" target="_blank">deb markham</a><br>with Special Guest Performance!<br>Tickets: <a href="http://www.pushcomedytheater.com/" rel="nofollow" target="_blank">www.pushcomedytheater.com</a>
</p>
<p><br><br>Round 2: Friday, September 22nd @ 10pm <br>Featuring <a href="https://www.facebook.com/dennis.andrews.144" rel="nofollow" target="_blank">Dennis Andrews</a>, <a href="https://www.facebook.com/actionmatt" rel="nofollow" target="_blank">Matt Moreau</a>, <a href="https://www.facebook.com/ldybugamanda" rel="nofollow" target="_blank">Amanda Steadele</a> <br>with Special Guest Performance!
</p>
<p><br><br>Round 3: Saturday, October 20th @ 10pm <br>Featuring <a href="https://www.facebook.com/grummell" rel="nofollow" target="_blank">Evan Michael</a>, <a href="https://www.facebook.com/scot.rose2" rel="nofollow" target="_blank">Scot Rose</a>, <a href="https://www.facebook.com/andracorinne" rel="nofollow" target="_blank">Andra Rosenberg</a><br>with Special Guest Performance!
</p>
<p><br><br>The winner of each round will then battle it out in our final night:<br>Friday, November 17th @ 10pm. <br>The winner takes home THE GOLDEN MIC!
</p>
<p><br><br>Join <a href="https://www.facebook.com/CORE-Theatre-Ensemble-29981515719/" rel="nofollow" target="_blank">CORE Theatre Ensemble</a> at <a href="https://www.facebook.com/PushComedyTheater/" rel="nofollow" target="_blank">Push Comedy Theater</a> as<br>
</p>
<p><a href="https://www.facebook.com/eddie.castillo.3998" rel="nofollow" target="_blank">Eddie Castillo</a>, <a href="https://www.facebook.com/emele" rel="nofollow" target="_blank">Emel Ertugrul</a>, <a href="https://www.facebook.com/laura.agudelo.946" rel="nofollow" target="_blank">Laura Agudelo</a>, and <a href="https://www.facebook.com/nancy.dickerson.148" rel="nofollow" target="_blank">Nancy Dickerson</a> host the hottest lippers in town!
</p>
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Lip Service - Ultimate Lip Sync Competition: Round 3",
slug: "6WDN3K",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-10-20T22:00:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-10-20T23:30:00.000-04:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/d54fa7f3-96fe-497d-90b4-c20383116110/-/resize/1200x/-/crop/450x450/302,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/d54fa7f3-96fe-497d-90b4-c20383116110/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!

%TicketAgent.EventTag{
listing_id: listing.id,
tag: "music"
}
|> TicketAgent.Repo.insert!


%TicketAgent.EventTag{
listing_id: listing.id,
tag: "lip-sync"
}
|> TicketAgent.Repo.insert!

description = """
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
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "The 666 Project: A Horror Anthology Show",
slug: "RFGK1H",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-10-21T20:00:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-10-30T21:30:00.000-04:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/00d2eb9c-b488-4917-b4e3-578d11ef3c0a/-/resize/1200x/-/crop/444x444/708,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/00d2eb9c-b488-4917-b4e3-578d11ef3c0a/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!
description = """
<p>It's Harold Night at the Push Comedy Theater!
</p>
<p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?
</p>
<p>The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.
</p>
<p>Harold Night
</p>
<p>Saturday, October 21st at 10:00pm
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
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Harold Night",
slug: "H38CJ0",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-10-21T22:00:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-10-21T23:30:00.000-04:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/49cb7b83-12f7-40fe-a963-5ad538df05a4/-/resize/1200x/-/crop/1200x1200/0,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/49cb7b83-12f7-40fe-a963-5ad538df05a4/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!

%TicketAgent.EventTag{
listing_id: listing.id,
tag: "deal"
}
|> TicketAgent.Repo.insert!


%TicketAgent.EventTag{
listing_id: listing.id,
tag: "harold"
}
|> TicketAgent.Repo.insert!

description = """
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
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Workshop: You Are Not The Scene",
slug: "YHRJ91",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-10-26T18:30:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-10-26T21:30:00.000-04:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/2e837c92-6ace-47c7-8dff-9bd38d67ecf8/-/resize/1200x/-/crop/641x641/519,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/2e837c92-6ace-47c7-8dff-9bd38d67ecf8/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!

%TicketAgent.EventTag{
listing_id: listing.id,
tag: "workshop"
}
|> TicketAgent.Repo.insert!

description = """
<p>Halloween is almost here... and that means it's time for <strong>The Pushers Halloween Spooktacular!!!</strong><br> <br>  The Pushers are back with a vengeance. The  gang has written a freaky and frightening new show chock full of their  trademarked racy and raucous humor. This is the show people are going to  be talking about for a long time to come.<br> <strong><br> The Pushers Halloween Spooktacular!!!</strong><br> It has all the spooks, frights and carnage of a normal Pushers' show only it's all amped up to 11.<br> <br> <br> <strong>The Pushers Halloween Spooktacular</strong><br> Friday, October 27th at The Push Comedy Theater<br> The show starts at 10pm<br> <br> The Push Comedy Theater<br> 763 Granby Street  .  Norfolk<br> <br> <a href="http://pushcomedytheater.com/" rel="nofollow" target="_blank">pushcomedytheater.com</a>
</p>
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "The Pushers Halloween Spooktacular!!!",
slug: "8Z1F5C",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-10-27T22:00:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-10-27T23:30:00.000-04:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/de2ae134-3bad-42e7-b8f4-156826e4b6a1/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/de2ae134-3bad-42e7-b8f4-156826e4b6a1/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!
description = """
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
<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, October 28th
</p>
<p>The show starts at 10pm
</p>
<p>Tickets are $5
</p>
<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.
</p>
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION",
slug: "MF7YLK",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-10-28T22:00:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-10-28T23:30:00.000-04:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/6a654ad0-cfee-43a6-9c35-dc86dfd97340/-/resize/1200x/-/crop/444x444/32,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/6a654ad0-cfee-43a6-9c35-dc86dfd97340/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!

%TicketAgent.EventTag{
listing_id: listing.id,
tag: "deal"
}
|> TicketAgent.Repo.insert!

description = """
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
<p>Friday, November 3rd at 8pm
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
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Date Night",
slug: "Z1KJCP",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-03T20:00:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-03T21:30:00.000-04:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/7e2ff30f-6b86-488e-8838-cfc9912b6824/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/7e2ff30f-6b86-488e-8838-cfc9912b6824/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!

%TicketAgent.EventTag{
listing_id: listing.id,
tag: "deal"
}
|> TicketAgent.Repo.insert!


%TicketAgent.EventTag{
listing_id: listing.id,
tag: "date-night"
}
|> TicketAgent.Repo.insert!

description = """
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
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition",
slug: "7CPZWX",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-03T22:00:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-03T23:30:00.000-04:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/83a0c1e9-fd2e-4b82-9e5b-a1edaf6416c9/-/resize/1200x/-/crop/886x886/180,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/83a0c1e9-fd2e-4b82-9e5b-a1edaf6416c9/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!

%TicketAgent.EventTag{
listing_id: listing.id,
tag: "deal"
}
|> TicketAgent.Repo.insert!

description = """
<p>I ain't afraid of no ghost!<br>
</p>
<p>The Push presents a frightful night of comedy (or is it a hilarious night of frights).<br>
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
<p>Saturday, November 4th at 8pm
</p>
<p>Tickets are $5
</p>
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Tales from the Campfire: The Improvised Ghost Story",
slug: "PKZS4D",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-04T20:00:00.000-04:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-04T21:30:00.000-04:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/fbca7042-3e12-4e21-9cff-98a451943cdf/-/resize/1200x/-/crop/799x799/401,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/fbca7042-3e12-4e21-9cff-98a451943cdf/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!

%TicketAgent.EventTag{
listing_id: listing.id,
tag: "deal"
}
|> TicketAgent.Repo.insert!

description = """
<p style="text-align: center;">Get ready for a night of comedy from the Pushers' own Brad McMurran.
</p>
<p style="text-align: center;">Alcohol and Drugs
</p>
<p style="text-align: center;">From the journals and Facebook posts of Brad McMurran, comes Brad's crazy experiences with drugs and alcohol.  And there have been many.  From peace pipes with Native Americans to waking up in the gutter on Colley Avenue... don't miss this alcohol and drug-filled ride. <br>
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><strong>Good Talk: The Brad McMurran Show</strong>
</p>
<p style="text-align: center;">Alcohol and Drugs
</p>
<p style="text-align: center;">Sunday, November 5th at 7pm
</p>
<p style="text-align: center;">Tickets are $12
</p>
<p style="text-align: center;">Good Talk is a one-man show starring Brad McMurran and focusing on McMurran's wildly popular Facebook posts.
</p>
<p style="text-align: center;">Each month, Good Talk looks at the life and experiences of a sketch and improv comedian.  Through storytelling, improv and mixed media, Brad will bring his Good Talk Facebook posts to life.
</p>
<p style="text-align: center;">You'll see is struggles with bill collectors, relationships, alcohol, parents, opening a theater and just trying to act like an adult.
</p>
<p style="text-align: center;">The show is going to be an unpredictable, wild and borderline-insane ride... just like Brad's life.
</p>
<p style="text-align: center;">Upcoming episodes of Good Talk: The Brad McMurran Show will include -
</p>
<p style="text-align: center;">Christmas Talks<br>
</p>
<p style="text-align: center;">New Years Resolutions
</p>
<p style="text-align: center;">Crazy for Love
</p>
<p style="text-align: center;">My Life in Comedy
</p>
<p style="text-align: center;">The College Years
</p>
<p style="text-align: center;">The New York Years
</p>
<p style="text-align: center;">Life and Death
</p>
<p style="text-align: center;">Failure
</p>
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Good Talk: The Brad McMurran Show",
slug: "1XNJ3L",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-05T19:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-05T21:00:00.000-05:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/de52f7d0-daa6-4b61-b647-322e1c8b9958/-/resize/1200x/-/crop/1200x1200/0,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/de52f7d0-daa6-4b61-b647-322e1c8b9958/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!

%TicketAgent.EventTag{
listing_id: listing.id,
tag: "good-talk"
}
|> TicketAgent.Repo.insert!

description = """
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
<p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, November 10th at the Push Comedy Theater<br>The show starts at 8, tickets are $5
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
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Girl-Prov: The Girls' Night of Improv",
slug: "YSNCMW",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-10T20:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-10T21:30:00.000-05:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/2818bca8-8162-47b8-999f-625527ad42d0/-/resize/1200x/-/crop/456x456/0,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/2818bca8-8162-47b8-999f-625527ad42d0/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!

%TicketAgent.EventTag{
listing_id: listing.id,
tag: "deal"
}
|> TicketAgent.Repo.insert!


%TicketAgent.EventTag{
listing_id: listing.id,
tag: "girl-prov"
}
|> TicketAgent.Repo.insert!

description = """
<p><strong>The Students Become The Masters!!!</strong>
</p>
<p>Teachers and students will join forces for a good old fashioned improv jam!!!
</p>
<p>Don't miss it! Some of the Push Comedy's Theater's funniest students share the stage with their teachers, The Pushers. Ordinarily we frown upon fraternization between teachers and students (Brad we're looking at you)... but for one night only all bets are off!!!
</p>
<p><strong>Teachers Pet</strong><br>Friday, November 10th, 10pm<br>Tickets are $5
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
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Teacher's Pet",
slug: "VTF75W",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-10T22:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-10T23:30:00.000-05:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/bc96f7b9-01c2-4ac8-9566-5bfdfa7f658d/-/resize/1200x/-/crop/451x451/370,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/bc96f7b9-01c2-4ac8-9566-5bfdfa7f658d/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!

%TicketAgent.EventTag{
listing_id: listing.id,
tag: "deal"
}
|> TicketAgent.Repo.insert!


%TicketAgent.EventTag{
listing_id: listing.id,
tag: "graduation-show"
}
|> TicketAgent.Repo.insert!

description = """
<p><strong>Get ready for a spine tingling murder mystery!!!</strong><br>
</p>
<p>There's a killer on the loose... can you solve this classic who dunnit before they strike again!?!<br>This show will have all the trappings of a thrilling mystery... a dastardly villain, shifty suspects and an intrepid detective.
</p>
<p>...And it will all be made up on the spot!!!
</p>
<p>Don't miss this exciting mystery, all based off the audience's suggestion.
</p>
<p><br><strong>Who Dunnit? ...The Improvised Murder Mystery</strong><br>Saturday, November 11th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $10
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
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Who Dunnit? ...The Improvised Murder Mystery",
slug: "PD27LX",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-11T20:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-11T21:30:00.000-05:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/e736e2a2-4950-4b7c-b606-f0ce63e26dff/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/e736e2a2-4950-4b7c-b606-f0ce63e26dff/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!

%TicketAgent.EventTag{
listing_id: listing.id,
tag: "murder-mystery"
}
|> TicketAgent.Repo.insert!

description = """
<p><strong>Second Saturday Stand-Up</strong>
</p>
<p>This once-a-month show is brought to you by almost-jaded veteran comic, <strong>Hatton Jordan </strong>who sets the lineup with proven comedians delivering road-tested jokes while they squeeze in new material.
</p>
<p>This is NOT a "open mic" .....it's selected talent working on their craft. Every month is a new seasoned lineup.
</p>
<p><br>
</p>
<p>Host: Hatton Jordan
</p>
<p>Line-Up TBA
</p>
<p><strong><br></strong>
</p>
<p><strong>Second Saturday Stand-Up</strong>
</p>
<p>Saturday, November 11th at 10pm
</p>
<p>Tickets are $5
</p>
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Second Saturday Stand-Up",
slug: "VDZJ2R",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-11T22:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-11T23:30:00.000-05:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/9bd8303c-a46b-4654-8fc9-c7eb6b68a587/-/resize/1200x/-/crop/451x451/372,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/9bd8303c-a46b-4654-8fc9-c7eb6b68a587/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!

%TicketAgent.EventTag{
listing_id: listing.id,
tag: "deal"
}
|> TicketAgent.Repo.insert!


%TicketAgent.EventTag{
listing_id: listing.id,
tag: "standup"
}
|> TicketAgent.Repo.insert!

description = """
<p>Are you ready for this?
</p>
<p>The hit show from the Core Theater Ensemble and Push Comedy Theater returns!!!
</p>
<p><br>Nine contestants, four months, one Golden Mic! Core Theatre Ensemble and Push Comedy Theater present the most ultimate Lip Sync Competition in Hampton Roads!
</p>
<p><br><br>Each month three brave contestants will show off their Lip Syncing skills over three different rounds with loud music, sweet dance moves, trash talking, and a few surprises along the way!
</p>
<p><br><br>Round 1: Friday, August 18th @ 10PM<br>Featuring <a href="https://www.facebook.com/ashley.hall.925" rel="nofollow" target="_blank">Ashley Hall</a>, <a href="https://www.facebook.com/joeleone86" rel="nofollow" target="_blank">Joe Leone</a>, <a href="https://www.facebook.com/debmarkham" rel="nofollow" target="_blank">deb markham</a><br>with Special Guest Performance!<br>Tickets: <a href="http://www.pushcomedytheater.com/" rel="nofollow" target="_blank">www.pushcomedytheater.com</a>
</p>
<p><br><br>Round 2: Friday, September 22nd @ 10pm <br>Featuring <a href="https://www.facebook.com/dennis.andrews.144" rel="nofollow" target="_blank">Dennis Andrews</a>, <a href="https://www.facebook.com/actionmatt" rel="nofollow" target="_blank">Matt Moreau</a>, <a href="https://www.facebook.com/ldybugamanda" rel="nofollow" target="_blank">Amanda Steadele</a> <br>with Special Guest Performance!
</p>
<p><br><br>Round 3: Saturday, October 20th @ 10pm <br>Featuring <a href="https://www.facebook.com/grummell" rel="nofollow" target="_blank">Evan Michael</a>, <a href="https://www.facebook.com/scot.rose2" rel="nofollow" target="_blank">Scot Rose</a>, <a href="https://www.facebook.com/andracorinne" rel="nofollow" target="_blank">Andra Rosenberg</a><br>with Special Guest Performance!
</p>
<p><br><br>The winner of each round will then battle it out in our final night:<br>Friday, November 17th @ 10pm. <br>The winner takes home THE GOLDEN MIC!
</p>
<p><br><br>Join <a href="https://www.facebook.com/CORE-Theatre-Ensemble-29981515719/" rel="nofollow" target="_blank">CORE Theatre Ensemble</a> at <a href="https://www.facebook.com/PushComedyTheater/" rel="nofollow" target="_blank">Push Comedy Theater</a> as<br>
</p>
<p><a href="https://www.facebook.com/eddie.castillo.3998" rel="nofollow" target="_blank">Eddie Castillo</a>, <a href="https://www.facebook.com/emele" rel="nofollow" target="_blank">Emel Ertugrul</a>, <a href="https://www.facebook.com/laura.agudelo.946" rel="nofollow" target="_blank">Laura Agudelo</a>, and <a href="https://www.facebook.com/nancy.dickerson.148" rel="nofollow" target="_blank">Nancy Dickerson</a> host the hottest lippers in town!
</p>
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Lip Service Finals - The Ultimate Lip Sync Competition!",
slug: "SQW23B",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-17T22:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-17T23:30:00.000-05:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/d54fa7f3-96fe-497d-90b4-c20383116110/-/resize/1200x/-/crop/450x450/302,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/d54fa7f3-96fe-497d-90b4-c20383116110/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!

%TicketAgent.EventTag{
listing_id: listing.id,
tag: "music"
}
|> TicketAgent.Repo.insert!


%TicketAgent.EventTag{
listing_id: listing.id,
tag: "lip-sync"
}
|> TicketAgent.Repo.insert!

description = """
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
<p><strong>***There will be no class on November 25th, December 23rd, or December 30th***</strong>
</p>
"""

listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: music_improv201.id,
type: "class",
title: "Musical Improv 201",
slug: "CWRY6N",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-18T15:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2018-01-06T18:00:00.000-05:00")
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/20f01bb1-d774-4ecd-8ac0-00dca64a153f/-/resize/1200x/-/crop/750x750/3,0/-/inline/yes/",
type: "cover"
}
|> TicketAgent.Repo.insert!

%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://images.universe.com/20f01bb1-d774-4ecd-8ac0-00dca64a153f/-/scale_crop/400x270/-/progressive/yes/",
type: "social"
}
|> TicketAgent.Repo.insert!
