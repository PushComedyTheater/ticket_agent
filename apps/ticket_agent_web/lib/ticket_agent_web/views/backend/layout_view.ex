defmodule TicketAgentWeb.Backend.LayoutView do
  alias TicketAgent.User
  use TicketAgentWeb, :view

  def user_initials(nil), do: "ZZ"
  def user_initials(%User{name: nil}), do: "ZZ"
  def user_initials(%User{} = user) do
    [first, last] =
      user.name
      |> String.split(" ")
      |> IO.inspect

    String.first(first) <> String.first(last)
  end
end
