defmodule Dway.Parser.OrderParser do

  alias Dway.Fleet.Order
  def get_order_distance(order_params) do
    IO.inspect(order_params, label: "antes do haversine")
    Haversine.distance(
      get_pickup_coord(order_params),
      get_delivery_coord(order_params)
    )
    |> IO.inspect(label: "haversine")
  end

  def get_pickup_coord(order_params) do

    {order_params.pickup_coordinates[:long], order_params.pickup_coordinates[:lat]}

  end

  def get_delivery_coord(order_params) do
    {order_params.delivery_coordinates[:long], order_params.delivery_coordinates[:lat]}
  end
end
