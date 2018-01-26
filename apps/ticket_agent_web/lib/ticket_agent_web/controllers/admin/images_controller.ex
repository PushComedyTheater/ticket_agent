defmodule TicketAgentWeb.Admin.ImageController do
  use TicketAgentWeb, :controller
  plug :put_layout, {TicketAgentWeb.Admin.ImageView, :index}

  def index(conn, params) do
    previous_cursor = Map.get(params, "nc", nil)
    tag = Map.get(params, "tag", "")
    {cursor, resources} = load_resources(tag, previous_cursor)
    render(
      conn,
      :index,
      resources: resources,
      next_cursor: cursor,
      previous_cursor: previous_cursor,
      tag: tag
    )
  end

  defp load_resources(tag, cursor) do
    {:ok, %{"next_cursor" => cursor, "resources" => resources}} = Cloudinex.resources_by_tag(tag, [next_cursor: cursor, tags: true])
    # cursor = "dsfafsdf"
    # resources = [
    #   %{
    #     "secure_url" => "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/wd4vnbdjwchrclmuhomg",
    #     "public_id" => "covers/wd4vnbdjwchrclmuhomg"
    #   },
    #   %{
    #     "secure_url" => "https://res.cloudinary.com/push-comedy-theater/image/upload/social/dxcfi6mfoag1mst2k0pr.jpg",
    #     "public_id" => "social/dxcfi6mfoag1mst2k0pr"
    #   }
    # ]

    {cursor, resources}
  end
end
