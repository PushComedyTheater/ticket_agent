defmodule Mix.Tasks.LoadGuests do
  alias TicketAgent.Mappings
  require Logger
  use Mix.Task

  def run(_) do
    Application.ensure_all_started(:ticket_agent)
    process_guests()
  end

  def process_guests do
    offset = 0
    Enum.each(1..15, fn(offset) ->
      offset = offset * 1000
      url = "https://www.universe.com/api/v2/guestlists?limit=1000&offset=#{offset}"
      Logger.info "Grabbing #{url}"

      body =
        "/guestlists?limit=10&offset=#{offset}"
        |> Universe.get()
        |> Map.fetch!(:body)
        
      uri = "/Users/patrickveverka/Code/ticket_agent/apps/ticket_agent/lib/mix/tasks/data/guest_lists/#{offset}.json"
      Logger.info "Writing #{url} to #{uri}"
      File.write!(uri, Poison.encode!(body))

      # raise "FUCK"
    end)
  end

  # defp load_json(url) do
  #   url
  #   |> Tesla.get
  #   |> Map.fetch!(:body)
  #   |> Poison.decode!
  # end


  # defp load_json_no_decode(url) do
  #   url
  #   |> Tesla.get
  #   |> Map.fetch!(:body)
  # end  
end


defmodule Universe do
  @api_endpoint_default "https://www.universe.com/api/v2"

  use Tesla

  plug Tesla.Middleware.BaseUrl, @api_endpoint_default
  plug Tesla.Middleware.Headers, %{"Authorization" => "Bearer 66357af744d1b404ea667eed280c676406c494bd57f9e8778bab52a78f1da47e"}
  plug Tesla.Middleware.JSON
end