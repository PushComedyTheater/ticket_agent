defmodule TicketAgent.State.ChargeProcessingState do
  require Logger
  alias TicketAgent.Repo
  alias TicketAgent.State.{OrderState, TicketState}
  
  def set_order_and_tickets_processing(order, ticket_ids) do
    Logger.info "set_order_and_tickets_processing->ticket_ids: #{inspect ticket_ids}"
    ticket_ids_count = Enum.count(ticket_ids)

    transaction = 
      ticket_ids
      |> TicketState.unlock_tickets_to_processing(order.id)
      |> Ecto.Multi.append(OrderState.set_order_processing_transaction(order))

    case Repo.transaction(transaction) do
      {:ok, %{order_processing: {1,[updated_order]}, unlocked_processing_tickets: {ticket_count, updated_tickets}}} when ticket_count == ticket_ids_count ->
        {:ok, {updated_order, updated_tickets}}
      {:ok, %{unlocked_processing_tickets: {ticket_count, _}}} when ticket_count != ticket_ids_count ->
        Logger.error "set_order_and_tickets_processing->tickets were not updated to processing"
        {:error, "Tickets were not captured"}
      {:ok, %{order_processing: {0, _}}} ->
        Logger.error "set_order_and_tickets_processing->order was not updated to processing"
        {:error, "Order was not captured"}
      anything ->
        Logger.error "set_order_and_tickets_processing->received unmatched error: #{inspect anything}"
        {:error, "Unknown error"}
    end
  end  
end