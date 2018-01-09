defmodule TicketAgent.State.ChargeProcessingState do
  require Logger
  alias TicketAgent.Repo
  alias TicketAgent.State.{OrderState, TicketState}
  
  def set_order_and_tickets_processing(order, ticket_ids) do
    
    ticket_ids
    |> TicketState.unlock_tickets_to_processing(order.id)
    |> Ecto.Multi.append(OrderState.set_order_processing_transaction(order))
    |> Repo.transaction
  end  
end