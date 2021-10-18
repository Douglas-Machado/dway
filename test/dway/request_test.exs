defmodule Dway.RequestTest do

  use Dway.DataCase, async: true

  alias Dway.Request

  @osrm_docker Application.get_env(:dway, :osrm_docker)
  @osrm Application.get_env(:dway, :osrm)

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

      assert {:ok, %Dway.Routing.Route{delivery_time: 387.7, driver_id: 2, id: nil, inserted_at: nil, order_id: "95436212", pickup_time: 118.6, polyline: "lckhCx~blG`KjCm@jEsLaB`F}SeFsAgEqAf@}BhI~Bm@hCvAl@zQoBpFWh@Zp@hHuBJTxGx@|F{@jHlGz[lQtq@X`@|Fb@fBkBBaAv@CFp@vBpAxK`A", total_distance: 4817.0, total_time: 506.3}} = response

    end
 # TESTAR CASO DE ERRO
  end

  end
