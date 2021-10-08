defmodule DwayWeb.RouteController do
  use DwayWeb, :controller

  alias Dway.Routing
  alias Dway.Routing.Route
  alias Dway.Parser.Api
  alias Dway.{Parser, Request}

  action_fallback DwayWeb.FallbackController

  def index(conn, _params) do
    routes = Routing.list_routes()
    render(conn, "index.json", routes: routes)
  end

  def create(conn, route_params) do
    Api.validate(route_params["api_token"])

    driver =
      Parser.get_driver_to_pickup_distance(route_params["drivers"], route_params["order"])
      |> Enum.at(0)
      |> Request.get_params(route_params["order"])

    conn
    |> json(driver)

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
