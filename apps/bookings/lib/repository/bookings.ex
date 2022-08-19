defmodule Bookings.Repository.Bookings do
  def insert_booking(booking) do
    {:ok, insertedOneResult} = Mongo.insert_one(Mongo.Bookings, "bookings", booking)

    %{"inserted_id" => BSON.ObjectId.encode!(insertedOneResult.inserted_id)}
  end

  def get_one_booking(booking_id) do
    booking_id = BSON.ObjectId.decode!(booking_id)
    booking = Mongo.find_one(Mongo.Bookings, "bookings", %{"_id" => booking_id})
    case booking do
      nil -> nil
      _ -> Map.put(booking, "_id", BSON.ObjectId.encode!(booking["_id"]))
    end
  end

  def update_booking(replace_data, booking_id) do
    booking_id = BSON.ObjectId.decode!(booking_id)

    Mongo.find_one_and_update(
      Mongo.Bookings,
      "bookings",
      %{"_id" => booking_id},
      %{"$set": replace_data})
  end

  def delete_booking(booking_id) do
    booking_id = BSON.ObjectId.decode!(booking_id)

    Mongo.find_one_and_delete(
      Mongo.Bookings,
      "bookings",
      %{"_id" => booking_id})
  end
end
