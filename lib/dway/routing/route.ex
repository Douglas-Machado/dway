defmodule Dway.Routing.Route do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dway.Fleet.Driver


  @fields_to_export ~w(driver total_time pickup_time  delivery_time total_distance polyline)a

  @derive {Jason.Encoder, only: @fields_to_export}

  @require_params [:total_time, :pickup_time, :delivery_time, :total_distance]

  @primary_key {:id, :binary_id, autogenerate: true}

  @type t :: %__MODULE__{
          driver: String.t(),
          total_time: Float.t(),
          pickup_time: Float.t(),
          delivery_time: Float.t(),
          polyline: String.t(),
          total_distance: Float.t()
        }

  schema "routes" do
    field :total_time, :float
    field :pickup_time, :float
    field :delivery_time, :float
    field :polyline, :string
    field :total_distance, :float

    embeds_one :driver, Driver
    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = route, attrs) do
    route
    |> cast(attrs, [:total_time, :pickup_time, :delivery_time, :total_distance, :polyline])
    |> cast_embed(:driver)
    |> validate_required(@require_params)
  end

  def applied_changeset(changeset) do
    apply_changes(changeset)
  end
end
