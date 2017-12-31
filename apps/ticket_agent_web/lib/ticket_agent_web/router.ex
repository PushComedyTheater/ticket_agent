defmodule TicketAgentWeb.Router do
  use TicketAgentWeb, :router
  use Coherence.Router         # Add this

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session  # Add this
  end

  pipeline :webhook_browser do
    plug :accepts, ["html"]
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true  # Add this
  end

  pipeline :admin_layout do
    plug :put_layout, {TicketAgentWeb.Admin.LayoutView, :admin}
  end

 # Add this block
  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  # Add this block
  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  scope "/webhook", TicketAgentWeb do
    pipe_through :webhook_browser

    post "/:provider", WebhookController, :create
  end

  scope "/", TicketAgentWeb do
    pipe_through :browser # Use the default browser stack
    resources "/about", AboutController, only: [:index, :show]
    resources "/camps", CampController, only: [:index, :show]
    resources "/charges", ChargeController, only: [:create]
    resources "/events", EventController, only: [:index, :show], param: "slug"
    resources "/tickets", TicketController

    get "/ticket_auth/:token", TicketAuthController, :show, as: :ticket_auth
    get "/ticket_auth", TicketAuthController, :new, as: :ticket_auth
    post "/custom_registration", TicketAuthController, :create, as: :custom_registration
    post "/waitlist", WaitlistController, :create, as: :waitlist

    get "/workshops", WorkshopController, :index, as: :workshop
    get "/classes", ClassController, :index, as: :classes
    get "/classes/:type", ClassController, :class, as: :class_type
    get "/class/:id", ClassController, :show, as: :class

    get "/privacy", RootController, :privacy, as: :privacy
    get "/terms", RootController, :terms, as: :terms
    get "/", RootController, :index
  end

  scope "/auth", TicketAgentWeb do
    pipe_through :browser

    get "/:provider", AuthController, :index
    get "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  scope "/dashboard", TicketAgentWeb do
    pipe_through :protected
    get "/", DashboardController, :index
    get "/tickets", Dashboard.TicketsController, :index, as: :dashboard_tickets
    get "/classes", Dashboard.TicketsController, :index, as: :dashboard_classes
    get "/order_pdf/:order_id", OrderPdfController, :show, as: :order_pdf
  end

  scope "/concierge", TicketAgentWeb.Concierge do
    pipe_through [:protected, :ensure_concierge]
    get "/single_checkin/:ticket_id", CheckinController, :show
    get "/listing_checkin/:listing_id", CheckinController, :show
    resources "checkin", CheckinController
  end

  scope "/admin", TicketAgentWeb.Admin do
    pipe_through [:protected, :ensure_admin, :admin_layout]
    get "/dashboard", DashboardController, :index, as: :admin_dashboard

    resources "/classes", ClassController, as: :admin_class
    resources "/listings", ListingController, as: :admin_event, param: "titled_slug"
    resources "/images", ImageController, as: :admin_image
    resources "/teachers", TeacherController, as: :admin_teacher
    resources "/tickets", TicketController, as: :admin_ticket

    get "/", Redirect, to: "/admin/dashboard"
  end

  scope "/", TicketAgentWeb do
    pipe_through :protected
    resources "/orders", OrderController
  end

  def ensure_admin(conn, params) do
    case conn.assigns.current_user.role do
      "admin" -> conn
      _ ->
        conn
        |> put_flash(:error, "You can't access that page!")
        |> redirect(to: "/")
        |> halt
    end
  end

  def ensure_concierge(conn, params) do
    case conn.assigns.current_user.role do
      "admin" -> conn
      "concierge" -> conn
      _ ->
        conn
        |> put_flash(:error, "You can't access that page!")
        |> redirect(to: "/access_denied")
        |> halt
    end
  end
end
