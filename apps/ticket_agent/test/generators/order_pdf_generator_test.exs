defmodule TicketAgent.Generators.OrderPdfGeneratorTest do
  import TicketAgent.Factory
  use TicketAgent.DataCase
  alias TicketAgent.Generators.OrderPdfGenerator
  alias TicketAgent.PdfGenerator.Mock
  import Mox

  setup do
    Code.compiler_options(ignore_module_conflict: true)
    event = insert(:event, image_url: "https://i.imgur.com/AV7itLr.jpg")
    listing = insert(:listing, event: event)
    order = insert(:order, status: "completed", completed_at: NaiveDateTime.utc_now())
    ticket = insert(:ticket, status: "purchased", order: order, listing: listing)
    {:ok, order: order, ticket: ticket}
  end

  describe "generate_order_pdf_binary" do
    test "works for orders that are processing and tickets that are processing", %{
      order: order,
      ticket: ticket
    } do
      expect(Mock, :generate_binary!, fn html, options ->
        assert Keyword.get(options, :delete_temporary) == true
        assert Keyword.get(options, :page_size) == "A5"
        assert Keyword.get(options, :shell_params) == ["-O", "landscape"]
        html
      end)

      response = OrderPdfGenerator.generate_order_pdf_binary(order)
    end
  end

  describe "generate_order_pdf_file" do
    test "it names the file", %{order: order} do
      expect(Mock, :generate_file!, fn _, options ->
        assert Keyword.get(options, :page_size) == "A5"
        assert Keyword.get(options, :shell_params) == ["-O", "landscape"]
        options[:filename]
      end)

      OrderPdfGenerator.generate_order_pdf_file(order)
    end
  end
end
