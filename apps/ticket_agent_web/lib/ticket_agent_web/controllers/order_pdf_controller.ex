defmodule TicketAgentWeb.OrderPdfController do
  require Logger
  use TicketAgentWeb, :controller
  alias TicketAgent.{Order, Repo}
  alias TicketAgent.Finders.OrderFinder

  @host Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")

  def show(conn, params) do
    value = load_order
    html conn, value
  end

  defp onetime do


    one_time_login_html = EEx.eval_file(File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/one_time_login.html.eex",
                                       [name: "dog", url: "apple"])

    html = EEx.eval_file(File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/layout.html.eex",
                        [body: one_time_login_html])

    html

  end

  defp load_order do
    order =
      Repo.get(Order, "32321158-81f2-4704-b3c5-98dffd6e627c")
      |> Repo.preload([:user, :credit_card, :tickets, :listing])

    ticket = Enum.at(order.tickets, 0)

    ticket_count = Enum.count(order.tickets)
    ticket_word = cond do
       ticket_count == 1 ->
         "1 ticket"
       ticket_count > 1 ->
         "#{ticket_count} tickets"
      end

    listing = ticket.listing |> Repo.preload([:images])



    # TicketAgent.UserEmail.order_email(Coherence.current_user(conn), order)
    # |> TicketAgent.Mailer.deliver!

message = """
<img src="#{listing_image_with_dimensions(listing, 590, 200)}" style="border-radius: 5px;" />
<br />
<h1 style="text-align: center;">NICE JOB!</h1>
<br />
<p>Not sure how you did it, but you scored #{ticket_word} to <em>#{ticket.listing.title}</em>!</p>
<p>We'll see you on #{event_date(listing.start_at)} and we'll try to start the show around #{event_time(listing.start_at)}.</p>
<table class="spacer"><tbody><tr><td height="16px" style="font-size:16px;line-height:16px;">&#xA0;</td></tr></tbody></table>
<h4>Order Details</h4>
<table class="callout">
  <tr>
    <th class="callout-inner secondary">
      <table class="row">
        <tbody>
          <tr>
            <th class="small-12 large-6 columns first">
              <table>
                <tr>
                  <th>
                    <p>
                    <strong>Payment Method</strong><br>
                    #{order.credit_card.type} ending in #{order.credit_card.last_4}
                    </p>
                    <p>
                    <strong>Order ID</strong><br>
                    <a href="#{@host}/orders/#{order.slug}">#{order.slug}</a>
                    </p>
                  </th>
                </tr>
              </table>
            </th>
            <th class="small-12 large-6 columns last">
              <table>
                <tr>
                  <th>
                    <p>
                    <strong>Email Address</strong><br>
                    #{order.user.email}
                    </p>
                  </th>
                </tr>
              </table>
            </th>
          </tr>
        </tbody>
      </table>
    </th>
    <th class="expander"></th>
  </tr>
</table>

<br />

<table style="width: 100%; padding: 5px;">
<tr style="border-bottom: 1px solid #000; margin-bottom: 10px;"><th style="margin-bottom: 5px;">Item</th><th>Price</th></tr>
"""
message = message <> Enum.map_join(order.tickets, "", fn(ticket) ->
  "<tr><td>#{ticket.description}</td><td>$#{:erlang.float_to_binary(ticket.price / 100,decimals: 2)}</td></tr>"
end)
message = message <> """
<tr>
<td colspan="2">&nbsp;<br /></td>
</tr>
<tr>
<td><b>Subtotal:</b></td>
<td>$#{:erlang.float_to_binary(order.subtotal / 100,decimals: 2)}</td>
</tr>
<tr>
<td><b>Processing Fee:</b></td>
<td>$#{:erlang.float_to_binary((order.total_price - order.subtotal) / 100,decimals: 2)}</td>
</tr>
<tr>
<td><b>Total:</b></td>
<td>$#{:erlang.float_to_binary(order.total_price / 100,decimals: 2)}</td>
</tr>
</table>

<hr>
<br />
<br />
<h4>Here are your tickets</h4>
<table style="width: 100%; border: 1px solid #000;">
"""

message = message <> Enum.map_join(order.tickets, "", fn(ticket) ->
  link = "#{@host}/concierge/checkin/#{ticket.id}"
  url = "https://chart.googleapis.com/chart?cht=qr&chl=#{link}/&chs=400x400"
  """
  <tr style="border-bottom: 1px solid #000; margin-bottom: 10px;">
    <th style="margin-bottom: 5px; padding: 9px; background-color: #f7f7f7;" align="center">#{ticket.guest_name}</th>
  </tr>
  <tr>
    <td align="center">
      <center>
        <img src="#{url}" />
        #{ticket.slug}
      </center>
    </td>
  </tr>
  """
end)

message = message <> """
</table>
"""

    value = EEx.eval_file(File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/layout.html.eex",
                         [body: message])

  end

  def event_date(date) do
    date
    |> Calendar.DateTime.shift_zone!("America/New_York")
    |> Calendar.Strftime.strftime!("%b %d, %Y")
  end

  def event_time(date) do
    date
    |> Calendar.DateTime.shift_zone!("America/New_York")
    |> Calendar.Strftime.strftime!("%l:%M %P")
  end

  def listing_image_with_dimensions(show, width, height) do
    IO.inspect show.images
    image =
      show.images
      |> hd

    public_id =
      image.url
      |> String.split("/")
      |> List.last()
      |> String.split(".")
      |> List.first()

    Cloudinex.Url.for(public_id, %{
      width: width,
      height: height,
      gravity: "north",
      crop: "fill",
      flags: 'progressive'
    })
  end
end
