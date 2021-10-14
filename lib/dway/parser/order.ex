defmodule Dway.Parser.OrderParser do
  @moduledoc """
    Calculates the distance between pickup and delivery
  """

  def get_order_distance(order) do
    Haversine.distance(
      get_pickup_coord(order),
      get_delivery_coord(order)
    )
  end

  def get_pickup_coord(order) do
    {order.pickup_coordinates[:long], order.pickup_coordinates[:lat]}
  end

  def get_delivery_coord(order) do
    {order.delivery_coordinates[:long], order.delivery_coordinates[:lat]}
  end
end
