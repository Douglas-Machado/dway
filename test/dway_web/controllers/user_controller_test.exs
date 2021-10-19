defmodule DwayWeb.UserControllerTest do
  use DwayWeb.ConnCase, async: true

  describe "create/2" do
    test "when user_email is invalid, returns an error", %{conn: conn} do
      params = %{
        "email" => "douglas aaa"
      }

      conn = post(conn, Routes.user_path(conn, :create), user: params)

      assert html_response(conn, 200) =~ "Email já cadastrado ou inválido"
    end

    test "when user_email is valid(unique), returns the user", %{conn: conn} do
      param = %{
        "user" => %{"email" => "douglas@ddd.com"}
      }

      response =
        conn
        |> post(Routes.user_path(conn, :create, param))

      assert response.status == 302
    end
  end
end
