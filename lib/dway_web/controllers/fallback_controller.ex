defmodule DwayWeb.FallbackController do
  alias DwayWeb.ErrorView

  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use DwayWeb, :controller

  # def call(conn, {:error, result}) do
  # conn
  # |> put_status(:bad_request)
  # |> put_view(ErrorView)
  # |> render("400.json", result: result)
  # end

  def call(conn, {:error, content}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("401.json", content: content)

    # |> put_resp_content_type("text/xml")
    # |> send_resp(401, content)
  end

  def call(conn, {:ok, :empty_drivers, message}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render("404.json", message: message)

    # |> send_resp(404, message: "Não há drivers disponíveis")
  end

  def call(conn, {:ok, :empty_order, message}) do
    conn
    |> put_status(:not_acceptable)
    |> put_view(ErrorView)
    |> render("406.json", message: message)

    # |> send_resp("406.json", message: "Não é possível roterizar a entrega")
  end

  # This clause handles errors returned by Ecto's insert/update/delete.
  # def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
  #   conn
  #   |> put_status(:unprocessable_entity)
  #   |> put_view(DwayWeb.ChangesetView)
  #   |> render("error.json", changeset: changeset)
  # end

  # # This clause is an example of how to handle resources that cannot be found.
  # def call(conn, {:error, :not_found}) do
  #   conn
  #   |> put_status(:not_found)
  #   |> put_view(DwayWeb.ErrorView)
  #   |> render(:"404")
  # end
end
