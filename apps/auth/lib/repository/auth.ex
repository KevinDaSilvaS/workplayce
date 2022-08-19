defmodule Auth.Repository.Auth do

  def insert_auth(auth) do
    {:ok, insertedOneResult} = Mongo.insert_one(Mongo.Auth, "auth", auth)

    %{"token_id" => BSON.ObjectId.encode!(insertedOneResult.inserted_id)}
  end

  def get_auth(auth_id) do
    auth_id = BSON.ObjectId.decode!(auth_id)
    auth = Mongo.find_one(Mongo.auth, "auth", %{"_id" => auth_id})
    case auth do
      nil -> nil
      _ -> Map.put(auth, "_id", BSON.ObjectId.encode!(auth["_id"]))
    end
  end
end
