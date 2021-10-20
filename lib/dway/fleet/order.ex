defmodule Dway.Fleet.Order do
  @moduledoc """
    Order schema and validations
  """

  use Ecto.Schema
  import Ecto.Changeset

  @order_params [
    :id,
    :time_window,
    :pickup_coordinates,
    :delivery_coordinates,
    :customer_name,
    :skill
  ]

  @require_params [
    :id,
    :time_window,
    :pickup_coordinates,
    :delivery_coordinates,
    :customer_name
  ]

  @type t :: %__MODULE__{
          id: String.t(),
          customer_name: String.t(),
          time_window: Float.t(),
          pickup_coordinates: map(),
          delivery_coordinates: map(),
          skill: Integer.t()
        }

  @primary_key false
  embedded_schema do
    field :id, :string
    field :customer_name, :string
    field :time_window, :float
    field :pickup_coordinates, :map
    field :delivery_coordinates, :map
    field :skill, :integer
  end

  @spec changeset(
          Dway.Fleet.Order.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = order, attributes) do
    attributes = parser_coordinates_delivery(attributes)

    attributes = parser_coordinates_pickup(attributes)

    order
    |> cast(attributes, @order_params)
    |> validate_required(@require_params)
  end

  @doc """
    case %Ecto.Changeset{} has any invalid or empty field, it will returns nil
  """
  @spec applied_changeset(Ecto.Changeset.t()) :: nil | map
  def applied_changeset(%Ecto.Changeset{valid?: false}) do
    nil
  end

  def applied_changeset(changeset) do
    apply_changes(changeset)
  end

  defp parser_coordinates_pickup(%{"pickup" => %{"coordinates" => coordinates}} = attributes)
       when coordinates in [nil, %{}] do
    Map.put(attributes, "pickup_coordinates", nil)
  end

  defp parser_coordinates_pickup(
         %{"pickup" => %{"coordinates" => %{"long" => long, "lat" => lat}}} = attributes
       )
       when long == nil or lat == nil do
    Map.put(attributes, "pickup_coordinates", nil)
  end

  defp parser_coordinates_pickup(
         %{"pickup" => %{"coordinates" => %{"long" => long, "lat" => lat}}} = attributes
       ) do
    with true <- is_float(long),
         true <- is_float(lat) do
      Map.put(attributes, "pickup_coordinates", %{long: long, lat: lat})
    else
      false -> Map.put(attributes, "pickup_coordinates", nil)
    end
  end

  defp parser_coordinates_pickup(
         %{"pickup" => %{"coordinates" => %{"longitude" => long, "latitude" => lat}}} = attributes
       ) do
    Map.put(attributes, "pickup_coordinates", %{long: long, lat: lat})
  end

  defp parser_coordinates_pickup(%{"pickup" => %{"coordinates" => _}} = attributes) do
    Map.put(attributes, "pickup_coordinates", nil)
  end

  defp parser_coordinates_pickup(_ = attributes) do
    Map.put(attributes, "pickup_coordinates", nil)
  end

  defp parser_coordinates_delivery(%{"delivery" => %{"coordinates" => coordinates}} = attributes)
       when coordinates in [nil, %{}] do
    Map.put(attributes, "delivery_coordinates", nil)
  end

  defp parser_coordinates_delivery(
         %{"delivery" => %{"coordinates" => %{"long" => long, "lat" => lat}}} = attributes
       )
       when long == nil or lat == nil do
    Map.put(attributes, "delivery_coordinates", nil)
  end

  defp parser_coordinates_delivery(
         %{"delivery" => %{"coordinates" => %{"long" => long, "lat" => lat}}} = attributes
       ) do
    with true <- is_float(long),
         true <- is_float(lat) do
      Map.put(attributes, "delivery_coordinates", %{long: long, lat: lat})
    else
      false -> Map.put(attributes, "delivery_coordinates", nil)
    end
  end

  defp parser_coordinates_delivery(
         %{"delivery" => %{"coordinates" => %{"longitude" => long, "latitude" => lat}}} =
           attributes
       ) do
    Map.put(attributes, "delivery_coordinates", %{long: long, lat: lat})
  end

  defp parser_coordinates_delivery(%{"delivery" => %{"coordinates" => _}} = attributes) do
    Map.put(attributes, "delivery_coordinates", nil)
  end

  defp parser_coordinates_delivery(_ = attributes) do
    Map.put(attributes, "delivery_coordinates", nil)
  end
end
