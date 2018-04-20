defmodule TicketAgent.Generators.OrderPdfGenerator do
  require Logger
  alias TicketAgent.Repo

  @root_dir       File.cwd!
  @template_dir   Application.app_dir(:ticket_agent, "priv/email_templates")
  @host           Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")
  @pdf_generator  Application.get_env(:ticket_agent, :pdf_generator)
  @base_options   [page_size: "A5", shell_params: [ "-O", "landscape"]]

  def generate_order_pdf_binary(order) do
    order
    |> generate_order_html()
    |> generate_pdf_binary()
  end

  def generate_order_pdf_file(order) do
    order
    |> generate_order_html()
    |> generate_pdf_file(Keyword.merge(@base_options, [filename: "#{order.slug}"]))
  end

  defp generate_pdf_binary(html), do: @pdf_generator.generate_binary!(html, Keyword.merge(@base_options, [delete_temporary: true]))
  defp generate_pdf_file(html, options), do: @pdf_generator.generate_file!(html, options)

  defp generate_order_html(order) do
    Logger.info "template_dir = #{@template_dir}"

    ticket_pdf_template = @template_dir <> "/tickets_pdf.html.eex"

    order =
      order
      |> Repo.preload([:user, :credit_card, :tickets, :listing])

    ticket = Enum.at(order.tickets, 0)
    ticket_count = Enum.count(order.tickets)

    listing = Repo.preload(ticket.listing, :event)

    EEx.eval_file(
      ticket_pdf_template,
      [
        tickets: order.tickets,
        listing: listing,
        ticket_count: ticket_count,
        host: @host
      ]
    )
  end
end
