defmodule Dway.Routing do
  @moduledoc """
  The Routing context.
  """

  alias Dway.Repo

  alias Dway.Routing.Route

  def create_route(attrs \\ %{}) do
    %Route{}
    |> Route.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a single route.

  Raises `Ecto.NoResultsError` if the Route does not exist.

  ## Examples

      iex> get_route!(123)
      %Route{}

      iex> get_route!(456)
      ** (Ecto.NoResultsError)

  """
  def get_route(id), do: Repo.get(Route, id)

  @doc """
  Creates a route.

  ## Examples

      iex> insert_route(%Route{field: value})
      {:ok, %Route{}}
  """
  def insert_route(route_struct) do
    route_struct
    |> Repo.insert()
  end

  def list_routes do
    Repo.all(Route)
  end
end
