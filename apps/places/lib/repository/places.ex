defmodule Places.Repository.Places do
  def list_places() do
    [
      %{name: "cool_startup_office", address: "laker street 451"},
      %{name: "small_business", address: "laker street 451"},
      %{name: "coworking", address: "laker street 1120"}
    ]
  end
end
