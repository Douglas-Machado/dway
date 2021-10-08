defmodule Dway.Parser.Api do
  alias Dway.Users.Create

  def validate(token) do
    case Create.get(token) do
      %Dway.User{} -> {:ok, token}
      nil -> {:error, "TEXTO PRO DOUGLAS"}
    end
  end
end

# Dway.Parser.Api.validate("5e92e0a5-eac9-4313-a0c8-faade0f0b77f")
