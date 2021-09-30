# parser da order  - gerar a struct da order
defmodule Dway.Parser.Order do

  @max_distance_biker 2000

  def get_order(order_params) do
    delivery_distance = Haversine.distance(
      get_pickup_coord(order_params), get_delivery_coord(order_params)
      )
      cond do
        delivery_distance > @max_distance_biker -> "m"
        true -> "b"
      end

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
