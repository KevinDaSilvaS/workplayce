defmodule CompaniesTest do
  use ExUnit.Case
  doctest Companies

  test "greets the world" do
    assert Companies.hello() == :world
  end
end
