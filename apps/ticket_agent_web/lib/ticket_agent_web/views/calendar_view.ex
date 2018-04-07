defmodule TicketAgentWeb.CalendarView do
  use TicketAgentWeb, :view

  def render("show.json", %{}) do
    [%{
      id: "abc",
      title: "title",
      allDay: false,
      start: "2018-04-04T18:00:00.00000Z",
      end: "2018-04-04T19:00:00.00000Z",
      url: "http://google.com"
    }]
  end
end
