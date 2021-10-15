defmodule Dway.Parser.DataParser do
  @moduledoc """
    Parse driver and order json into structs(embedded schema)
  """

  alias Dway.Fleet.{Driver, Order, Data}
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
