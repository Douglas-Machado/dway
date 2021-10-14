defmodule Dway.Parser.DataParser do
  @moduledoc """
    Parse driver and order json into structs(embedded schema)
  """

  alias Dway.Fleet.{Driver, Order, Data}

  def parse_params(route_params) do
    case Data.changeset(route_params) do
      nil -> {:error, nil}
      params -> {:ok, params}
    end
  end

  @doc """
    validate drivers params and reject driver with any nil field
  """
  def parse_drivers_params(driver_params) do
    drivers =
      driver_params
      |> Enum.map(fn param -> Driver.changeset(%Driver{}, param) |> Driver.applied_changeset() end)
      |> Enum.reject(&is_nil/1)

    case drivers do
      [] -> {:error, [], message: "Nenhum driver encontrado"}
      _ -> {:ok, drivers}
    end
    |> IO.inspect()
  end

  @doc """
  validate order
  """
  def parse_order_params(order_params) do
    case Order.changeset(%Order{}, order_params) |> Order.applied_changeset() do
      nil -> {:error, nil}
      order -> {:ok, order}
    end
  end
end
