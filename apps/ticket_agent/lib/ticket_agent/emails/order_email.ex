defmodule TicketAgent.Emails.OrderEmail do
  import Swoosh.Email
  alias Swoosh.Email
  alias TicketAgent.Generators.OrderPdfGenerator
  alias TicketAgent.{Listing, Order, Repo}

  @host         Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")
  @root_dir     File.cwd!
  @template_dir Path.join(~w(#{@root_dir} lib ticket_agent emails templates))

  def order_receipt_email(order_id) do
    order =
      Order
      |> Repo.get(order_id)
      |> Repo.preload([:user, :credit_card, :tickets, :listing])

    %{name: name, email: email} = order.user
    
    ticket = Enum.at(order.tickets, 0)
    ticket_count = Enum.count(order.tickets)

    listing = Repo.preload(ticket.listing, [:event])

    pdf_task = Task.async(fn -> OrderPdfGenerator.generate_order_pdf_file(order) end)

    ical_file_name = generate_ical(listing)
    
    {html, text} = load_content(listing, ticket_count, order)

    pdf_filename = Task.await(pdf_task, 20000)

    %Email{}
    |> to({name, email})
    |> from({"Push Comedy Theater", "support@pushcomedytheater.com"})
    |> subject("Here are your tickets for #{listing.title}")
    |> text_body(text)
    |> html_body(html)
    |> attachment(pdf_filename)
    |> attachment(ical_file_name)
  end

  def admin_order_receipt_email(order_id) do
    order =
      Order
      |> Repo.get(order_id)
      |> Repo.preload([:user, :credit_card, :tickets, :listing])

    ticket = order.tickets |> hd

    listing = Repo.preload(ticket.listing, [:event])

    html = load_admin_content(listing, order)

    %Email{}
    |> to({"Push Team", "web@pushcomedytheater.com"})
    |> from({"Push Comedy Theater", "support@pushcomedytheater.com"})
    |> subject("Order for #{admin_ticket_subject(order.tickets)} for #{listing.title}")
    |> html_body(html)
  end  

  defp admin_ticket_subject(tickets) when length(tickets) > 1, do: "#{Enum.count(tickets)} tickets"
  defp admin_ticket_subject(tickets), do: "1 ticket"

  defp load_admin_content(listing, order) do
    admin_order_html_template = @template_dir <> "/admin_order.html.eex"
    html_layout_template = @template_dir <> "/layout.html.eex"

    admin_html = 
      admin_order_html_template
      |> EEx.eval_file([
        listing: listing, 
        order: order, 
        host: @host
      ])    

    EEx.eval_file(html_layout_template, [body: admin_html])
  end

  defp load_content(listing, ticket_count, order) do
    customer_order_html_template = @template_dir <> "/customer_order.html.eex"
    customer_order_text_template = @template_dir <> "/customer_order.txt.eex"
    
    html_layout_template = @template_dir <> "/layout.html.eex"
    text_layout_template = @template_dir <> "/layout.txt.eex"

    customer_order_html = 
      customer_order_html_template
      |> EEx.eval_file([
        listing: listing, 
        ticket_count: 
        ticket_count, 
        order: order, 
        host: @host
      ])
    
    customer_order_text = 
      customer_order_text_template
      |> EEx.eval_file([
        listing: listing, 
        ticket_count: ticket_count, 
        order: order, 
        host: @host
      ])

    {
      EEx.eval_file(html_layout_template, [body: customer_order_html]),
      EEx.eval_file(text_layout_template, [body: customer_order_text])
    }
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