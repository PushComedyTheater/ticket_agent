require Logger
import Ecto.Query
alias TicketAgent.{Account, Class, Event, Listing, ListingImage, ListingTag, Repo, Teacher, User}

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

  def create_user(email, account) do
    Logger.info "Seeds->create_user:    Checking if user with email #{email} exists"
    query = from u in User,
            where: u.email == ^email,
            select: u

    user = case Repo.one(query) do
      nil ->
        Logger.info "Seeds->create_user:    Creating user"
        %User{
          name: "Patrick Veverka",
          email: email,
          password: "secret",
          password_confirmation: "secret",
          role: "admin",
          account_id: account.id
        }
        |> TicketAgent.Repo.insert!
      user ->
        Logger.info "Seeds->create_user:    User with email #{email} already exists"
        user
    end

    account
    |> Ecto.Changeset.cast(%{creator_id: user.id}, [:creator_id])
    |> Repo.update!()   
    
    user
  end  

  def create_teacher(name, biography, email, social \\ %{}) do
    Logger.info "Seeds->create_teacher: Checking if teacher with name #{name} exists"
    query = from t in Teacher,
            where: t.name == ^name,
            select: t

    case Repo.one(query) do
      nil ->
        Logger.info "Seeds->create_teacher: Creating teacher with name #{name}"
        %Teacher{
          biography: biography,
          email: email,
          name: name,
          social: social
        }
        |> TicketAgent.Repo.insert!        
      teacher ->
        Logger.info "Seeds->create_teacher: Teacher #{name} already exists"
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

  def create_event(%{slug: slug} = event) do
    Logger.info "Seeds->create_event:   Checking if event with slug #{slug} exists"
    query = from e in Event,
            where: e.slug == ^slug,
            select: e

    case Repo.one(query) do
      nil ->
        Logger.info "Seeds->create_event:   Creating event"
        struct(Event, event)
        |> TicketAgent.Repo.insert!        
      event ->
        Logger.info "Seeds->create_event:   Event #{slug} already exists"
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

  def create_tag(%{tag: tag, listing_id: listing_id} = listing_tag) do
    Logger.info "Seeds->create_tag:     Checking if tag with name #{tag} exists"
    query = from l in ListingTag,
            where: l.tag == ^tag,
            where: l.listing_id == ^listing_id,
            select: l

    case Repo.one(query) do
      nil ->
        Logger.info "Seeds->create_tag:     Creating tag"
        struct(ListingTag, listing_tag)
        |> TicketAgent.Repo.insert!        
      listing ->
        Logger.info "Seeds->create_tag:     Tag with name #{tag} already exists"
        listing
    end  
  end

  def create_image(%{type: type, listing_id: listing_id} = listing_image) do
    Logger.info "Seeds->create_image:   Checking if image with type #{type} and listing_id #{listing_id} exists"
    query = from l in ListingImage,
            where: l.type == ^type,
            where: l.listing_id == ^listing_id,
            select: l

    case Repo.one(query) do
      nil ->
        Logger.info "Seeds->create_image:   Creating image"
        struct(ListingImage, listing_image)
        |> TicketAgent.Repo.insert!        
      listing ->
        Logger.info "Seeds->create_image:   Image with type #{type} and listing_id #{listing_id} exists"
        listing
    end  
  end
end