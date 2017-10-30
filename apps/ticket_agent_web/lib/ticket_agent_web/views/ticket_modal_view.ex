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

  def ticket_link(conn, show) do
    available_tickets = Listing.available_tickets(show)

    link =
      if Enum.count(available_tickets) > 0 do
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
    cost =
      show
      |> Listing.ticket_cost
      |> :erlang.float_to_binary([decimals: 2])

    "#{cost}"
  end

  def event_time(%Listing{start_time: nil} = show) do
    ""
  end

  def event_time(%Listing{start_time: start_time, end_time: nil} = show) do
    Calendar.Strftime.strftime!(start_time, "%I:%M %p")
  end

  def event_time(%Listing{start_time: start_time, end_time: end_time} = show) when not is_nil(start_time) and not is_nil(end_time) do
    start = Calendar.Strftime.strftime!(start_time, "%I:%M %p")
    finish = Calendar.Strftime.strftime!(end_time, "%I:%M %p")
    "#{start}-#{finish}"
  end

  def event_date(%Listing{start_time: nil} = show) do
    ""
  end

  def event_date(%Listing{start_time: start_time, end_time: nil} = show) when not is_nil(start_time) do
    Calendar.Strftime.strftime!(start_time, "%a, %b %e")
  end

  def event_date(%Listing{start_time: start_time, end_time: end_time} = show) when not is_nil(start_time) and not is_nil(end_time) do
    start_date = NaiveDateTime.to_date(show.start_time)
    end_date =  NaiveDateTime.to_date(show.end_time)

    case start_date == end_date do
      true ->
        Calendar.Strftime.strftime!(start_time, "%a, %b %e")
      false ->
        start = Calendar.Strftime.strftime!(start_time, "%a, %b %e")
        finish = Calendar.Strftime.strftime!(end_time, "%a, %b %e")
        "#{start}-#{finish}"
    end
  end
end
