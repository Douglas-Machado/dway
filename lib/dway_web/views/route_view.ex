defmodule DwayWeb.RouteView do
  use DwayWeb, :view
  alias DwayWeb.RouteView

  def render("index.json", %{routes: routes}) do
    %{data: render_many(routes, RouteView, "route.json")}
  end

  def render("show.json", %{route: route}) do
    %{data: render_one(route, RouteView, "route.json")}
  end

  def render("route.json", %{route: route}) do
    %{
      id: route.id,
      api_token: route.api_token,
      drivers: route.drivers,
      order: route.order
    }
  end
end
