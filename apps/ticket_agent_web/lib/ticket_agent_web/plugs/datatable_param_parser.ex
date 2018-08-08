defmodule TicketAgentWeb.Plugs.DatatablesParamParser do
  require Logger
  import Plug.Conn

  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"_format" => "json"} = params} = conn, _) do
    conn
    |> calculate_page_size()
    |> calculate_page_number()
    |> increment_draw()
    |> set_search_term()
    |> set_order()
  end

  def call(conn, _), do: conn

  defp calculate_page_size(%Plug.Conn{params: %{"length" => value} = params} = conn)
       when not is_nil(value) do
    {page_size, _} = Integer.parse(value)

    conn
    |> assign(:page_size, page_size)
  end

  defp calculate_page_size(conn), do: assign(conn, :page_size, 10)

  defp increment_draw(%Plug.Conn{params: %{"draw" => value} = params} = conn)
       when not is_nil(value) do
    {draw_number, _} = Integer.parse(value)

    conn
    |> assign(:draw_number, draw_number + 1)
  end

  defp increment_draw(conn), do: assign(conn, :draw_number, 1)

  defp calculate_page_number(%Plug.Conn{params: %{"start" => value} = params} = conn)
       when not is_nil(value) do
    {start_value, _} = Integer.parse(value)
    value = round(start_value / conn.assigns.page_size + 1)

    conn
    |> assign(:page_number, value)
  end

  defp calculate_page_number(conn), do: assign(conn, :page_number, 1)

  defp set_search_term(%Plug.Conn{params: %{"search" => %{"value" => value}} = params} = conn)
       when not is_nil(value) do
    conn
    |> assign(:search_term, value)
  end

  defp set_search_term(conn), do: assign(conn, :search_term, nil)

  defp set_order(
         %Plug.Conn{
           params:
             %{"columns" => columns, "order" => %{"0" => %{"column" => column, "dir" => dir}}} =
               params
         } = conn
       ) do
    column_data = get_in(columns, [column, "data"])

    conn
    |> assign(:sort_column, column_data)
    |> assign(:sort_dir, dir)
  end

  defp set_order(conn) do
    conn
    |> assign(:sort_column, "id")
    |> assign(:sort_dir, "asc")
  end
end
