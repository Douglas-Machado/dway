defmodule Dway.Users.Create do
  alias Dway.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end

  def get(user_token) do
    Repo.get(User, user_token)
  end
end
