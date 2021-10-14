defmodule Dway.Parser.Api do
  alias Dway.Users.Create

  def validate(token) do
    with true <- String.length(token) == 36 do
      case Create.get(token) do
        %Dway.User{} -> {:ok, token}
        nil -> {:error, "Token inválido"}
      end
    else
      false -> {:error, "Token inválido"}
    end
  end
end
