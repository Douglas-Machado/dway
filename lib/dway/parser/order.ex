# parser da order  - gerar a struct da order
defmodule Dway.Order do

  def get_order(order_params) do
    pickup_coordinates = order_params["pickup"]["coordinates"]
    pickup = {pickup_coordinates["lat"], pickup_coordinates["long"]}
    delivery_coordinates = order_params["delivery"]["coordinates"]
    delivery = {delivery_coordinates["lat"], delivery_coordinates["long"]}

    Haversine.distance(pickup, delivery)
    |> IO.inspect(label: "HAVERSINE")


  end

end
