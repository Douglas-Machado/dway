defmodule Dway.Parser.OrderParser do
  def get_order_distance(order_params) do
    Haversine.distance(
      get_pickup_coord(order_params),
      get_delivery_coord(order_params)
    )
  end

  def get_pickup_coord(order_params) do
    pickup_coordinates = %Order{pickup_coordinates: %{pickup_lat: pickup_lat, pickup_long: pickup_long}}
  #   pickup_coordinates = order_params["pickup"]["coordinates"]
  #   {pickup_coordinates["long"], pickup_coordinates["lat"]}
  end

  def get_delivery_coord(order_params) do
    delivery_coordinates = %Order{delivery_coordinates: %{delivery_lat: delivery_lat, delivery_long: delivery_long}}

    # delivery_coordinates = order_params["delivery"]["coordinates"]
    # {delivery_coordinates["long"], delivery_coordinates["lat"]}
  end
end
