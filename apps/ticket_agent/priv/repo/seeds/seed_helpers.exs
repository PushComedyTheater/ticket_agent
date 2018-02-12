require Logger
import Ecto.Query
use Coherence.Config
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
  Teacher, 
  Ticket,
  User,
  UserCredential,
  Waitlist
}

defmodule SeedHelpers do
  def create_account(name) do
    Logger.info "Seeds->create_account: Checking if account with name #{name} exists"
    query = from a in Account,
            where: a.name == ^name,
            select: a

    case Repo.one(query) do
      nil ->
        Logger.info "Seeds->create_account: Creating account"
        %Account{
          name: name,
          description: name,
          url: "https://pushcomedytheater.com",
          enabled: true
        }
        |> Repo.insert!
      account ->
        Logger.info "Seeds->create_account: Account already exists"
        account
    end
  end

  def create_credit_card(%{id: user_id} = user) do
    Logger.info "Seeds->create_credit_card: Checking if credit card with user_id #{user_id} exists"
    query = from c in CreditCard,
            where: c.user_id == ^user_id,
            select: c

    case Repo.one(query) do
      nil ->
        Logger.info "Seeds->create_credit_card: Creating card"
        %CreditCard{
          user_id: user_id,
          stripe_id: "abc123"a,
          type: "Visa",
          name: user.name,
          line_1_check: "pass",
          zip_check: "pass",
          cvc_check: "pass",
          exp_month: 12,
          exp_year: 2018,
          fingerprint: nil,
          funding: "credit",
          last_4: "1004",
          address: nil,
          metadata: nil
        }
        |> Repo.insert!
      card ->
        Logger.info "Seeds->create_credit_card: Card already exists"
        card
    end
  end

  def create_user(email, account, role \\ "admin") do
    Logger.info "Seeds->create_user:    Checking if user with email #{email} exists"
    query = from u in User,
            where: u.email == ^email,
            select: u

    user = case Repo.one(query) do
      nil ->
        Logger.info "Seeds->create_user:    Creating user"

        changes = %{
          name: "Patrick Veverka",
          email: email,
          password: "supersecret",
          password_confirmation: "supersecret",
          account_id: account.id,
          role: role
        }

        %User{} |> User.changeset(changes) |> Repo.insert!

      user ->
        Logger.info "Seeds->create_user:    User with email #{email} already exists"
        user
    end

    account
    |> Ecto.Changeset.cast(%{creator_id: user.id}, [:creator_id])
    |> Repo.update!()

    user
  end

  def create_teacher(%{slug: slug} = teacher) do
    Logger.info "Seeds->create_teacher: Checking if teacher with slug #{slug} exists"
    query = from t in Teacher,
            where: t.slug == ^slug,
            select: t

    case Repo.one(query) do
      nil ->
        Logger.info "Seeds->create_teacher: Creating teacher with slug #{slug}"
        struct(Teacher, teacher)
        |> TicketAgent.Repo.insert!
      teacher ->
        Logger.info "Seeds->create_teacher: Teacher #{slug} already exists"
        teacher
    end
  end

  def create_class(%{slug: slug} = class) do
    Logger.info "Seeds->create_class:   Checking if class with slug #{slug} exists"
    query = from t in Class,
            where: t.slug == ^slug,
            select: t

    case Repo.one(query) do
      nil ->
        Logger.info "Seeds->create_class:   Creating class"
        struct(Class, class)
        |> TicketAgent.Repo.insert!
      class ->
        Logger.info "Seeds->create_class:   Class with slug #{slug} already exists"
        class
    end
  end

  def create_event(%{slug: slug, title: title} = event) do
    title = String.trim(title)
    Logger.info "Seeds->create_event:   Checking if event with slug #{slug} or title #{title} exists"
    query = from e in Event,
            where: e.slug == ^slug or e.title == ^title,
            select: e

    case Repo.one(query) do
      nil ->
        Logger.info "Seeds->create_event:   Creating event"
        struct(Event, event)
        |> TicketAgent.Repo.insert!
      event ->
        Logger.info "Seeds->create_event:   Event with slug #{slug} or title #{title} exists"
        event
    end
  end

  def create_listing(%{slug: slug} = listing) do
    Logger.info "Seeds->create_listing: Checking if listing with name #{slug} exists"
    query = from l in Listing,
            where: l.slug == ^slug,
            select: l

    case Repo.one(query) do
      nil ->
        Logger.info "Seeds->create_listing: Creating listing"
        struct(Listing, listing)
        |> TicketAgent.Repo.insert!
      listing ->
        Logger.info "Seeds->create_listing: Listing #{slug} already exists"
        listing
    end
  end

  def create_tag(%{tag: tag, event_id: event_id} = event_tag) do
    Logger.info "Seeds->create_tag:     Checking if tag with name #{tag} exists"
    query = from e in EventTag,
            where: e.tag == ^tag,
            where: e.event_id == ^event_id,
            select: e

    case Repo.one(query) do
      nil ->
        Logger.info "Seeds->create_tag:     Creating tag"
        struct(EventTag, event_tag)
        |> TicketAgent.Repo.insert!
      event_tag ->
        Logger.info "Seeds->create_tag:     Tag with name #{tag} already exists"
        event_tag
    end
  end

  def create_order(order) do
    Logger.info "Seeds->create_order:   Creating order"
    struct(Order, order)
    |> TicketAgent.Repo.insert!
  end

  def create_ticket(listing, _, status, price, group) when status == "available" do
    title = String.replace(listing.title, "\"", "'") 
    %{
      listing_id: listing.id,
      slug: Random.generate_slug(),
      name: "Ticket for #{title}",
      status: status,
      description: "Ticket for #{title}",
      group: group,
      price: price,
      sale_start: listing.start_at |> Calendar.NaiveDateTime.subtract!(604800),
      inserted_at: listing.inserted_at,
      updated_at: listing.updated_at
    }
  end

  def create_ticket(listing, order, status, price, group) when status == "purchased" do
    title = String.replace(listing.title, "\"", "'") 
    guest_name = FakerElixir.Name.name()
    {:ok, seconds, a, b} = Calendar.NaiveDateTime.diff(listing.start_at, NaiveDateTime.utc_now())
    %{
      listing_id: listing.id,
      slug: Random.generate_slug(),
      name: "Ticket for #{title}",
      status: status,
      purchased_at: NaiveDateTime.utc_now |> Calendar.NaiveDateTime.subtract!(FakerElixir.Number.between(86400, seconds)),
      description: "Ticket for #{title}",
      guest_name: guest_name,
      guest_email: FakerElixir.Internet.email(:popular, guest_name),   
      order_id: order.id,   
      group: group,
      price: price,
      sale_start: listing.start_at |> Calendar.NaiveDateTime.subtract!(604800),
      inserted_at: listing.inserted_at,
      updated_at: listing.updated_at
    }
  end  

  def create_ticket(listing, order, status, price, group) when status == "emailed" do
    ticket = create_ticket(listing, order, "purchased", price, group)
    emailed_at = ticket.purchased_at |> Calendar.NaiveDateTime.add!(FakerElixir.Number.between(0, 500))
    
    ticket = 
      ticket
      |> Map.put(:status, "emailed")
      |> Map.put(:emailed_at, emailed_at)
  end    
end
