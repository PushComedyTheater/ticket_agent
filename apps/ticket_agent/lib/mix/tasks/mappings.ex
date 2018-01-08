defmodule TicketAgent.Mappings do
  def classes do
    [
      "Stand-Up Comedy 101 with Hatton Jordan",
      "Stand-Up Comedy 101 with Jason Kypros",
      "Improv 101 with Brad McMurran",
      "Improv 501: Improv Studio",
      "Improv 501: Improv Studio (Advanced Harold Study)",
      "Improv for Teens at the Push Comedy Theater",
      "KidProv 201 at the Push Comedy Theater",
      "KidProv at the Push Comedy Theater",
      "Musical Improv 101",
      "Musical Improv 201",
      "Musical Improv Studio",
      "Sketch Comedy Writing 101",
      "Sketch Comedy Writing 201",
      "​Improv 201 at the Push Comedy Theater",
      "​Improv 301 : The Harold Openers and Group Games",
      "​Improv 401: Advanced Harold"
    ]
  end

  def workshops do 
    [
      "Character Workshop",
      "Murder Mystery Workshop",
      "Workshop: Composition/Viewpoints with Deborah Wallace",
      "Workshop: Curve Balls and Breaking the Rules",
      "Workshop: Fear of Commitment with Andy Livengood",
      "Workshop: Give a S*** with Andy Livengood",
      "Workshop: Improv Workout",
      "Workshop: Introduction to Sketch Writing",
      "Workshop: Musical Comedy",
      "Workshop: Silence and Sincerity in Improvisation",
      "Workshop: The End of the World",
      "Workshop: Viewpoints Intensive",
      "Workshop: Writing Funny Songs w/ Reformed Whores",
      "Workshop: You Are Not The Scene"
    ]
  end

  def camps do
    [
      "Pre-Teen Improv Camp (session 1)",
      "Pre-Teen Improv Camp (session 2)",
      "Pre-teen Improvisation Comedy Camp",
      "Teen Improv Camp",
      "Teen Improv and Sketch Comedy Summer Camp"
    ]
  end

  def mappings do
    %{
      ~r/^Musical Improv 101/i => "music_improv101",
      ~r/^Musical Improv 201/i => "music_improv201",
      ~r/^Musical Improv Studio/i => "music_improv_studio",

      ~r/^Improv 101/i => "improv101",
      ~r/^Improv 201/i => "improv201",
      ~r/Improv 201/i => "improv201",
      ~r/^Improv 301/i => "improv301",
      ~r/Improv 301/i => "improv301",
      ~r/^Improv 401/i => "improv401",
      ~r/^Improv 501/i => "improv501",
      ~r/^Improv For Teens/i => "teen_improv",
      ~r/^KidProv 201/i => "kidprov201",
      ~r/^KidProv/i => "kidprov101",
    
      ~r/^Stand-Up Comedy 101/i => "improv301",
      ~r/^Sketch Comedy Writing 101/i => "sketch101",
      ~r/^Sketch Comedy Writing 201/i => "sketch201",  
    }
  end

  def regex_mappings do
    %{
      ~r/\b666\b/i => ["666", "project", "halloween"],
      ~r/\babsolute uncertainty\b/i => ["absolute-uncertainty"],
      ~r/\ball ages\b/i => ["all-ages"],
      ~r/\bharold\b/i => ["harold"],
      ~r/\blip\b/i => ["lip-sync", "music"],
      ~r/\bncf\b/i => ["ncf", "norfolk", "comedy", "festival"],
      ~r/\bpre madonnas\b/i => ["pre-maddonas"],
      ~r/\bstandup\b|\bstand-up\b/i => ["standup"],
      ~r/\bstorytelling\b/i => ["tell-me-more", "storytelling"],
      ~r/\bteacher\b/i => ["graduation-show"],
      ~r/\bupright\b/i => ["uscb", "upright", "senior-citizens"],
      ~r/\bworkshop\b/i => ["workshop"],
      ~r/3 on 3/i => ["tournament"],
      ~r/christmas/i => ["christmas"],
      ~r/class dismissed/i => ["graduation", "students"],
      ~r/date night/i => ["date-night"],
      ~r/double feature/i => ["double-feature", "movie"],
      ~r/double treble/i => ["music"],
      ~r/girl-prov/i => ["girl-prov"],
      ~r/good talk/i => ["good-talk"],
      ~r/improvageddon/i => ["improvageddon", "contest"],
      ~r/locals only/i => ["locals-only"],
      ~r/panties in a twist/i => ["panties", "panties-in-a-twist"],
      ~r/santa/i => ["christmas"],
      ~r/tell me more/i => ["tell-me-more", "storytelling"],
      ~r/the dude/i => ["the-dudes"],
      ~r/the pullers/i => ["pullers", "pre-teen", "kids"],
      ~r/too far/i => ["too-far"],
      ~r/who dunnit/i => ["murder-mystery"],
      ~r/bright side/i => ["bright-side"],
    }
  end
end