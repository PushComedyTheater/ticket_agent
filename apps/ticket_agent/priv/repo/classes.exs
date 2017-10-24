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
