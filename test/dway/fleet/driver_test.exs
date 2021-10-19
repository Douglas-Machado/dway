defmodule Dway.Fleet.DriverTest do
  use Dway.DataCase, async: true

  alias Dway.Fleet.Driver
  alias Ecto.Changeset

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      driver = %Dway.Fleet.Driver{
        coordinates: nil,
        distance_to_delivery: nil,
        distance_to_pickup: nil,
        id: nil,
        index: nil,
        max_distance: nil,
        modal: nil,
        name: nil
      }

      attributes = %{
        "coordinates" => %{"lat" => -22.513476978859, "long" => -44.091791768114874},
        "id" => 1,
        "index" => 2,
        "max_distance" => 2000,
        "modal" => "b",
        "name" => "Julio de Jundiai",
        "skills" => [%{"skill" => "string"}]
      }

      response = Driver.changeset(driver, attributes)

      assert %Changeset{changes: %{modal: "b"}, valid?: true} = response
    end

    test "when there are some error, returns a invalid changeset" do
      driver = %Dway.Fleet.Driver{
        coordinates: nil,
        distance_to_delivery: nil,
        distance_to_pickup: nil,
        id: nil,
        index: nil,
        max_distance: nil,
        modal: nil,
        name: nil
      }

      attributes = %{
        "coordinates" => %{"lat" => -22.513476978859, "long" => -44.091791768114874},
        "id" => 1,
        "index" => 2,
        "max_distance" => 2000,
        "modal" => nil,
        "name" => "Julio de Jundiai",
        "skills" => [%{"skill" => "string"}]
      }

      response = Driver.changeset(driver, attributes)

      expected_response = %{modal: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end
end
