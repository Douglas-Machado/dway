defmodule Dway.Parser.DriverParser do

  alias Dway.Fleet.Driver

  def get_driver_coord(driver_params) do
    driver_params
    |> Enum.map(fn param -> Driver.changeset(%Driver{}, param) |> Driver.applied_changeset() end)
  end
end
