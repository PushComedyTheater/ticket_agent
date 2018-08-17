defmodule TicketAgent.Generators.OrderPdfGenerator do
  require Logger
  alias TicketAgent.{Order, Repo}

  @root_dir File.cwd!()
  @template_dir Application.app_dir(:ticket_agent, "priv/email_templates")
  @host Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")
  @pdf_generator Application.get_env(:ticket_agent, :pdf_generator)
  @base_options [page_size: "A5", shell_params: ["-O", "landscape"]]

  def priv_directory, do: to_string(:code.priv_dir(:ticket_agent))

  def generate_order_pdf_binary(order) do
    order
    |> generate_order_html()
    |> generate_pdf_binary()
  end

  def generate_order_pdf_file(order) do
    order
    |> generate_order_html()
    |> generate_pdf_file(Keyword.merge(@base_options, filename: "#{order.slug}"))
  end

  defp generate_pdf_binary(html) do
    {:ok, pdf_path} = Briefly.create(extname: ".pdf")

    case PuppeteerPdf.generate_with_html(html, pdf_path, debug: true, print_background: true) do
      {:ok, _} ->
        content = pdf_path |> File.read!()
        pdf_path |> File.rm()
        content

      {:error, message} ->
        Logger.error(message)
        raise message
    end
  end

  defp generate_pdf_file(html, options) do
    filename = options[:filename] <> ".pdf"
    pdf_path = Path.join(System.tmp_dir(), filename)

    case PuppeteerPdf.generate_with_html(html, pdf_path, debug: true, print_background: true) do
      {:ok, _} ->
        pdf_path

      {:error, message} ->
        Logger.error(message)
        raise message
    end
  end

  defp generate_order_html(order) do
    Logger.info(Application.app_dir(:ticket_agent, "priv/email_templates"))
    ticket_pdf_template = Path.join([priv_directory, "email_templates", "tickets_pdf.html.eex"])
    Logger.info("ticket_pdf_template = #{ticket_pdf_template}")

    order =
      order
      |> Repo.preload([:user, :credit_card, :tickets, :listing])

    ticket_count = Enum.count(order.tickets)
    listing = order.listing

    EEx.eval_file(
      ticket_pdf_template,
      tickets: order.tickets,
      listing: order.listing,
      ticket_count: ticket_count,
      order: order,
      host: @host
    )
  end
end
