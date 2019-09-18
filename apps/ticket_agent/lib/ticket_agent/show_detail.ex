defmodule TicketAgent.ShowDetail do
  defstruct [
    :event_slug,
    :event_title,
    :event_description,
    :event_image_url,
    :event_id,
    :listing_count,
    :start_at,
    :listing_ids
  ]

  defimpl Phoenix.Param, for: TicketAgent.ShowDetail do
    def to_param(%{event_slug: slug, event_title: title}) do
      "#{slug}-#{TicketAgent.ShowDetail.slugified_title(title)}"
    end
  end

  def slugified_title(title) do
    title
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9\s-]/, "")
    |> String.replace(~r/(\s|-)+/, "-")
  end
end
