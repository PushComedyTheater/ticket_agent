defmodule TicketAgent.UserEmail do
  import Swoosh.Email
  alias Swoosh.Email
  use Phoenix.Swoosh, view: TicketAgentWeb.Coherence.EmailView, layout: {TicketAgentWeb.Coherence.LayoutView, :email}

  def one_time_login(user, url) do
    %Email{}
    |> to({user.name, user.email})
    |> from({"Push Comedy Theater", "support@pushcomedytheater.com"})
    |> subject("Verify Your Email Address")
    |> render_body(
      "one_time_login.html",
      %{
        url: url,
        name: user.name,
        body_text: """
        Recently, this email address was used for a guest checkout on our site.
        We are sending this email to verify that it was you trying to do this.
        <br /><br />
        If this was you, please click the link below to continue.   You will be
        automatically logged into your account.
        <br /><br />If it was not you, ignore this email - nothing has changed.
        """
      }
    )
  end
end
