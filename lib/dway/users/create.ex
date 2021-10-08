defmodule Dway.Users.Create do
  alias Dway.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end

  def get(token) do
    Repo.get(User, token)
  end
end
