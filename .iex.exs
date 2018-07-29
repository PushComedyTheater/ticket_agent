  alias TicketAgent.{
    Account,
    Class,
    CreditCard,
    Event,
    EventTag,
    Listing,
    ListingImage,
    Order,
    OrderDetail,
    Random,
    Repo,
    ShowDetail,
    Teacher,
    Ticket,
    User,
    UserCredential,
    Waitlist,
    WebhookDetail
  }
  alias TicketAgent.Services.Stripe
  alias TicketAgent.State.{
    ChargeProcessingState,
    OrderState,
    TicketState,
    UserState
  }
  require Logger
  import Ecto.Query
