defmodule Server.Integrations.Places do
  def get_places(filters, opts) do
    Places.Repository.Places.list_places(filters, opts)
  end

  def get_place(id) do
    Places.Repository.Places.get_one_place(id)
  end

  def insert_place(place) do
    Places.Repository.Places.insert_place(place)
  end

  def update_place(place_data) do
    {id, place} = Map.pop(place_data, "id")
    Places.Repository.Places.update_place(place, id)
  end
end
