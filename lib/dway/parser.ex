# receber o request da rota
# fazer o parser (converter a string do json pro map do elixir, validar os dados) do json
defmodule Dway.Parser do
  def parse_route(params) do


  end


  def get_order_distance(input) do
    input.order.pickup.coordinates
    |> Enum.at(2)
  end
end
