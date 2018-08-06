defmodule TicketAgent.Emails.OneTimeLogin do
  import Swoosh.Email
  alias Swoosh.Email
  alias TicketAgent.Listing

  def one_time_login(user, listing_id) do
    upcoming_html_template =
      File.cwd!() <>
        "/apps/ticket_agent/lib/ticket_agent/emails/templates/upcoming_shows.html.eex"

    upcoming_text_template =
      File.cwd!() <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/upcoming_shows.txt.eex"

    shows = Enum.take(Listing.upcoming_shows(), 3)
    upcoming_shows_html = EEx.eval_file(upcoming_html_template, shows: shows, host: host())
    upcoming_shows_text = EEx.eval_file(upcoming_text_template, shows: shows, host: host())

    html_layout_template =
      File.cwd!() <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/layout.html.eex"

    text_layout_template =
      File.cwd!() <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/layout.txt.eex"

    html_template =
      File.cwd!() <>
        "/apps/ticket_agent/lib/ticket_agent/emails/templates/one_time_login.html.eex"

    text_template =
      File.cwd!() <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/one_time_login.txt.eex"

    url = "#{host()}/ticket_auth/#{user.one_time_token}?listing_id=#{listing_id}"

    html =
      EEx.eval_file(
        html_layout_template,
        body:
          EEx.eval_file(
            html_template,
            name: user.name,
            url: url,
            upcoming_shows_html: upcoming_shows_html
          )
      )

    text =
      EEx.eval_file(
        text_layout_template,
        body:
          EEx.eval_file(
            text_template,
            name: user.name,
            url: url,
            upcoming_shows_text: upcoming_shows_text
          )
      )

    %Email{}
    |> to({user.name, user.email})
    |> from({"Push Comedy Theater", "support@pushcomedytheater.com"})
    |> subject("Verify Your Email Address")
    |> html_body(html)
    |> text_body(text)
  end

  def host do
    Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")
  end
end
