defmodule Places.Repository.Places do
  def list_places(filters, opts) do
    Mongo.find(Mongo.Places, "places", filters, opts)
    |> Enum.to_list()
    |> Enum.map(fn place ->
      Map.put(place, "_id", BSON.ObjectId.encode!(place["_id"]))
    end)
  end

  def insert_place(place) do
    {:ok, insertedOneResult} = Mongo.insert_one(Mongo.Places, "places", place)

    %{"inserted_id" => BSON.ObjectId.encode!(insertedOneResult.inserted_id)}
  end

  def get_one_place(place_id) do
    place_id = BSON.ObjectId.decode!(place_id)
    place = Mongo.find_one(Mongo.Places, "places", %{"_id" => place_id})
    case place do
      nil -> nil
      _ -> Map.put(place, "_id", BSON.ObjectId.encode!(place["_id"]))
    end
  end

  def update_place(replace_data, place_id) do
    place_id = BSON.ObjectId.decode!(place_id)

    Mongo.find_one_and_update(
      Mongo.Places,
      "places",
      %{"_id" => place_id},
      %{"$set": replace_data})
  end

  def delete_place(place_id) do
    place_id = BSON.ObjectId.decode!(place_id)

    Mongo.find_one_and_delete(
      Mongo.Places,
      "places",
      %{"_id" => place_id})
  end
end
