defmodule Server.Services.HashPasswords do
  def hash_password(password) do
    Bcrypt.hash_pwd_salt(password)
  end
end
