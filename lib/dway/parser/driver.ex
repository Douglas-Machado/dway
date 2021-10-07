defmodule Dway.Parser.DriverParser do
  alias Dway.Fleet.Driver
  alias Dway.Fleet.Order
  alias Dway.Parser.OrderParser

  def get_driver_coord(driver_params) do
    driver_params
    |> Enum.map(fn param -> Driver.changeset(%Driver{}, param) |> Driver.applied_changeset() end)
  end

  def get_order_coord(order_params) do
  Order.changeset(%Order{}, order_params) |> Order.applied_changeset()
  end
end
