defmodule TicketAgent.PdfGenerator.Generator do
  @behaviour TicketAgent.PdfBehaviour
  
  def generate_file(html, options \\ []), do: PdfGenerator.generate(html, options)
  def generate_file!(html, options \\ []), do: PdfGenerator.generate!(html, options)
  def generate_binary(html, options \\ []), do: PdfGenerator.generate_binary(html, options)
  def generate_binary!(html, options \\ []), do: PdfGenerator.generate_binary!(html, options)
  
end