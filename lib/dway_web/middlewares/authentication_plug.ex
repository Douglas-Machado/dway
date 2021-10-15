defmodule DwayWeb.AuthenticationPlug do
  @moduledoc """

  """
  import Plug.Conn

  alias Dway.Parser.Api

  @token_header_key "authentication"

  def init(default), do: default

  def call(conn, _opts) do
    conn
    |> get_admin_token_header()
    |> authorize_admin()
    |> maybe_stop_request(conn)
  end

  defp maybe_stop_request(true = _authorized, conn), do: conn

  defp maybe_stop_request(false = _authorized, conn) do
    conn
    |> send_resp(:unauthorized, "Unauthorized")
    |> halt
  end

  defp authorize_admin(token_header_value) do
    case Api.validate(token_header_value) do
      {:ok, _} -> true
      _ -> false
    end
  end

  defp get_admin_token_header(conn) do
    conn
    |> get_req_header(@token_header_key)
    |> List.first()
  end
end
