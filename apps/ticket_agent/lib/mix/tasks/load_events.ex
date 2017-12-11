defmodule Mix.Tasks.LoadEvents do
  alias TicketAgent.{Account, Event, EventTag, Listing, Mappings, Random, Repo, User}
  import Ecto.Query

  require Logger
  use Mix.Task

  def run(_) do
    Application.ensure_all_started(:ticket_agent)

    non_words = File.read!("./apps/ticket_agent/lib/mix/tasks/ignore.txt")
                |> String.split("\n")
    # parse_current(non_words)
    parse_history_files(non_words)
  end 

  def parse_current(now_words) do
    body = load_json("https://www.universe.com/api/v2/listings?limit=50&offset=0&order=desc&sort=created_at&states=posted&user_id=55fba3caaed6b30fa80859c0")  
    Enum.each(body["listings"], fn(listing) ->
      id = listing["id"]
      url = "https://www.universe.com/api/v2/listings/#{id}.json"
      item = load_json_no_decode(url)
      title = String.trim(listing["title"])
      base = "/Users/patrickveverka/Code/ticket_agent/apps/ticket_agent/lib/mix/tasks/data"
      uri = if title == "Workshop: Tales from the Campfire" do
        "#{base}/workshops/#{id}.json"
      else
        case Enum.find(Mappings.mappings, fn({reg, _}) -> String.match?(title, reg) end) do
          {h, class_id} ->
            IO.puts "class"
            "#{base}/newstuff/classes/#{id}.json"
          n ->
            IO.puts "show"
            "#{base}/newstuff/shows/#{id}.json"
        end
      end
      IO.inspect uri
      File.write!(uri, item) |> IO.inspect
    end)
  end

  def parse_history_files(non_words) do
    load_new_stuff(non_words)
    # load_classes(non_words)
    # load_shows(non_words)
    # load_workshops(non_words)
    # load_camps(non_words)
  end

  def load_new_stuff(non_words) do
    clean_directory(File.cwd! <> "/apps/ticket_agent/priv/repo/seeds/classes")
    base = "./apps/ticket_agent/lib/mix/tasks/data/newstuff/classes/"

    files = File.ls!(base)
    counter = Enum.count(files)
    preface = load_preface("classes")

    files
    |> Enum.chunk_every(10)
    |> Enum.with_index
    |> Enum.each(fn({chunk, index}) -> 
      Logger.info "Processing #{index+1} of class chunks"  
      {:ok, pid} = StringIO.open("")
      Enum.each(chunk, fn(file) ->
        process_file(base <> file, non_words, :class, pid)
      end)
      string = StringIO.flush(pid)
      File.write!("./apps/ticket_agent/priv/repo/seeds/classes/listings_#{index}.exs", preface <> string)    
      StringIO.close(pid)
    end)

    clean_directory(File.cwd! <> "/apps/ticket_agent/priv/repo/seeds/shows")
    base = "./apps/ticket_agent/lib/mix/tasks/data/newstuff/shows/"

    files = File.ls!(base)
    counter = Enum.count(files)
    preface = load_preface("shows")

    files
    |> Enum.chunk_every(20)
    |> Enum.with_index
    |> Enum.each(fn({chunk, index}) -> 
      Logger.info "Processing #{index+1} of show chunks"  
      {:ok, pid} = StringIO.open("")
      Enum.each(chunk, fn(file) ->
        process_file(base <> file, non_words, :show, pid)
      end)
      string = StringIO.flush(pid)
      File.write("./apps/ticket_agent/priv/repo/seeds/shows/listings_#{index}.exs", preface <> string)    
      StringIO.close(pid)
    end)   
    
    clean_directory(File.cwd! <> "/apps/ticket_agent/priv/repo/seeds/camps")    
    clean_directory(File.cwd! <> "/apps/ticket_agent/priv/repo/seeds/workshops")    
  end

  def load_classes(non_words) do
    clean_directory(File.cwd! <> "/apps/ticket_agent/priv/repo/seeds/classes")
    base = "./apps/ticket_agent/lib/mix/tasks/data/classes/"

    files = File.ls!(base)
    counter = Enum.count(files)
    preface = load_preface("classes")

    files
    |> Enum.chunk_every(10)
    |> Enum.with_index
    |> Enum.each(fn({chunk, index}) -> 
      Logger.info "Processing #{index+1} of class chunks"  
      {:ok, pid} = StringIO.open("")
      Enum.each(chunk, fn(file) ->
        process_file(base <> file, non_words, :class, pid)
      end)
      string = StringIO.flush(pid)
      File.write!("./apps/ticket_agent/priv/repo/seeds/classes/listings_#{index}.exs", preface <> string)    
      StringIO.close(pid)
    end)
  end

  def load_shows(non_words) do
    base = "./apps/ticket_agent/lib/mix/tasks/data/shows/"

    files = File.ls!(base)
    counter = Enum.count(files)
    preface = load_preface("shows")

    files
    |> Enum.chunk_every(20)
    |> Enum.with_index
    |> Enum.each(fn({chunk, index}) -> 
      Logger.info "Processing #{index+1} of show chunks"  
      {:ok, pid} = StringIO.open("")
      Enum.each(chunk, fn(file) ->
        process_file(base <> file, non_words, :show, pid)
      end)
      string = StringIO.flush(pid)
      File.write("./apps/ticket_agent/priv/repo/seeds/shows/listings_#{index}.exs", preface <> string)    
      StringIO.close(pid)
    end)  
  end

  def load_workshops(non_words) do
    {:ok, pid} = StringIO.open("")
    base = "./apps/ticket_agent/lib/mix/tasks/data/workshops/"

    files = File.ls!(base)
    counter = Enum.count(files)

    preface = load_preface("workshops")

    keywords = 
      files
      |> Enum.with_index()
      |> Enum.reduce([], fn({file, index}, acc) ->
        Logger.info "Processing #{index + 1} of #{counter} workshops"
        acc ++ process_file(base <> file, non_words, :workshop, pid)
      end)
      |> Enum.uniq
      |> Enum.sort
    
    string = StringIO.flush(pid)

    File.write("./apps/ticket_agent/priv/repo/seeds/workshops/listings_0.exs", preface <> string)    
  end

  def load_camps(non_words) do
    {:ok, pid} = StringIO.open("")
    base = "./apps/ticket_agent/lib/mix/tasks/data/camps/"

    files = File.ls!(base)
    counter = Enum.count(files)

    preface = load_preface("camps")

    keywords = 
      files
      |> Enum.with_index()
      |> Enum.reduce([], fn({file, index}, acc) ->
        Logger.info "Processing #{index + 1} of #{counter} camps"
        acc ++ process_file(base <> file, non_words, :workshop, pid)
      end)
      |> Enum.uniq
      |> Enum.sort
    
    string = StringIO.flush(pid)

    File.write("./apps/ticket_agent/priv/repo/seeds/camps/listings_0.exs", preface <> string)    
  end  

  def process_file(file, non_words, type, pid) do
    body = 
      file
      |> File.read!
      |> Poison.decode!()

    event = body["events"] |> hd
    listing = body["listing"]
    price = listing["price"]
    slug = listing["slug"]
    title = String.trim(listing["title"])
    class_id = load_class_id(title, type)
    
    description = listing["description"]
    tags = load_tags(price, title, description, type)
    keywords = get_keywords(description, non_words)

    cover_photo = process_images(body["images"], listing["event_photo_id"])

    item = EEx.eval_file(
      "./apps/ticket_agent/lib/mix/tasks/templates/event.eex",
      assigns: [
        slug: slug,
        title: title,
        class_id: class_id,
        type: type,
        description: listing["description_html"],
        start_time: event["start_time"],
        end_time: event["end_time"],
        cover_photo: cover_photo,
        price: price,
        created_at: listing["created_at"],
        tags: Enum.uniq(tags ++ keywords)
      ]
    )
    IO.write(pid, item)

    keywords
  end

  defp clean_directory(dir) do
    File.rm_rf!(dir)
    File.mkdir!(dir)
  end
  defp load_class_id(title, :class) do
    title = String.trim(title)
    title = if String.at(title, 0) == "​" do
      String.split(title, "​") |> tl |> hd
    else
      title
    end
    case Enum.find(Mappings.mappings, fn({reg, _}) -> String.match?(title, reg) end) do
      {_, class_id} ->
        "#{class_id}.id"
      _ ->
        raise title
        nil
    end
  end
  defp load_class_id(_, _), do: nil
  
  defp process_images(images, event_photo_id) do
    photo = Enum.find(images, fn(x) -> x["id"] == event_photo_id end)
    %{"url" => photo_url} = photo
    

    photo = (Regex.run(~r/(https:\/\/images.universe.com\/[a-z0-9\-]*)/, photo_url) |> hd) <> "/-/inline/yes/"
    public_id = String.split(photo, "/") |> Enum.at(3)
   
    process_image(photo, public_id)
    Cloudinex.Url.for(public_id)
  end

  def load_tags(_, _, _, :class), do: ["class"]
  def load_tags(price, title, description, type) do
    title = String.downcase(title)
    tags = [Atom.to_string(type)]
    if price == 0 do
      tags = tags ++ ["free"]
    else
      if price <= 5 do
        tags = tags ++ ["deal"]
      end
    end

    Enum.reduce(Mappings.regex_mappings, tags, fn({reg, val}, acc) ->
      if String.match?(title, reg) do
        acc = acc ++ val
      end
      acc
    end)
    |> Enum.uniq()
  end

  defp load_json(url) do
    url
    |> Tesla.get
    |> Map.fetch!(:body)
    |> Poison.decode!
  end

  defp load_json_no_decode(url) do
    url
    |> Tesla.get
    |> Map.fetch!(:body)
  end

  defp get_keywords(text, non_words) do
    Regex.scan(~r/(\w+)/, text)
    |> Enum.map(fn([_, word]) ->
      String.downcase(word)
    end)
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
    |> Enum.filter(fn({x,y}) -> 
      y > 2 && String.length(x) > 2 && String.valid?(x)
    end)  
    |> Enum.map(fn({x,_}) -> 
      x
    end)  
  end

  defp process_image(photo, public_id) do
    Logger.info "process_images -> Loading photo #{photo} with public id #{public_id}"

    case Cloudinex.resource(public_id) do
      {:ok, %{"secure_url" => c_photo}} ->
        Logger.info "process_images -> Photo #{c_photo} with public_id #{public_id} found"
        c_photo
      {:error, _} ->
        Logger.warn "process_images -> Photo with public_id #{public_id} not found, uploading"
        case Cloudinex.Uploader.upload_url(photo, %{public_id: public_id}) do
          {:ok, %{"secure_url" => uploaded_photo}} ->
            uploaded_photo
          {:error, reason} ->
            Logger.error "#{inspect reason}"
            photo
        end
    end
  end    

  defp blah do
    # {:ok, pid} = StringIO.open("")
    # [
    #   "./apps/ticket_agent/lib/mix/tasks/data/classes/",
    #   "./apps/ticket_agent/lib/mix/tasks/data/shows/",
    #   "./apps/ticket_agent/lib/mix/tasks/data/workshops/",
    #   "./apps/ticket_agent/lib/mix/tasks/data/camps/"
    # ]
    # |> Enum.reduce([], fn(base, acc) ->
    #   stuff = 
    #     base
    #     |> File.ls!()
    #     |> Enum.reduce([], fn(file, cnt) ->
    #       body = 
    #         base <> file
    #         |> File.read!
    #         |> Poison.decode!()

    #       listing = body["listing"]
    #       images = body["images"]
    #       event_photo_id = listing["event_photo_id"]
    #       photo = Enum.find(images, fn(x) -> x["id"] == event_photo_id end)
    #       %{"social_image" => social_photo, "url" => cover_photo} = photo            
    #       social_photo = (Regex.run(~r/(https:\/\/images.universe.com\/[a-z0-9\-]*)/, social_photo) |> hd) <> "/-/inline/yes/"
    #       social_public_id = String.split(social_photo, "/") |> Enum.at(3)
    #       cover_photo = (Regex.run(~r/(https:\/\/images.universe.com\/[a-z0-9\-]*)/, cover_photo) |> hd) <> "/-/inline/yes/"
    #       cover_public_id = String.split(cover_photo, "/") |> Enum.at(3)

    #       result = []
    #       if Enum.member?(missing, social_public_id) do
    #         result = result ++ [social_photo] 
    #       end
    #       if Enum.member?(missing, cover_public_id) do
    #         result = result ++ [cover_photo]  
    #       end          

    #       cnt = cnt ++ result
    #     end)
    #   acc = acc ++ stuff
    # end)
    # |> Enum.uniq
    # |> Enum.each(fn(url) ->
    #   IO.inspect url
    #   photo = (Regex.run(~r/(https:\/\/images.universe.com\/[a-z0-9\-]*)/, url) |> hd) <> "/-/inline/yes/"
    #   public_id = String.split(photo, "/") |> Enum.at(3)
    #   case Cloudinex.resource(public_id) do
    #     {:ok, _} ->
    #       Logger.info "public_id #{public_id} is cool"
    #       :ok
    #     {:error, _} ->
    #       # Logger.warn "public_id #{public_id} is not cool"
    #       case Cloudinex.Uploader.upload_url(photo, %{public_id: public_id}) do
    #       {:ok, _} ->
    #         Logger.info "uploaded"
    #       {:error, reason} ->
    #         Logger.error "#{inspect reason}"
    #     end
    #   end
    # end)
    # string = StringIO.flush(pid)
    # IO.inspect string
    # File.write!("./apps/ticket_agent/priv/repo/missing.txt", string)    
    # |> IO.inspect
    
  end

  defp load_preface(type) do
    preface = """
require Logger
alias TicketAgent.Random

Code.require_file("seed_helpers.exs", "./apps/ticket_agent/priv/repo/seeds")

account = SeedHelpers.create_account("Push Comedy Theater")
user = SeedHelpers.create_user("patrick@pushcomedytheater.com", account)
"""
if type == "classes" do
  preface = preface <> """
Logger.info "Loading classes"
improv101 = SeedHelpers.create_class(%{slug: "improv101"})
improv201 = SeedHelpers.create_class(%{slug: "improv201"})
improv301 = SeedHelpers.create_class(%{slug: "improv301"})
improv401 = SeedHelpers.create_class(%{slug: "improv401"})
improv501 = SeedHelpers.create_class(%{slug: "improv501"})
improv_studio = SeedHelpers.create_class(%{slug: "improv_studio"})
kidprov101 = SeedHelpers.create_class(%{slug: "kidprov101"})
kidprov201 = SeedHelpers.create_class(%{slug: "kidprov201"})
music_improv101 = SeedHelpers.create_class(%{slug: "music_improv101"})
music_improv201 = SeedHelpers.create_class(%{slug: "music_improv201"})
music_improv_studio = SeedHelpers.create_class(%{slug: "music_improv_studio"})
teen_improv = SeedHelpers.create_class(%{slug: "teen_improv"})
sketch101 = SeedHelpers.create_class(%{slug: "sketch101"})
sketch201 = SeedHelpers.create_class(%{slug: "sketch201"})
standup101 = SeedHelpers.create_class(%{slug: "standup101"})
acting101 = SeedHelpers.create_class(%{slug: "acting101"})
"""
  end
  preface = preface <> """
Logger.info "Seeding #{type}"
  """      
  preface
  end
end
