defmodule Dway.Fleet.Driver do
  use Ecto.Schema
  import Ecto.Changeset

  @require_params [:id, :name, :max_distance, :coordinates, :modal, :index]

  @fields_to_export ~w(id name modal index distance_to_delivery distance_to_pickup)a
  @derive {Jason.Encoder, only: @fields_to_export}

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          max_distance: Integer.t(),
          coordinates: map(),
          modal: String.t(),
          index: Integer.t(),
          distance_to_pickup: Float.t(),
          distance_to_delivery: Float.t()
        }

  @primary_key false
  embedded_schema do
    field :id, :string
    field :name, :string
    field :max_distance, :integer
    field :coordinates, :map
    field :modal, :string
    field :index, :integer
    field :distance_to_pickup, :float
    field :distance_to_delivery, :float
  end

  @spec changeset(
          Dway.Fleet.Driver.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = driver, attributes) do
    attributes = parser_coordinates(attributes)

    driver
    |> cast(attributes, @require_params)
    |> validate_required(@require_params)
    |> validate_inclusion(:modal, ["b", "m"])
  end

  def change_distances(%__MODULE__{} = driver, distances) do
    driver
    |> cast(distances, [:distance_to_pickup, :distance_to_delivery])
    |> applied_changeset()
  end

  @spec applied_changeset(Ecto.Changeset.t()) :: %__MODULE__{}
  def applied_changeset(%Ecto.Changeset{valid?: false}) do
    nil
  end

  def applied_changeset(changeset) do
    apply_changes(changeset)
  end

  defp parser_coordinates(%{"coordinates" => coordinates} = attributes)
       when coordinates in [nil, %{}] do
    Map.put(attributes, "coordinates", nil)
  end

  defp parser_coordinates(%{"coordinates" => %{"long" => long, "lat" => lat}} = attributes)
       when long == nil or lat == nil do
    Map.put(attributes, "coordinates", nil)
  end

  defp parser_coordinates(%{"coordinates" => %{"long" => long, "lat" => lat}} = attributes) do
    Map.put(attributes, "coordinates", %{long: long, lat: lat})
  end

  defp parser_coordinates(
         %{"coordinates" => %{"longitude" => long, "latitude" => lat}} = attributes
       ) do
    Map.put(attributes, "coordinates", %{long: long, lat: lat})
  end

  defp parser_coordinates(%{"coordinates" => _} = attributes) do
    Map.put(attributes, "coordinates", nil)
  end
end
