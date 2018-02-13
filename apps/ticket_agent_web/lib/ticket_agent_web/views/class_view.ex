defmodule TicketAgentWeb.ClassView do
  use TicketAgentWeb, :view
  alias TicketAgent.{Class, Listing, Repo}
  import Ecto.Query

  def classes_by_type(type) do
    query = from c in Class,
            where: c.type == ^type,
            order_by: c.menu_order,
            select: c
    Repo.all(query)
  end

  def class_buy_timestamp(nil), do: ""
  def class_buy_timestamp(%Listing{start_at: start_at, end_at: end_at}) do
    start_at =
      start_at
      |> Calendar.DateTime.shift_zone!("America/New_York")

    end_at =
      end_at
      |> Calendar.DateTime.shift_zone!("America/New_York")      
     
    "Register for " <> Calendar.Strftime.strftime!(start_at, "%b %d, %Y") <> " - " <> Calendar.Strftime.strftime!(end_at, "%b %d, %Y") <> Calendar.Strftime.strftime!(start_at, " at %l:%M%p")
    
  end  
end
