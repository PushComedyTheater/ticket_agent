defmodule TicketAgentWeb.LoadOrder do
    alias TicketAgent.{Order, Repo}
  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"order_id" => order_id}} = conn, _) when not is_nil(order_id) do
    order = Repo.get_by!(Order, slug: order_id)

    conn
    |> Plug.Conn.assign(:order, order)
  end

  def call(conn, _), do: conn
end
