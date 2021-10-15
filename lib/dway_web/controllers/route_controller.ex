defmodule DwayWeb.RouteController do
  @moduledoc """
    The entry point of application
  """

  use DwayWeb, :controller

  alias Dway.Routing
  alias Dway.Routing.Route
  alias Dway.Parser.{Api, DataParser}
  alias Dway.{Parser, Request}
  alias DwayWeb.FallbackController

  action_fallback FallbackController

  @doc """
    Returns the route json if all conditions match

    ## params

    *conn
    *route_params - json with driver and order params
  """
  # @spec create(Plug.Conn.t(), nil | maybe_improper_list | map) :: Plug.Conn.t()
  def create(conn, route_params) do
    with {:ok, drivers} <- DataParser.parse_drivers_params(route_params["drivers"]),
         {:ok, order} <- DataParser.parse_order_params(route_params["order"]),
         {:ok, driver} <- Parser.get_driver_to_pickup_distance(drivers, order),
         {:ok, route} <- Request.get_params(driver, order) do
      Routing.insert_route(route)

      conn
      |> json(route)
    else
      {:error, message} -> FallbackController.call(conn, {:error, message})
      {:error, [], message} -> FallbackController.call(conn, {:ok, :empty_drivers, message})
      {:ok, nil, message} -> FallbackController.call(conn, {:ok, :empty_order, message})
    end
  end
end
