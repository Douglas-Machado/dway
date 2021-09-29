#fazer o parser da lista de drivers e retornar a struct (dos drivers)
#lista de structs
defmodule Dway.Parser.Driver do

  def get_driver_coord(driver_params) do
    driver_params
      |> Enum.map(&({&1["coordinates"]["long"], &1["coordinates"]["lat"]}))
  end

  def get_driver_modal(drivers_params) do
    drivers_params
      |>Enum.filter(&(&1["modal"] == "b"))
      |> get_driver_coord()
  end
end
