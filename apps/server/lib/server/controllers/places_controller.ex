defmodule Server.PlacesController do
  use Server, :controller

  def index(conn, opts) do
    body = Server.Integrations.Places.get_places("country like this")
    conn |> put_status(200) |> json(body)
  end

  def show(conn, opts) do
    conn |> put_status(200) |> json(%{})
  end

  def create(conn, opts) do
    body = Server.Integrations.Places.insert_place(%{})
    conn |> put_status(200) |> json(body)
  end

  def update(conn, opts) do
    conn |> put_status(200) |> json(%{})
  end

  def delete(conn, opts) do
    conn |> put_status(200) |> json(%{})
  end
end
