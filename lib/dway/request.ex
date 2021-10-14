defmodule Dway.Request do
  alias Dway.Routing.Route

  @osrm_docker Application.get_env(:dway, :osrm_docker)
  @osrm Application.get_env(:dway, :osrm)

  def get_params(driver, order) do
    case request(driver, order) do
      {:ok, map} ->
        route =
          Route.changeset(%Route{order_id: order.id, driver_id: driver.id}, map)
          |> Route.applied_changeset()

        {:ok, route}

      {:error, message} ->
        {:error, message}
    end
  end

  def request_osrm(string) do
    HTTPoison.start()

    with {:ok, %HTTPoison.Response{body: body}} <- HTTPoison.get(@osrm_docker <> string) do
      {:ok, content} = Jason.decode(body, keys: :atoms)

      content.routes
      |> route_time_and_distance()
      |> hd()
    else
      {:error, _content} ->
        {:ok, %HTTPoison.Response{body: body}} =
          HTTPoison.get(@osrm <> string <> "?overview=false")

        {:ok, content} = Jason.decode(body, keys: :atoms)

        content.routes
        |> route_time_and_distance()
        |> hd()

      _ ->
        {:error, "Não foi possível roteirizar - OSRM indisponível"}
    end
  end

  defp route_time_and_distance(route) do
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

  def validate_time_window(map, order) do
    total_time = map["total_time"]

    case total_time <= order.time_window do
      true ->
        {:ok, map}

      _ ->
        {:error,
         "Não foi possível roteirizar: Tempo da rota excedido. Tempo estimado: #{total_time}s Tempo máximo: #{order.time_window}s"}
    end
  end

  defp request(driver, order) do
    IO.inspect(order, label: "ORDER")

    "#{driver.coordinates.long},#{driver.coordinates.lat};#{order.pickup_coordinates.long},#{order.pickup_coordinates.lat};#{order.delivery_coordinates.long},#{order.delivery_coordinates.lat}"
    |> request_osrm()
    |> validate_time_window(order)
  end
end
