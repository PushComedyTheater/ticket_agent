defmodule TicketAgent.Generators.OrderPdfGenerator do
  require Logger
  alias TicketAgent.Repo

  @host Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")

  def generate_pdf_binary(order) do
    order = Repo.preload(order, [:user, :credit_card, :tickets, :listing])

    ticket = Enum.at(order.tickets, 0)
    ticket_count = Enum.count(order.tickets)

    listing = Repo.preload(ticket.listing, :event)

    customer_order = EEx.eval_file(File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/tickets_pdf.html.eex",
                                       [tickets: order.tickets, listing: listing, ticket_count: ticket_count, host: @host])
    PdfGenerator.generate_binary!(customer_order, delete_temporary: true)
  end
end
