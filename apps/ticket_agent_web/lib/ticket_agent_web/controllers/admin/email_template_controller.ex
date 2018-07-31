defmodule TicketAgentWeb.Admin.EmailTemplateController do
  use TicketAgentWeb, :controller
  require Logger
  alias TicketAgent.{Order, Repo, Ticket}

  @host         Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")
  @template_dir Application.app_dir(:ticket_agent, "priv/email_templates")

  def show(conn, %{"type" => "ticket_pdf", "id" => ticket_slug}) do
    ticket =
      Ticket
      |> Repo.get_by([slug: ticket_slug])
      |> Repo.preload([:order, :listing])

    html = ""
    order =
      ticket.order
      |> Repo.preload([:user, :credit_card, :tickets, :listing])

    %{name: name, email: email} = order.user

    ticket_count = Enum.count(order.tickets)

    listing = Repo.preload(ticket.listing, [:event])

    link = "#{@host}/concierge/single_checkin/#{ticket.id}"
    url = "https://chart.googleapis.com/chart?cht=qr&chl=#{link}/&chs=300x300"

    template = @template_dir <> "/tickets_pdf.html.eex"

    html = EEx.eval_file(template, [url: url, ticket: ticket, listing: listing, ticket_count: ticket_count, order: order, host: @host])


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
