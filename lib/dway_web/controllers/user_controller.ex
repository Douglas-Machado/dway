defmodule DwayWeb.UserController do
  @moduledoc """
    User controller rendering the pages to user register
  """
  use DwayWeb, :controller

  alias Dway.Accounts.User
  alias Dway.Accounts

  action_fallback FallbackController

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.call(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %{status: :bad_request, result: changeset}} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get(id)
    render(conn, "show.html", user: user)
  end
end
