defmodule Server.Services.LoggedIn do
  def logged_in?(nil), do: false
  def logged_in?(token), do: true

  def is_company?(nil), do: false
  def is_company?(token) do
    Map.get(token, "type", false) == "COMPANY"
  end

  def is_user?(nil), do: false
  def is_user?(token) do
    Map.get(token, "type", false) == "USER"
  end
end
