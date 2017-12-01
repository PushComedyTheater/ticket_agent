require Logger
Code.load_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")
Code.load_file("classes.exs", "./apps/ticket_agent/priv/repo/seeds")
Code.load_file("teachers.exs", "./apps/ticket_agent/priv/repo/seeds")

[
  "./apps/ticket_agent/priv/repo/seeds/camps/",
  "./apps/ticket_agent/priv/repo/seeds/classes/",
  "./apps/ticket_agent/priv/repo/seeds/shows/",
  "./apps/ticket_agent/priv/repo/seeds/workshops/",
]
|> Enum.each(fn(base) ->
  File.ls!(base)
  |> Enum.each(fn(file) ->
    Code.load_file(file, base)
  end)
end)