defmodule Dway.Request do
  alias Dway.Routing.Route
  alias Dway.Parser.DriverParser

  @url_docker "http://127.0.0.1:5000/route/v1/driving/"
  @url "http://router.project-osrm.org/route/v1/driving/"

  def get_params(driver, order_params) do
    order = DriverParser.parse_order_params(order_params)

    params =
      "#{driver.coordinates.long},#{driver.coordinates.lat};#{order.pickup_coordinates.long},#{order.pickup_coordinates.lat};#{order.delivery_coordinates.long},#{order.delivery_coordinates.lat}"
      |> request_osrm()
      |> valid_time(order_params)

    Route.changeset(%Route{driver: driver.id, order_id: order.id}, params) |> Route.applied_changeset()
  end

  def request_osrm(string) do
    HTTPoison.start()
    with {:ok, %HTTPoison.Response{body: body}} <- HTTPoison.get(@url_docker <> string) do
    {:ok, content} = Jason.decode(body, keys: :atoms)

    content.routes
    |> route_time_and_distance()
    |> hd()
    else
      {:error, _content} -> {:ok, %HTTPoison.Response{body: body}}  = HTTPoison.get(@url <> string <> "?overview=false")

      {:ok, content} = Jason.decode(body, keys: :atoms)

    content.routes
    |> route_time_and_distance()
    |> hd()
    end
  end

  def valid_time(map, order_params) do
    case map["total_time"] <= order_params["time_window"] do
      true -> map
      _ -> IO.puts("Não é possivel roteirizar")
    end
  end

  def route_time_and_distance(route) do
    route
    |> Enum.map(fn el ->
      %{
        "total_distance" => el[:distance],
        "total_time" => el[:duration],
        "pickup_time" => Enum.at(el[:legs], 0)[:duration],
        "delivery_time" => Enum.at(el[:legs], 1)[:duration]
      }
    end)
  end
end
