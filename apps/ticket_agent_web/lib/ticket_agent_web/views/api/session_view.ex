defmodule TicketAgentWeb.Api.SessionView do
  use TicketAgentWeb, :view

  def render("index.json", %{logged_in: logged_in, user: nil}) do
    %{
      logged_in: logged_in,
      email: "",
      name: ""
    }
  end

  def render("index.json", %{logged_in: logged_in, user: user}) do
    %{
      logged_in: logged_in,
      email: user.email,
      name: user.name
    }
  end

  def render("user.json", %{user: nil}) do
    %{
      email: nil
    }
  end

  def render("user.json", %{user: user}) do
    %{
      email: user.email
    }
  end
end
