defmodule TicketAgentWeb.Plugs.Admin.MenuLoader do
  require Logger
  import Plug.Conn
  def init(opts), do: opts

  def call(%{private: %{phoenix_action: action, phoenix_controller: controller}} = conn, _) do
    controller = 
      controller
      |> Atom.to_string()
      |> match_controller()

    # Logger.info "action = #{action}"
    # Logger.info "controller = #{controller}"
    
    conn
    |> assign(:treeview_root, controller)
    |> assign(:treeview_action, "#{controller}_#{action}")
  end

  defp match_controller("Elixir.TicketAgentWeb.Admin.ClassController"), do: "classes"
  defp match_controller("Elixir.TicketAgentWeb.Admin.ListingController"), do: "listings"
  defp match_controller("Elixir.TicketAgentWeb.Admin.OrderController"), do: "orders"
  defp match_controller("Elixir.TicketAgentWeb.Admin.TeacherController"), do: "teachers"
  defp match_controller("Elixir.TicketAgentWeb.Admin.UserController"), do: "users"
end
