defmodule Dway.Repo.Migrations.CreateRoutes do
  use Ecto.Migration

  def change do
    create table(:routes) do
      add :total_time, :float
      add :pickup_time, :float
      add :delivery_time, :float
      add :polyline, :float
      add :total_distance, :float
      add :driver_id, :string

      timestamps()
    end
  end
end
