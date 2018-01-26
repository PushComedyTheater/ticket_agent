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

    tickets = 
      tickets
      |> Enum.group_by(fn({_, ticket}) -> 
        ticket["group"] 
      end, 
      fn({_, item}) -> 
        item 
      end)

    if slug == listing_id do
      conn
      |> assign(:listing_id, slug)
      |> assign(:tickets, tickets)
    else
      conn
      |> delete_resp_cookie("ticket_data")
      |> put_flash(:error, "Something went wrong with your request.")
      |> redirect(to: "/events/#{slug}")
    end
  end

  def call(%Plug.Conn{params: %{"listing_id" => listing_id}} = conn, _) do
      conn
      |> delete_resp_cookie("ticket_data")
      |> put_flash(:error, "Something went wrong with your request.")
      |> redirect(to: "/events")
  end

  def call(conn, _) do
    conn
    |> delete_resp_cookie("ticket_data")
    |> put_flash(:error, "Something went wrong with your request.")
    |> redirect(to: "/")
  end
end
