defmodule PlacesTest do
  use ExUnit.Case
  doctest Places

  test "greets the world" do
    assert Places.hello() == :world
  end
end
