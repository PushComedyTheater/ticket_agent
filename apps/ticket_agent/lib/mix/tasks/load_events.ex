defmodule Mix.Tasks.LoadEvents do
  alias TicketAgent.{Account, Listing, Repo, User}
  import Ecto.Query

  require Logger
  use Mix.Task

  def run(_) do
    Application.ensure_all_started(:ticket_agent)

    {:ok, pid} = StringIO.open("")

    classes =
      "./apps/ticket_agent/lib/mix/tasks/classes.json"
      |> File.read!
      |> Poison.decode!

    shows =
      "./apps/ticket_agent/lib/mix/tasks/shows.json"
      |> File.read!
      |> Poison.decode!

    url = "https://www.universe.com/users/push-comedy-theater-CT01HK/portfolio/current.json"
    body = load_json(url)

    string = """
    Logger.info "Getting account and user"
    account = TicketAgent.Repo.one(from x in TicketAgent.Account, order_by: [desc: x.id], limit: 1)
    user = TicketAgent.Repo.one(from x in TicketAgent.User, order_by: [desc: x.id], limit: 1)
    """

    IO.write(pid, string)
    Enum.each(body["data"]["portfolio"]["hosting"], &process_item(&1, classes, shows, pid))

    string = StringIO.flush(pid)
    existing = File.read!("./apps/ticket_agent/priv/repo/classes.exs")

    File.write("./apps/ticket_agent/priv/repo/seeds.exs", existing <> string)
  end

  def process_item(show, classes, shows, pid) do
    mappings = %{
      "Improv 101 with Brad McMurran" => "improv101",
      "Improv for Teens at the Push Comedy Theater" => "teen_improv",
      "Musical Improv 101" => "music_improv101",
      "KidProv 201 at the Push Comedy Theater" => "kidprov201",
      "Musical Improv Studio" => "music_improv_studio",
      "​Improv 201 at the Push Comedy Theater" => "improv201",
      "Sketch Comedy Writing 101" => "sketch101",
      "KidProv at the Push Comedy Theater" => "kidprov101",
      "Musical Improv 201" => "music_improv201"
    }

    url = "https://www.universe.com/api/v2/listings/#{show["id"]}.json"

    #IO.inspect "Parsing #{show["id"]} at #{url}"

    body = load_json(url)

    images = body["images"]
    event = body["events"] |> hd
    listing = body["listing"]
    price = listing["price"]

    social_photo = Enum.find(images, fn(x) -> x["id"] == listing["event_photo_id"] end)
                  |> Map.get("social_image")

    social_photo = (Regex.run(~r/(https:\/\/images.universe.com\/[a-z0-9\-]*)/, social_photo) |> hd) <> "/-/inline/yes/"

    public_id = String.split(social_photo, "/") |> Enum.at(3)

    social_photo = case Cloudinex.resource(public_id) do
      {:ok, %{"secure_url" => social_photo}} ->
        IO.inspect "ok"
        social_photo
      {:error, _} ->
        IO.inspect "GOTTA UPLOAD"
        {:ok, %{"secure_url" => social_photo, "public_id" => public_id}} = Cloudinex.Uploader.upload_url(social_photo, %{public_id: public_id})
        social_photo
    end

    cover_photo = Enum.find(images, fn(x) -> x["id"] == listing["event_photo_id"] end)
                  |> Map.get("url")

    cover_photo = (Regex.run(~r/(https:\/\/images.universe.com\/[a-z0-9\-]*)/, cover_photo) |> hd) <> "/-/inline/yes/"

    public_id = String.split(cover_photo, "/") |> Enum.at(3)

    cover_photo = case Cloudinex.resource(public_id) do
      {:ok, %{"secure_url" => cover_photo}} ->
        IO.inspect "ok"
        cover_photo
      {:error, _} ->
        IO.inspect "GOTTA UPLOAD"
        {:ok, %{"secure_url" => cover_photo, "public_id" => public_id}} = Cloudinex.Uploader.upload_url(cover_photo, %{public_id: public_id})
        cover_photo
    end

    is_class = Enum.any?(classes, fn(x) -> x["id"] == listing["id"] end)
    is_show = Enum.any?(shows, fn(x) -> x["id"] == listing["id"] end)

    listing_type = ""
    listing_type = if is_class do "class" else listing_type end
    listing_type = if is_show do "show" else listing_type end

    title = String.trim(listing["title"])

    class_id = if is_class do "#{mappings[title]}.id" else "nil" end

    string = """
    description = \"\"\"
    #{listing["description_html"]}
    \"\"\"
Logger.info "Writing Class #{title}"
listing = %TicketAgent.Listing{
    user_id: user.id,
    account_id: account.id,
    class_id: #{class_id},
    type: "#{listing_type}",
    title: "#{title}",
    slug: "#{listing["slug"]}",
    description: description,
    status: "active",
    start_time:  NaiveDateTime.from_iso8601!("#{event["start_time"]}"),
    end_time:  NaiveDateTime.from_iso8601!("#{event["end_time"]}")
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing cover photo for #{title}"
%TicketAgent.ListingImage{
  listing_id: listing.id,
  url: "#{cover_photo}",
  type: "cover"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing social photo for #{title}"
%TicketAgent.ListingImage{
  listing_id: listing.id,
  url: "#{social_photo}",
  type: "social"
}
|> TicketAgent.Repo.insert!

Logger.info "> Writing 88 tickets for #{title}"

Enum.each(1..88, fn(x) ->
  %TicketAgent.Ticket{
    listing_id: listing.id,
    name: "Ticket for #{title}",
    status: "available",
    description: "Ticket for #{title}",
    price: #{round(price) * 100},
    sale_start:  NaiveDateTime.from_iso8601!("#{listing["created_at"]}")
  }
  |> TicketAgent.Repo.insert!
end)
     """
IO.write(pid, string)

     if is_show do
       if listing["price"] == 0 do
         IO.write(pid, generate_tag("free", title))
       else
         if listing["price"] <= 5 do
           IO.write(pid, generate_tag("deal", title))
         end
       end
       if String.match?(title, ~r/\bworkshop\b/i) do
         IO.write(pid, generate_tag("workshop", title))
       end
       if String.match?(title, ~r/\bharold\b/i) do
         IO.write(pid, generate_tag("harold", title))
       end
       if String.match?(title, ~r/who dunnit/i) do
         IO.write(pid, generate_tag("murder-mystery", title))
       end
       if String.match?(title, ~r/date night/i) do
         IO.write(pid, generate_tag("date-night", title))
       end
       if String.match?(title, ~r/good talk/i) do
         IO.write(pid, generate_tag("good-talk", title))
       end
       if String.match?(title, ~r/girl-prov/i) do
         IO.write(pid, generate_tag("girl-prov", title))
       end
       if String.match?(title, ~r/\bteacher\b/i) do
         IO.write(pid, generate_tag("graduation-show", title))
       end
       if String.match?(title, ~r/\bstandup\b|\bstand-up\b/i) do
         IO.write(pid, generate_tag("standup", title))
       end
       if String.match?(title, ~r/\blip\b/i) do
         IO.write(pid, generate_tag("music", title))
         IO.write(pid, generate_tag("lip-sync", title))
       end
      #  IO.inspect listing["title"]
     end

  end

  defp generate_tag(tag, title) do
    """
Logger.info ">> Writing tag #{tag} for #{title}"
%TicketAgent.ListingTag{
  listing_id: listing.id,
  tag: "#{tag}"
}
|> TicketAgent.Repo.insert!

    """
  end
  defp load_json(url) do
    url
    |> Tesla.get
    |> Map.fetch!(:body)
    |> Poison.decode!
  end

  defp get_keywords(text) do
    non_words = ["theater", "comedy", "from", "will", "this", "that", "brad", "mary", "push"]
    description = HtmlSanitizeEx.strip_tags(text)

    description = Regex.replace(~r/\W/, description, " ")
                  |> String.replace("\n", " ")
                  |> String.replace(".", " ")
                  |> String.replace("_", "")
                  |> String.replace("   ", " ")
                  |> String.replace("  ", " ")

      String.split(description, " ")
      |> Enum.reduce(%{}, fn(word, acc) ->
        if String.length(word) > 0 && !Enum.member?(non_words, String.downcase(word)) do
          if Map.has_key?(acc, word) do
            {_, acc} = Map.get_and_update(acc, word, fn current_value -> {current_value, current_value + 1} end)
          else
            acc = Map.put(acc, word, 1)
          end
        end
        acc
      end)
      |> Enum.filter(fn({x,y}) -> y > 2 end)
  end
end
