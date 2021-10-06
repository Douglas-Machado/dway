defmodule Dway.Parser.Api do
  alias Dway.Users.Create

  def validate(token) do
    case Create.get(token) do
      %{} -> token
      {:error, content} -> content
    end
  end
end
