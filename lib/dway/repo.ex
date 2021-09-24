defmodule Dway.Repo do
  use Ecto.Repo,
    otp_app: :dway,
    adapter: Ecto.Adapters.Postgres
end
