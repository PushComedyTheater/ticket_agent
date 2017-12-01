defmodule TicketAgentWeb.TicketModalView do
  use TicketAgentWeb, :view
  alias TicketAgent.Listing
  import Ecto.Query

  def user_first_name(conn) do
    Coherence.current_user_name(conn)
    |> String.split(" ")
    |> hd
  end

  def user_last_name(conn) do
    Coherence.current_user_name(conn)
    |> String.split(" ")
    |> tl
  end

  def event_display_time(show) do
    "Sunday, November 5, 7:00PM"
    event_date(show) <> ", " <> event_time(show)
  end

  def ticket_link(conn, show) do
    available_ticket_count = Listing.available_ticket_count(show)

    link =
      if Enum.count(available_ticket_count) > 0 do
        link(
          "Buy Tickets",
          to: "#modal",
          data_modal_target: "#modal",
          data_modal_effect: "#slit",
          class: "btn u-btn-primary g-font-size-13 text-uppercase g-py-10 g-px-15"
        )
      else
        link(
          "Sold Out",
          to: "#",
          class: "btn u-btn-red g-font-size-13 text-uppercase g-py-10 g-px-15"
        )
      end
  end

  def event_cost(show) do
    Listing.ticket_cost(show)
  end

  def event_time(%Listing{start_at: nil} = show) do
    ""
  end

  def event_time(%Listing{start_at: start_at, end_at: nil} = show) do
    Calendar.Strftime.strftime!(start_at, "%I:%M %p")
  end

  def event_time(%Listing{start_at: start_at, end_at: end_at} = show) when not is_nil(start_at) and not is_nil(end_at) do
    start = Calendar.Strftime.strftime!(start_at, "%I:%M %p")
    finish = Calendar.Strftime.strftime!(end_at, "%I:%M %p")
    "#{start}-#{finish}"
  end

  def event_date(%Listing{start_at: nil} = show) do
    ""
  end

  def event_date(%Listing{start_at: start_at, end_at: nil} = show) when not is_nil(start_at) do
    Calendar.Strftime.strftime!(start_at, "%a, %b %e")
  end

  def event_date(%Listing{start_at: start_at, end_at: end_at} = show) when not is_nil(start_at) and not is_nil(end_at) do
    start_date = NaiveDateTime.to_date(show.start_at)
    end_date =  NaiveDateTime.to_date(show.end_at)

    case start_date == end_date do
      true ->
        Calendar.Strftime.strftime!(start_at, "%a, %b %e")
      false ->
        start = Calendar.Strftime.strftime!(start_at, "%a, %b %e")
        finish = Calendar.Strftime.strftime!(end_at, "%a, %b %e")
        "#{start}-#{finish}"
    end
  end
end
