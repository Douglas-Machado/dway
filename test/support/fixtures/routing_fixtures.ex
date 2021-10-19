# defmodule Dway.RoutingFixtures do
#   @moduledoc """
#   This module defines test helpers for creating
#   entities via the `Dway.Routing` context.
#   """

#   @doc """
#   Generate a route.
#   """
#   def route_fixture(attrs \\ %{}) do
#     {:ok, route} =
#       attrs
#       |> Enum.into(%{
#         api_token: "some api_token",
#         drivers: "some drivers",
#         order: "some order"
#       })
#       |> Dway.Routing.create_route()

#     route
#   end
# end
