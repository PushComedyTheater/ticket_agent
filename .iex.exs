alias TicketAgent.Atomizer

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

alias TicketAgent.Emails.{MailSender, OneTimeLogin, OrderEmail, UserWelcomeEmail}

alias TicketAgent.Finders.{
  ListingFinder,
  OrderFinder,
  ShowFinder,
  TicketFinder,
  UserFinder,
  WaitlistFinder
}

alias TicketAgent.Generators.OrderPdfGenerator
alias TicketAgent.ListingsGenerator
alias TicketAgent.Mailer
alias TicketAgent.Services.Stripe

alias TicketAgent.State.{
  ChargeProcessingState,
  OrderState,
  TicketState,
  UserState
}

alias TicketAgentWeb.Coherence.UserEmail
require Logger
import Ecto.Query
