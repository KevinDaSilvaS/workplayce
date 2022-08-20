defmodule Server.Integrations.Auth do

  def get_auth(nil), do: nil
  def get_auth(id) do
    Auth.Repository.Auth.get_auth(id)
  end

  def insert_auth(auth) do
    Auth.Repository.Auth.insert_auth(auth)
  end
end
