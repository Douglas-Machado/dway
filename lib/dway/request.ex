defmodule Dway.Request do

  alias Dway.Routing.Route

  #@url "http://127.0.0.1:5000/route/v1/driving/"
   @u "http://router.project-osrm.org/route/v1/driving/"

  def get_params(driver, order_params) do
    pickup_long = order_params["pickup"]["coordinates"]["long"]
    pickup_lat = order_params["pickup"]["coordinates"]["lat"]
    delivery_long = order_params["delivery"]["coordinates"]["long"]
    delivery_lat = order_params["delivery"]["coordinates"]["lat"]

    params = "#{driver.coordinates.long},#{driver.coordinates.lat};#{pickup_long},#{pickup_lat};#{delivery_long},#{delivery_lat}"
    |> request_osrm()
    |> valid_time(order_params)
    Route.changeset(%Route{driver: driver.id}, params) |> Route.applied_changeset()
  end

  def request_osrm(string) do
    HTTPoison.start()
    #%{body: body} = HTTPoison.get!(@url <> string)
     %{body: body} = HTTPoison.get! @u <> string <> "?overview=false"
    {:ok, content} = Jason.decode(body, keys: :atoms)
    content.routes
    |> Enum.map(fn el ->
      %{
        "total_distance" => el[:distance],
        "total_time" => el[:duration],
        "pickup_time" => Enum.at(el[:legs], 0)[:duration],
        "delivery_time" => Enum.at(el[:legs], 1)[:duration]}
    end)
    |> hd()
  end
  def valid_time(map, order_params) do
    case map["total_time"] <= order_params["time_window"] do
      true -> map
      _ -> IO.puts("Não é possivel roteirizar")

    end

  end

end
