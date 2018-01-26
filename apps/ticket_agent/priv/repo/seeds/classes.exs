require Logger

Code.load_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")


TicketAgent.Repo.query("CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\"")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)

improv101 = SeedHelpers.create_class(
  %{
    title: "Improv 101: Introduction to Improvisational Comedy",
    type: "improvisation",
    slug: "improv101",
    description: "Learn the beginnings of Chicago-based, long form improv. Students will learn how to create scenes based off of audience suggestions. They will learn: <ul><li>the fundamentals of 'Yes, And'</li><li>how to support scene partners' ideas and energy</li><li>and how to make strong character choices.</li></ul> Absolutely no experience in acting or comedy is needed. The Push Comedy Theater strides to create a fun, safe and supportive experience for all students.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/wd4vnbdjwchrclmuhomg.jpg",
    menu_order: 1,
    account_id: account.id,
    prerequisite_id: nil
  }
)

improv201 = SeedHelpers.create_class(
  %{
    title: "Improv 201: Foundations of the Harold: Game and Second Beats",
    type: "improvisation",
    slug: "improv201",
    description: "This course builds upon the fundamentals and skills learned in 101. Students will learn the beginnings 'The Harold' a long form improvisation structure developed by Del Close. They will learn how to identify the 'game' of a scene and how to heighten these games to develop 'second beats'.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/qphl4uwhh5opshbsjuvl.jpg",
    menu_order: 2,
    account_id: account.id,
    prerequisite_id: improv101.id
  }
)

improv301 = SeedHelpers.create_class(
  %{
    title: "Improv 301: The Harold: Openers and Group Games",
    type: "improvisation",
    slug: "improv301",
    description: "This course continues the Harold work started in 202. Students will delve more deeply into 'The Harold' structure. They will learn a series of 'openers' and 'group games' that will complete the Harold format. Openers are used to derive inspiration from the audience's suggestion while group games are multi person scenes that break up the traditional 2 person scenes.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/uyjvypsmg96fcd4zl88j.jpg",
    menu_order: 3,
    account_id: account.id,
    prerequisite_id: improv201.id
  }  
)

improv401 = SeedHelpers.create_class(
  %{
    title: "Improv 401: Advanced Harold",
    type: "improvisation",
    slug: "improv401",
    description: "Now we put it all together. Students will combine the skills learned in the previous courses for an in depth study of The Harold. This course will delve deeper into the form, focusing on editing scenes, individual and group commitment, as well as the components of 2-person, 3-person, and group scenes.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/vbstqyeecfovcwm3mx9r.jpg",
    menu_order: 4,
    account_id: account.id,
    prerequisite_id: improv301.id
  }
)

improv501 = SeedHelpers.create_class(
  %{
    title: "Improv 501: Improv Studio",
    type: "improvisation",
    slug: "improv501",
    description: "***THIS COURSE WILL CAP AT 16 STUDENTS*** This course focuses on giving students individual attention to their strengths and weaknesses. We will also break down the different components of improv scenes and the choices that improvisers have and make within those scenes.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/hhlz9x5qcz2qqkk3xyga.jpg",
    menu_order: 5,
    account_id: account.id,
    prerequisite_id: improv401.id
  }
)

kidprov101 = SeedHelpers.create_class(
  %{
    title: "Kidprov 101",
    type: "improvisation",
    slug: "kidprov101",
    description: "Don't miss out on the fun!!! Sign up your kids, grand kids, nieces, nephews, even the stinky neighbor kid from down the street for KidProv at the Push Comedy Theater.<br />This class is open to children ages 8 to 12. Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public-speaking, social and team-building skills.<br />This class will be conducted in a non-judgmental environment where the students will build confidence, make friends and most importantly ... have fun<br />The session concludes with the students performing in a graduation show on the Push Comedy Theater Stage.<br />This is class is $150 for new students and $140 for returning students.<br />New students also receive a free tshirt.",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/g0upzsg4dchanai2ul0l.jpg",
    menu_order: 6,
    account_id: account.id,
    prerequisite_id: nil
  }
)

kidprov_studio = SeedHelpers.create_class(
  %{
    title: "Kidprov Studio",
    type: "improvisation",
    slug: "kidprov_studio",
    description: "Don't miss out on the fun!!! Sign up your kids, grand kids, nieces, nephews, even the stinky neighbor kid from down the street for KidProv at the Push Comedy Theater.<br />This class is open to children ages 8 to 12 who have previously taken at least 2 sessions of KidProv 101. Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public-speaking, social and team-building skills.<br />This class will be conducted in a non-judgmental environment where the students will build confidence, make friends and most importantly ... have fun<br />The session concludes with the students performing in a graduation show on the Push Comedy Theater Stage.<br />This class is $150.",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/orrcrhg9bcgnexgseitw.jpg",
    menu_order: 7,
    account_id: account.id,
    prerequisite_id: kidprov101.id
  }
)

music_improv101 = SeedHelpers.create_class(
  %{
    title: "Musical Improv 101",
    type: "improvisation",
    slug: "music_improv101",
    description: "This is what you've been waiting for! The Push Comedy Theater brings you MUSICAL IMPROV!!!<br />This course offers an introduction to long form musical improvisation. We will cover the basics of how to work with music while learning how to create two person musical numbers, placing them together to create a 15 minute thematic musical show.<br />Additional focus will be on sound exploration, movement, stylization, and accessing voice. Prepare to challenge yourself while having a ton of fun! This course culminates with a graduation show.",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/vggfmhm2c99mhkxi7r7v.jpg",
    menu_order: 8,
    account_id: account.id,
    prerequisite_id: improv101.id
  }
)

music_improv201 = SeedHelpers.create_class(
  %{
    title: "Musical Improv 201",
    type: "improvisation",
    slug: "music_improv201",
    description: "This class is focused on building a long form Musical Harold. It will improve upon the concepts and skills learned in Musical Improv 101, with a focus on finding deeper relationships and themes to bring to life through song.",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/rxu5yn34d5rp0nvnkssf.jpg",
    menu_order: 9,
    account_id: account.id,
    prerequisite_id: music_improv101.id
  }
)

music_improv_studio = SeedHelpers.create_class(
  %{
    title: "Musical Improv Studio",
    type: "improvisation",
    slug: "music_improv_studio",
    description: "This course builds on what is learned in Musical Improv 101 and 201. We will work together on creating new forms and building skills for more varied and interesting scenes and songs.<br />Together, we will create a thematic musical form that will be the structure for our graduation show.",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/yes_yfvtxd.jpg",
    menu_order: 10,
    account_id: account.id,
    prerequisite_id: music_improv201.id
  }
)

teen_improv = SeedHelpers.create_class(
  %{
    title: "Improv for Teens",
    type: "improvisation",
    slug: "teen_improv",
    description: "Jump head first into the wonderful worlds of sketch and improv comedy. This class is open to teens from the ages of 13 to 18. Absolutely no experience is needed. Students will explore the key tools behind both long and short form improvisation. We will play numerous games to help you sharpen your mind. We will then use improv as a springboard for writing basic comedy sketches- like those seen on SNL. We strive to create a safe, non-judgmental environment where teens can build confidence, make friends and most importantly... have fun.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/s9uyzugyefwu81hmicmb.jpg",
    menu_order: 11,
    account_id: account.id,
    prerequisite_id: nil
  }
)

sketch101 = SeedHelpers.create_class(
  %{
    title: "Sketch Comedy Writing 101",
    type: "sketch",
    slug: "sketch101",
    description: "Dive head first into the wonderful world of sketch comedy! Whether you're a seasoned writer or someone who rarely picks up a pen, this class will teach how to get the funny ideas out of your head and onto the page. In this class we will examine the various types of sketches, learn how to generate funny ideas and then turn them into a sketches ready for the stage. This class is open to everyone, no writing or comedy experience is ready.<br />At the end of the session, students sketches will be performed on the Push Comedy Theater stage by some of Hampton Roads finest actors.",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/nfshrdoaapy0pcsqayru.jpg",
    menu_order: 1,
    account_id: account.id,
    prerequisite_id: nil
  }
)

sketch201 = SeedHelpers.create_class(
  %{
    title: "Sketch Comedy Writing 201",
    type: "sketch",
    slug: "sketch201",
    description: "This course builds upon the fundamentals and skills learned in 101.<br />At the end of the session, students sketches will be performed on the Push Comedy Theater stage by some of Hampton Roads finest actors.",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/wk3zfokdjzhpxpfsrgxx.jpg",
    menu_order: 2,
    account_id: account.id,
    prerequisite_id: sketch101.id
  }
)

standup101 = SeedHelpers.create_class(
  %{
    title: "Standup 101",
    type: "standup",
    slug: "standup101",
    description: "Learn how to perform stand-up comedy!<br />Learn about the often-overlooked basics of stand-up comedy and the nuances of fine tuning your act from almost-jaded veteran comic Hatton Jordan.<br />This class focuses on learning three skills:<br /><ul><li>HOW to craft an original set,</li><li>HOW to host a show like a pro</li><li>HOW to market yourself so club bookers will want to pay you.</li></ul><br />This course culminates with YOU and the others in your class performing your set at your Grad Show at the Push Theater.<br />The class will be a 6 week course ending with a graduation show at the 90 seat Push Comedy Theater.",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/sxdcjtuvqwxkwyraic4x.jpg",
    menu_order: 1,
    account_id: account.id,
    prerequisite_id: nil
  }
)

acting101 = SeedHelpers.create_class(
  %{
    title: "Acting 101",
    type: "acting",
    slug: "acting101",
    description: "This foundational course introduces the basic principles of acting through improvisation, monologue, scene work, and technical methods in voice, physical action, and text analysis. It involves fundamental skills and techniques with an emphasis on physical/vocal awareness, spontaneity, concentration, and truthful response.",
    image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/hgjkgz1oh1qqjrqznljt.jpg",
    menu_order: 1,
    account_id: account.id,
    prerequisite_id: nil
  }
)