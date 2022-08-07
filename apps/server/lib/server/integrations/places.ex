defmodule Server.Integrations.Places do
  def get_places(filters) do
    Places.Repository.Places.list_places(filters)
  end

  def insert_place(place) do
    Places.Repository.Places.insert_place(place)
  end
end
