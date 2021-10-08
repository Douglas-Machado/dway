defmodule Dway.Parser.DriverParser do
  alias Dway.Fleet.Driver
  alias Dway.Fleet.Order

  def parse_driver_params(driver_params) do
    driver_params
    |> Enum.map(fn param -> Driver.changeset(%Driver{}, param) |> Driver.applied_changeset() end)
  end

  def parse_order_params(order_params) do
    Order.changeset(%Order{}, order_params) |> Order.applied_changeset()
  end
end
