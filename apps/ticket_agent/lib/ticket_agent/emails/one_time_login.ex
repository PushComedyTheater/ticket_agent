defmodule TicketAgent.Emails.OneTimeLogin do
  import Swoosh.Email
  alias Swoosh.Email

  def one_time_login(user, listing_id) do
    html_layout_template = File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/layout.html.eex"
    text_layout_template = File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/layout.txt.eex"
    html_template = File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/one_time_login.html.eex"
    text_template = File.cwd! <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/one_time_login.txt.eex"

    url = "#{host()}/ticket_auth/#{user.one_time_token}?listing_id=#{listing_id}"

    html = EEx.eval_file(html_layout_template, [body: EEx.eval_file(html_template, [name: user.name, url: url])])
    text = EEx.eval_file(text_layout_template, [body: EEx.eval_file(text_template, [name: user.name, url: url])])

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
