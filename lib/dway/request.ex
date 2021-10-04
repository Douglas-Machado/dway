defmodule Dway.Request do

  @url "http://127.0.0.1:5000/route/v1/driving/"
  # @u "http://router.project-osrm.org/route/v1/driving/"

  def get_params(driver, order_params) do
    pickup_long = order_params["pickup"]["coordinates"]["long"]
    pickup_lat = order_params["pickup"]["coordinates"]["lat"]
    delivery_long = order_params["delivery"]["coordinates"]["long"]
    delivery_lat = order_params["delivery"]["coordinates"]["lat"]

    string =
      "#{driver.coordinates.long},#{driver.coordinates.lat};#{pickup_long},#{pickup_lat};#{delivery_long},#{delivery_lat}"

    request_osrm(string)
  end

  def request_osrm(string) do
    IO.inspect(string, label: "string")
    HTTPoison.start()
    %{body: body} = HTTPoison.get!(@url <> string)
    # %{body: body} = HTTPoison.get! @u <> string <> "?overview=false"
    {:ok, content} = Jason.decode(body, keys: :atoms)
    IO.inspect(content)
    content.routes
    |> Enum.map(fn el ->
      %{
        "total_time" => el[:duration],
        "time_to_pickup" => Enum.at(el[:legs], 0)[:duration],
        "time_to_delivery" => Enum.at(el[:legs], 1)[:duration] }
    end)
  end
end
