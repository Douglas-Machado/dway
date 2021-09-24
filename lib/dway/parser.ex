# receber o request da rota
# fazer o parser (converter a string do json pro map do elixir, validar os dados) do json
defmodule Dway.Parser do
  def parse_route(params) do
  # Jason para fazer o decode das informações
    IO.inspect(Jason.decode(params))
  end
end
