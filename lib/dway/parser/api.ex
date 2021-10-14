defmodule Dway.Parser.Api do
  alias Dway.Users.Create

  def validate(token) do
    case Create.get(token) do
      %Dway.User{} -> {:ok, token}
      nil -> {:error, "Token inválido"}
      _ -> {:error, "erro para o douglas"}
    end
  end
end
