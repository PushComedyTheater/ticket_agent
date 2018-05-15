defmodule TicketAgentWeb.Backend.TeacherView do
  use TicketAgentWeb, :view
  import Scrivener.HTML

  def social_links(nil) do
    ""
  end

  def social_links(social) when is_map(social) do
    Enum.map(social, fn({type, link}) ->
      "#{type} - #{link}"
    end)
  end
end
