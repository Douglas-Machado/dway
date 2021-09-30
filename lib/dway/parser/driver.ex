#fazer o parser da lista de drivers e retornar a struct (dos drivers)
#lista de structs
defmodule Dway.Parser.Driver do

  alias Dway.Parser.Order

  def get_driver_coord(driver_params) do
    driver_params
      |> Enum.map(&({&1["coordinates"]["long"], &1["coordinates"]["lat"], &1["id"], &1["modal"], &1["index"]}))
  end

  # def get_driver_modal(drivers_params, order_params) do
  #   type = Order.get_order(order_params)
  #   drivers_params
  #     |>Enum.filter(&(&1["modal"] == type))
  #     |> get_driver_coord()
  # end

end
