defmodule TicketAgentWeb.ExceptionSender do
  require Logger
  def send(message, type, extra \\ %{}) do
    Logger.info "Sending Exception"
    result = 
      message
      |> RuntimeError.exception
      |> Sentry.capture_exception(
        [
          stacktrace: System.stacktrace(), 
          extra: extra,
          result: (if (Mix.env == :test), do: :sync, else: :async)
        ]
      )
  end

  def message(:missing_tickets), do: "No tickets associated with this order."
  def message(:ticket_processing_error), do: "Tickets were not able to be updated to processing."
  def message(:order_processing_error), do: "Order was not able to be updated to processing"
  def message(:token_error), do: "There was an error receiving a token from our credit card processor."
  def message(:missing_stripe_customer_id), do: "There was an error with our payment process, please try again."
  def message(error), do: "There was an unknown error.  Please try again."
end