defmodule TicketAgentWeb.Admin.EmailTemplateController do
  use TicketAgentWeb, :controller
  require Logger
  alias TicketAgent.{Order, Repo}

  @host         Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")
  @template_dir Application.app_dir(:ticket_agent, "priv/email_templates")

  def show(conn, %{"type" => "order_receipt", "id" => order_id}) do
    order =
      Order
      |> Repo.get_by([slug: order_id])
      |> Repo.preload([:user, :credit_card, :tickets, :listing])

    %{name: name, email: email} = order.user

    ticket = Enum.at(order.tickets, 0)
    ticket_count = Enum.count(order.tickets)

    listing = Repo.preload(ticket.listing, [:event])

    customer_order_html_template = @template_dir <> "/customer_order.html.eex"

    link = "#{@host}/concierge/single_checkin/#{ticket.id}"
    url = "https://chart.googleapis.com/chart?cht=qr&chl=#{link}/&chs=300x300"

    html = ~s"""
<!DOCTYPE html>
<html lang='en' class=''>

<head>
  <meta charset='UTF-8'>
  <meta name="robots" content="noindex">
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css'>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" integrity="sha256-NuCn4IvuZXdBaFKJOAcsU2Q3ZpwbdFisd5dux4jkQ5w=" crossorigin="anonymous" />
  <style>
    *,
    *::after {
      box-sizing: border-box;
      margin: 0;
    }

    body {
      display: flex;
      align-items: center;
      min-height: 100vh;
      color: #454f54;
      background-color: #f4f5f6;
      background-image: linear-gradient(to bottom left, #abb5ba, #d5dadd);
    }

    .ticket {
      margin: 0 auto;
      display: grid;
      grid-template-rows: auto 1fr auto;
      max-width: 795px;
      width: 795px;
      align-content: center;
      align-items: center;
      page-break-after: always;
    }

    .ticket__header,
    .ticket__body,
    .ticket__footer {
      padding: 2.25rem;
      background-color: white;
      border: 1px solid #abb5ba;
      box-shadow: 0 2px 4px rgba(41, 54, 61, 0.25);
    }

    .ticket__header {
      font-size: 15px;
      border-top: 0.35rem solid #72c02c;
      padding-left: 500px;
      border-bottom: none;
      box-shadow: none;
      background-image: url(https://cdn.rawgit.com/PushComedyTheater/assets/master/images/header_logo_wide.jpg);
      background-repeat: no-repeat;
      min-height: 100px;
      align: right;
      text-align: right;
      width: 100%;
    }

    .ticket__wrapper {
      box-shadow: 0 2px 4px rgba(41, 54, 61, 0.25);
      border-radius: 0.375em 0.375em 0 0;
      overflow: hidden;
    }

    .ticket__divider {
      position: relative;
      height: 1rem;
      background-color: white;
      margin-left: 0.5rem;
      margin-right: 0.5rem;
    }

    .ticket__divider::after {
      content: '';
      position: absolute;
      height: 50%;

      top: 0;
      border-bottom: 2px dashed #e9ebed;
    }

    .ticket__notch {
      position: absolute;
      left: -0.5rem;
      width: 1rem;
      height: 1rem;
      overflow: hidden;
    }

    .ticket__notch::after {
      content: '';
      position: relative;
      display: block;
      width: 2rem;
      height: 2rem;
      right: 100%;
      top: -50%;
      border: 0.5rem solid white;
      border-radius: 50%;
      box-shadow: inset 0 2px 4px rgba(41, 54, 61, 0.25);
    }

    .ticket__notch--right {
      left: auto;
      right: -0.5rem;
    }

    .ticket__notch--right::after {
      right: 0;
    }

    .ticket__body {
      border-bottom: none;
      border-top: none;
    }

    .ticket__body>*+* {
      margin-top: 1.5rem;
      padding-top: 1.5rem;
      border-top: 1px solid #e9ebed;
    }

    .ticket__section>*+* {
      margin-top: 0.25rem;
    }

    .ticket__section>h3 {
      font-size: 1.125rem;
      margin-bottom: 0.5rem;
    }

    .ticket__header,
    .ticket__footer {
      display: flex;
      justify-content: space-between;
    }

    .ticket__footer {
      border-top: 2px dashed #e9ebed;
      border-radius: 0 0 0.325rem 0.325rem;
    }
  </style>
</head>

<body>
  <article class="ticket">
    <header class="ticket__wrapper">
      <div class="ticket__header">
        763 Granby Street, Norfolk, VA 23510<br />
        757.333.7442<br />
        http://pushcomedytheater.com
      </div>
    </header>
    <div class="ticket__divider">
      <div class="ticket__notch"></div>
      <div class="ticket__notch ticket__notch--right"></div>
    </div>
    <div class="ticket__body">
      <section class="ticket__section">
        <div align="center">
          <img src="#{listing_image(listing)}"/>
          <br />
          <h3>Here Are Your Tickets For #{listing.title}</h3>
        </div>
        <br />
        <p><i class="fa fa-calendar" aria-hidden="true"></i> Showtime: #{event_date(listing.start_at)} at #{event_time(listing.start_at)}</p>
        <p><i class="fa fa-user" aria-hidden="true"></i> Guest Name: <strong>#{ticket.guest_name}</strong></p>
      </section>
    </div>
    <footer class="ticket__footer">
      <div align="center" style="width: 100%">
        <img src="https://chart.googleapis.com/chart?cht=qr&chl=https://veverka.ngrok.io/concierge/single_checkin/09b2530c-b7fd-46ac-9cdf-f7c56130a8f7/&chs=300x300">
        <br />
        #{ticket.slug}
      </div>
    </footer>
  </article>
</body>
</html>


    """






    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  def event_date(nil), do: ""
  def event_date(date) do
    date
    |> Calendar.DateTime.shift_zone!("America/New_York")
    |> Calendar.Strftime.strftime!("%m/%d/%Y")
  end

  def event_time(nil), do: ""
  def event_time(date) do
    date
    |> Calendar.DateTime.shift_zone!("America/New_York")
    |> Calendar.Strftime.strftime!("%l:%M%p")
  end

  def listing_image(show, width \\ 1050) do
    image = show.event.image_url

    public_id =
      image
      |> String.split("/")
      |> List.last()
      |> String.split(".")
      |> List.first()

    Logger.info "Listing image public id = #{public_id}"

    Cloudinex.Url.for(public_id, %{
      width: 700,
      height: 280,
      crop: "fill",
      flags: 'progressive'
    })
  end
end
