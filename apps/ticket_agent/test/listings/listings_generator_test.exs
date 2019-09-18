defmodule TicketAgent.ListingsGeneratorTest do
  import TicketAgent.Factory
  use TicketAgent.DataCase
  alias TicketAgent.ListingsGenerator
  alias TicketAgent.{Listing, Repo, Ticket}

  describe "create event" do
    test "it creates an event from an event" do
      event = insert(:event)
      user = insert(:user)

      listings = [
        %{
          "end_time" => "",
          "pass_fees_to_buyer" => true,
          "slug" => "1e7110c0c8",
          "start_time" => "2018-04-02T05:50:00+01:00",
          "tickets" => [
            %{
              "description" => "",
              "group" => "TEST - REMOVE",
              "name" => "TEST - REMOVE",
              "price" => 10000,
              "quantity" => 1,
              "sale_end" => "2018-04-03T05:50:00+01:00",
              "sale_start" => "2018-04-02T05:40:00+01:00"
            },
            %{
              "description" => "",
              "group" => "TEST - REMOVEs",
              "name" => "TEST - REMOVEs",
              "price" => 15000,
              "quantity" => 1,
              "sale_end" => "",
              "sale_start" => ""
            }
          ]
        }
      ]

      params = %{
        "description" => "asdlfkjsdflkj",
        "image" =>
          "https://res.cloudinary.com/push-comedy-theater/image/upload/v1530992150/cover/k0gmdxgq55dkjmot4myn.png",
        "listings" => listings,
        "title" => "sfadskjlkjl",
        "user" => user,
        "event_id" => event.id
      }

      ListingsGenerator.create_event(params)

      tickets = Repo.all(Ticket)

      assert 2 == Enum.count(tickets)

      first = Enum.filter(tickets, fn x -> x.price == 10000 end) |> hd
      assert {:ok, first.sale_start, 0} == DateTime.from_iso8601("2018-04-02 04:40:00.000000Z")
      assert {:ok, first.sale_end, 0} == DateTime.from_iso8601("2018-04-03 04:50:00.000000Z")
      assert first.group == "TEST - REMOVE"
      assert first.status == "available"

      second = Enum.filter(tickets, fn x -> x.price == 15000 end) |> hd
      assert second.sale_start
      refute second.sale_end
      assert second.group == "TEST - REMOVEs"
      assert second.status == "available"

      listing = Repo.all(Listing) |> hd
      assert listing.status == "active"
      assert listing.type == "show"
      assert listing.pass_fees_to_buyer
    end

    test "it creates an event not from an event" do
      user = insert(:user)

      listings = [
        %{
          "end_time" => "",
          "pass_fees_to_buyer" => true,
          "slug" => "1e7110c0c8",
          "start_time" => "2018-04-02T05:50:00+01:00",
          "tickets" => [
            %{
              "description" => "",
              "group" => "TEST - REMOVE",
              "name" => "TEST - REMOVE",
              "price" => 10000,
              "quantity" => 1,
              "sale_end" => "2018-04-03T05:50:00+01:00",
              "sale_start" => "2018-04-02T05:40:00+01:00"
            },
            %{
              "description" => "",
              "group" => "TEST - REMOVEs",
              "name" => "TEST - REMOVEs",
              "price" => 15000,
              "quantity" => 1,
              "sale_end" => "",
              "sale_start" => ""
            }
          ]
        }
      ]

      params = %{
        "description" => "asdlfkjsdflkj",
        "image" =>
          "https://res.cloudinary.com/push-comedy-theater/image/upload/v1530992150/cover/k0gmdxgq55dkjmot4myn.png",
        "listings" => listings,
        "title" => "sfadskjlkjl",
        "user" => user,
        "event_id" => nil
      }

      ListingsGenerator.create_event(params)

      tickets = Repo.all(Ticket)

      assert 2 == Enum.count(tickets)

      first = Enum.filter(tickets, fn x -> x.price == 10000 end) |> hd
      assert {:ok, first.sale_start, 0} == DateTime.from_iso8601("2018-04-02 04:40:00.000000Z")
      assert {:ok, first.sale_end, 0} == DateTime.from_iso8601("2018-04-03 04:50:00.000000Z")
      assert first.group == "TEST - REMOVE"
      assert first.status == "available"

      second = Enum.filter(tickets, fn x -> x.price == 15000 end) |> hd
      assert second.sale_start
      refute second.sale_end
      assert second.group == "TEST - REMOVEs"
      assert second.status == "available"

      listing = Repo.all(Listing) |> hd
      assert listing.status == "active"
      assert listing.type == "show"
      assert listing.pass_fees_to_buyer
    end
  end

  # describe "create_from_class" do
  #   test "it creates from a class" do
  #     class = insert(:class)
  #     user = insert(:user)
  #     listings = [
  #       %{
  #         "end_time" => "",
  #         "pass_fees_to_buyer" => true,
  #         "slug" => "1e7110c0c8",
  #         "start_time" => "2018-04-02T05:50:00+01:00",
  #         "tickets" => [
  #           %{
  #             "description" => "",
  #             "group" => "TEST - REMOVE",
  #             "name" => "TEST - REMOVE",
  #             "price" => 10000,
  #             "quantity" => 1,
  #             "sale_end" => "2018-04-03T05:50:00+01:00",
  #             "sale_start" => "2018-04-02T05:40:00+01:00"
  #           },
  #           %{
  #             "description" => "",
  #             "group" => "TEST - REMOVEs",
  #             "name" => "TEST - REMOVEs",
  #             "price" => 15000,
  #             "quantity" => 1,
  #             "sale_end" => "",
  #             "sale_start" => ""
  #           }
  #         ]
  #       }
  #     ]
  #     params = %{"user" => user, "class_id" => class.id, "title" => class.title, "description" => class.description, "listings" => listings}
  #     ListingsGenerator.create_from_class(params)

  #     tickets = Repo.all(Ticket)

  #     assert 2 == Enum.count(tickets)

  #     first = Enum.filter(tickets, fn(x) -> x.price == 10000 end) |> hd
  #     assert {:ok, first.sale_start, 0} == DateTime.from_iso8601("2018-04-02 04:40:00.000000Z")
  #     assert {:ok, first.sale_end, 0} == DateTime.from_iso8601("2018-04-03 04:50:00.000000Z")
  #     assert first.group == "TEST - REMOVE"
  #     assert first.status == "available"

  #     second = Enum.filter(tickets, fn(x) -> x.price == 15000 end) |> hd
  #     assert second.sale_start
  #     refute second.sale_end
  #     assert second.group == "TEST - REMOVEs"
  #     assert second.status == "available"

  #     listing = Repo.all(Listing) |> hd
  #     assert listing.status == "active"
  #     assert listing.pass_fees_to_buyer
  #   end

  #   test "it creates from a class without passing fees to buyer" do
  #     class = insert(:class)
  #     user = insert(:user)
  #     listings = [
  #       %{
  #         "end_time" => "",
  #         "pass_fees_to_buyer" => false,
  #         "slug" => "1e7110c0c8",
  #         "start_time" => "2018-04-02T05:50:00+01:00",
  #         "tickets" => [
  #           %{
  #             "description" => "",
  #             "group" => "TEST - REMOVE",
  #             "name" => "TEST - REMOVE",
  #             "price" => 10000,
  #             "quantity" => 1,
  #             "sale_end" => "2018-04-03T05:50:00+01:00",
  #             "sale_start" => "2018-04-02T05:40:00+01:00"
  #           },
  #           %{
  #             "description" => "",
  #             "group" => "TEST - REMOVEs",
  #             "name" => "TEST - REMOVEs",
  #             "price" => 15000,
  #             "quantity" => 1,
  #             "sale_end" => "",
  #             "sale_start" => ""
  #           }
  #         ]
  #       }
  #     ]
  #     params = %{"user" => user, "class_id" => class.id, "title" => class.title, "description" => class.description, "listings" => listings}
  #     ListingsGenerator.create_from_class(params)

  #     tickets = Repo.all(Ticket)

  #     assert 2 == Enum.count(tickets)

  #     first = Enum.filter(tickets, fn(x) -> x.price == 10000 end) |> hd
  #     assert {:ok, first.sale_start, 0} == DateTime.from_iso8601("2018-04-02 04:40:00.000000Z")
  #     assert {:ok, first.sale_end, 0} == DateTime.from_iso8601("2018-04-03 04:50:00.000000Z")
  #     assert first.group == "TEST - REMOVE"
  #     assert first.status == "available"

  #     second = Enum.filter(tickets, fn(x) -> x.price == 15000 end) |> hd
  #     assert second.sale_start
  #     refute second.sale_end
  #     assert second.group == "TEST - REMOVEs"
  #     assert second.status == "available"

  #     listing = Repo.all(Listing) |> hd
  #     assert listing.status == "active"
  #     refute listing.pass_fees_to_buyer
  #   end

  #   test "it creates multiple from a class" do
  #     class = insert(:class)
  #     user = insert(:user)
  #     listings = [
  #       %{
  #         "end_time" => "",
  #         "slug" => "1e7210c0c8",
  #         "start_time" => "2018-12-02T05:50:00+01:00",
  #         "tickets" => [
  #           %{
  #             "description" => "",
  #             "group" => "TEST - REMOVE",
  #             "name" => "TEST - REMOVE",
  #             "price" => 10000,
  #             "quantity" => 1,
  #             "sale_end" => "2018-04-03T05:50:00+01:00",
  #             "sale_start" => "2018-04-02T05:40:00+01:00"
  #           },
  #           %{
  #             "description" => "",
  #             "group" => "TEST - REMOVEs",
  #             "name" => "TEST - REMOVEs",
  #             "price" => 15000,
  #             "quantity" => 1,
  #             "sale_end" => "",
  #             "sale_start" => ""
  #           }
  #         ]
  #       },
  #       %{
  #         "end_time" => "",
  #         "slug" => "1e7110c0c8",
  #         "start_time" => "2018-04-02T05:50:00+01:00",
  #         "tickets" => [
  #           %{
  #             "description" => "",
  #             "group" => "TEST - REMOVE",
  #             "name" => "TEST - REMOVE",
  #             "price" => 10000,
  #             "quantity" => 1,
  #             "sale_end" => "2018-04-03T05:50:00+01:00",
  #             "sale_start" => "2018-04-02T05:40:00+01:00"
  #           },
  #           %{
  #             "description" => "",
  #             "group" => "TEST - REMOVEs",
  #             "name" => "TEST - REMOVEs",
  #             "price" => 15000,
  #             "quantity" => 1,
  #             "sale_end" => "",
  #             "sale_start" => ""
  #           }
  #         ]
  #       }
  #     ]
  #     params = %{"user" => user, "class_id" => class.id, "title" => class.title, "description" => class.description, "listings" => listings}
  #     ListingsGenerator.create_from_class(params)

  #     tickets = Repo.all(Ticket)

  #     assert 4 == Enum.count(tickets)

  #     first = Enum.filter(tickets, fn(x) -> x.price == 10000 end) |> hd
  #     assert {:ok, first.sale_start, 0} == DateTime.from_iso8601("2018-04-02 04:40:00.000000Z")
  #     assert {:ok, first.sale_end, 0} == DateTime.from_iso8601("2018-04-03 04:50:00.000000Z")
  #     assert first.group == "TEST - REMOVE"
  #     assert first.status == "available"

  #     second = Enum.filter(tickets, fn(x) -> x.price == 15000 end) |> hd
  #     assert second.sale_start
  #     refute second.sale_end
  #     assert second.group == "TEST - REMOVEs"
  #     assert second.status == "available"

  #     Repo.all(Listing)
  #     |> Enum.each(fn(listing) ->
  #       assert listing.status == "active"
  #       assert listing.class_id == class.id
  #     end)
  #   end

  #   test "it creates with tickets" do
  #     class = insert(:class)
  #     user = insert(:user)
  #     params = %{
  #       "user" => user,
  #       "class_id" => class.id,
  #       "description" => "Jump head first into the wonderful worlds of sketch and improv comedy. This class is open to teens from the ages of 13 to 18. Absolutely no experience is needed. Students will explore the key tools behind both long and short form improvisation. We will play numerous games to help you sharpen your mind. We will then use improv as a springboard for writing basic comedy sketches- like those seen on SNL. We strive to create a safe, non-judgmental environment where teens can build confidence, make friends and most importantly... have fun.At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.",
  #       "listings" => [
  #         %{
  #           "end_time" => "",
  #           "slug" => "fcaea1ab45",
  #           "start_time" => "2018-03-09T01:00:00Z",
  #           "tickets" => [
  #             %{
  #               "description" => "Additional information",
  #               "group" => "TEST - REMOVE",
  #               "name" => "TEST - REMOVE",
  #               "price" => 10000,
  #               "quantity" => 1,
  #               "sale_end" => "",
  #               "sale_start" => "2018-03-08T12:00:00Z"
  #             }
  #           ]
  #         }
  #       ],
  #       "title" => "Improv for Teens"
  #     }

  #     ListingsGenerator.create_from_class(params)

  #     ticket =
  #       Repo.all(Ticket)
  #       |> hd

  #     listing =
  #       Repo.all(Listing)
  #       |> hd

  #     refute listing.end_at
  #   end

  #   test "it creates with end time" do
  #     class = insert(:class)
  #     user = insert(:user)
  #     params = %{
  #       "user" => user,
  #       "class_id" => class.id,
  #       "description" => class.description,
  #       "listings" => [
  #         %{
  #           "end_time" => "2018-03-31T22:55:00+01:00",
  #           "slug" => "fcaea1ab45",
  #           "start_time" => "2018-03-11T21:50:00Z",
  #            "tickets" => [
  #              %{
  #                "description" => "",
  #                "group" => "TEST - REMOVE",
  #                "name" => "TEST - REMOVE",
  #                "price" => 10000,
  #                "quantity" => 1,
  #                "sale_end" => "",
  #                "sale_start" => ""
  #               }
  #             ]
  #         }
  #       ],
  #       "title" => class.title
  #     }
  #     ListingsGenerator.create_from_class(params)

  #     listing =
  #       Repo.all(Listing)
  #       |> hd

  #     {:ok, ending, _} = DateTime.from_iso8601("2018-03-31T22:55:00.000000+01:00")
  #     assert listing.status == "active"
  #     assert listing.class_id == class.id
  #     assert listing.end_at == ending
  #   end
  # end
end
