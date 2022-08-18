defmodule Availability.Repository.Availability do
  def list_availabilities(filters, opts) do
    Mongo.find(Mongo.Availability, "availability", filters, opts)
    |> Enum.to_list()
    |> Enum.map(fn availability ->
      Map.put(availability, "_id", BSON.ObjectId.encode!(availability["_id"]))
    end)
  end

  def insert_availability(availability) do
    {:ok, insertedOneResult} = Mongo.insert_one(Mongo.Availability, "availability", availability)

    %{"inserted_id" => BSON.ObjectId.encode!(insertedOneResult.inserted_id)}
  end

  def get_one_availability(availability_id) do
    availability_id = BSON.ObjectId.decode!(availability_id)
    availability = Mongo.find_one(Mongo.Availability, "availability", %{"_id" => availability_id})
    case availability do
      nil -> nil
      _ -> Map.put(availability, "_id", BSON.ObjectId.encode!(availability["_id"]))
    end
  end

  def update_availability(reavailability_data, availability_id) do
    availability_id = BSON.ObjectId.decode!(availability_id)

    Mongo.find_one_and_update(
      Mongo.Availability,
      "availability",
      %{"_id" => availability_id},
      %{"$set": reavailability_data})
  end

  def delete_availability(availability_id) do
    availability_id = BSON.ObjectId.decode!(availability_id)

    Mongo.find_one_and_delete(
      Mongo.Availability,
      "availability",
      %{"_id" => availability_id})
  end
end
