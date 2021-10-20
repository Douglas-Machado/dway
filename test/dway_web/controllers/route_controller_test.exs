defmodule DwayWeb.RouteControllerTest do
  use DwayWeb.ConnCase

  setup do
    {:ok, user} = Dway.Accounts.call(%{email: "judite@d.com"})

    conn =
      put_req_header(
        build_conn(),
        "authentication",
        user.id
      )

    [conn: conn]
  end

  describe "create/2" do
    test "when all params are valid, creates the route", %{conn: conn} do
      params = %{
        "drivers" => [
          %{
            "coordinates" => %{
              "lat" => -22.513476978859,
              "long" => -44.091791768114874
            },
            "id" => 1,
            "index" => 2,
            "max_distance" => 2000,
            "modal" => "b",
            "name" => "Julio de Jundiai",
            "skills" => 1
          },
          %{
            "coordinates" => %{
              "lat" => -22.508229883387585,
              "long" => -44.093416921900584
            },
            "id" => 2,
            "index" => 1,
            "max_distance" => 10_000,
            "modal" => "m",
            "name" => "Douglas Martins",
            "skills" => 1
          },
          %{
            "coordinates" => %{
              "lat" => -22.508229883387585,
              "long" => -44.093416921900584
            },
            "id" => 3,
            "index" => 10,
            "max_distance" => 10_000,
            "modal" => "m",
            "name" => "Arthur Obayashi"
          }
        ],
        "order" => %{
          "customer_name" => "Theodora",
          "delivery" => %{
            "coordinates" => %{
              "lat" => -22.52219686435724,
              "long" => -44.10977748780379
            }
          },
          "id" => "95436212",
          "pickup" => %{
            "coordinates" => %{
              "lat" => -22.50776369362348,
              "long" => -44.09077352792969
            }
          },
          "time_window" => 1800
        }
      }

      response =
        conn
        |> post(Routes.route_path(conn, :create), params)
        |> json_response(:ok)

      assert %{
               "delivery_time" => 387.7,
               "driver_id" => 2,
               "order_id" => "95436212",
               "pickup_time" => 118.6,
               "polyline" =>
                 "lckhCx~blG`KjCm@jEsLaB`F}SeFsAgEqAf@}BhI~Bm@hCvAl@zQoBpFWh@Zp@hHuBJTxGx@|F{@jHlGz[lQtq@X`@|Fb@fBkBBaAv@CFp@vBpAxK`A",
               "total_distance" => 4817.0,
               "total_time" => 506.3
             } = response
    end

    test "when the coordinates are nil, returns an error", %{conn: conn} do
      params = %{
        "drivers" => [
          %{
            "coordinates" => %{},
            "id" => 1,
            "index" => 2,
            "max_distance" => 2000,
            "modal" => "b",
            "name" => "Julio de Jundiai",
            "skills" => [%{"skill" => "string"}]
          },
          %{
            "coordinates" => %{
              "lat" => -22.508229883387585
            },
            "id" => 2,
            "index" => 1,
            "max_distance" => 10_000,
            "modal" => "m",
            "name" => "Douglas Martins",
            "skills" => [%{"skill" => "string"}]
          },
          %{
            "coordinates" => %{
              "lat" => nil
            },
            "id" => 3,
            "index" => 10,
            "max_distance" => 10_000,
            "modal" => "m",
            "name" => "Arthur Obayashi",
            "skills" => [%{"skill" => "string"}]
          }
        ],
        "order" => %{
          "customer_name" => "Theodora",
          "delivery" => %{
            "coordinates" => %{
              "lat" => -22.52219686435724,
              "long" => -44.10977748780379
            }
          },
          "id" => "95436212",
          "pickup" => %{
            "coordinates" => %{
              "lat" => -22.50776369362348,
              "long" => -44.09077352792969
            }
          },
          "skill" => "string",
          "time_window" => 1800
        }
      }

      conn
      |> post(Routes.route_path(conn, :create), params)
      |> json_response(:unauthorized)

      assert %{"errors" => %{"detail" => "Bad Request"}}
    end
  end
end
