# parser da order  - gerar a struct da order
defmodule Dway.Parser.Order do

  def get_order(order_params) do
    Haversine.distance(
      get_pickup_coord(order_params), get_delivery_coord(order_params)
      )
    # |> Rules.rule()
  end

  def get_pickup_coord(order_params) do
    pickup_coordinates = order_params["pickup"]["coordinates"]
    {pickup_coordinates["long"], pickup_coordinates["lat"]}
  end

  def get_delivery_coord(order_params) do
    delivery_coordinates = order_params["delivery"]["coordinates"]
    {delivery_coordinates["long"], delivery_coordinates["lat"]}
  end

end
