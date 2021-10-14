defmodule Dway.Parser.DataParser do
  alias Dway.Fleet.{Driver, Order, Data}

  def parse_params(route_params) do
    case Data.changeset(route_params) do
      nil -> {:error, nil}
      params -> {:ok, params}
    end
  end

  def parse_drivers_params(driver_params) do
    drivers =
      driver_params
      |> Enum.map(fn param -> Driver.changeset(%Driver{}, param) |> Driver.applied_changeset() end)
      |> Enum.reject(&is_nil/1)

    case drivers do
      [] -> {:error, [], message: "Nenhum driver encontrado"}
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
