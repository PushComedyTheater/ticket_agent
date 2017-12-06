defmodule TicketAgentWeb.LayoutView do
  use TicketAgentWeb, :view

  def open_graph_description(text, true) do
    HtmlSanitizeEx.strip_tags(text) |> truncated_description()
  end

  def open_graph_description(text, false) do
    HtmlSanitizeEx.strip_tags(text)
  end

  def truncated_description(text, opts \\ []) do
    # text = HtmlSanitizeEx.strip_tags(text)
    max_length  = opts[:max_length] || 300
    omission    = opts[:omission] || "..."

    cond do
      not String.valid?(text) ->
        text
      String.length(text) < max_length ->
        text
      true ->
        length_with_omission = max_length - String.length(omission)

        "#{String.slice(text, 0, length_with_omission)}#{omission}"
    end
  end

  def page_title(conn) do
    title = og_data(conn, :page_title, "Push Comedy Theater")
  end

  def page_description(conn) do
    default = "The Push Comedy Theater is a 90 seat venue in the heart of Norfolk's brand new Arts District."
    og_data(conn, :page_description, default)
  end

  def page_image(conn) do
    og_data(conn, :page_image, "https://cdn.pushcomedytheater.com/images/logo.jpg")
  end

  def full_url(conn) do
    "https://#{conn.host}#{conn.request_path}"
  end

  def event_date(date) do
    #Sat, Dec 2, 2017
    Calendar.Strftime.strftime!(date, "%m/%d/%Y")
  end  

  def event_time(date) do
    Calendar.Strftime.strftime!(date, "%l:%M%p")
  end  
  
  def full_event_time(%{start_at: start_at, end_at: end_at}) when start_at != end_at do
    "#{event_time(start_at)} - #{event_time(end_at)}"
  end
  def full_event_time(%{start_at: start_at, end_at: end_at}) when start_at == end_at, do: event_time(start_at)
  def full_event_time(_), do: "Unknown"

  def event_cost(show) do
    Listing.ticket_cost(show)
  end

  defp og_data(conn, key, default) do
    case Map.get(conn.assigns, key) do
      nil -> default
      something -> something
    end
  end
end
