defmodule TicketAgentWeb.Plugs.ValidateShowRequest do
  require Logger
  import Plug.Conn
  import Phoenix.Controller
  def init(opts), do: opts

  def call(%Plug.Conn{cookies: %{"ticket_data" => data}, params: %{"listing_id" => listing_id}} = conn, _) do
    %{
      "listing" => %{
        "slug" => slug
      },
      "tickets" => tickets
    } =
      data
      |> Base.decode64!()
      |> Poison.decode!

    if slug == listing_id do
      conn
      |> assign(:show_id, slug)
      |> assign(:tickets, tickets)
    # else
    #   conn
    #   |> delete_resp_cookie("ticket_data")
    #   |> put_flash(:info, "Something went wrong with your request.")
    #   |> redirect(to: "/")
    end
  end

  def call(conn, _) do
    IO.inspect conn.cookies
    raise "FUCK"
    conn
    |> delete_resp_cookie("ticket_data")
    |> put_flash(:info, "Something went wrong with your request.")
    |> redirect(to: "/")
  end
end
