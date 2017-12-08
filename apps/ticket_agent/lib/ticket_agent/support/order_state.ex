defmodule TicketAgent.OrderState do
  alias Ecto.Multi
  alias TicketAgent.{Listing, Order, Repo}
  import Ecto.{Changeset, Query}

  # def activate_operation(%Channel{id: id}, timestamp \\ NaiveDateTime.utc_now()) do
  #   Multi.new()
  #   |> Multi.update_all(:activate_channel,
  #     from(t in Channel, where: t.status in ["provisioning"] and t.id == ^id),
  #     [set: [status: "active", status_updated_at: timestamp]],
  #     returning: true
  #   )
  # end
end