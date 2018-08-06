Code.ensure_loaded(Phoenix.Swoosh)

defmodule TicketAgentWeb.Coherence.UserEmail do
  @moduledoc false
  use Phoenix.Swoosh,
    view: TicketAgentWeb.Coherence.EmailView,
    layout: {TicketAgentWeb.Coherence.LayoutView, :email}

  alias Swoosh.Email
  require Logger
  alias Coherence.Config
  alias TicketAgent.Listing
  import TicketAgentWeb.Gettext

  @host Application.get_env(:ticket_agent, :email_base_url, "https://pushcomedytheater.com")

  defp site_name, do: Config.site_name(inspect(Config.module()))

  def password(user, url) do
    upcoming_html_template =
      File.cwd!() <>
        "/apps/ticket_agent/lib/ticket_agent/emails/templates/upcoming_shows.html.eex"

    upcoming_text_template =
      File.cwd!() <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/upcoming_shows.txt.eex"

    shows = Enum.take(Listing.upcoming_shows(), 3)
    upcoming_shows_html = EEx.eval_file(upcoming_html_template, shows: shows, host: @host)
    upcoming_shows_text = EEx.eval_file(upcoming_text_template, shows: shows, host: @host)

    %Email{}
    |> from(from_email())
    |> to(user_email(user))
    |> add_reply_to()
    |> subject(
      dgettext("coherence", "%{site_name} - Reset password instructions", site_name: site_name())
    )
    |> render_body("password.html", %{
      url: url,
      name: first_name(user.name),
      upcoming_shows_html: upcoming_shows_html
    })
  end

  def confirmation(user, url) do
    upcoming_html_template =
      File.cwd!() <>
        "/apps/ticket_agent/lib/ticket_agent/emails/templates/upcoming_shows.html.eex"

    upcoming_text_template =
      File.cwd!() <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/upcoming_shows.txt.eex"

    shows = Enum.take(Listing.upcoming_shows(), 3)
    upcoming_shows_html = EEx.eval_file(upcoming_html_template, shows: shows, host: @host)
    upcoming_shows_text = EEx.eval_file(upcoming_text_template, shows: shows, host: @host)

    %Email{}
    |> from(from_email())
    |> to(user_email(user))
    |> add_reply_to()
    |> subject(
      dgettext("coherence", "%{site_name} - Confirm your new account", site_name: site_name())
    )
    |> render_body("confirmation.html", %{
      url: url,
      name: first_name(user.name),
      upcoming_shows_html: upcoming_shows_html
    })
  end

  def invitation(invitation, url) do
    upcoming_html_template =
      File.cwd!() <>
        "/apps/ticket_agent/lib/ticket_agent/emails/templates/upcoming_shows.html.eex"

    upcoming_text_template =
      File.cwd!() <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/upcoming_shows.txt.eex"

    shows = Enum.take(Listing.upcoming_shows(), 3)
    upcoming_shows_html = EEx.eval_file(upcoming_html_template, shows: shows, host: @host)
    upcoming_shows_text = EEx.eval_file(upcoming_text_template, shows: shows, host: @host)

    %Email{}
    |> from(from_email())
    |> to(user_email(invitation))
    |> add_reply_to()
    |> subject(
      dgettext(
        "coherence",
        "%{site_name} - Invitation to create a new account",
        site_name: site_name()
      )
    )
    |> render_body("invitation.html", %{
      url: url,
      name: first_name(invitation.name),
      upcoming_shows_html: upcoming_shows_html
    })
  end

  def unlock(user, url) do
    upcoming_html_template =
      File.cwd!() <>
        "/apps/ticket_agent/lib/ticket_agent/emails/templates/upcoming_shows.html.eex"

    upcoming_text_template =
      File.cwd!() <> "/apps/ticket_agent/lib/ticket_agent/emails/templates/upcoming_shows.txt.eex"

    shows = Enum.take(Listing.upcoming_shows(), 3)
    upcoming_shows_html = EEx.eval_file(upcoming_html_template, shows: shows, host: @host)
    upcoming_shows_text = EEx.eval_file(upcoming_text_template, shows: shows, host: @host)

    %Email{}
    |> from(from_email())
    |> to(user_email(user))
    |> add_reply_to()
    |> subject(
      dgettext("coherence", "%{site_name} - Unlock Instructions", site_name: site_name())
    )
    |> render_body("unlock.html", %{
      url: url,
      name: first_name(user.name),
      upcoming_shows_html: upcoming_shows_html
    })
  end

  defp add_reply_to(mail) do
    case Coherence.Config.email_reply_to() do
      nil -> mail
      true -> reply_to(mail, from_email())
      address -> reply_to(mail, address)
    end
  end

  defp first_name(name) do
    case String.split(name, " ") do
      [first_name | _] -> first_name
      _ -> name
    end
  end

  defp user_email(user) do
    {user.name, user.email}
  end

  defp from_email do
    case Coherence.Config.email_from() do
      nil ->
        Logger.error(
          ~s|Need to configure :coherence, :email_from_name, "Name", and :email_from_email, "me@example.com"|
        )

        nil

      {name, email} = email_tuple ->
        if is_nil(name) or is_nil(email) do
          Logger.error(
            ~s|Need to configure :coherence, :email_from_name, "Name", and :email_from_email, "me@example.com"|
          )

          nil
        else
          email_tuple
        end
    end
  end
end
