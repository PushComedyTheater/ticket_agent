defmodule TicketAgentWeb.RootView do
  alias TicketAgent.Random
  use TicketAgentWeb, :view

  @months ~w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
  @images ~w(push_sign push_sign push_sign push_sign push_sign push_sign driving
             lion lion lion lion lion elf_wizard alba_brad alba_brad alba_brad
             alba_brad ed_bunny life_preservers brad_purple brad_purple brad_purple
             brad_purple brad_purple brad_purple)

  def header_image do
    "https://pushcomedytheater.com/pushassets/images/headers/#{Random.sample(@images)}.jpg"
  end

  def event_date(date) do
    """
    <time datetime="#{date.year}-#{date.month}-#{date.day}">
      <span class="d-block g-color-black g-font-weight-700 g-font-size-40 g-line-height-1">
        #{date.day}
      </span> #{Enum.at(@months, date.month)}, #{date.year}
    </time>
    """
  end
end
