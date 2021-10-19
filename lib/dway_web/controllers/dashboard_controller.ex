defmodule DwayWeb.DashboardController do
  use DwayWeb, :controller

  alias Dway.Routing

  def show(conn, _params) do
    routes = Routing.list_routes()

    conn
    |> render("index.html", routes: routes)
  end
end
