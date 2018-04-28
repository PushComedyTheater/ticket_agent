defmodule TicketAgentWeb.Plug.Timing do
  @behaviour Plug

  import Plug.Conn

  def init(opts \\ []), do: opts

  def call(conn, opts) do
    start = System.monotonic_time()
    register_before_send(conn, fn conn ->
      stop = System.monotonic_time()
      diff = System.convert_time_unit(stop - start, :native, :micro_seconds) / 1000
      conn
      |> put_resp_header("server-timing", ~s|plug, db;dur=53, plug;desc="#{conn.private[:phoenix_endpoint]}";dur=#{diff}|)
      |> put_resp_header("server-timing", ~s(database;desc="Cache Read";dur=23.2))
    end)
  end
end
