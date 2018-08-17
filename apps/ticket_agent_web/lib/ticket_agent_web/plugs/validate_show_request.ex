defmodule TicketAgentWeb.Plugs.ValidateShowRequest do
  require Logger
  import Plug.Conn
  import Phoenix.Controller
  alias TicketAgent.{UserStorage}
  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"listing_id" => listing_id, "uid" => uid}} = conn, _) do
    Logger.info("Handling uid")

    storage =
      uid
      |> Base.decode64!()
      |> UserStorage.get_user_storage!()

    listing = storage.details["listing"]
    slug = listing["slug"]

    if slug == listing_id do
      Logger.info("slug and listing id match")

      tickets =
        storage.details["tickets"]
        |> Enum.group_by(
          fn {_, ticket} ->
            ticket["group"]
          end,
          fn {_, item} ->
            item
          end
        )

      conn
      |> assign(:listing_id, slug)
      |> assign(:tickets, tickets)
    else
      Logger.error("The storage does not match the params")

      conn
      |> put_flash(:error, "Something went wrong with your request.")
      |> redirect(to: "/events/#{slug}")
    end
  end

  def call(%Plug.Conn{params: %{"listing_id" => listing_id}} = conn, _) do
    Logger.info("ValidateShowRequest - ine 46")

    conn
    |> delete_resp_cookie("ticket_data")
    |> halt
    |> put_flash(:error, "Something went wrong with your request.")
    |> redirect(to: "/events")
  end

  def call(conn, params) do
    IO.inspect(conn.params)
    Logger.info("Line 53")

    conn
    |> delete_resp_cookie("ticket_data")
    |> put_flash(:error, "Something went wrong with your request.")
    |> redirect(to: "/")
  end
end
