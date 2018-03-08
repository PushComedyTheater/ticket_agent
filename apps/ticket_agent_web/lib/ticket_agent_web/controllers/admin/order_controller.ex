defmodule TicketAgentWeb.Admin.OrderController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Repo, Order}
  plug TicketAgentWeb.Plugs.Admin.MenuLoader, %{root: "orders"}

  def index(conn, params) do
    orders = Order.list_orders(params)

    conn
    |> assign(:orders, orders)
    |> render("index.html")
  end

  def new(conn, _params) do
    changeset = Order.changeset(%Order{}, %{})

    conn
    |> assign(:changeset, changeset)
    |> render("new.html")
  end

  def create(conn, %{"teacher" => teacher_params}) do
    changeset = Order.changeset(%Order{}, teacher_params)

    case Repo.insert(changeset) do
      {:ok, teacher} ->
        conn
        |> put_flash(:info, "Order created successfully.")
        |> redirect(to: admin_teacher_path(conn, :show, teacher))
      {:error, changeset} ->
        conn
        |> assign(:changeset, changeset)
        |> render("new.html")
    end
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

  def delete(conn, %{"id" => id}) do
    teacher = Repo.get!(Order, id)

    Repo.delete!(teacher)

    conn
    |> put_flash(:info, "Order deleted successfully.")
    |> redirect(to: admin_teacher_path(conn, :index))
  end
end
