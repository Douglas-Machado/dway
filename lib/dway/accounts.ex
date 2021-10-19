defmodule Dway.Accounts do
  @moduledoc """
    The user context.
  """

  alias Dway.Repo
  alias Dway.Accounts.User

  @doc """
    User registration

    ## params

    %{email: user_email}
  """
  def call(params \\ %{}) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  def get(token) do
    Repo.get(User, token)
  end

  def change_user(%User{} = _user, attrs \\ %{}) do
    User.changeset(attrs)
  end

  defp handle_insert({:ok, %User{} = result}), do: {:ok, %User{} = result}

  defp handle_insert({:error, result}) do
    {:error, %{status: :bad_request, result: result}}
  end
end
