#fazer o parser da lista de drivers e retornar a struct (dos drivers)
#lista de structs
defmodule Dway.Parser.Driver do

  def get_driver_coord(driver_params) do
    driver = Enum.at(driver_params, 0)
    {driver["coordinates"]["long"], driver["coordinates"]["lat"]}
  end
end
