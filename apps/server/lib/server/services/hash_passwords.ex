defmodule Server.Services.HashPasswords do
  def hash_password(password) do
    :crypto.hash(:sha256, "123") |> Base.encode16()
  end
end
