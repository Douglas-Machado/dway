defmodule DwayWeb.FallbackController do
  alias DwayWeb.ErrorView

  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use DwayWeb, :controller

  @doc """
    handle the errors and show the user the json with the current error message.
  """
  def call(conn, {:error, content}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ErrorView)
    |> render("401.json", content: content)
  end

  def call(conn, {:ok, :empty_drivers, message}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("404.json", message: message)
  end

  def call(conn, {:ok, :empty_order, message}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("406.json", message: message)
  end
end
