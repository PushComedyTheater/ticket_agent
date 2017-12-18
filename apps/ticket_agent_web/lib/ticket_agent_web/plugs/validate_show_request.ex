defmodule TicketAgentWeb.Plugs.ValidateShowRequest do
  require Logger
  import Plug.Conn
  import Phoenix.Controller
  alias TicketAgent.Listing
  def init(opts), do: opts

  def call(%Plug.Conn{cookies: %{"ticket_data" => data}, params: %{"show_id" => show_id}} = conn, _) do
    %{
      "listing" => %{
        "id" => listing_id,
        "slug" => slug
      },
      "tickets" => tickets
    } =
      data
      |> Base.decode64!()
      |> Poison.decode!

    if slug == show_id do
      conn
      |> assign(:show_id, slug)
      |> assign(:tickets, tickets)
    else
      conn
      |> delete_resp_cookie("ticket_data")
      |> put_flash(:info, "Something went wrong with your request.")
      |> redirect(to: "/")
    end
  end

  def call(conn, _) do
    conn
    |> delete_resp_cookie("ticket_data")
    |> put_flash(:info, "Something went wrong with your request.")
    |> redirect(to: "/")
  end
end
