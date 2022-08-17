defmodule Users.Repository.Users do
  def list_users(filters, opts) do
    Mongo.find(Mongo.Users, "users", filters, opts)
    |> Enum.to_list()
    |> Enum.map(fn user ->
      Map.put(user, "_id", BSON.ObjectId.encode!(user["_id"]))
    end)
  end

  def insert_user(user) do
    {:ok, insertedOneResult} = Mongo.insert_one(Mongo.Users, "users", user)

    %{"inserted_id" => BSON.ObjectId.encode!(insertedOneResult.inserted_id)}
  end

  def get_one_user(%{"_id" => user_id}) do
    user_id = BSON.ObjectId.decode!(user_id)
    user = Mongo.find_one(Mongo.Users, "users", %{"_id" => user_id})
    case user do
      nil -> nil
      _ -> Map.put(user, "_id", BSON.ObjectId.encode!(user["_id"]))
    end
  end
  def get_one_user(user_email) do
    user = Mongo.find_one(Mongo.Users, "users", user_email)
    case user do
      nil -> nil
      _ -> Map.put(user, "_id", BSON.ObjectId.encode!(user["_id"]))
    end
  end

  def update_user(replace_data, user_id) do
    user_id = BSON.ObjectId.decode!(user_id)

    Mongo.find_one_and_update(
      Mongo.Users,
      "users",
      %{"_id" => user_id},
      %{"$set": replace_data})
  end

  def delete_user(user_id) do
    user_id = BSON.ObjectId.decode!(user_id)

    Mongo.find_one_and_delete(
      Mongo.Users,
      "users",
      %{"_id" => user_id})
  end
end
