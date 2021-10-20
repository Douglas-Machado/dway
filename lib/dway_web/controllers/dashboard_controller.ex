defmodule DwayWeb.DashboardController do
  use DwayWeb, :controller

  alias Dway.Routing

  def show(conn, _params) do
    routes = Routing.list_routes()

    conn
    |> render("index.html", routes: routes)
  end

  def create(conn, params) do
    current_route = Routing.get_route(params["route_id"])

    polyline =
      Polyline.decode(current_route.polyline)
      |> Enum.map(fn {long, lat} -> [lat, long] end)

    conn
    |> render("map.html", route: current_route, polyline: polyline)
  end
end
