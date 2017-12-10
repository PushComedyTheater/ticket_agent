defmodule TicketAgentWeb.ChargeController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Order, Repo}
  alias TicketAgent.Finders.CardFinder
  import Ecto.Query

  def create(conn, params) do
    IO.inspect params

    conn
    |> render("create.json")    
  end

  # def create(conn, %{"order_id" => order_slug, "token" => token} = params) do
  #   order = Repo.get_by!(Order, slug: order_slug)
  #   conn
  #   |> render("create.json")
  # end
end
