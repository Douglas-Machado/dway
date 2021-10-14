defmodule Dway.Fleet.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @require_params [:id, :time_window, :pickup_coordinates, :delivery_coordinates, :customer_name]

  @type t :: %__MODULE__{
          id: String.t(),
          customer_name: String.t(),
          time_window: Float.t(),
          pickup_coordinates: map(),
          delivery_coordinates: map()
        }

  @primary_key false
  embedded_schema do
    field :id, :string
    field :customer_name, :string
    field :time_window, :float
    field :pickup_coordinates, :map
    field :delivery_coordinates, :map
  end

  @spec changeset(
          Dway.Fleet.Order.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = order, attributes) do
    attributes = parser_coordinates_delivery(attributes)
    attributes = parser_coordinates_pickup(attributes)

    order
    |> cast(attributes, @require_params)
    |> validate_required(@require_params)
  end

  def applied_changeset(changeset) do
    apply_changes(changeset)
  end

  def parser_coordinates_pickup(
        %{"pickup" => %{"coordinates" => %{"long" => long, "lat" => lat}}} = attributes
      ) do
    Map.put(attributes, "pickup_coordinates", %{long: long, lat: lat})
  end

  def parser_coordinates_pickup(
        %{"pickup" => %{"coordinates" => %{"longitude" => long, "latitude" => lat}}} = attributes
      ) do
    Map.put(attributes, "pickup_coordinates", %{long: long, lat: lat})
  end

  def parser_coordinates_delivery(
        %{"delivery" => %{"coordinates" => %{"long" => long, "lat" => lat}}} = attributes
      ) do
    Map.put(attributes, "delivery_coordinates", %{long: long, lat: lat})
  end

  def parser_coordinates_delivery(
        %{"delivery" => %{"coordinates" => %{"longitude" => long, "latitude" => lat}}} =
          attributes
      ) do
    Map.put(attributes, "delivery_coordinates", %{long: long, lat: lat})
  end
end
