require Logger

Code.load_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

alba = SeedHelpers.create_teacher(%{
  slug: "alba_woolard",
  name: "Alba Woolard", 
  biography: "<p>Alba has been a performer and writer for the sketch and improv comedy group The Pushers since the summer of 2009. As a member of the group, she also produces and directs \"Panties in a Twist: The All Female Sketch Comedy Show.\"</p><p>She graduated with a BFA in Acting from Old Dominion University. She has studied Improv with the Pushers and several regional improvisers. With the Pushers, she has performed up and down the east coast. By day, Alba is a Standardized Patient Educator at Eastern Virginia Medical School.</p>",
  email: "alba@pushcomedytheater.com",
  social: %{}
})

brad = SeedHelpers.create_teacher(%{
  slug: "brad_mcmurran",
  name: "Brad McMurran",
  biography: "<p>Brad McMurran is the founder of The Pushers Sketch and Improvisation Comedy Troupe. He is the co-head writer, performer, and artistic director of the Push Comedy Theater.</p><p>Brad studied acting in college, trained in improvisation at Upright Citizen's Brigades, and is the co-writer of Cuff Me; The 50 Shades of Grey Musical Parody (which played off-broadway in New York for the past year).</p><p>Brad has been writing sketch comedy for ten years and is pleased as a pickle to be opening up this theater in Hampton Roads. McMurran is a graduate of Old Dominion and enjoys pizza.</p>",
  email: "brad@pushcomedytheater.com",
  social: %{"facebook" => "https://www.facebook.com/bradmcmurran", "twitter" => "https://twitter.com/Brad_ThePushers"}
})

ed = SeedHelpers.create_teacher(%{
  slug: "ed_carden",
  name: "Ed Carden",
  biography: "<p>Ed Carden has been acting and performing comedy for more than a decade, and has appeared in nearly 30 local theatrical productions, as well as a handful of commercials and short films.</p><p>He is a founding member of The Pushers Sketch/Improv Comedy Group, in which he serves as a performer, writer, and producer. With The Pushers, he has performed up and down the east coast.</p><p>By day he works for Virginia Beach Public Schools. In addition to writing and performing, he enjoys cheeseburgers, sushi, and science fiction—not necessarily in that order.</p>",
  email: "ed@pushcomedytheater.com",
  social: %{"twitter" => "https://twitter.com/TheEdCarden"}
})

sean = SeedHelpers.create_teacher(%{
  slug: "sean_devereux",
  name: "Sean Devereux",
  biography: "<p>Sean Devereux is an original member of The Pushers, and has been performing and writing comedy for nearly ten years.</p><p>Sean studied improv at the Upright Citizens Brigade Theater in New York and is one of the co-writers of the Off-Broadway hit Cuff Me: The Fifty Shades of Grey Musical Parody. In his civilian guise, Sean is an Emmy award winning writer and producer at WVEC-TV13.</p>",
  email: "sean@pushcomedytheater.com",
  social: %{"twitter" => "https://twitter.com/Sean_ThePushers"}
})