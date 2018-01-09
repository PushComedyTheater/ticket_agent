defmodule TicketAgent.Emails.OrderEmail do
  import Swoosh.Email
  alias Swoosh.Email
  alias TicketAgent.{Listing, Order, Repo}

  def order_receipt_email(order_id) do
    order =
      Order
      |> Repo.get(order_id)
      |> Repo.preload([:user, :credit_card, :tickets, :listing])

    %{name: name, email: email} = order.user
    
    ticket = Enum.at(order.tickets, 0)
    ticket_count = Enum.count(order.tickets)

    listing = Repo.preload(ticket.listing, [:images])
    pdf_task = Task.async(fn -> generate_pdf(order.tickets, listing, order.slug) end)
    ical_task = Task.async(fn -> generate_ical(listing) end)

    customer_order_html_template = File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/customer_order.html.eex"
    customer_order_text_template = File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/customer_order.txt.eex"

    customer_order_html = EEx.eval_file(customer_order_html_template, [listing: listing, ticket_count: ticket_count, order: order, host: host()])
    customer_order_text = EEx.eval_file(customer_order_text_template, [listing: listing, ticket_count: ticket_count, order: order, host: host()])

    html_layout_template = File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/layout.html.eex"
    text_layout_template = File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/layout.txt.eex"

    html = EEx.eval_file(html_layout_template, [body: customer_order_html])
    text = EEx.eval_file(text_layout_template, [body: customer_order_text])
    
    pdf_filename = Task.await(pdf_task)
    ical_file_name = Task.await(ical_task)

    %Email{}
    |> to({name, email})
    |> from({"Push Comedy Theater", "support@pushcomedytheater.com"})
    |> subject("Here are your tickets for #{listing.title}")
    |> text_body(text)
    |> html_body(html)
    |> attachment(pdf_filename)
    |> attachment(ical_file_name)
  end

  defp generate_pdf(tickets, listing, order_slug) do
    order_template = File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/tickets_pdf.html.eex"
    
    {:ok, filename} = 
      order_template
      |> EEx.eval_file(
        [
          tickets: tickets, 
          listing: listing, 
          ticket_count: Enum.count(tickets), 
          host: host()
        ]
      )
      |> PdfGenerator.generate(filename: order_slug, page_size: "A5", shell_params: [ "-O", "landscape"])

    filename
  end

  defp generate_ical(listing) do
    ical_file_name = Path.join(System.tmp_dir, "#{listing.slug}-#{Listing.slugified_title(listing.title)}.ics")
    ics = Listing.to_ical(listing)
    File.write!(ical_file_name, ics)
    ical_file_name    
  end

  def host do
    Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")
  end
end