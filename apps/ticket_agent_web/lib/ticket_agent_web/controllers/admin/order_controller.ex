defmodule TicketAgentWeb.Admin.OrderController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Repo, Order}
  import Ecto.Query
  alias TicketAgent.State.ChargeProcessingState

  plug(TicketAgentWeb.Plugs.MenuLoader, %{root: "orders"})
  plug(TicketAgentWeb.Plugs.DatatablesParamParser)

  def index(conn, %{"_format" => "json"} = params) do
    records = retrieve_records(conn)

    render(
      conn,
      "index.json",
      records: records,
      page_number: conn.assigns.page_number,
      draw_number: conn.assigns.draw_number
    )
  end

  defp retrieve_records(
         %Plug.Conn{
           assigns: %{
             page_size: page_size,
             page_number: page_number,
             search_term: search_term,
             sort_column: sort_column,
             sort_dir: sort_dir
           }
         } = conn
       ) do
    query =
      from(
        l in Order,
        preload: [:user, :credit_card, :listing, :tickets],
        select: l
      )

    Repo.paginate(query, page: page_number, page_size: page_size)
  end

  def index(conn, params) do
    conn
    |> render("index.html")
  end

  def show(conn, %{"id" => id}) do
    order = Order.get_by_slug!(id)

    conn
    |> assign(:order, order)
    |> render("show.html")
  end

  def edit(conn, %{"id" => id}) do
    order = Order.get_by_slug!(id)
    changeset = Order.changeset(order, %{})

    conn
    |> assign(:order, order)
    |> assign(:changeset, changeset)
    |> render("edit.html")
  end

  def update(conn, %{"id" => id, "teacher" => teacher_params}) do
    teacher = Repo.get!(Order, id)
    changeset = Order.changeset(teacher, teacher_params)

    case Repo.update(changeset) do
      {:ok, teacher} ->
        conn
        |> put_flash(:info, "Order updated successfully.")
        |> redirect(to: admin_teacher_path(conn, :show, teacher))

      {:error, changeset} ->
        conn
        |> assign(:teacher, teacher)
        |> assign(:changeset, changeset)
        |> render("edit.html")
    end
  end

  def delete(conn, %{"id" => slug}) do
    with order = Order.get_by_slug!(slug),
         "completed" <- order.status,
         :ok <- ChargeProcessingState.cancel_order_and_release_tickets(order) do
      IO.inspect("IN HERE")
    else
      err ->
        IO.inspect(err)
    end

    # Repo.delete!(teacher)

    conn
    |> json("ok")
  end
end
