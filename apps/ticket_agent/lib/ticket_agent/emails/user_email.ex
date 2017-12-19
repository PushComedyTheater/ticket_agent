defmodule TicketAgent.UserEmail do
  import Swoosh.Email
  alias Swoosh.Email
  alias TicketAgent.Listing

  def one_time_login(user, url) do
    host = Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")

    one_time_login_html = EEx.eval_file(File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/one_time_login.html.eex",
                                       [name: user.name, url: url])

    html = EEx.eval_file(File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/layout.html.eex",
                        [body: one_time_login_html])

    %Email{}
    |> to({user.name, user.email})
    |> from({"Push Comedy Theater", "support@pushcomedytheater.com"})
    |> subject("Verify Your Email Address")
    |> html_body(html)
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
end
