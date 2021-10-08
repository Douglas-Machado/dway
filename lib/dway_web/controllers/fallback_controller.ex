defmodule DwayWeb.FallbackController do
  alias DwayWeb.ErrorView

  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use DwayWeb, :controller

  def call(conn, {:error, content}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    # |> put_resp_content_type("text/xml")
    |> send_resp(401, content)
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
