defmodule TicketAgent.UserEmail do
  import Swoosh.Email
  alias Swoosh.Email
  alias TicketAgent.{Listing, Order, Repo}

  def one_time_login(user, url) do
    host = Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")

    one_time_login_html = EEx.eval_file(File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/one_time_login.html.eex",
                                       [name: user.name, url: url])

    one_time_login_html = one_time_login_html <> """
    <img src="cid:image.png">
    """

    html = EEx.eval_file(File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/layout.html.eex",
                        [body: one_time_login_html])

    attachment = Swoosh.Attachment.new("/Users/patrickveverka/Downloads/logo.png", filename: "logo.png", content_type: "image/png", type: :inline)

    %Email{}
    |> to({user.name, user.email})
    |> from({"Push Comedy Theater", "support@pushcomedytheater.com"})
    |> subject("Verify Your Email Address")
    |> html_body(html)
    |> attachment(attachment)
    |> IO.inspect
  end

  def welcome_email(name, email) do
    host = Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")

    upcoming_shows_html = EEx.eval_file(File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/upcoming_shows.html.eex",
                                       [shows: Enum.take(Listing.upcoming_shows, 3), host: host])

    message = """
    <h2 align="center">Welcome Aboard, #{name}!</h2>
    <div style="background-color: #f7f7f7 !important; padding: 18px; border-radius: 15px;">
      Thanks so much for joining us at PushComedyTheater.com.  We hope you enjoy
      our shows and classes and look forward to seeing you at the Push!
    </div>
    <br><br>
    #{upcoming_shows_html}
    <br><br>
    """
    html = EEx.eval_file(File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/layout.html.eex",
                        [body: message])
    %Email{}
    |> to({name, email})
    |> from({"Push Comedy Theater", "support@pushcomedytheater.com"})
    |> subject("Welcome to Push Comedy Theater!")
    |> text_body("Thanks so much for joining us at PushComedyTheater.com.  We hope you enjoy our shows and classes and look forward to seeing you at the Push!.")
    |> html_body(html)
  end

  def order_email(user, order_id) do
    order =
      Repo.get(Order, order_id)
      |> Repo.preload([:user, :credit_card, :tickets, :listing])

      ticket = Enum.at(order.tickets, 0)

      ticket_count = Enum.count(order.tickets)

      listing = ticket.listing |> Repo.preload([:images])

      TicketAgent.OrderHelpers.generate_ical(listing)

      attachment = Swoosh.Attachment.new("/Users/patrickveverka/Downloads/logo.png", filename: "logo.png", content_type: "image/png", type: :inline)
      customer_order = EEx.eval_file(File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/customer_order.html.eex",
                                         [listing: listing, ticket_count: ticket_count, order: order, host: host])
      html = EEx.eval_file(File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/layout.html.eex",
                         [body: customer_order])
      %Email{}
      |> to({user.name, user.email})
      |> from({"Push Comedy Theater", "support@pushcomedytheater.com"})
      |> subject("Here are your tickets")
      |> text_body("")
      |> html_body(html)
  end

  def order_ticket_pdf(user, order) do
    order = Repo.preload(order, [:user, :credit_card, :tickets, :listing])

    ticket = Enum.at(order.tickets, 0)
    ticket_count = Enum.count(order.tickets)

    listing = ticket.listing |> Repo.preload([:images])

    customer_order = EEx.eval_file(File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/tickets_pdf.html.eex",
                                       [tickets: order.tickets, listing: listing, ticket_count: ticket_count, host: host])

   html = customer_order
   # # be aware, this may take a while...
   { :ok, filename }    = PdfGenerator.generate html, page_size: "A5", shell_params: [ "-O", "landscape"]
   filename

   # PdfGenerator.generate_binary!(html, delete_temporary: true)

   %Email{}
   |> to({user.name, user.email})
   |> from({"Push Comedy Theater", "support@pushcomedytheater.com"})
   |> subject("Here are your tickets")
   |> text_body("")
   |> html_body("dude")
   |> attachment(filename)
  end

  def host do
    Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")
  end
end
