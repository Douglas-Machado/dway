defmodule Dway.Fleet.Data do
  use Ecto.Schema
  import Ecto.Changeset

  @require_params [:driver_id, :name, :max_distance, :coordinates, :modal, :index]

  @type t :: %__MODULE__{
          api: String.t(),
          drivers: list(),
          driver_id: String.t(),
          name: String.t(),
          max_distance: Integer.t(),
          coordinates: map(),
          modal: String.t(),
          index: Integer.t(),
          order: map(),
          order_id: String.t(),
          customer_name: String.t(),
          time_window: Float.t(),
          pickup_coordinates: map(),
          delivery_coordinates: map()
        }

  @primary_key false
  embedded_schema do
    field :api, :string
    field :drivers, {:array, :map}
    field :driver_id, :string
    field :name, :string
    field :max_distance, :integer
    field :coordinates, :map
    field :modal, :string
    field :index, :integer
    field :distance_to_pickup, :float
    field :distance_to_delivery, :float
    field :order, :map
    field :order_id, :string
    field :customer_name, :string
    field :time_window, :float
    field :pickup_coordinates, :map
    field :delivery_coordinates, :map
  end

  def changeset(attributes) do
    %__MODULE__{}
    |> cast(attributes, @require_params)
    |> validate_required(@require_params)
    |> validate_length(:api, is: 36)
  end
end
