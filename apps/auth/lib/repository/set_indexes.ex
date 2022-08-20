defmodule Auth.Index.Setter do
  use Agent

  def start_link(expiration_seconds) do
    Mongo.drop_index(Mongo.Auth, "auth", "expire_at_index")
    indexes =  [[key: [type: 1], name: "expire_at_index"]]
    IO.inspect(
      Mongo.create_indexes(Mongo.Auth, "auth", indexes, [expireAfterSeconds: 30, expire_after_seconds: 30]))
    IO.inspect(Mongo.list_index_names Mongo.Auth, "auth")
    Agent.start_link(fn -> expiration_seconds end, name: __MODULE__)
  end
end
