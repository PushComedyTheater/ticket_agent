defmodule TicketAgent.Atomizer do
  def atomize(item) when is_list(item) or is_map(item) do
    IO.inspect "atomize"
    IO.inspect item
    Enum.map(item, fn({k, v}) -> {String.to_existing_atom(k), v} end)
  end
end
