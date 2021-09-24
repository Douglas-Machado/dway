defmodule Dway.Routing.Route do
  use Ecto.Schema
  import Ecto.Changeset

  schema "routes" do
    field :api_token, :string
    field :drivers, :string
    field :order, :string

    timestamps()
  end

  @doc false
  def changeset(route, attrs) do
    route
    |> cast(attrs, [:api_token, :drivers, :order])
    |> validate_required([:api_token, :drivers, :order])
  end
end
