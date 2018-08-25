defmodule TicketAgent.State.ChargeProcessingState do
  require Logger
  alias TicketAgent.Repo
  alias TicketAgent.State.{OrderState, TicketState}

  def set_order_processing_with_tickets(%{tickets: %Ecto.Association.NotLoaded{}} = order),
    do: set_order_processing_with_tickets(Repo.preload(order, :tickets))

  def set_order_processing_with_tickets(%{tickets: []} = order), do: {:error, :no_tickets_error}

  def set_order_processing_with_tickets(order) do
    order_ticket_count = Enum.count(order.tickets)
    Logger.info("set_order_processing_with_tickets->order_ticket_count: #{order_ticket_count}")

    transaction =
      order
      |> TicketState.unlock_tickets_to_processing_for_order()
      |> Ecto.Multi.append(OrderState.set_order_processing(order))

    case Repo.transaction(transaction) do
      {:ok,
       %{
         order_processing: {1, [updated_order]},
         unlocked_processing_tickets: {^order_ticket_count, updated_tickets}
       }} ->
        {:ok, {updated_order, updated_tickets}}

      {:ok, %{order_processing: {0, _}}} ->
        Logger.error(
          "set_order_processing_with_tickets->#{order.slug}: order was not updated to processing"
        )

        {:error, :order_processing_error}

      {:ok, %{unlocked_processing_tickets: _}} ->
        Logger.error(
          "set_order_processing_with_tickets->#{order.slug}: tickets were not updated to processing"
        )

        {:error, :ticket_processing_error}

      anything ->
        Logger.error(
          "set_order_processing_with_tickets->#{order.slug}: received unmatched error: #{
            inspect(anything)
          }"
        )

        {:error, :unknown_error}
    end
  end

  def set_order_completed_with_tickets(%{tickets: %Ecto.Association.NotLoaded{}} = order),
    do: set_order_completed_with_tickets(Repo.preload(order, :tickets))

  def set_order_completed_with_tickets(%{tickets: []} = order), do: {:error, :no_tickets_error}

  def set_order_completed_with_tickets(order) do
    order_ticket_count = Enum.count(order.tickets)
    Logger.info("set_order_completed_with_tickets->order_ticket_count: #{order_ticket_count}")

    transaction =
      order
      |> TicketState.purchase_processing_tickets_for_order()
      |> Ecto.Multi.append(OrderState.set_order_completed(order))

    case Repo.transaction(transaction) do
      {:ok,
       %{
         order_completed: {1, [updated_order]},
         purchased_processing_tickets: {^order_ticket_count, updated_tickets}
       }} ->
        {:ok, {updated_order, updated_tickets}}

      {:ok, %{order_completed: {0, _}}} ->
        Logger.error(
          "set_order_completed_with_tickets->#{order.slug}: order was not updated to completed"
        )

        {:error, :order_completing_error}

      {:ok, %{purchased_processing_tickets: _}} ->
        Logger.error(
          "set_order_completed_with_tickets->#{order.slug}: tickets were not updated to completed"
        )

        {:error, :ticket_completing_error}

      anything ->
        Logger.error(
          "set_order_completed_with_tickets->#{order.slug}: received unmatched error: #{
            inspect(anything)
          }"
        )

        {:error, :unknown_error}
    end
  end

  def cancel_order_and_release_tickets(%{tickets: %Ecto.Association.NotLoaded{}} = order),
    do: cancel_order_and_release_tickets(Repo.preload(order, :tickets))

  def cancel_order_and_release_tickets(order) do
    order_ticket_count = Enum.count(order.tickets)
    Logger.info("cancel_order_and_release_tickets->order_ticket_count: #{order_ticket_count}")

    transaction =
      order
      |> TicketState.release_tickets()
      |> Ecto.Multi.append(OrderState.release_order(order))

    case Repo.transaction(transaction) do
      {:ok,
       %{
         order_released: {1, [updated_order]},
         release_tickets: {^order_ticket_count, updated_tickets}
       }} ->
        Logger.info("cancel_order_and_release_tickets->cancelled order and released tickets")
        :ok

      anything ->
        Logger.info("cancel_order_and_release_tickets->mismatch on count #{inspect(anything)}")
        :ok
    end
  end

  def reset_order_and_tickets(%{tickets: %Ecto.Association.NotLoaded{}} = order),
    do: reset_order_and_tickets(Repo.preload(order, :tickets))

  def reset_order_and_tickets(order) do
    order_ticket_count = Enum.count(order.tickets)
    Logger.info("reset_order_and_tickets->order_ticket_count: #{order_ticket_count}")

    transaction =
      order
      |> TicketState.lock_processing_tickets()
      |> Ecto.Multi.append(OrderState.set_order_started(order))

    case Repo.transaction(transaction) do
      {:ok,
       %{
         order_started: {1, [updated_order]},
         locked_processing_tickets: {^order_ticket_count, updated_tickets}
       }} ->
        {:ok, {updated_order, updated_tickets}}

      {:ok, %{order_started: {0, _}}} ->
        Logger.error("reset_order_and_tickets->#{order.slug}: order was not updated to started")
        {:error, :order_starting_error}

      {:ok, %{locked_processing_tickets: _}} ->
        Logger.error("reset_order_and_tickets->#{order.slug}: tickets were not updated to locked")
        {:error, :ticket_locked_error}

      anything ->
        Logger.error(
          "reset_order_and_tickets->#{order.slug}: received unmatched error: #{inspect(anything)}"
        )

        {:error, :unknown_error}
    end
  end

  def cancel_order_and_tickets(%{tickets: %Ecto.Association.NotLoaded{}} = order),
    do: cancel_order_and_tickets(Repo.preload(order, :tickets))

  def cancel_order_and_tickets(order, refunded_by) do
    order_ticket_count = Enum.count(order.tickets)
    Logger.info("cancel_order_and_tickets->order_ticket_count: #{order_ticket_count}")

    transaction =
      order
      |> TicketState.refund_tickets()
      |> Ecto.Multi.append(OrderState.refund_order(order, refunded_by))

    case Repo.transaction(transaction) do
      {:ok,
       %{
         refund_order: {1, [updated_order]},
         refund_tickets: {order_ticket_count, updated_tickets}
       }} ->
        Logger.info("Refunded order and all tickets")
        {:ok, %{order: updated_order, tickets: updated_tickets}}

      anything ->
        Logger.error(
          "cancel_order_and_tickets->#{order.slug}: received unmatched error: #{inspect(anything)}"
        )

        IO.inspect(anything)
        {:error, :unknown_error}
    end
  end
end
