defmodule TicketAgentWeb.ValidateShowRequest do
  require Logger
  import Plug.Conn
  import Phoenix.Controller
  alias TicketAgent.Listing
  def init(opts), do: opts

  def call(%Plug.Conn{cookies: %{"ticket_data" => data}, params: %{"show_id" => show_id}} = conn, _) do
    %{
      "buyer_name" => buyer_name, 
      "buyer_email" => buyer_email, 
      "ticket_count" => ticket_count, 
      "show_id" => encoded_show_id,
      "guest_checkout" => guest_checkout,
      "tickets" => tickets
    } =
      data
      |> Base.decode64!()
      |> Poison.decode!

    {buyer_name, buyer_email} = case Coherence.logged_in?(conn) do
      true ->
        user = Coherence.current_user(conn)
        {user.name, user.email}
      false ->
        {buyer_name, buyer_email}
    end

    if encoded_show_id == show_id do
      conn
      |> assign(:buyer_name, buyer_name)
      |> assign(:buyer_email, buyer_email)
      |> assign(:guest_checkout, guest_checkout)
      |> assign(:ticket_count, ticket_count)
      |> assign(:show_id, show_id)
      |> assign(:tickets, tickets)
    else
      conn
      |> delete_resp_cookie("ticket_data")
      |> put_flash(:info, "Something went wrong with your request.")
      |> redirect(to: "/")  
    end
   
  end

  def call(conn, _) do
    conn
    |> delete_resp_cookie("ticket_data")
    |> put_flash(:info, "Something went wrong with your request.")
    |> redirect(to: "/")       
  end
end
