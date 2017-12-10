# new file
# web/models/channel_monitor.ex
defmodule TicketAgentWeb.ChannelMonitor do
  use GenServer

  def start_link(initial_state) do
   GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def user_joined(channel, user) do
   GenServer.call(__MODULE__, {:user_joined, channel, user})
  end

  def users_in_channel(channel) do
   GenServer.call(__MODULE__, {:users_in_channel, channel})
  end

  def user_left(channel, user_id) do
    GenServer.call(__MODULE__, {:user_left, channel, user_id})
  end

  # GenServer implementation
  def handle_call({:user_joined, channel, user}, _from, state) do
    new_state = case Map.get(state, channel) do
      nil ->
        Map.put(state, channel, [user])
      users ->
        Map.put(state, channel, Enum.uniq([user | users]))
    end

    {:reply, new_state, new_state}
  end

  def handle_call({:users_in_channel, channel}, _from, state) do
    {:reply, Map.get(state, channel), state}
  end

  def handle_call({:user_left, channel, user_id}, _from, state) do
    new_users = state
      |> Map.get(channel)
      |> Enum.reject(&(&1.id == user_id))

    new_state = Map.update!(state, channel, fn(_) -> new_users end)

    {:reply, new_state, new_state}
  end
end