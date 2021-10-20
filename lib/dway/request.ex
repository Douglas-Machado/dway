defmodule Dway.Request do
  @moduledoc """
    Request to osrm api
  """

  alias Dway.Routing.Route

  @osrm_docker Application.get_env(:dway, :osrm_docker)
  @osrm Application.get_env(:dway, :osrm)

  @doc """
    Returns the struct route

    example:
    {
      "order_id": "string",
      "driver_id": "string (unique)",
      "total_time": "float",
      "pickup_time": "float",
      "delivery_time": "float",
      "total_distance": "float",
      "polyline": "string"
    }

    this function will make a request to osrm api and in case of sucess,
    it will validate if the route total time is greater than delivery maximum time and
    then insert the values in the %Route{}, else will show an error and its reason.

     ## OSRM

     Returns a map with osrm response body

     fields: distance, duration and polyline
  """
  def get_params(driver, order) do
    case request(driver, order) do
      {:ok, map} ->
        route =
          Route.changeset(
            %Route{
              order_id: order.id,
              order_pickup_coordinates: order.pickup_coordinates,
              order_delivery_coordinates: order.delivery_coordinates,
              driver_id: driver.id,
              driver_name: driver.name,
              modal: driver.modal,
              driver_coordinates: driver.coordinates
            },
            map
          )
          |> Route.applied_changeset()

        {:ok, route}

      {:error, message} ->
        {:error, message}
    end
  end

  defp request_osrm(string) do
    HTTPoison.start()

    case HTTPoison.get(@osrm_docker <> string <> "?geometries=polyline") do
      {:ok, %HTTPoison.Response{body: body}} ->
        {:ok, content} = Jason.decode(body, keys: :atoms)

        content.routes
        |> route_time_and_distance()
        |> hd()

      {:error, _content} ->
        {:ok, %HTTPoison.Response{body: body}} =
          HTTPoison.get(@osrm <> string <> "?geometries=polyline")

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
        "polyline" => el[:geometry],
        "total_distance" => el[:distance],
        "total_time" => el[:duration],
        "pickup_time" => Enum.at(el[:legs], 0)[:duration],
        "delivery_time" => Enum.at(el[:legs], 1)[:duration]
      }
    end)
  end

  defp validate_field(map) do
    total_time = map["total_time"]

    case total_time == 0 do
      true ->
        {:error, "Não foi possível roteirizar - OSRM indisponível"}

      _ ->
        map
    end
  end

  defp validate_time_window(map, order) do
    case is_tuple(map) do
      true ->
        {:error, "Não foi possível roteirizar - OSRM indisponível"}

      _ ->
        total_time = map["total_time"]

        case total_time <= order.time_window do
          true ->
            {:ok, map}

          _ ->
            {:error,
             "Não foi possível roteirizar: Tempo da rota excedido. Tempo estimado: #{total_time}s Tempo máximo: #{order.time_window}s"}
        end
    end
  end

  defp request(driver, order) do
    "#{driver.coordinates.long},#{driver.coordinates.lat};#{order.pickup_coordinates.long},#{order.pickup_coordinates.lat};#{order.delivery_coordinates.long},#{order.delivery_coordinates.lat}"
    |> request_osrm()
    |> validate_field()
    |> validate_time_window(order)
  end
end
