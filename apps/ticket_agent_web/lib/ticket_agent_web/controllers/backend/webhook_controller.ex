defmodule TicketAgentWeb.Backend.WebHookController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Repo, WebhookDetail}
  plug TicketAgentWeb.Plugs.MenuLoader, %{root: "webhooks"}

  def index(conn, params) do
    details = Repo.paginate(WebhookDetail, params)

    conn
    |> assign(:details, details)
    |> render("index.html")
  end

  def show(conn, %{"id" => id}) do
    detail = Repo.get!(WebhookDetail, id)

    conn
    |> assign(:detail, detail)
    |> render("show.html")
  end
end
