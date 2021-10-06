defmodule DwayWeb.WelcomeController do
  use DwayWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> text("Welcome!")
  end
end
