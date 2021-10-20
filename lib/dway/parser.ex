defmodule Dway.Parser do
  @moduledoc """
    Filter the 'best' driver according to order requirements.
  """

  alias Dway.Parser.OrderParser
  alias Dway.Fleet.Driver

  @max_distance_biker 2000

  @doc """
    Return the driver at first index of the list, else return an error with an empty list

    ## params a list drivers structs and the order struct

    this function will first calculate the distancies to pickup and delivery from each driver,
    reject the drivers which have a maximum distance smaller than the order total distance;
    then it sort the list of drivers by modal, distance to pickup and index.
  """
  def get_driver_to_pickup_distance(drivers, order) do
    order_distance = OrderParser.get_order_distance(order)

    drivers
    |> get_drivers_params(order, order_distance)
    |> reject_drivers_by_max_distance()
    |> validate_order_skill(order)
    |> order_drivers_by_modal(order_distance)
    |> handle_response()
  end

  defp get_drivers_params(drivers, order, order_distance) do
    drivers
    |> Enum.map(fn %Driver{coordinates: %{lat: lat, long: long}} = driver ->
      distance_to_pickup = Haversine.distance({long, lat}, OrderParser.get_pickup_coord(order))
      distance_to_delivery = distance_to_pickup + order_distance

      Driver.change_distances(driver, %{
        distance_to_pickup: distance_to_pickup,
        distance_to_delivery: distance_to_delivery
      })
    end)
  end

  defp validate_order_skill(drivers, order) do
    case order.skill != nil do
      true -> filter_drivers_by_skill(drivers, order)
      false -> drivers
    end
  end

  defp filter_drivers_by_skill(drivers, order) do
    case Enum.reject(drivers, fn %Driver{skill: skill} -> skill != order.skill end) do
      [] -> {:error, "Nenhum driver apto para realizar essa entrega"}
      drivers -> drivers
    end
  end

  defp order_drivers_by_modal({:error, message}, _), do: {:error, message}

  defp order_drivers_by_modal(drivers, order_distance)
       when order_distance <= @max_distance_biker do
    drivers
    |> Enum.sort_by(&{&1.modal, &1.distance_to_pickup, &1.index})
  end

  defp order_drivers_by_modal(drivers, _order_distance) do
    drivers
    |> Enum.reject(fn %Driver{modal: modal} -> modal == "b" end)
    |> Enum.sort_by(&{&1.modal, &1.distance_to_pickup, &1.index})
  end

  defp reject_drivers_by_max_distance(drivers_list) do
    drivers_list
    |> Enum.reject(fn %Driver{
                        distance_to_delivery: distance_to_delivery,
                        max_distance: max_distance
                      } ->
      distance_to_delivery > max_distance
    end)
  end

  defp handle_response({:error, message}) do
    {:error, message}
  end

  defp handle_response([]) do
    {:error, "Sem drivers disponíveis"}
  end

  defp handle_response(drivers) do
    {:ok, Enum.at(drivers, 0)}
  end
end
