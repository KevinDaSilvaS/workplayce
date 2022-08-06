defmodule Server.Integrations.Places do
  def get_places() do
    Places.Repository.Places.list_places()
  end
end
