defmodule TicketAgentWeb.Plugs.MenuLoader do
  require Logger
  import Plug.Conn
  def init(opts), do: opts

  def call(%{private: %{phoenix_action: action, phoenix_controller: controller}} = conn, _) do
    controller =
      controller
      |> Atom.to_string()
      |> match_controller()

    Logger.info "action = #{action}"
    Logger.info "controller = #{controller}"

    conn
    |> assign(:treeview_root, controller)
    |> assign(:treeview_action, "#{controller}_#{action}")
  end

  defp match_controller("Elixir.TicketAgentWeb.Backend.DashboardController"), do: "dashboard"
  defp match_controller("Elixir.TicketAgentWeb.Backend.ClassController"), do: "classes"
  defp match_controller("Elixir.TicketAgentWeb.Backend.ListingController"), do: "listings"
  defp match_controller("Elixir.TicketAgentWeb.Backend.OrderController"), do: "orders"
  defp match_controller("Elixir.TicketAgentWeb.Backend.TeacherController"), do: "teachers"
  defp match_controller("Elixir.TicketAgentWeb.Backend.WebHookController"), do: "webhooks"
  defp match_controller("Elixir.TicketAgentWeb.Admin.UserController"), do: "users"
  defp match_controller("Elixir.TicketAgentWeb.Admin.WebHookController"), do: "webhooks"
  defp match_controller(_), do: "dashboard"
end
