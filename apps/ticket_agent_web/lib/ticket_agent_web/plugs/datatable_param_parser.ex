defmodule TicketAgentWeb.Plugs.DatatablesParamParser do
  require Logger
  import Plug.Conn
  import Ecto.Query
  alias TicketAgent.Repo

  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"_format" => "json"} = params} = conn, %{schema: schema}) do
    {page_size, page_number, draw_number, search_term} = build_paging_info(params)

    query = from(l in schema, select: struct(l, [:title, :status, :start_at, :end_at]))

    records = retrieve_records(page_size, page_number, search_term, schema)

    conn
    |> assign(:page_size, page_size)
    |> assign(:page_number, page_number)
    |> assign(:draw_number, draw_number)
    |> assign(:search_term, search_term)
    |> assign(:records, records)
  end

  def call(conn, _), do: conn

  def build_paging_info(params) do
    page_size = calculate_page_size(params["length"])
    page_number = calculate_page_number(params["start"], page_size)
    search_term = params["search"]["value"]
    draw_number = increment_draw(params["draw"])
    {page_size, page_number, draw_number, search_term}
  end

  defp increment_draw(value) when value == nil, do: 1

  defp increment_draw(value) do
    {draw_number, _} = Integer.parse(value)
    draw_number + 1
  end

  defp calculate_page_number(nil, _), do: 1

  defp calculate_page_number(value, page_size) do
    {start_value, _} = Integer.parse(value)
    round(start_value / page_size + 1)
  end

  defp calculate_page_size(nil), do: 25

  defp calculate_page_size(value) do
    {page_size, _} = Integer.parse(value)
    page_size
  end

  defp retrieve_records(page_size, page_number, search_term, schema) do
    query =
      from(
        l in schema,
        preload: [:tickets],
        select: struct(l, [:title, :status, :start_at, :end_at])
      )

    query = add_filter(query, search_term)
    Repo.paginate(query, page: page_number, page_size: page_size)
  end

  defp add_filter(query, search_term) when search_term == nil or search_term == "", do: query

  defp add_filter(query, original_search_term) do
    search_term = "%#{original_search_term}%"
    from(z in query, where: ilike(z.title, ^search_term))
  end
end
