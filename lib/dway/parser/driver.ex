#fazer o parser da lista de drivers e retornar a struct (dos drivers)
#lista de structs
defmodule Dway.Parser.Driver do

  def get_driver_coord(driver_params) do
    driver_params
      |> Enum.map(&(&1["coordinates"]))
      |> Enum.map(&({&1["long"], &1["lat"]}))
  end
end
