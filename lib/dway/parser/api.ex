defmodule Dway.Parser.Api do
  @moduledoc """
    Validate user token UUID
  """
  alias Ecto.UUID
  alias Dway.Accounts
  alias Dway.Accounts.User

  @doc """
    returns a tuple {:ok, token} if is a valid UUID and if the user exists in the database

    iex(1)> Dway.Parser.Api.validate(YOUR-API-KEY)
    {:ok, YOUR-API-KEY}
  """
  def validate(token) do
    case UUID.cast(token) do
      :error -> {:error, %{status: :bad_request, result: "Invalid ID format"}}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(token) do
    case Accounts.get(token) do
      nil -> {:error, %{status: :not_found, result: "User not found!"}}
      %User{} -> {:ok, token}
    end
  end
end
