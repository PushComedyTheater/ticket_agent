defmodule TicketAgent.Factory do
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
    Waitlist,
    WebhookDetail
  }
  @lorem "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam quis leo eu mauris tincidunt aliquam quis sed sapien. Donec tristique malesuada diam ut venenatis. Quisque bibendum scelerisque massa. Suspendisse potenti. Pellentesque odio lacus, cursus ut venenatis id, posuere vitae ligula. Morbi mollis libero non ex vulputate interdum. Nullam a suscipit nisi. Morbi egestas interdum neque vel vestibulum. Aenean lacinia euismod viverra. Phasellus suscipit, lectus quis viverra sodales, arcu quam dictum est, porta iaculis sapien nisi nec urna. Curabitur pulvinar mi at odio mollis, sed scelerisque metus aliquam. Phasellus sit amet ante porta, imperdiet libero sit amet, blandit augue. Vestibulum in congue mauris. Mauris sed dolor quis velit euismod aliquet."
  use ExMachina.Ecto, repo: TicketAgent.Repo

  def account_factory do
    %Account{
      name: sequence(:name, &"Account #{&1}"),
      description: "",
      url: "",
      enabled: true,
      logo: ""
    }
  end

  def class_factory do
    type = Random.sample(["improvisation", "sketch", "improvisation", "improvisation", "standup", "acting"])
    title = sequence(:name, &"#{type} 10#{&1}")
    slug = String.split(title, " ") |> hd |> String.downcase

    %Class{
      type: type,
      title: title,
      slug: slug,
      description: @lorem,
      image_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/covers/wd4vnbdjwchrclmuhomg.jpg"
    }
  end

  def credit_card_factory do
    %CreditCard{
      user: build(:user),
      stripe_id: sequence(:stripe_id, &"card_1BhrdEBwsbTzoyHbzn#{&1}"),
      type: Random.sample(["Visa", "American Express", "MasterCard", "Discover", "JCB", "Diners Club", "Unknown"]),
      name: sequence(:name, &"Jane Smith#{&1}"),
      line_1_check: "pass",
      zip_check: "pass",
      cvc_check: "pass",
      exp_month: 12,
      exp_year: 2018,
      last_4: "4242"
    }
  end

  def event_factory do
    %Event{
      slug: Random.generate_slug(),
      title: ExMachina.Sequence.next("title"),
      description: @lorem,
    }
  end

  def event_tag_factory do
    %EventTag{}
  end  

  def listing_factory do
    %Listing{
      slug: Random.generate_slug(),
      title: ExMachina.Sequence.next("title"),
      description: @lorem,
      status: "active",
      start_at: DateTime.utc_now(),
      end_at: nil
    }
  end

  def order_factory do
    %Order{
      user: build(:user),
      credit_card: build(:credit_card),
      listing: build(:listing),
      slug: Random.generate_slug(),
      status: "completed",
      subtotal: 100,
      credit_card_fee: 100,
      processing_fee: 100,
      total_price: 300
    }
  end

  def order_detail_factory do
    %OrderDetail{}
  end

  def teacher_factory do
    %Teacher{}
  end

  def ticket_factory do
    %Ticket{
      slug: Random.generate_slug(),
      listing: build(:listing),
      order: build(:order),
      name: sequence(:name, &"Ticket for It #{&1}"),
      group: sequence(:group, &"group#{&1}"),
      status: "available",
      price: 500
    }
  end

  def user_factory do
    %User{
      name: sequence(:name, &"Jane Smith#{&1}"),
      email: sequence(:email, &"email-#{&1}@example.com"),
      account: build(:account),
      password: "reallylongandsecurepassword",
      password_confirmation: "reallylongandsecurepassword"
    }
  end

  def user_credential_factory do
    %UserCredential{}
  end

  def waitlist_factory do
    %Waitlist{}
  end

  def webhook_detail_factory do
    %WebhookDetail{}
  end
end
