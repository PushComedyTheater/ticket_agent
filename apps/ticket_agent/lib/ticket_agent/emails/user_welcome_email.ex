defmodule TicketAgent.Emails.UserWelcomeEmail do
  import Swoosh.Email
  alias Swoosh.Email
  alias TicketAgent.{Listing}

  def welcome_email(name, email) do
    upcoming_html_template =
      File.cwd!() <>
        "/apps/ticket_agent/lib/ticket_agent/emails/templates/upcoming_shows.html.eex"

    upcoming_text_template =
      File.cwd!() <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/upcoming_shows.txt.eex"

    shows = Enum.take(Listing.upcoming_shows(), 3)
    upcoming_shows_html = EEx.eval_file(upcoming_html_template, shows: shows, host: host())
    upcoming_shows_text = EEx.eval_file(upcoming_text_template, shows: shows, host: host())

    user_welcome_html_template =
      File.cwd!() <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/user_welcome.html.eex"

    user_welcome_text_template =
      File.cwd!() <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/user_welcome.txt.eex"

    user_welcome_html =
      EEx.eval_file(user_welcome_html_template,
        name: name,
        upcoming_shows_html: upcoming_shows_html
      )

    user_welcome_text =
      EEx.eval_file(user_welcome_text_template,
        name: name,
        upcoming_shows_text: upcoming_shows_text
      )

    html_layout_template =
      File.cwd!() <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/layout.html.eex"

    text_layout_template =
      File.cwd!() <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/layout.txt.eex"

    html = EEx.eval_file(html_layout_template, body: user_welcome_html)
    text = EEx.eval_file(text_layout_template, body: user_welcome_text)

    %Email{}
    |> to({name, email})
    |> from({"Push Comedy Theater", "support@pushcomedytheater.com"})
    |> subject("Welcome to Push Comedy Theater!")
    |> text_body(text)
    |> html_body(html)
  end

  def host do
    Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")
  end
end
