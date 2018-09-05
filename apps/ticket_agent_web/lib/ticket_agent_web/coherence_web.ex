defmodule TicketAgentWeb.Coherence do
  @moduledoc false

  def view do
    quote do
      use Phoenix.View, root: "../ticket_agent_web/lib/ticket_agent_web/templates"
      # Import convenience functions from controllers

      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import TicketAgentWeb.Router.Helpers
      import TicketAgentWeb.ErrorHelpers
      import TicketAgentWeb.Gettext
      import TicketAgentWeb.Coherence.ViewHelpers
    end
  end

  def controller do
    quote do
      use Phoenix.Controller, except: [layout_view: 2]
      use Coherence.Config
      use Timex

      import Ecto
      import Ecto.Query
      import Plug.Conn
      import TicketAgentWeb.Router.Helpers
      import TicketAgentWeb.Gettext
      import Coherence.Controller

      alias Coherence.Config
      alias Coherence.Controller

      require Redirects
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
