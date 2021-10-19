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
  Creates a route.

  ## Examples

      iex> insert_route(%Route{field: value})
      {:ok, %Route{}}
  """
  def insert_route(route_struct) do
    route_struct
    |> Repo.insert()
  end
end
