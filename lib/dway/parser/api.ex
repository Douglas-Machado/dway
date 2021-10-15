defmodule Dway.Parser.Api do
  @moduledoc """
    Validate user token
  """

  alias Dway.Users.Accounts
  alias Ecto.UUID

  @doc """
    returns a tuple {:ok, token} if is a valid UUID and if the user exists in the database
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
      %Dway.User{} -> {:ok, token}
    end
  end
end
