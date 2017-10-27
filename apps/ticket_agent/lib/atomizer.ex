defmodule TicketAgent.Atomizer do
  def atomize(item) when is_map(item) do
    Enum.reduce(item, %{}, fn({k, v}, acc) ->
      Map.put(acc, String.to_atom("#{k}"), v)
    end)
  end
end
