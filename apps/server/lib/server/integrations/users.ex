defmodule Server.Integrations.Users do
  def get_users(filters, opts) do
    Users.Repository.Users.list_users(filters, opts)
  end

  def get_user(nil), do: false
  def get_user(value, field \\"_id") do
    query = Map.new() |> Map.put_new(field, value)
    Users.Repository.Users.get_one_user(query)
  end

  def login(email, password) do
    Users.Repository.Users.login(email, password)
  end

  def insert_user(user) do
    Users.Repository.Users.insert_user(user)
  end

  def update_user(user_data) do
    {id, user} = Map.pop(user_data, "id")
    Users.Repository.Users.update_user(user, id)
  end

  def delete_user(id) do
    Users.Repository.Users.delete_user(id)
  end
end
