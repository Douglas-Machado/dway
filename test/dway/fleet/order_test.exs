defmodule Dway.Fleet.OrderTest do
  use Dway.DataCase, async: true

  alias Dway.Fleet.Order
  alias Ecto.Changeset

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      order = %Dway.Fleet.Order{
        customer_name: nil,
        delivery_coordinates: nil,
        id: nil,
        pickup_coordinates: nil,
        time_window: nil
      }

      attributes = %{
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
        "skill" => 1,
        "time_window" => 1800
      }

      response = Order.changeset(order, attributes)

      assert %Changeset{changes: %{customer_name: "Theodora"}, valid?: true} = response
    end

    test "when there are some error, returns a invalid changeset" do
      order = %Dway.Fleet.Order{
        customer_name: nil,
        delivery_coordinates: nil,
        id: nil,
        pickup_coordinates: nil,
        time_window: nil
      }

      attributes = %{
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

      response = Order.changeset(order, attributes)

      expected_response = %{time_window: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end
end
