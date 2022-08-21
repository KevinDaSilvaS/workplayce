defmodule Server.Services.HashPasswords do
  def hash_password(password) do
    :crypto.hash(:sha256, password) |> Base.encode16()
  end
end
