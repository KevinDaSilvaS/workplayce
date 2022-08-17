defmodule Server.Services.UserExists do
  def user_exists?(email) do
    userFound = Server.Integrations.Users.get_user(email, "email")

    case userFound do
      nil -> false
      _ -> true
    end
  end
end
