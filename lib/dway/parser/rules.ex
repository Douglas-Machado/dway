defmodule Dway.Parser.Rules do
  @max_distance_biker 2000

  def rule(delivery_distance) when delivery_distance > @max_distance_biker do
    "m"
  end

  def rule(delivery_distance) when delivery_distance < @max_distance_biker do
    "b"
  end
end
