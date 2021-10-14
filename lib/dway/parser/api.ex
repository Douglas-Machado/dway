defmodule Dway.Parser.Api do
  @moduledoc """
    Validate user token
  """
  alias Dway.Users.Accounts

  def validate(token) do
    case Accounts.get(token) do
      %Dway.User{} -> {:ok, token}
      nil -> {:error, "Token inválido"}
      _ -> {:error, "erro para o douglas"}
    end
  end
end
