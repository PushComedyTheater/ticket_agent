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
      import Logger

      alias TicketAgent.{
        Account,
        Class,
        Listing,
        ListingImage,
        ListingTag,
        Repo,
        Teacher,
        Ticket,
        User,
        UserCredential
      }
    end
  end
end
