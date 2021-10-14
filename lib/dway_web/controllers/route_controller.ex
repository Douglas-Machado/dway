defmodule DwayWeb.RouteController do
  use DwayWeb, :controller

  alias Dway.Routing
  alias Dway.Routing.Route
  alias Dway.Parser.{Api, DataParser}
  alias Dway.{Parser, Request}
  alias DwayWeb.FallbackController

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    routes = Routing.list_routes()
    render(conn, "index.json", routes: routes)
  end

  @spec create(Plug.Conn.t(), nil | maybe_improper_list | map) :: Plug.Conn.t()
  def create(conn, route_params) do
    with {:ok, _content} <- Api.validate(route_params["api_token"]),
         {:ok, drivers} <- DataParser.parse_drivers_params(route_params["drivers"]),
         {:ok, order} <- DataParser.parse_order_params(route_params["order"]),
         {:ok, driver} <- Parser.get_driver_to_pickup_distance(drivers, order),
         {:ok, route} <- Request.get_params(driver, order) do
      Routing.insert_route(route)

      conn
      |> json(route)
    else
      {:error, message} -> FallbackController.call(conn, {:error, message})
      {:error, []} -> FallbackController.call(conn, {:ok, :empty_drivers})
      {:ok, nil} -> FallbackController.call(conn, {:ok, :empty_order})
    end

    # with {:ok, %Route{} = route} <- Routing.create_route(route_params) do
    #   conn
    #   |> put_status(:created)
    #   |> put_resp_header("location", Routes.route_path(conn, :show, route))
    #   |> render("show.json", route: route)
    # end
  end

  def show(conn, %{"id" => id}) do
    route = Routing.get_route!(id)
    render(conn, "show.json", route: route)
  end

  def update(conn, %{"id" => id, "route" => route_params}) do
    route = Routing.get_route!(id)

    with {:ok, %Route{} = route} <- Routing.update_route(route, route_params) do
      render(conn, "show.json", route: route)
    end
  end

  def delete(conn, %{"id" => id}) do
    route = Routing.get_route!(id)

    with {:ok, %Route{}} <- Routing.delete_route(route) do
      send_resp(conn, :no_content, "")
    end
  end
end
