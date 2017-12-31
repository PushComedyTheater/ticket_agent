defmodule TicketAgentWeb.ListingChannel do
  require Logger
  use TicketAgentWeb, :channel
  alias TicketAgent.{Repo, User}
  alias TicketAgent.Finders.TicketFinder

  def join("listing:" <> listing_id, payload, socket) do

    if authorized?(payload, socket) do
      {:ok, load_tickets(listing_id), socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def broadcast_change(listing_id, ticket) do
    payload = %{
      "checkedin" => (ticket.status == "checkedin"),
      "slug" => ticket.slug,
      "guest_name" => ticket.guest_name,
      "id" => ticket.id
    }

    TicketAgentWeb.Endpoint.broadcast("listing:#{listing_id}", "change", payload)
  end

  # Add authorization logic here as required.
  defp authorized?(%{"token" => token} = payload, socket) do
    case Coherence.verify_user_token(socket, token, &assign/3) do
      {:error, _} ->
        false
      {:ok, socket} ->
        user = Repo.get(User, socket.assigns.user_id)
        cond do
          is_nil(user) ->
            false
          Enum.member?(["admin", "concierge"], user.role) ->
            true
          true ->
            false
        end
    end
  end

  defp load_tickets(listing_id) do
    TicketFinder.all_tickets_for_checkin(listing_id)
    |> Enum.map(fn(ticket) ->
      %{
        "checkedin" => (ticket.status == "checkedin"),
        "slug" => ticket.slug,
        "guest_name" => ticket.guest_name,
        "id" => ticket.id
      }
    end)
  end
end
