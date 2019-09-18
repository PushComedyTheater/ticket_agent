defmodule TicketAgent.ExpectJson do
  def expect_json(bypass, fun) do
    Bypass.expect(bypass, fn conn ->
      conn =
        Plug.Conn.put_resp_header(
          conn,
          "content-type",
          "application/json"
        )

      fun.(conn)
    end)
  end
end
