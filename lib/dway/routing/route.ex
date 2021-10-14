defmodule Dway.Routing.Route do
  @moduledoc """
    route schema
  """

  use Ecto.Schema
  import Ecto.Changeset

  @fields_to_export ~w(order_id driver_id total_time pickup_time  delivery_time total_distance polyline)a

  @derive {Jason.Encoder, only: @fields_to_export}

  @require_params [
    :total_time,
    :pickup_time,
    :delivery_time,
    :total_distance,
    :order_id,
    :driver_id,
    :polyline
  ]

  @primary_key {:id, :binary_id, autogenerate: true}

  @type t :: %__MODULE__{
          order_id: String.t(),
          driver_id: String.t(),
          total_time: Float.t(),
          pickup_time: Float.t(),
          delivery_time: Float.t(),
          total_distance: Float.t(),
          polyline: String.t()
        }

  schema "routes" do
    field :total_time, :float
    field :pickup_time, :float
    field :delivery_time, :float
    field :total_distance, :float
    field :order_id, :string
    field :driver_id, :string
    field :polyline, :string
    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = route, attrs) do
    route
    |> cast(attrs, @require_params)
    |> validate_required(@require_params)
  end

  def applied_changeset(changeset) do
    apply_changes(changeset)
  end
end
