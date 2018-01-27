defmodule Frequency.StationCacheTest do
  use ExUnit.Case, async: true

  alias Frequency.NPR.{Station, StationCache}

  test "coordinates do not exist in the cache" do
    assert StationCache.check_coordinates(30.1234, 50.1211) == :empty
  end

  test "sets coordinates" do
    StationCache.set_coordinates(50, 30, [%Station{id: 1}])
    assert StationCache.check_coordinates(50, 30) == [%Station{id: 1}]
  end

end
