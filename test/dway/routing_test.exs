defmodule Dway.RoutingTest do
  use Dway.DataCase

  alias Dway.Routing

  describe "routes" do
    alias Dway.Routing.Route

    import Dway.RoutingFixtures

    @invalid_attrs %{api_token: nil, drivers: nil, order: nil}

    test "list_routes/0 returns all routes" do
      route = route_fixture()
      assert Routing.list_routes() == [route]
    end

    test "get_route!/1 returns the route with given id" do
      route = route_fixture()
      assert Routing.get_route!(route.id) == route
    end

    test "create_route/1 with valid data creates a route" do
      valid_attrs = %{api_token: "some api_token", drivers: "some drivers", order: "some order"}

      assert {:ok, %Route{} = route} = Routing.create_route(valid_attrs)
      assert route.api_token == "some api_token"
      assert route.drivers == "some drivers"
      assert route.order == "some order"
    end

    test "create_route/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Routing.create_route(@invalid_attrs)
    end

    test "update_route/2 with valid data updates the route" do
      route = route_fixture()

      update_attrs = %{
        api_token: "some updated api_token",
        drivers: "some updated drivers",
        order: "some updated order"
      }

      assert {:ok, %Route{} = route} = Routing.update_route(route, update_attrs)
      assert route.api_token == "some updated api_token"
      assert route.drivers == "some updated drivers"
      assert route.order == "some updated order"
    end

    test "update_route/2 with invalid data returns error changeset" do
      route = route_fixture()
      assert {:error, %Ecto.Changeset{}} = Routing.update_route(route, @invalid_attrs)
      assert route == Routing.get_route!(route.id)
    end

    test "delete_route/1 deletes the route" do
      route = route_fixture()
      assert {:ok, %Route{}} = Routing.delete_route(route)
      assert_raise Ecto.NoResultsError, fn -> Routing.get_route!(route.id) end
    end

    test "change_route/1 returns a route changeset" do
      route = route_fixture()
      assert %Ecto.Changeset{} = Routing.change_route(route)
    end
  end
end
