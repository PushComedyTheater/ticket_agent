defmodule TicketAgentWeb.WaitlistController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Repo, Waitlist}

  def create(conn, %{"email" => email_address, "class_id" => class_id, "name" => name} = params) do
    user_id = case Coherence.current_user(conn) do
      nil -> nil
      user -> user.id
    end

    changeset =
      %Waitlist{}
      |> Waitlist.changeset(%{
        user_id: user_id,
        name: name,
        email_address: email_address,
        class_id: class_id,
        admin_notified: false
      })

    case Repo.insert(changeset) do
      {:error, message} ->
        Logger.error "Error inserted waitlist #{inspect params}"
        Logger.error "#{inspect message}"
      {:ok, waitlist} ->
        Logger.info "Inserted waitlist #{inspect waitlist}"
    end

    conn
    |> put_status(200)
    |> render("create.json")
  end


  def create(conn, %{"email" => email_address, "listing_id" => listing_id, "name" => name} = params) do
    user_id = case Coherence.current_user(conn) do
      nil -> nil
      user -> user.id
    end

    changeset =
      %Waitlist{}
      |> Waitlist.changeset(%{
        user_id: user_id,
        name: name,
        email_address: email_address,
        listing_id: listing_id,
        admin_notified: false
      })

    case Repo.insert(changeset) do
      {:error, message} ->
        Logger.error "Error inserted waitlist #{inspect params}"
        Logger.error "#{inspect message}"
      {:ok, waitlist} ->
        Logger.info "Inserted waitlist #{inspect waitlist}"
    end

    conn
    |> put_status(200)
    |> render("create.json")
  end
end
