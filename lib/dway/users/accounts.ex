defmodule Dway.Users.Accounts do
  alias Dway.{Repo, User}

  def call(params \\ %{}) do
    params
    |> User.changeset()
    |> Repo.insert()
  end

  def get(token) do
    Repo.get(User, token)
  end

  def change_user(%User{} = _user, attrs \\ %{}) do
    User.changeset(attrs)
  end

end
