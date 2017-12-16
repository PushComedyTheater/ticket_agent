defmodule TicketAgent.UserEmail do
  import Swoosh.Email
  alias Swoosh.Email
  use Phoenix.Swoosh, view: TicketAgentWeb.Coherence.EmailView, layout: {TicketAgentWeb.Coherence.LayoutView, :email}

  def welcome(user, url) do
    new()
    |> to({user.name, user.email})
    |> from({"Dr B Banner", "hulk.smash@example.com"})
    |> subject("Hello, Avengers!")
    |> html_body("<h1>Hello #{user.name}<br /> <a href='#{url}'>click here</a></h1>")
    |> text_body("Hello #{user.name}\n")
  end

  def one_time_login(user, url) do
    %Email{}
    |> to({user.name, user.email})
    |> from({"Push Comedy Theater", "support@pushcomedytheater.com"})
    |> subject("Verify Your Email Address")
    |> render_body("one_time_login.html", %{url: url, name: user.name, body_text: "Recently, you attempted to use your email address for a guest checkout on our site.  We sent this email to verify that it was you trying to do this.<br /><br />If this was you, please click the link below to continue.<br /><br />If it was not you, ignore this email - nothing has changed."})
  end  
end

# 