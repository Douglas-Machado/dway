# receber o request da rota
# fazer o parser (converter a string do json pro map do elixir, validar os dados) do json
defmodule Dway.Parser do
  alias Dway.Parser.{Driver, Order}

  def get_driver_to_pickup_distance(drivers, order) do
    mapa = Driver.get_driver_coord(drivers)
      |> Enum.map(fn {long, lat, driver_id, modal, index} -> {Haversine.distance({long, lat}, Order.get_pickup_coord(order)), driver_id, modal, index} end)
      |> Enum.map(fn {distance_to_pickup, driver_id, modal, index} -> {distance_to_pickup + Order.get_order(order), driver_id, modal, index} end)

    case Enum.filter(mapa, fn {_total_distance, _driver_id, modal, _index} -> modal == "b" end) do
      [] -> Enum.filter(mapa, fn {_total_distance, _driver_id, modal, _index} -> modal == "m" end)
      |> IO.inspect(label: "moto")
          |> order_drivers()
      list -> IO.inspect(list, label: "bike")
      order_drivers(list)

    end
      |> IO.inspect(label: "Mapa")
    #   Enum.reduce(mapa, {99999999, "ss", "aa"}, fn {distancia, _id, _modal} = driver, {acc_distancia, _, _} = acc -> if distancia < acc_distancia do
    #     driver
    #   else
    #     acc
    #   end
    # end )

  end

  def order_drivers(params) do
    params
      |> Enum.sort()
      |> IO.inspect(label: "ordem aqui")
  end

end