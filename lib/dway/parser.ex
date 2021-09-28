# receber o request da rota
# fazer o parser (converter a string do json pro map do elixir, validar os dados) do json
defmodule Dway.Parser do
  alias Dway.Parser.{Driver, Order}

  def get_driver_to_pickup_distance(drivers, order) do
    Haversine.distance(Driver.get_driver_coord(drivers), Order.get_pickup_coord(order))
    |> IO.inspect(label: "pickup_distance")
  end
end
