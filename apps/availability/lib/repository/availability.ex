defmodule Availability.Repository.Availability do

  def insert_availability(availability) do
    {:ok, insertedOneResult} = Mongo.insert_one(Mongo.Availability, "availability", availability)

    %{"inserted_id" => BSON.ObjectId.encode!(insertedOneResult.inserted_id)}
  end

  def get_availability(%{"_id" => availability_id}) do
    availability_id = BSON.ObjectId.decode!(availability_id)
    availability = Mongo.find_one(Mongo.Availability, "availability", %{"_id" => availability_id})
    case availability do
      nil -> nil
      _ -> Map.put(availability, "_id", BSON.ObjectId.encode!(availability["_id"]))
    end
  end
  def get_availability(query) do
    availability = Mongo.find_one(Mongo.Availability, "availability", query)
    case availability do
      nil -> nil
      _ -> Map.put(availability, "_id", BSON.ObjectId.encode!(availability["_id"]))
    end
  end

  def update_availability(replace_data, availability_id) do
    availability_id = BSON.ObjectId.decode!(availability_id)

    Mongo.find_one_and_update(
      Mongo.Availability,
      "availability",
      %{"_id" => availability_id},
      %{"$set": replace_data})
  end

  def delete_availability(availability_id) do
    availability_id = BSON.ObjectId.decode!(availability_id)

    Mongo.find_one_and_delete(
      Mongo.Availability,
      "availability",
      %{"_id" => availability_id})
  end
end
