defmodule TicketAgentWeb.OrderPdfController do
  require Logger
  use TicketAgentWeb, :controller
  alias TicketAgent.{Order, Repo, User}
  alias TicketAgent.Finders.OrderFinder
  alias TicketAgent.Generators.OrderPdfGenerator

  @host Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")

  def show(conn, %{"order_id" => order_id}) do
    current_user = Coherence.current_user(conn)
    case OrderFinder.find_order(order_id, current_user.id) do
      nil ->
        Logger.info "NO ORDER FOUND"
        conn
        |> put_status(404)
        |> render(TicketAgentWeb.ErrorView, "404.html")
      order ->
        value = TicketAgent.Generators.OrderPdfGenerator.generate_pdf_binary(order)

        conn
        |> put_resp_content_type("application/pdf")
        |> put_resp_header("content-disposition", "attachment; filename=\"#{order.slug}.pdf\"")
        |> send_resp(200, value)
    end
  end
end
