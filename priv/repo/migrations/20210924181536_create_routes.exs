defmodule Dway.Repo.Migrations.CreateRoutes do
  use Ecto.Migration

  def change do
    create table(:routes) do
      add :total_time, :float
      add :pickup_time, :float
      add :delivery_time, :float
      add :polyline, :string
      add :total_distance, :float
      add :order_id, :string
      add :driver_id, :integer
      add :modal, :string
      add :driver_coordinates, :map
      add :driver_name, :string
      add :order_pickup_coordinates, :map
      add :order_delivery_coordinates, :map
      timestamps()
    end
  end
end
