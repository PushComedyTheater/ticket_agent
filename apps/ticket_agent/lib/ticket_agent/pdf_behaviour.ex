defmodule TicketAgent.PdfBehaviour do
  @doc """
  Generates a pdf file from given html string. Returns a string containing a
  temporary file path for that PDF.
  """
  @callback generate_file(html :: term, options :: term) :: {:ok, result :: term} | {:error, reason :: term}

  @doc """
  Same as generate_file but returns PDF file name only (raises on error).
  """  
  @callback generate_file!(html :: term, options :: term) :: any

  @doc """
  Takes same options as `generate` but will return an
  `{:ok, binary_pdf_content}` tuple.

  In case option _delete_temporary_ is true, will as well delete the temporary
  pdf file.
  """
  @callback generate_binary(html :: term, options :: term) :: {:ok, result :: term} | {:error, reason :: term}
  
  @doc """
  Same as generate_binary but returns PDF content directly or raises on
  error.
  """
  @callback generate_binary!(html :: term, options :: term) :: any
end