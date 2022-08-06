defmodule Server.PlacesController do
  use Server, :controller

  def get_places(conn, opts) do
    body = Server.Integrations.Places.get_places()
    conn |> put_status(200) |> json(body)
  end
end
