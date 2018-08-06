defmodule TicketAgentWeb.Router do
  use TicketAgentWeb, :router
  # Add this
  use Coherence.Router

  pipeline :browser do
    plug(TicketAgentWeb.Plug.Timing)
    plug(:accepts, ["html", "ics"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    # Add this
    plug(Coherence.Authentication.Session)
  end

  pipeline :webhook_browser do
    plug(:accepts, ["html"])
    plug(:put_secure_browser_headers)
  end

  pipeline :protected do
    plug(:accepts, ["html", "json"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    # Add this
    plug(Coherence.Authentication.Session, protected: true)
  end

  pipeline :protected_api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    # Add this
    plug(Coherence.Authentication.Session, protected: true)
  end

  pipeline :admin_layout do
    plug(:put_layout, {TicketAgentWeb.Admin.LayoutView, :admin})
  end

  pipeline :backend_layout do
    plug(:put_layout, {TicketAgentWeb.Backend.LayoutView, :backend})
  end

  # Add this block
  scope "/" do
    pipe_through(:browser)
    coherence_routes()
  end

  # Add this block
  scope "/" do
    pipe_through(:protected)
    coherence_routes(:protected)
  end

  scope "/webhook", TicketAgentWeb do
    pipe_through(:webhook_browser)

    post("/:provider", WebhookController, :create)
  end

  scope "/", TicketAgentWeb do
    # Use the default browser stack
    pipe_through(:browser)
    resources("/about", AboutController, only: [:index, :show])
    resources("/camps", CampController, only: [:index, :show])
    resources("/charges", ChargeController, only: [:create])
    get("/event_calendar/:slug", EventCalendarController, :show, as: :event_ics)
    resources("/events", EventController, only: [:index, :show], param: "slug")
    get("/tickets/:listing_id/new", TicketController, :new, as: :new_ticket)
    resources("/tickets", TicketController)

    get("/ticket_auth/:token", TicketAuthController, :show, as: :ticket_auth)
    get("/ticket_auth", TicketAuthController, :new, as: :ticket_auth)
    post("/custom_registration", TicketAuthController, :create, as: :custom_registration)
    post("/waitlist", WaitlistController, :create, as: :waitlist)

    get("/workshops", WorkshopController, :index, as: :workshop)
    get("/classes", ClassController, :index, as: :classes)
    get("/classes/:type", ClassController, :class, as: :class_type)
    get("/class/:id", ClassController, :show, as: :class)

    get("/privacy", RootController, :privacy, as: :privacy)
    get("/terms", RootController, :terms, as: :terms)
    get("/", RootController, :index)
  end

  scope "/", TicketAgentWeb do
    pipe_through(:protected)
    resources("/orders", OrderController)
  end

  scope "/auth", TicketAgentWeb do
    pipe_through(:browser)

    get("/:provider", AuthController, :index)
    get("/:provider/callback", AuthController, :callback)
    delete("/logout", AuthController, :delete)
  end

  scope "/dashboard", TicketAgentWeb do
    pipe_through(:protected)
    get("/", DashboardController, :index)
    get("/tickets", Dashboard.TicketsController, :index, as: :dashboard_tickets)
    get("/classes", Dashboard.TicketsController, :index, as: :dashboard_classes)
    get("/order_pdf/:order_id", OrderPdfController, :show, as: :order_pdf)
  end

  scope "/concierge", TicketAgentWeb.Concierge do
    pipe_through([:protected, :ensure_concierge])
    get("/", DashboardController, :index, as: :concierge_dashboard)
    get("/single_checkin/:ticket_id", CheckinController, :show, as: :concierge_single_checkin)
    get("/listing_checkin/:listing_slug", CheckinController, :show, as: :concierge_checkin)
    resources("/checkin", CheckinController)
  end

  scope "/api", TicketAgentWeb.Api do
    pipe_through([:protected_api, :ensure_admin])
    get("/listings/:listing_slug/tickets", ListingTicketsController, :show)
  end

  scope "/admin", TicketAgentWeb.Admin do
    pipe_through([:protected, :ensure_admin, :admin_layout])
    get("/dashboard", DashboardController, :index, as: :admin_dashboard)
    get("/config", ConfigController, :index, as: :admin_config)

    resources("/classes", ClassController, as: :admin_class)
    resources("/listings", ListingController, as: :admin_event, param: "titled_slug")
    resources("/images", ImageController, as: :admin_image)
    resources("/orders", OrderController, as: :admin_order)
    resources("/teachers", TeacherController, as: :admin_teacher)
    resources("/tickets", TicketController, as: :admin_ticket)
    resources("/users", UserController, as: :admin_user)
    resources("/webhooks", WebHookController, as: :admin_webhook)

    get("/email_template/:type/:id", EmailTemplateController, :show, as: :admin_email_template)
    get("/email_template/:type", EmailTemplateController, :show, as: :admin_email_template)

    get("/", Redirect, to: "/admin/dashboard")
  end

  scope "/backend", TicketAgentWeb.Backend do
    pipe_through([:protected, :ensure_concierge, :backend_layout])
    get("/", DashboardController, :index, as: :backend_dashboard)
    resources("/classes", ClassController, as: :backend_class)
    resources("/listings", ListingController, as: :backend_event, param: "titled_slug")
    resources("/orders", OrderController, as: :backend_order)
    resources("/teachers", TeacherController, as: :backend_teacher)
    resources("/tickets", TicketController, as: :backend_ticket)
    resources("/users", UserController, as: :backend_user)
    resources("/webhooks", WebHookController, as: :backend_webhook)
  end

  def ensure_admin(conn, _params) do
    case conn.assigns.current_user.role do
      "admin" ->
        conn

      _ ->
        conn
        |> put_flash(:error, "You can't access that page!")
        |> redirect(to: "/")
        |> halt
    end
  end

  def ensure_concierge(conn, _params) do
    case conn.assigns.current_user.role do
      "admin" ->
        conn

      "concierge" ->
        conn

      _ ->
        conn
        |> put_flash(:error, "You can't access that page!")
        |> redirect(to: "/access_denied")
        |> halt
    end
  end
end
