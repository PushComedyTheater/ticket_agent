 mix do ecto.drop, ecto.create, ecto.migrate &&  mix run apps/ticket_agent/priv/repo/seeds.exs && mix do ecto.dump
 cd ../data_dump
 mix run lib/seeds.exs
 cd ../ticket_agent