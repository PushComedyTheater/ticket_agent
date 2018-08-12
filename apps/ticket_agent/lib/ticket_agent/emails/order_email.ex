defmodule TicketAgent.Emails.OrderEmail do
  require Logger
  import Swoosh.Email
  alias Swoosh.Email
  alias TicketAgent.Generators.OrderPdfGenerator
  alias TicketAgent.{Listing, Order, Repo}

  @host Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")
  @template_dir Application.app_dir(:ticket_agent, "priv/email_templates")

  def order_receipt_email(order_id) do
    Logger.info("order_receipt_email #{order_id}")

    order =
      order_id
      |> Order.get_order!()
      |> Repo.preload([:user, :credit_card, :tickets, listing: [:event]])

    %{name: name, email: email} = order.user

    ticket_count = Enum.count(order.tickets)

    pdf_task = Task.async(fn -> OrderPdfGenerator.generate_order_pdf_file(order) end)

    ical_file_name = generate_ical(order)

    {html, text} = generate_content(order)

    pdf_filename = Task.await(pdf_task, 20000)

    %Email{}
    |> to({name, email})
    |> from({"Push Comedy Theater", "support@pushcomedytheater.com"})
    |> subject("Here are your tickets for #{order.listing.title}")
    |> text_body(text)
    |> html_body(html)
    |> attachment(pdf_filename)
    |> attachment(ical_file_name)
    |> put_provider_option(:custom_vars, %{
      metadata: %{order_id: order_id, order_slug: order.slug}
    })
  end

  def order_cancellation_email(order_id) do
    Logger.info("order_cancellation_email #{order_id}")

    order =
      order_id
      |> Order.get_order!()
      |> Repo.preload([:user, :credit_card, :tickets, listing: [:event]])

    %{name: name, email: email} = order.user

    {html, text} = generate_cancellation_content(order)

    %Email{}
    |> to({name, email})
    |> from({"Push Comedy Theater", "support@pushcomedytheater.com"})
    |> subject("Your order has been cancelled")
    |> text_body(text)
    |> html_body(html)
  end

  def admin_order_receipt_email(order_id) do
    order =
      Order
      |> Repo.get(order_id)
      |> Repo.preload([:user, :credit_card, :tickets, :listing])

    ticket = order.tickets |> hd

    listing = Repo.preload(ticket.listing, [:event])

    html = load_admin_content(order)

    %Email{}
    |> to({"Push Team", "web@pushcomedytheater.com"})
    |> from({"Push Comedy Theater", "support@pushcomedytheater.com"})
    |> subject("Order for #{admin_ticket_subject(order.tickets)} for #{listing.title}")
    |> html_body(html)
  end

  defp admin_ticket_subject(tickets) when length(tickets) > 1,
    do: "#{Enum.count(tickets)} tickets"

  defp admin_ticket_subject(tickets), do: "1 ticket"

  def load_admin_content(
        %Order{listing: %Listing{id: _} = listing, user: _, credit_card: _} = order
      ) do
    admin_order_html_template = @template_dir <> "/admin_order.html.eex"
    html_layout_template = @template_dir <> "/layout.html.eex"

    admin_html =
      admin_order_html_template
      |> EEx.eval_file(
        listing: listing,
        order: order,
        host: @host
      )

    EEx.eval_file(html_layout_template, body: admin_html)
  end

  def load_admin_content(_), do: raise("Missing details")

  def generate_cancellation_content(
        %Order{tickets: tickets, listing: %Listing{id: _} = listing} = order
      )
      when is_list(tickets) do
    html_template = @template_dir <> "/customer_cancel_order.html.eex"
    text_template = @template_dir <> "/customer_order.txt.eex"

    html_layout = @template_dir <> "/layout.html.eex"
    text_layout = @template_dir <> "/layout.txt.eex"

    ticket_count = Enum.count(tickets)

    customer_order_html =
      html_template
      |> EEx.eval_file(
        listing: listing,
        ticket_count: ticket_count,
        order: order,
        host: @host
      )

    customer_order_text =
      text_template
      |> EEx.eval_file(
        listing: listing,
        ticket_count: ticket_count,
        order: order,
        host: @host
      )

    {
      EEx.eval_file(html_layout, body: customer_order_html),
      EEx.eval_file(text_layout, body: customer_order_text)
    }
  end

  def generate_content(%Order{tickets: tickets, listing: %Listing{id: _} = listing} = order)
      when is_list(tickets) do
    html_template = @template_dir <> "/customer_order.html.eex"
    text_template = @template_dir <> "/customer_order.txt.eex"

    html_layout = @template_dir <> "/layout.html.eex"
    text_layout = @template_dir <> "/layout.txt.eex"

    ticket_count = Enum.count(tickets)

    customer_order_html =
      html_template
      |> EEx.eval_file(
        listing: listing,
        ticket_count: ticket_count,
        order: order,
        host: @host
      )

    customer_order_text =
      text_template
      |> EEx.eval_file(
        listing: listing,
        ticket_count: ticket_count,
        order: order,
        host: @host
      )

    {
      EEx.eval_file(html_layout, body: customer_order_html),
      EEx.eval_file(text_layout, body: customer_order_text)
    }
  end

  def generate_content(_), do: raise("Missing listing")

  def generate_ical(%Order{listing: %Listing{slug: slug, title: title} = listing} = _) do
    ical_file_name = Path.join(System.tmp_dir(), "#{slug}-#{Listing.slugified_title(title)}.ics")
    ics = Listing.to_ical(listing)
    File.write!(ical_file_name, ics)
    ical_file_name
  end

  def generate_ical(_), do: raise("Missing listing")

  def host do
    Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")
  end
end
