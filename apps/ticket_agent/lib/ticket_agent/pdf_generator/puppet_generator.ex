defmodule TicketAgent.PdfGenerator.PuppetGenerator do
  @behaviour TicketAgent.PdfBehaviour

  def generate_file(html, options \\ [print_background: true]) do
    {:ok, html} = File.read("/Users/patrickveverka/Downloads/8a748b3d7d10a3fb387c.html")
    pdf_path = "/Users/patrickveverka/Downloads/blah.pdf"
    case PuppeteerPdf.generate_with_html(html, pdf_path, options) do
      {:ok, a} ->
        IO.inspect a
      {:error, message} ->
        IO.inspect message
    end
    # PdfGenerator.generate(html, options)
  end
  # def generate_file!(html, options \\ []), do: PdfGenerator.generate!(html, options)
  # def generate_binary(html, options \\ []), do: PdfGenerator.generate_binary(html, options)
  # def generate_binary!(html, options \\ []), do: PdfGenerator.generate_binary!(html, options)

end
