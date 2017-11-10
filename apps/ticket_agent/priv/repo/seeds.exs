import Ecto.Query
require Logger

Logger.info "Creating Account"
account = TicketAgent.Account.changeset(%TicketAgent.Account{},
  %{name: "Push Comedy Theater",
    description: "Push Comedy Theater",
    url: "https://pushcomedytheater.com",
    enabled: true})
|> TicketAgent.Repo.insert!

Logger.info "Creating User"
user = TicketAgent.User.changeset(%TicketAgent.User{},
  %{name: "Patrick Veverka",
    email: "patrick@pushcomedytheater.com",
    password: "secret",
    password_confirmation: "secret",
    role: "admin",
    account_id: account.id})
|> TicketAgent.Repo.insert!

account
|> Ecto.Changeset.cast(%{creator_id: user.id}, [:creator_id])
|> TicketAgent.Repo.update!()

Logger.info "Creating Alba"
alba = TicketAgent.Teacher.changeset(%TicketAgent.Teacher{},
  %{
    biography: "<p>Alba has been a performer and writer for the sketch and improv comedy group The Pushers since the summer of 2009. As a member of the group, she also produces and directs \"Panties in a Twist: The All Female Sketch Comedy Show.\"</p>
    <p>She graduated with a BFA in Acting from Old Dominion University. She has studied Improv with the Pushers and several regional improvisers. With the Pushers, she has performed up and down the east coast. By day, Alba is a Standardized Patient Educator at Eastern Virginia Medical School.</p>",
    email: "alba@pushcomedytheater.com",
    name: "Alba Woolard",
    social: %{}
  }
)
|> TicketAgent.Repo.insert!

Logger.info "Creating Brad"
brad = TicketAgent.Teacher.changeset(%TicketAgent.Teacher{},
  %{
    biography: "<p>Brad McMurran is the founder of The Pushers Sketch and Improvisation Comedy Troupe. He is the co-head writer, performer, and artistic director of the Push Comedy Theater.</p>
    <p>Brad studied acting in college, trained in improvisation at Upright Citizen's Brigades, and is the co-writer of Cuff Me; The 50 Shades of Grey Musical Parody (which played off-broadway in New York for the past year).</p>
    <p>Brad has been writing sketch comedy for ten years and is pleased as a pickle to be opening up this theater in Hampton Roads. McMurran is a graduate of Old Dominion and enjoys pizza.</p>",
    email: "brad@pushcomedytheater.com",
    name: "Brad McMurran",
    social: %{"facebook" => "https://www.facebook.com/bradmcmurran", "twitter" => "https://twitter.com/Brad_ThePushers"}
  }
)
|> TicketAgent.Repo.insert!

Logger.info "Creating Ed"
ed = TicketAgent.Teacher.changeset(%TicketAgent.Teacher{},
  %{
    biography: "<p>Ed Carden has been acting and performing comedy for more than a decade, and has appeared in nearly 30 local theatrical productions, as well as a handful of commercials and short films.</p>
    <p>He is a founding member of The Pushers Sketch/Improv Comedy Group, in which he serves as a performer, writer, and producer. With The Pushers, he has performed up and down the east coast.</p>
    <p>By day he works for Virginia Beach Public Schools. In addition to writing and performing, he enjoys cheeseburgers, sushi, and science fiction—not necessarily in that order.</p>",
    email: "ed@pushcomedytheater.com",
    name: "Ed Carden",
    social: %{"twitter" => "https://twitter.com/TheEdCarden"}
  }
)
|> TicketAgent.Repo.insert!

Logger.info "Creating Sean"
sean = TicketAgent.Teacher.changeset(%TicketAgent.Teacher{},
  %{
    biography: "<p>Sean Devereux is an original member of The Pushers, and has been performing and writing comedy for nearly ten years.</p>
    <p>Sean studied improv at the Upright Citizens Brigade Theater in New York and is one of the co-writers of the Off-Broadway hit Cuff Me: The Fifty Shades of Grey Musical Parody. In his civilian guise, Sean is an Emmy award winning writer and producer at WVEC-TV13.</p>",
    email: "sean@pushcomedytheater.com",
    name: "Sean Devereux",
    social: %{"twitter" => "https://twitter.com/Sean_ThePushers"}
  }
)
|> TicketAgent.Repo.insert!

TicketAgent.Repo.delete_all TicketAgent.Class

Logger.info "Creating Improv101"
improv101 = TicketAgent.Class.changeset(%TicketAgent.Class{},
  %{title: "Improv 101: Introduction to Improvisational Comedy",
    type: "improvisation",
    slug: "improv101",
    description: "Learn the beginnings of Chicago-based, long form improv. Students will learn how to create scenes based off of audience suggestions. They will learn: <ul><li>the fundamentals of 'Yes, And'</li><li>how to support scene partners' ideas and energy</li><li>and how to make strong character choices.</li></ul> Absolutely no experience in acting or comedy is needed. The Push Comedy Theater strides to create a fun, safe and supportive experience for all students.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.",
    cover_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293297/covers/wd4vnbdjwchrclmuhomg.png",
    social_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293297/social/dxcfi6mfoag1mst2k0pr.png",
    menu_order: 1,
    prerequisite_id: nil})
|> TicketAgent.Repo.insert!

Logger.info "Creating Improv201"
improv201 = TicketAgent.Class.changeset(%TicketAgent.Class{},
  %{title: "Improv 201: Foundations of the Harold: Game and Second Beats",
    type: "improvisation",
    slug: "improv201",
    description: "This course builds upon the fundamentals and skills learned in 101. Students will learn the beginnings 'The Harold' a long form improvisation structure developed by Del Close. They will learn how to identify the 'game' of a scene and how to heighten these games to develop 'second beats'.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.",
    cover_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293298/covers/qphl4uwhh5opshbsjuvl.png",
    social_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293298/social/ffgpushg2ayvryxab0yr.png",
    menu_order: 2,
    prerequisite_id: improv101.id})
|> TicketAgent.Repo.insert!

Logger.info "Creating Improv301"
improv301 = TicketAgent.Class.changeset(%TicketAgent.Class{},
  %{title: "Improv 301: The Harold: Openers and Group Games",
    type: "improvisation",
    slug: "improv301",
    description: "This course continues the Harold work started in 202. Students will delve more deeply into 'The Harold' structure. They will learn a series of 'openers' and 'group games' that will complete the Harold format. Openers are used to derive inspiration from the audience's suggestion while group games are multi person scenes that break up the traditional 2 person scenes.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.",
    cover_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293299/covers/uyjvypsmg96fcd4zl88j.png",
    social_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293299/social/rggwbzzpfnpuptw7de8g.png",
    menu_order: 3,
    prerequisite_id: improv201.id})
|> TicketAgent.Repo.insert!

Logger.info "Creating Improv401"
improv401 = TicketAgent.Class.changeset(%TicketAgent.Class{},
  %{title: "Improv 401: Advanced Harold",
    type: "improvisation",
    slug: "improv401",
    description: "Now we put it all together. Students will combine the skills learned in the previous courses for an in depth study of The Harold. This course will delve deeper into the form, focusing on editing scenes, individual and group commitment, as well as the components of 2-person, 3-person, and group scenes.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.",
    cover_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293300/covers/vbstqyeecfovcwm3mx9r.png",
    social_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293301/social/yq11wolwyrfnxet05pxa.png",
    menu_order: 4,
    prerequisite_id: improv301.id})
|> TicketAgent.Repo.insert!

Logger.info "Creating Improv501"
improv501 = TicketAgent.Class.changeset(%TicketAgent.Class{},
  %{title: "Improv 501: Improv Studio",
    type: "improvisation",
    slug: "improv501",
    description: "***THIS COURSE WILL CAP AT 16 STUDENTS*** This course focuses on giving students individual attention to their strengths and weaknesses. We will also break down the different components of improv scenes and the choices that improvisers have and make within those scenes.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.",
    cover_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293301/covers/hhlz9x5qcz2qqkk3xyga.png",
    social_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293301/social/uzjuqg9yff9u1kzqvvwt.png",
    menu_order: 5,
    prerequisite_id: improv401.id})
|> TicketAgent.Repo.insert!

Logger.info "Creating KidProv101"
kidprov101 = TicketAgent.Class.changeset(%TicketAgent.Class{},
  %{title: "Kidprov 101",
    type: "improvisation",
    slug: "kidprov101",
    description: "Don't miss out on the fun!!! Sign up your kids, grand kids, nieces, nephews, even the stinky neighbor kid from down the street for KidProv at the Push Comedy Theater.<br />This class is open to children ages 8 to 12. Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public-speaking, social and team-building skills.<br />This class will be conducted in a non-judgmental environment where the students will build confidence, make friends and most importantly ... have fun<br />The session concludes with the students performing in a graduation show on the Push Comedy Theater Stage.<br />This is class is $150 for new students and $140 for returning students.<br />New students also receive a free tshirt.",
    cover_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293302/covers/g0upzsg4dchanai2ul0l.jpg",
    social_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293303/social/snxdh3iuskvytzavxixc.jpg",
    menu_order: 6,
    prerequisite_id: nil})
|> TicketAgent.Repo.insert!

Logger.info "Creating KidProv201"
kidprov201 = TicketAgent.Class.changeset(%TicketAgent.Class{},
  %{title: "Kidprov 201",
    type: "improvisation",
    slug: "kidprov201",
    description: "Don't miss out on the fun!!! Sign up your kids, grand kids, nieces, nephews, even the stinky neighbor kid from down the street for KidProv at the Push Comedy Theater.<br />This class is open to children ages 8 to 12 who have previously taken at least 2 sessions of KidProv 101. Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public-speaking, social and team-building skills.<br />This class will be conducted in a non-judgmental environment where the students will build confidence, make friends and most importantly ... have fun<br />The session concludes with the students performing in a graduation show on the Push Comedy Theater Stage.<br />This class is $150.",
    cover_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293303/covers/orrcrhg9bcgnexgseitw.jpg",
    social_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293304/social/opfauadeuweqcowtqqh8.jpg",
    menu_order: 7,
    prerequisite_id: kidprov101.id})
|> TicketAgent.Repo.insert!

Logger.info "Creating MusicalImprov101"
music_improv101 = TicketAgent.Class.changeset(%TicketAgent.Class{},
  %{title: "Musical Improv 101",
    type: "improvisation",
    slug: "music_improv101",
    description: "This is what you've been waiting for! The Push Comedy Theater brings you MUSICAL IMPROV!!!<br />This course offers an introduction to long form musical improvisation. We will cover the basics of how to work with music while learning how to create two person musical numbers, placing them together to create a 15 minute thematic musical show.<br />Additional focus will be on sound exploration, movement, stylization, and accessing voice. Prepare to challenge yourself while having a ton of fun! This course culminates with a graduation show.",
    cover_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293304/covers/vggfmhm2c99mhkxi7r7v.jpg",
    social_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293305/social/wcsdlaqpevv4uwsaeurc.jpg",
    menu_order: 8,
    prerequisite_id: improv101.id})
|> TicketAgent.Repo.insert!

Logger.info "Creating Musical Improv 201"
music_improv201 = TicketAgent.Class.changeset(%TicketAgent.Class{},
  %{title: "Musical Improv 201",
    type: "improvisation",
    slug: "music_improv201",
    description: "This class is focused on building a long form Musical Harold. It will improve upon the concepts and skills learned in Musical Improv 101, with a focus on finding deeper relationships and themes to bring to life through song.",
    cover_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293305/covers/rxu5yn34d5rp0nvnkssf.jpg",
    social_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293306/social/aajatymvgjmpxlp6qxeg.jpg",
    menu_order: 9,
    prerequisite_id: music_improv101.id})
|> TicketAgent.Repo.insert!

Logger.info "Creating Musical Improv Studio"
music_improv_studio = TicketAgent.Class.changeset(%TicketAgent.Class{},
  %{title: "Musical Improv Studio",
    type: "improvisation",
    slug: "music_improv_studio",
    description: "This course builds on what is learned in Musical Improv 101 and 201. We will work together on creating new forms and building skills for more varied and interesting scenes and songs.<br />Together, we will create a thematic musical form that will be the structure for our graduation show.",
    cover_photo_url: "http://res.cloudinary.com/push-comedy-theater/image/upload/v1508021107/covers/yes_yfvtxd.jpg",
    social_photo_url: "http://res.cloudinary.com/push-comedy-theater/image/upload/v1508021035/social/yes_m4winq.jpg",
    menu_order: 10,
    prerequisite_id: music_improv201.id})
|> TicketAgent.Repo.insert!

Logger.info "Creating Improv For Teens"
teen_improv = TicketAgent.Class.changeset(%TicketAgent.Class{},
  %{title: "Improv for Teens",
    type: "improvisation",
    slug: "teen_improv",
    description: "Jump head first into the wonderful worlds of sketch and improv comedy. This class is open to teens from the ages of 13 to 18. Absolutely no experience is needed. Students will explore the key tools behind both long and short form improvisation. We will play numerous games to help you sharpen your mind. We will then use improv as a springboard for writing basic comedy sketches- like those seen on SNL. We strive to create a safe, non-judgmental environment where teens can build confidence, make friends and most importantly... have fun.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.",
    cover_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293306/covers/s9uyzugyefwu81hmicmb.jpg",
    social_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293307/social/et3vui72l78dx76y8dqa.jpg",
    menu_order: 11,
    prerequisite_id: nil})
|> TicketAgent.Repo.insert!

Logger.info "Creating Sketch 101"
sketch101 = TicketAgent.Class.changeset(%TicketAgent.Class{},
  %{title: "Sketch Comedy Writing 101",
    type: "sketch",
    slug: "sketch101",
    description: "Dive head first into the wonderful world of sketch comedy! Whether you're a seasoned writer or someone who rarely picks up a pen, this class will teach how to get the funny ideas out of your head and onto the page. In this class we will examine the various types of sketches, learn how to generate funny ideas and then turn them into a sketches ready for the stage. This class is open to everyone, no writing or comedy experience is ready.<br />At the end of the session, students sketches will be performed on the Push Comedy Theater stage by some of Hampton Roads finest actors.",
    cover_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293307/covers/nfshrdoaapy0pcsqayru.png",
    social_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293308/social/i4llenihjpc2jilbohde.png",
    menu_order: 1,
    prerequisite_id: nil})
|> TicketAgent.Repo.insert!

Logger.info "Creating Sketch 201"
sketch201 = TicketAgent.Class.changeset(%TicketAgent.Class{},
  %{title: "Sketch Comedy Writing 201",
    type: "sketch",
    slug: "sketch201",
    description: "This course builds upon the fundamentals and skills learned in 101.<br />At the end of the session, students sketches will be performed on the Push Comedy Theater stage by some of Hampton Roads finest actors.",
    cover_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293308/covers/wk3zfokdjzhpxpfsrgxx.jpg",
    social_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293309/social/sntit15jmbm4aghfcuad.jpg",
    menu_order: 2,
    prerequisite_id: sketch101.id})
|> TicketAgent.Repo.insert!

Logger.info "Creating Standup 101"
standup101 = TicketAgent.Class.changeset(%TicketAgent.Class{},
  %{title: "Standup 101",
    type: "standup",
    slug: "standup101",
    description: "Learn how to perform stand-up comedy!<br />Learn about the often-overlooked basics of stand-up comedy and the nuances of fine tuning your act from almost-jaded veteran comic Hatton Jordan.<br />This class focuses on learning three skills:<br /><ul><li>HOW to craft an original set,</li><li>HOW to host a show like a pro</li><li>HOW to market yourself so club bookers will want to pay you.</li></ul><br />This course culminates with YOU and the others in your class performing your set at your Grad Show at the Push Theater.<br />The class will be a 6 week course ending with a graduation show at the 90 seat Push Comedy Theater.",
    cover_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293309/covers/sxdcjtuvqwxkwyraic4x.jpg",
    social_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293310/social/g9lxuwhqekktyez02vpd.jpg",
    menu_order: 1,
    prerequisite_id: nil})
|> TicketAgent.Repo.insert!

Logger.info "Creating Acting 101"
acting101 = TicketAgent.Class.changeset(%TicketAgent.Class{},
  %{title: "Acting 101",
    type: "acting",
    slug: "acting101",
    description: "This foundational course introduces the basic principles of acting through improvisation, monologue, scene work, and technical methods in voice, physical action, and text analysis. It involves fundamental skills and techniques with an emphasis on physical/vocal awareness, spontaneity, concentration, and truthful response.",
    cover_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293310/covers/hgjkgz1oh1qqjrqznljt.png",
    social_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293311/social/yx6iivhhc0jx95maepi8.png",
    menu_order: 1,
    prerequisite_id: nil})
|> TicketAgent.Repo.insert!

Logger.info "Done inserting from classes.exs"
Logger.info "Getting account and user"
account = TicketAgent.Repo.one(from x in TicketAgent.Account, order_by: [desc: x.id], limit: 1)
user = TicketAgent.Repo.one(from x in TicketAgent.User, order_by: [desc: x.id], limit: 1)
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
Logger.info "Writing Class Musical Improv 101"
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

Logger.info "> Writing cover photo for Musical Improv 101"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611623/23e6339b-5e4c-4e6b-9a88-98524c89699d.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for Musical Improv 101"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611623/23e6339b-5e4c-4e6b-9a88-98524c89699d.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for Musical Improv 101"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for Musical Improv 101",
status: "available",
description: "Ticket for Musical Improv 101",
price: 21000,
sale_start:  NaiveDateTime.from_iso8601!("2017-09-10T20:43:52.306Z")
}
|> TicketAgent.Repo.insert!
end)
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
Logger.info "Writing Class Musical Improv Studio"
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

Logger.info "> Writing cover photo for Musical Improv Studio"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611627/3c6b59d5-1728-4c8d-9329-1eadc79fa4ef.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for Musical Improv Studio"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611627/3c6b59d5-1728-4c8d-9329-1eadc79fa4ef.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for Musical Improv Studio"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for Musical Improv Studio",
status: "available",
description: "Ticket for Musical Improv Studio",
price: 21000,
sale_start:  NaiveDateTime.from_iso8601!("2017-09-10T20:55:52.402Z")
}
|> TicketAgent.Repo.insert!
end)
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
Logger.info "Writing Class ​Improv 201 at the Push Comedy Theater"
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

Logger.info "> Writing cover photo for ​Improv 201 at the Push Comedy Theater"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611628/c76ccb66-c7a5-4a89-95c4-c9c20824e139.png",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for ​Improv 201 at the Push Comedy Theater"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611628/c76ccb66-c7a5-4a89-95c4-c9c20824e139.png",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for ​Improv 201 at the Push Comedy Theater"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for ​Improv 201 at the Push Comedy Theater",
status: "available",
description: "Ticket for ​Improv 201 at the Push Comedy Theater",
price: 19000,
sale_start:  NaiveDateTime.from_iso8601!("2017-09-05T13:09:01.323Z")
}
|> TicketAgent.Repo.insert!
end)
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
Logger.info "Writing Class Sketch Comedy Writing 101"
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

Logger.info "> Writing cover photo for Sketch Comedy Writing 101"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611629/118a9c8b-e0f4-4b6d-b3ee-c2be59410624.png",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for Sketch Comedy Writing 101"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611629/118a9c8b-e0f4-4b6d-b3ee-c2be59410624.png",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for Sketch Comedy Writing 101"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for Sketch Comedy Writing 101",
status: "available",
description: "Ticket for Sketch Comedy Writing 101",
price: 22000,
sale_start:  NaiveDateTime.from_iso8601!("2017-09-13T18:13:28.707Z")
}
|> TicketAgent.Repo.insert!
end)
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
Logger.info "Writing Class KidProv at the Push Comedy Theater"
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

Logger.info "> Writing cover photo for KidProv at the Push Comedy Theater"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611625/9052b361-b187-4963-aaa8-d59d95a2a381.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for KidProv at the Push Comedy Theater"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611625/9052b361-b187-4963-aaa8-d59d95a2a381.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for KidProv at the Push Comedy Theater"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for KidProv at the Push Comedy Theater",
status: "available",
description: "Ticket for KidProv at the Push Comedy Theater",
price: 14000,
sale_start:  NaiveDateTime.from_iso8601!("2017-09-13T17:29:27.141Z")
}
|> TicketAgent.Repo.insert!
end)
description = """
<p>They said it couldn't be done...  They said it shouldn't be done...
</p>
<p>Despite the odds (and it's dipsh*tty owners), the Push Comedy Theater is turning 3 years old!!!!
</p>
<p>To celebrate the fact that we're still open, we are throwing the anniversary bash to end all anniversary bashes!!!
</p>
<p>Get ready for a night of sketch comedy with The Pushers and members of The Bright Side, Panties in a Twist, The Pre Madonnas, the Upright Senior Citizens Brigade, Too Far, Date Night and more.
</p>
<p>We're cramming a year's worth of comedy into one amazing show and the best part is you, the audience will choose what sketches we perform!!!
</p>
<p>How exactly will this work, you ask... you're going to have to come to the show to find out.
</p>
<p><strong>The Push Comedy Theater Anniversary Bash</strong>
</p>
<p>Friday, November 10th at 8pm.
</p>
<p>Tickets are $15.
</p>
"""
Logger.info "Writing Class The Push Comedy Theater Anniversary Bash"
listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "The Push Comedy Theater Anniversary Bash",
slug: "X9MW8F",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-10T20:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-10T23:00:00.000-05:00")
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing cover photo for The Push Comedy Theater Anniversary Bash"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285434/0b7a892a-167f-48b6-9207-c4a6d16166ac.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for The Push Comedy Theater Anniversary Bash"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285434/0b7a892a-167f-48b6-9207-c4a6d16166ac.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for The Push Comedy Theater Anniversary Bash"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for The Push Comedy Theater Anniversary Bash",
status: "available",
description: "Ticket for The Push Comedy Theater Anniversary Bash",
price: 1500,
sale_start:  NaiveDateTime.from_iso8601!("2017-10-26T02:51:46.526Z")
}
|> TicketAgent.Repo.insert!
end)
description = """
<p>You've heard of Generation X and Gen Y. Now get ready for the funniest, silliest, cutest generation of them all as The Pushers bring to you... The Pre-Teen Improv Superstars!!!
</p>
<p>Don't miss this group of talented tween-boppers as they put on a funny and fast paced 'Who's Line Is It Anyway' style show.
</p>
<p>The group is coached by local comedy couple, Jim and Mary Veverka, and local comedy giants, The Pushers.
</p>
<p>The Pushers present The Pullers! - Kids Pre-Teen Improv Graduation Show
</p>
<p>Saturday, November 11th<br>The show starts at 12pm.<br>This is a free show!!!
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
<p>--
</p>
<p>Push Comedy Theater
</p>
<p>763 Granby Street<br>Norfolk, VA
</p>
<p>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=SAQEp-CGB&amp;enc=AZPSkpnzx134nCcYgDU_0YyrxP8zVtNaf96oRmxhwRhXWkRATDUW2gOh6TNIa-MQOgs&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a>
</p>
"""
Logger.info "Writing Class The Pullers! - Kids Improv 101 Graduation Show"
listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "The Pullers! - Kids Improv 101 Graduation Show",
slug: "M8N6CF",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-11T12:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-11T13:00:00.000-05:00")
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing cover photo for The Pullers! - Kids Improv 101 Graduation Show"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285435/956c4dd4-f384-4e42-81da-ffce538d8992.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for The Pullers! - Kids Improv 101 Graduation Show"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285435/956c4dd4-f384-4e42-81da-ffce538d8992.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for The Pullers! - Kids Improv 101 Graduation Show"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for The Pullers! - Kids Improv 101 Graduation Show",
status: "available",
description: "Ticket for The Pullers! - Kids Improv 101 Graduation Show",
price: 0,
sale_start:  NaiveDateTime.from_iso8601!("2017-10-31T19:28:13.395Z")
}
|> TicketAgent.Repo.insert!
end)
Logger.info ">> Writing tag free for The Pullers! - Kids Improv 101 Graduation Show"
%TicketAgent.ListingTag{
listing_id: listing.id,
tag: "free"
}
|> TicketAgent.Repo.insert!

description = """
<strong></strong><strong></strong><strong></strong><strong></strong>
<p><strong></strong><strong>Get ready for Hampton Roads' newest generation of comedy superstars!!!</strong>
</p>
<p><br>
</p>
<p><strong></strong>It's the Teen Great Big Improv and Sketch Graduation Show!!! Don't miss this group of talented teenage improvisers and sketch comedians as they put on a funny and fast paced 'Whose Line Is It Anyway' style show.
</p>
<p><br>
</p>
<p><strong></strong>
</p>This is a free show.
<p><strong></strong>
</p>
<p><strong><br></strong>
</p>
<h1>The Teen Great Big Improv and Sketch Grad Show</h1>
<p>Saturday, November 11th at 2pm<br>
</p>
<p>Push Comedy Theater<br>763 Granby Street <br>Norfolk, VA<br>757-333-7442<br><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fpushcomedytheater.com%2F&amp;h=IAQFXbWK-&amp;enc=AZOPL4oGCU8KwLS1ULzXIGkAlp390nUXmKxOesT9vjgB6P5g9tvKt2_4aOrkgku0E98&amp;s=1" rel="nofollow" target="_blank">pushcomedytheater.com</a>
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
"""
Logger.info "Writing Class Class Dismissed: The Teen Improv Grad Show"
listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Class Dismissed: The Teen Improv Grad Show",
slug: "85M2PK",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-11T14:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-11T15:00:00.000-05:00")
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing cover photo for Class Dismissed: The Teen Improv Grad Show"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285436/b10e4c68-360d-4a5d-baf5-aaa3e2d7ec8a.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for Class Dismissed: The Teen Improv Grad Show"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285436/b10e4c68-360d-4a5d-baf5-aaa3e2d7ec8a.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for Class Dismissed: The Teen Improv Grad Show"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for Class Dismissed: The Teen Improv Grad Show",
status: "available",
description: "Ticket for Class Dismissed: The Teen Improv Grad Show",
price: 0,
sale_start:  NaiveDateTime.from_iso8601!("2017-11-10T03:04:39.935Z")
}
|> TicketAgent.Repo.insert!
end)
Logger.info ">> Writing tag free for Class Dismissed: The Teen Improv Grad Show"
%TicketAgent.ListingTag{
listing_id: listing.id,
tag: "free"
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
Logger.info "Writing Class Who Dunnit? ...The Improvised Murder Mystery"
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

Logger.info "> Writing cover photo for Who Dunnit? ...The Improvised Murder Mystery"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611651/e736e2a2-4950-4b7c-b606-f0ce63e26dff.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for Who Dunnit? ...The Improvised Murder Mystery"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611651/e736e2a2-4950-4b7c-b606-f0ce63e26dff.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for Who Dunnit? ...The Improvised Murder Mystery"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for Who Dunnit? ...The Improvised Murder Mystery",
status: "available",
description: "Ticket for Who Dunnit? ...The Improvised Murder Mystery",
price: 1000,
sale_start:  NaiveDateTime.from_iso8601!("2017-09-08T23:15:11.031Z")
}
|> TicketAgent.Repo.insert!
end)
Logger.info ">> Writing tag murder-mystery for Who Dunnit? ...The Improvised Murder Mystery"
%TicketAgent.ListingTag{
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
Logger.info "Writing Class Second Saturday Stand-Up"
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

Logger.info "> Writing cover photo for Second Saturday Stand-Up"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611652/9bd8303c-a46b-4654-8fc9-c7eb6b68a587.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for Second Saturday Stand-Up"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611652/9bd8303c-a46b-4654-8fc9-c7eb6b68a587.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for Second Saturday Stand-Up"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for Second Saturday Stand-Up",
status: "available",
description: "Ticket for Second Saturday Stand-Up",
price: 500,
sale_start:  NaiveDateTime.from_iso8601!("2017-10-16T20:06:45.310Z")
}
|> TicketAgent.Repo.insert!
end)
Logger.info ">> Writing tag deal for Second Saturday Stand-Up"
%TicketAgent.ListingTag{
listing_id: listing.id,
tag: "deal"
}
|> TicketAgent.Repo.insert!

Logger.info ">> Writing tag standup for Second Saturday Stand-Up"
%TicketAgent.ListingTag{
listing_id: listing.id,
tag: "standup"
}
|> TicketAgent.Repo.insert!

description = """
<p>Dust off those caps and gowns... because it's graduation time at the Push.
</p>
<p>Check out the Push Comedy Theater's Improv 101 class as they show off their comedy chops.
</p>
<p>You won't believe what these improv newcomers have in store for you!!!
</p>
<p>Class Dismissed: The Improv 101 Graduation Show<br>Tuesday, November 14th at 7pm<br>Tickets are $5
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
"""
Logger.info "Writing Class Class Dismissed: The Improv 101 Grad Show"
listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Class Dismissed: The Improv 101 Grad Show",
slug: "Y08MFK",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-14T19:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-14T20:30:00.000-05:00")
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing cover photo for Class Dismissed: The Improv 101 Grad Show"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285437/87dc866e-46e3-4d6e-9494-46cc076c3e6d.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for Class Dismissed: The Improv 101 Grad Show"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285437/87dc866e-46e3-4d6e-9494-46cc076c3e6d.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for Class Dismissed: The Improv 101 Grad Show"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for Class Dismissed: The Improv 101 Grad Show",
status: "available",
description: "Ticket for Class Dismissed: The Improv 101 Grad Show",
price: 500,
sale_start:  NaiveDateTime.from_iso8601!("2017-11-08T03:30:48.316Z")
}
|> TicketAgent.Repo.insert!
end)
Logger.info ">> Writing tag deal for Class Dismissed: The Improv 101 Grad Show"
%TicketAgent.ListingTag{
listing_id: listing.id,
tag: "deal"
}
|> TicketAgent.Repo.insert!

description = """
<p>Come cheer on Push Comedy Theater’s Musical Improv Class as they take the stage for their graduation show!
</p>
<p>This talented band of improvisers has been working incredibly hard for 6 weeks - singing, rapping, and even dancing - so let’s support them as they show us their brand new skills.
</p>
<p>Get ready as singing and improv collide!!!
</p>
<p><strong>Class Dismissed: The Musical Improv 101 Graduation Show</strong>
</p>
<p>Thursday, November 16th at 7pm
</p>
<p>Tickets are $5
</p>
"""
Logger.info "Writing Class Class Dismissed: The Musical Improv 101 Graduation Show"
listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Class Dismissed: The Musical Improv 101 Graduation Show",
slug: "3ZFND0",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-16T19:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-16T20:30:00.000-05:00")
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing cover photo for Class Dismissed: The Musical Improv 101 Graduation Show"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285438/376331a7-12e6-4099-aa80-cee9908af7dd.png",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for Class Dismissed: The Musical Improv 101 Graduation Show"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285438/376331a7-12e6-4099-aa80-cee9908af7dd.png",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for Class Dismissed: The Musical Improv 101 Graduation Show"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for Class Dismissed: The Musical Improv 101 Graduation Show",
status: "available",
description: "Ticket for Class Dismissed: The Musical Improv 101 Graduation Show",
price: 500,
sale_start:  NaiveDateTime.from_iso8601!("2017-11-09T01:41:48.016Z")
}
|> TicketAgent.Repo.insert!
end)
Logger.info ">> Writing tag deal for Class Dismissed: The Musical Improv 101 Graduation Show"
%TicketAgent.ListingTag{
listing_id: listing.id,
tag: "deal"
}
|> TicketAgent.Repo.insert!

description = """
<p>Howdy there, partner!
</p>
<p>Get ready for the Improvised Western.<br><br>Don't miss the gun slinger with a heart of gold, the damsel in distress, the villain dressed in black... bank heists, shoot outs, horse chases and more.<br><br>It's everything you love about the good old fashioned western... made up right before your eyes.<br><br>From John Wayne to Clint Eastwood, Tombstone to True Grit... if you're a fan of westerns (or just a fan of comedy), you'll love How the West was Improvised.<br><br>How the West was Improvised: The Made Up Western<br>Friday, November 17th at 8pm<br>Tickets are $10
</p>
"""
Logger.info "Writing Class How the West was Improvised: The Made Up Western"
listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "How the West was Improvised: The Made Up Western",
slug: "0G83DL",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-17T20:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-17T21:30:00.000-05:00")
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing cover photo for How the West was Improvised: The Made Up Western"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285439/5c2916c4-1c98-4369-9021-88aee9b5519c.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for How the West was Improvised: The Made Up Western"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285439/5c2916c4-1c98-4369-9021-88aee9b5519c.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for How the West was Improvised: The Made Up Western"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for How the West was Improvised: The Made Up Western",
status: "available",
description: "Ticket for How the West was Improvised: The Made Up Western",
price: 1000,
sale_start:  NaiveDateTime.from_iso8601!("2017-10-26T02:12:50.299Z")
}
|> TicketAgent.Repo.insert!
end)
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
Logger.info "Writing Class Lip Service Finals - The Ultimate Lip Sync Competition!"
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

Logger.info "> Writing cover photo for Lip Service Finals - The Ultimate Lip Sync Competition!"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611653/d54fa7f3-96fe-497d-90b4-c20383116110.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for Lip Service Finals - The Ultimate Lip Sync Competition!"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611653/d54fa7f3-96fe-497d-90b4-c20383116110.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for Lip Service Finals - The Ultimate Lip Sync Competition!"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for Lip Service Finals - The Ultimate Lip Sync Competition!",
status: "available",
description: "Ticket for Lip Service Finals - The Ultimate Lip Sync Competition!",
price: 1000,
sale_start:  NaiveDateTime.from_iso8601!("2017-10-08T20:33:12.475Z")
}
|> TicketAgent.Repo.insert!
end)
Logger.info ">> Writing tag music for Lip Service Finals - The Ultimate Lip Sync Competition!"
%TicketAgent.ListingTag{
listing_id: listing.id,
tag: "music"
}
|> TicketAgent.Repo.insert!

Logger.info ">> Writing tag lip-sync for Lip Service Finals - The Ultimate Lip Sync Competition!"
%TicketAgent.ListingTag{
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
Logger.info "Writing Class Musical Improv 201"
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

Logger.info "> Writing cover photo for Musical Improv 201"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611655/20f01bb1-d774-4ecd-8ac0-00dca64a153f.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for Musical Improv 201"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611655/20f01bb1-d774-4ecd-8ac0-00dca64a153f.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for Musical Improv 201"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for Musical Improv 201",
status: "available",
description: "Ticket for Musical Improv 201",
price: 21000,
sale_start:  NaiveDateTime.from_iso8601!("2017-09-10T21:07:26.636Z")
}
|> TicketAgent.Repo.insert!
end)
description = """
<p>Suggested theme: Patience<br><br>Join us 7 p.m. Nov. 19 at the Push Comedy Theater for a night of stories. This month the theme is "patience." Storytellers to be announced. Admission: $5.<br><br>Want to tell a story? Visit <a href="https://l.facebook.com/l.php?u=http%3A%2F%2Fwww.tellmemorelive.org%2Fpitch&amp;h=ATM8uKh5nwl4N69YVVQcgfhmXbyIqJ9-qdiBHnVpduAeOmAjz3xD871ArFwkw934424WfZ2a4g84y1k1rZTVTRk499fyK0bjmtQOw4hRuThkTGhdX9FJlvZ4v4P1cWdEveFskkNFp46qZ0HUqo-qJPjCWg&amp;enc=AZMUEFm0cXrM5DbqWWyXul5gE-gMcpnAn1uNpQoCtjY2_BLzEOg5v4uJpUbtQ5cegoY&amp;s=1" rel="nofollow" target="_blank">www.tellmemorelive.org/<wbr>pitch</wbr></a>. Call (757) 785-5590. Or email submit@tellmemorelive.org.<br><br>Time: 7 p.m.<br>Date: Sunday, November 19th, 2017<br>Location: Push Comedy Theater, 763 Granby Street, Norfolk<br>Admission: $5
</p>
"""
Logger.info "Writing Class Tell Me More Storytelling"
listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Tell Me More Storytelling",
slug: "DLNXJP",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-19T19:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-19T20:30:00.000-05:00")
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing cover photo for Tell Me More Storytelling"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285441/f67e17eb-7f1d-4674-97c9-ffc80f398f8e.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for Tell Me More Storytelling"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285441/f67e17eb-7f1d-4674-97c9-ffc80f398f8e.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for Tell Me More Storytelling"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for Tell Me More Storytelling",
status: "available",
description: "Ticket for Tell Me More Storytelling",
price: 500,
sale_start:  NaiveDateTime.from_iso8601!("2017-11-09T01:53:13.638Z")
}
|> TicketAgent.Repo.insert!
end)
Logger.info ">> Writing tag deal for Tell Me More Storytelling"
%TicketAgent.ListingTag{
listing_id: listing.id,
tag: "deal"
}
|> TicketAgent.Repo.insert!

description = """
<p><strong></strong><strong>Dust off those caps and gowns... because it's graduation time at the Push.</strong>
</p>
<p>Check out the Push Comedy Theater's Improv 201 class as they show off their comedy chops.
</p>
<p>Watch as these brave 201 souls dive head first into the wonderful world of The Harold. So who the heck is Harold? More accurately the question should be... what the heck is a Harold?
</p>
<p>The Harold is perhaps the best know style of long form improv. It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.
</p>
<p><strong>Class Dismissed: The Improv 201 Graduation Show </strong><br>Monday, November 20th at 7pm<br>Tickets are $5
</p>
<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.
</p>
<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.
</p>
"""
Logger.info "Writing Class Class Dismissed: The Improv 201 Graduation Show"
listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Class Dismissed: The Improv 201 Graduation Show",
slug: "BJRHV0",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-20T19:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-11-20T20:30:00.000-05:00")
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing cover photo for Class Dismissed: The Improv 201 Graduation Show"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285442/8b5822d7-25d6-4a77-a774-ff0916f5db49.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for Class Dismissed: The Improv 201 Graduation Show"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285442/8b5822d7-25d6-4a77-a774-ff0916f5db49.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for Class Dismissed: The Improv 201 Graduation Show"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for Class Dismissed: The Improv 201 Graduation Show",
status: "available",
description: "Ticket for Class Dismissed: The Improv 201 Graduation Show",
price: 500,
sale_start:  NaiveDateTime.from_iso8601!("2017-11-08T03:38:28.344Z")
}
|> TicketAgent.Repo.insert!
end)
Logger.info ">> Writing tag deal for Class Dismissed: The Improv 201 Graduation Show"
%TicketAgent.ListingTag{
listing_id: listing.id,
tag: "deal"
}
|> TicketAgent.Repo.insert!

description = """
<p><strong>Jump into the wonderful and wild world of improv comedy!!!</strong>
</p>
<p><br>Learn the beginnings of Chicago-based, long form improv. Students will learn how to create scenes based off of audience suggestions. They will learn the fundamentals of 'Yes, And,' how to support scene partners' ideas and energy, and how to make strong character choices.
</p>
<p>Absolutely no experience in acting or comedy is needed. The Push Comedy Theater strives to create a fun, safe and supportive experience for all students.
</p>
<p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.
</p>
<p>This class meets six times from 6:30pm-9:30pm on Tuesday nights from November 8th through December 26th.
</p>
<p>Cost: $190
</p>
<p><br>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.
</p>
<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.
</p>
"""
Logger.info "Writing Class Improv 101 with Brad McMurran"
listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: improv101.id,
type: "class",
title: "Improv 101 with Brad McMurran",
slug: "8WNSBH",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-11-28T18:30:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-12-26T21:30:00.000-05:00")
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing cover photo for Improv 101 with Brad McMurran"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611207/988155d3-5ef5-494c-a005-0fabeb97240d.png",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for Improv 101 with Brad McMurran"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611207/988155d3-5ef5-494c-a005-0fabeb97240d.png",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for Improv 101 with Brad McMurran"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for Improv 101 with Brad McMurran",
status: "available",
description: "Ticket for Improv 101 with Brad McMurran",
price: 19000,
sale_start:  NaiveDateTime.from_iso8601!("2017-11-05T05:07:12.175Z")
}
|> TicketAgent.Repo.insert!
end)
description = """
<p style="text-align: center;">Get ready for a night of comedy from the Pushers' own Brad McMurran.
</p>
<p style="text-align: center;"><br>
</p>
<p style="text-align: center;"><strong>Good Talk: The Brad McMurran Show</strong>
</p>
<p style="text-align: center;">Christmas Talks
</p>
<p style="text-align: center;">Sunday, December 3rd at 7pm
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
<p style="text-align: center;">New Years Resolutions<br>
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
Logger.info "Writing Class Good Talk: The Brad McMurran Show"
listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Good Talk: The Brad McMurran Show",
slug: "JXTVZ0",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-12-03T19:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-12-03T21:00:00.000-05:00")
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing cover photo for Good Talk: The Brad McMurran Show"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611645/de52f7d0-daa6-4b61-b647-322e1c8b9958.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for Good Talk: The Brad McMurran Show"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611645/de52f7d0-daa6-4b61-b647-322e1c8b9958.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for Good Talk: The Brad McMurran Show"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for Good Talk: The Brad McMurran Show",
status: "available",
description: "Ticket for Good Talk: The Brad McMurran Show",
price: 1200,
sale_start:  NaiveDateTime.from_iso8601!("2017-11-06T01:15:59.748Z")
}
|> TicketAgent.Repo.insert!
end)
Logger.info ">> Writing tag good-talk for Good Talk: The Brad McMurran Show"
%TicketAgent.ListingTag{
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
<p><strong>Girl-Prov: The Girls' Night of Improv</strong><br>Friday, December 8th at the Push Comedy Theater<br>The show starts at 8, tickets are $5
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
Logger.info "Writing Class Girl-Prov: The Girls' Night of Improv"
listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Girl-Prov: The Girls' Night of Improv",
slug: "YSNCMW",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-12-08T20:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-12-08T21:30:00.000-05:00")
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing cover photo for Girl-Prov: The Girls' Night of Improv"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611647/2818bca8-8162-47b8-999f-625527ad42d0.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for Girl-Prov: The Girls' Night of Improv"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611647/2818bca8-8162-47b8-999f-625527ad42d0.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for Girl-Prov: The Girls' Night of Improv"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for Girl-Prov: The Girls' Night of Improv",
status: "available",
description: "Ticket for Girl-Prov: The Girls' Night of Improv",
price: 500,
sale_start:  NaiveDateTime.from_iso8601!("2017-10-15T16:43:07.317Z")
}
|> TicketAgent.Repo.insert!
end)
Logger.info ">> Writing tag deal for Girl-Prov: The Girls' Night of Improv"
%TicketAgent.ListingTag{
listing_id: listing.id,
tag: "deal"
}
|> TicketAgent.Repo.insert!

Logger.info ">> Writing tag girl-prov for Girl-Prov: The Girls' Night of Improv"
%TicketAgent.ListingTag{
listing_id: listing.id,
tag: "girl-prov"
}
|> TicketAgent.Repo.insert!

description = """
<p><strong>Santa Claus is coming to the Push Comedy Theater!</strong>
</p>
<p>Come visit with Santa and take part in interactive holiday stories. There will be stories, some improv and Santa.
</p>
<p>Enjoy seasonal treats including cookies, hot cocoa, juice and coffee or tea for the adults.
</p>
<p>Children will have a chance to chat with Santa and receive a goodie bag.
</p>
<p>There is limited seating and reservations are recommended.
</p>
<p>Parents, make sure to bring your cameras!
</p>
<p><strong><br></strong>
</p>
<p><strong>Stories with Santa</strong>
</p>
<p>Saturday, December 16th
</p>
<p>Sunday, December 17th
</p>
<p>Friday, December 22nd.<br>
</p>
<p>The show starts at noon.
</p>
<p>Tickets are $5.
</p>
<p>This show is fun for the whole family.
</p>
<p>--
</p>
<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
</p>
<p><br>
</p>
"""
Logger.info "Writing Class Stories With Santa"
listing = %TicketAgent.Listing{
user_id: user.id,
account_id: account.id,
class_id: nil,
type: "show",
title: "Stories With Santa",
slug: "ZTHQFL",
description: description,
status: "active",
start_time:  NaiveDateTime.from_iso8601!("2017-12-16T12:00:00.000-05:00"),
end_time:  NaiveDateTime.from_iso8601!("2017-12-22T14:00:00.000-05:00")
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing cover photo for Stories With Santa"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285443/bbdfb86d-39d8-465c-8f0e-9b5d33a8b4ec.jpg",
type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for Stories With Santa"
%TicketAgent.ListingImage{
listing_id: listing.id,
url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1510285443/bbdfb86d-39d8-465c-8f0e-9b5d33a8b4ec.jpg",
type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for Stories With Santa"

Enum.each(1..88, fn(x) ->
%TicketAgent.Ticket{
listing_id: listing.id,
name: "Ticket for Stories With Santa",
status: "available",
description: "Ticket for Stories With Santa",
price: 500,
sale_start:  NaiveDateTime.from_iso8601!("2017-11-10T01:42:21.104Z")
}
|> TicketAgent.Repo.insert!
end)
Logger.info ">> Writing tag deal for Stories With Santa"
%TicketAgent.ListingTag{
listing_id: listing.id,
tag: "deal"
}
|> TicketAgent.Repo.insert!

