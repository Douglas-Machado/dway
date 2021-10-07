# receber o request da rota
# fazer o parser (converter a string do json pro map do elixir, validar os dados) do json
defmodule Dway.Parser do
  alias Dway.Parser.{DriverParser, OrderParser}
  alias Dway.Fleet.Driver

  @max_distance_biker 2000

  def get_driver_to_pickup_distance(drivers_params, order_params) do
    order = DriverParser.get_order_coord(order_params)
    order_distance = OrderParser.get_order_distance(order)

    DriverParser.get_driver_coord(drivers_params)
    |> Enum.map(fn %Driver{coordinates: %{lat: lat, long: long}} = driver ->
      distance_to_pickup = Haversine.distance({long, lat}, OrderParser.get_pickup_coord(order))
      distance_to_delivery = distance_to_pickup + order_distance

      Driver.change_distances(driver, %{
        distance_to_pickup: distance_to_pickup,
        distance_to_delivery: distance_to_delivery
      })
    end)
    |> Enum.reject(fn %Driver{
                        distance_to_delivery: distance_to_delivery,
                        max_distance: max_distance
                      } ->
      distance_to_delivery > max_distance
    end)
    |> order_drivers_by_modal(order_distance)
  end

  def order_drivers_by_modal(drivers, order_distance)
      when order_distance <= @max_distance_biker do
    drivers
    |> Enum.sort_by(&{&1.modal, &1.distance_to_pickup, &1.index})
  end

  def order_drivers_by_modal(drivers, _order_distance) do
    drivers
    |> Enum.reject(fn %Driver{modal: modal} -> modal == "b" end)
    |> Enum.sort_by(&{&1.modal, &1.distance_to_pickup, &1.index})
  end
end
