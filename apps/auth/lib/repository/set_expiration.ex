defmodule Expiration.Setter do
  use Agent

  def start_link(expiration_seconds) do
    Mongo.create_indexes(Mongo.Auth, "auth", [], expire_after_seconds: expiration_seconds)
    Agent.start_link(fn -> expiration_seconds end, name: __MODULE__)
  end
end
