defmodule Dway.Parser.DataParserTest do
  use Dway.DataCase, async: true

  alias Dway.Parser.DataParser

  describe "parse_drivers_params/1" do
    test "when all params are valid, returns a list of drivers" do
      params = [
        %{
          "coordinates" => %{
            "lat" => -22.513476978859,
            "long" => -44.091791768114874
          },
          "id" => 1,
          "index" => 2,
          "max_distance" => 2000,
          "modal" => "b",
          "name" => "Julio de Jundiai",
          "skills" => 1
        },
        %{
          "coordinates" => %{
            "lat" => -22.508229883387585,
            "long" => -44.093416921900584
          },
          "id" => 2,
          "index" => 1,
          "max_distance" => 10_000,
          "modal" => "m",
          "name" => "Douglas Martins",
          "skill" => 1
        },
        %{
          "coordinates" => %{
            "lat" => -22.508229883387585,
            "long" => -44.093416921900584
          },
          "id" => 3,
          "index" => 10,
          "max_distance" => 10_000,
          "modal" => "m",
          "name" => "Arthur Obayashi",
          "skills" => 1
        }
      ]

      response = DataParser.parse_drivers_params(params)

      assert {:ok,
              [
                %Dway.Fleet.Driver{
                  coordinates: %{lat: -22.513476978859, long: -44.091791768114874},
                  distance_to_delivery: nil,
                  distance_to_pickup: nil,
                  id: 1,
                  index: 2,
                  max_distance: 2000,
                  modal: "b",
                  name: "Julio de Jundiai"
                },
                %Dway.Fleet.Driver{
                  coordinates: %{lat: -22.508229883387585, long: -44.093416921900584},
                  distance_to_delivery: nil,
                  distance_to_pickup: nil,
                  id: 2,
                  index: 1,
                  max_distance: 10_000,
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
                }
              ]} = response
    end

    test "when there are no params valid, returns an empty list" do
      params = [
        %{
          "coordinates" => %{},
          "id" => 1,
          "index" => 2,
          "max_distance" => 2000,
          "modal" => "b",
          "name" => "Julio de Jundiai"
        },
        %{
          "coordinates" => %{
            "lat" => -22.508229883387585
          },
          "id" => 2,
          "index" => 1,
          "max_distance" => 10_000,
          "modal" => "m",
          "name" => "Douglas Martins"
        },
        %{
          "coordinates" => %{
            "lat" => -22.508229883387585,
            "long" => -44.093416921900584
          },
          "id" => 3,
          "max_distance" => 10_000,
          "modal" => "m",
          "name" => "Arthur Obayashi"
        }
      ]

      response = DataParser.parse_drivers_params(params)

      assert {:error, "Nenhum driver encontrado"} = response
    end
  end

  describe "parse_order_params/1" do
    test "when the order params are valid, returns the order" do
      params = %{
        "customer_name" => "Theodora",
        "delivery" => %{
          "coordinates" => %{
            "lat" => -22.52219686435724,
            "long" => -44.10977748780379
          }
        },
        "id" => "95436212",
        "pickup" => %{
          "coordinates" => %{
            "lat" => -22.50776369362348,
            "long" => -44.09077352792969
          }
        },
        "time_window" => 1800
      }

      response = DataParser.parse_order_params(params)

      assert {:ok,
              %Dway.Fleet.Order{
                customer_name: "Theodora",
                delivery_coordinates: %{lat: -22.52219686435724, long: -44.10977748780379},
                id: "95436212",
                pickup_coordinates: %{lat: -22.50776369362348, long: -44.09077352792969},
                time_window: 1.8e3
              }} = response
    end

    test "when the are some error, returns an empty list" do
      params = %{
        "customer_name" => "Theodora",
        "delivery" => %{
          "coordinates" => %{
            "lat" => -22.52219686435724,
            "long" => -44.10977748780379
          }
        },
        "id" => "95436212",
        "pickup" => %{
          "coordinates" => %{
            "lat" => -22.50776369362348,
            "long" => -44.09077352792969
          }
        },
        "time_window" => nil
      }

      response = DataParser.parse_order_params(params)

      assert {:error, "dados da entrega inválidos"} = response
    end
  end
end
