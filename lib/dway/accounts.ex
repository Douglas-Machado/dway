defmodule Dway.Accounts do
  alias Dway.{User, Repo}

  def create_user(params \\ %{}) do
    User.changeset(params)
    |> Repo.insert()
  end

  def change_user(%User{} = _user, attrs \\ %{}) do
    User.changeset(attrs)
  end

  def get_user(id), do: Repo.get!(User, id)
end
