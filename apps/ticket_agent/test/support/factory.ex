defmodule TicketAgent.Factory do
  @lorem "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam quis leo eu mauris tincidunt aliquam quis sed sapien. Donec tristique malesuada diam ut venenatis. Quisque bibendum scelerisque massa. Suspendisse potenti. Pellentesque odio lacus, cursus ut venenatis id, posuere vitae ligula. Morbi mollis libero non ex vulputate interdum. Nullam a suscipit nisi. Morbi egestas interdum neque vel vestibulum. Aenean lacinia euismod viverra. Phasellus suscipit, lectus quis viverra sodales, arcu quam dictum est, porta iaculis sapien nisi nec urna. Curabitur pulvinar mi at odio mollis, sed scelerisque metus aliquam. Phasellus sit amet ante porta, imperdiet libero sit amet, blandit augue. Vestibulum in congue mauris. Mauris sed dolor quis velit euismod aliquet."
  use ExMachina.Ecto, repo: TicketAgent.Repo

  def account_factory do
    %TicketAgent.Account{
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

    %TicketAgent.Class{
      type: type,
      title: title,
      slug: slug,
      description: @lorem,
      cover_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293297/covers/wd4vnbdjwchrclmuhomg.png",
      social_photo_url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293297/social/dxcfi6mfoag1mst2k0pr.png"
    }
  end

  def listing_factory do
    %TicketAgent.Listing{
      type: "show",
      slug: TicketAgent.Listing.generate_slug(),
      title: ExMachina.Sequence.next("title"),
      description: @lorem,
      status: "active",
      start_time: DateTime.utc_now(),
      end_time: nil
    }
  end

  def listing_image_factory do
    %TicketAgent.ListingImage{
      listing: build(:listing),
      url: "https://res.cloudinary.com/push-comedy-theater/image/upload/v1507293297/social/dxcfi6mfoag1mst2k0pr.png",
      type: "cover"
    }
  end

  def user_factory do
    %TicketAgent.User{
      name: sequence(:name, &"Jane Smith#{&1}"),
      email: sequence(:email, &"email-#{&1}@example.com"),
      account: build(:account)
    }
  end
end
