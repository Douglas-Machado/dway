defmodule Dway.Parser.DataParser do
  alias Dway.Fleet.{Driver, Order}

  def parse_drivers_params(driver_params) do
    drivers =
      driver_params
      |> Enum.map(fn param -> Driver.changeset(%Driver{}, param) |> Driver.applied_changeset() end)
      |> Enum.reject(&is_nil/1)

    case drivers do
      [] -> {:error, []}
      _ -> {:ok, drivers}
    end
  end

  def parse_order_params(order_params) do
    case Order.changeset(%Order{}, order_params) |> Order.applied_changeset() do
      nil -> {:error, nil}
      order -> {:ok, order}
    end
  end
end
