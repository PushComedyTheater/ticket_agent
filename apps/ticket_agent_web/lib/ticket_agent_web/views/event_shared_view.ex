defmodule TicketAgentWeb.Event.SharedView do
  use TicketAgentWeb, :view

  def event_buy_timestamp(nil), do: ""
  def event_buy_timestamp(date) do
    date
    |> Calendar.DateTime.shift_zone!("America/New_York")
    |> Calendar.Strftime.strftime!("%m/%d/%Y at %l:%M%p")    
  end
end
