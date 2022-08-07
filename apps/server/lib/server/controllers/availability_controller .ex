defmodule Server.AvailabilityController  do
  use Server, :controller

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
