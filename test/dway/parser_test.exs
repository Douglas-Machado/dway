defmodule Dway.ParserTest do
  use Dway.DataCase, async: true
  alias Dway.Parser

  describe "get_driver_to_pickup_distance/2" do
    test "when all params are valid, the first driver in the list" do
      drivers = [
        %Dway.Fleet.Driver{
          coordinates: %{lat: -22.508229883387585, long: -44.093416921900584},
          distance_to_delivery: nil,
          distance_to_pickup: nil,
          id: 2,
          index: 1,
          max_distance: 3000,
          modal: "m",
          name: "Douglas Martins"
        },
        %Dway.Fleet.Driver{
          coordinates: %{lat: -22.508229883387585, long: -44.093416921900584},
          distance_to_delivery: nil,
          distance_to_pickup: nil,
          id: 3,
          index: 10,
          max_distance: 10_000,
          modal: "m",
          name: "Arthur Obayashi"
        },
        %Dway.Fleet.Driver{
          coordinates: %{lat: -22.504969210257798, long: -44.088185323488986},
          distance_to_delivery: nil,
          distance_to_pickup: nil,
          id: 4,
          index: 8,
          max_distance: 10_000,
          modal: "m",
          name: "Eduardo Ferrazoli"
        }
      ]

      order = %Dway.Fleet.Order{
        customer_name: "Theodora",
        delivery_coordinates: %{lat: -22.52219686435724, long: -44.10977748780379},
        id: "95436212",
        pickup_coordinates: %{lat: -22.50776369362348, long: -44.09077352792969},
        time_window: 1.8e3
      }

      response = Parser.get_driver_to_pickup_distance(drivers, order)

      assert {:ok,
              %Dway.Fleet.Driver{
                coordinates: %{lat: -22.508229883387585, long: -44.093416921900584},
                distance_to_delivery: 2803.5628518888216,
                distance_to_pickup: 276.44614440930565,
                id: 2,
                index: 1,
                max_distance: 3000,
                modal: "m",
                name: "Douglas Martins"
              }} = response
    end

    test "when there are some error, returns an error" do
      drivers = [
        %Dway.Fleet.Driver{
          coordinates: %{lat: -22.508229883387585, long: -44.093416921900584},
          distance_to_delivery: nil,
          distance_to_pickup: nil,
          id: 2,
          index: 1,
          max_distance: 10,
          modal: "m",
          name: "Douglas Martins"
        },
        %Dway.Fleet.Driver{
          coordinates: %{lat: -22.508229883387585, long: -44.093416921900584},
          distance_to_delivery: nil,
          distance_to_pickup: nil,
          id: 3,
          index: 10,
          max_distance: 10,
          modal: "m",
          name: "Arthur Obayashi"
        },
        %Dway.Fleet.Driver{
          coordinates: %{lat: -22.504969210257798, long: -44.088185323488986},
          distance_to_delivery: nil,
          distance_to_pickup: nil,
          id: 4,
          index: 8,
          max_distance: 10,
          modal: "m",
          name: "Eduardo Ferrazoli"
        }
      ]

      order = %Dway.Fleet.Order{
        customer_name: "Theodora",
        delivery_coordinates: %{lat: -22.52219686435724, long: -44.10977748780379},
        id: "95436212",
        pickup_coordinates: %{lat: -22.50776369362348, long: -44.09077352792969},
        time_window: 1.8e3
      }

      response = Parser.get_driver_to_pickup_distance(drivers, order)

      assert {:error, "Sem drivers disponíveis"} = response
    end
  end
end
