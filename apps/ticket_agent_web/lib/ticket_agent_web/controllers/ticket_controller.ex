defmodule TicketAgentWeb.TicketController do
  use TicketAgentWeb, :controller
  alias TicketAgent.Finders.TicketFinder
  alias TicketAgent.{UserStorage, Repo}
  plug(TicketAgentWeb.Plugs.TicketAuthCheck when action in [:new])
  plug(TicketAgentWeb.Plugs.TicketInfoLoader when action in [:new])

  def new(conn, %{"listing_id" => listing_id}) do
    message = """
      Please choose how many tickets you would like to purchase for this show.
      <br />
      <br />
      Supplies are limited and we restrict the number of tickets per purchase.
    """

    tickets = load_tickets(conn.assigns.listing.id)

    conn
    |> assign(:message, message)
    |> assign(:available_tickets, tickets)
    |> render("new.html")
  end

  def create(conn, %{"data" => data} = params) do
    user = Coherence.current_user(conn)

    result =
      case Repo.get_by(UserStorage, user_id: user.id) do
        nil ->
          %UserStorage{user_id: user.id}

        storage ->
          storage
      end
      |> UserStorage.changeset(%{details: data})
      |> Repo.insert_or_update()

    case result do
      {:ok, struct} ->
        conn
        |> json(%{
          status: "ok",
          unique_id: struct.id |> Base.encode64()
        })

      # Something went wrong
      {:error, changeset} ->
        conn
        |> put_status(500)
        |> json("error")
    end
  end

  def load_tickets(listing_id) do
    TicketFinder.all_available_tickets_by_listing_id(listing_id)
    |> Enum.chunk_by(fn ticket ->
      ticket.group
    end)
  end
end
