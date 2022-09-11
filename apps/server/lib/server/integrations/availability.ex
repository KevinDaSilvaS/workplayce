defmodule Server.Integrations.Availability do

  def get_availability(id) do
    Availability.Repository.Availability.get_availability(id)
  end

  def insert_availability(availability) do
    Availability.Repository.Availability.insert_availability(availability)
  end

  def update_availability(replace_data) do
    {id, availability} = Map.pop(replace_data, "id")
    Availability.Repository.Availability.update_availability(availability, id)
  end

  def delete_availability(id) do
    Availability.Repository.Availability.delete_availability(id)
  end

  def list_availabilities(month, place_id) do
    Availability.Repository.Availability.list_availabilities(month, place_id)
  end
end
