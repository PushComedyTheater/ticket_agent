defmodule TicketAgent.Schema do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Ecto.Query
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @derive {Phoenix.Param, key: :id}
      @timestamps_opts [type: :utc_datetime, autogenerate: {Ecto.Schema, :__timestamps__, [:utc_datetime, :seconds]}]
      import Logger

      alias TicketAgent.{
        Account,
        Class,
        CreditCard,
        Event,
        Listing,
        ListingImage,
        ListingTag,
        Order,
        OrderDetail,
        Random,
        Repo,
        Teacher,
        Ticket,
        User,
        UserCredential,
        Waitlist,
        WebhookDetail
      }
    end
  end
end
