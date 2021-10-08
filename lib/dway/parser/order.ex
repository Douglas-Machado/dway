defmodule Dway.Parser.OrderParser do
  def get_order_distance(order_params) do
    Haversine.distance(
      get_pickup_coord(order_params),
      get_delivery_coord(order_params)
    )
  end

  def get_pickup_coord(order_params) do
    {order_params.pickup_coordinates[:long], order_params.pickup_coordinates[:lat]}
  end

  def get_delivery_coord(order_params) do
    {order_params.delivery_coordinates[:long], order_params.delivery_coordinates[:lat]}
  end
end
