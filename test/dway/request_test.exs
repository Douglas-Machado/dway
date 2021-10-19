defmodule Dway.RequestTest do
  use Dway.DataCase, async: true

  alias Dway.Request

  describe "get_params/2" do
    test "when the params are valid, returns the route" do
      driver = %Dway.Fleet.Driver{
        coordinates: %{lat: -22.508229883387585, long: -44.093416921900584},
        distance_to_delivery: 2803.5628518888216,
        distance_to_pickup: 276.44614440930565,
        id: 2,
        index: 1,
        max_distance: 6000,
        modal: "m",
        name: "Douglas Martins"
      }

      order = %Dway.Fleet.Order{
        customer_name: "Theodora",
        delivery_coordinates: %{lat: -22.52219686435724, long: -44.10977748780379},
        id: "95436212",
        pickup_coordinates: %{lat: -22.50776369362348, long: -44.09077352792969},
        time_window: 1.8e3
      }

      response = Request.get_params(driver, order)

      assert {:ok,
              %Dway.Routing.Route{
                delivery_time: 387.7,
                driver_id: 2,
                id: nil,
                inserted_at: nil,
                order_id: "95436212",
                pickup_time: 118.6,
                polyline:
                  "lckhCx~blG`KjCm@jEsLaB`F}SeFsAgEqAf@}BhI~Bm@hCvAl@zQoBpFWh@Zp@hHuBJTxGx@|F{@jHlGz[lQtq@X`@|Fb@fBkBBaAv@CFp@vBpAxK`A",
                total_distance: 4817.0,
                total_time: 506.3
              }} = response
    end

    test "when the total time is higher than the time window, returns an error" do
      driver = %Dway.Fleet.Driver{
        coordinates: %{lat: -22.508229883387585, long: -44.093416921900584},
        distance_to_delivery: 2803.5628518888216,
        distance_to_pickup: 276.44614440930565,
        id: 2,
        index: 1,
        max_distance: 6000,
        modal: "m",
        name: "Douglas Martins"
      }

      order = %Dway.Fleet.Order{
        customer_name: "Theodora",
        delivery_coordinates: %{lat: -22.52219686435724, long: -44.10977748780379},
        id: "95436212",
        pickup_coordinates: %{lat: -22.50776369362348, long: -44.09077352792969},
        time_window: 300
      }

      response = Request.get_params(driver, order)

      assert {:error,
              "Não foi possível roteirizar: Tempo da rota excedido. Tempo estimado: 506.3s Tempo máximo: 300s"} =
               response
    end

    # test "when the total time is equal to zero, returns an OSRM error" do

    #   driver = %Dway.Fleet.Driver{
    #     coordinates: %{lat: -22.508229883387585, long: -44.093416921900584},
    #     distance_to_delivery: 2803.5628518888216,
    #     distance_to_pickup: 276.44614440930565,
    #     id: 2,
    #     index: 1,
    #     max_distance: 6000,
    #     modal: "m",
    #     name: "Douglas Martins"
    #   }

    #   order = %Dway.Fleet.Order{
    #     customer_name: "Theodora",
    #     delivery_coordinates: %{lat: -22.52219686435724, long: -44.10977748780379},
    #     id: "95436212",
    #     pickup_coordinates: %{lat: -22.50776369362348, long: -44.09077352792969},
    #     time_window: 300
    #   }

    #   response = Request.get_params(driver, order)

    #   assert {:error, "Não foi possível roteirizar - OSRM indisponível"} =
    #            response
    # end
  end
end
