defmodule Server.PlacesController do
  use Server, :controller

  def index(conn, opts) do
    {limit, page} = Server.Helpers.Pagination.set(opts)
    filters = Server.Mappers.Places.map_filters(opts)

    body =
      Server.Integrations.Places.get_places(filters,
        limit: limit,
        skip: (page - 1) * limit
      )

    conn |> put_status(200) |> json(body)
  end

  def show(conn, opts) do
    place = Server.Integrations.Places.get_place(opts["id"])
    case place do
      nil -> conn |> put_status(404) |> json(%{error: "Resource not found"})
      _ -> conn |> put_status(200) |> json(place)
    end
  end

  def create(conn, opts) do
    request_body = Server.Mappers.Places.validate_fields(opts)

    case request_body do
      {:ok, request_body} ->
        body = Server.Integrations.Places.insert_place(request_body)
        conn |> put_status(201) |> json(body)

      {:error, err} ->
        conn |> put_status(400) |> json(%{error: err})
    end
  end

  def update(conn, opts) do
    request_body = Server.Mappers.Places.validate_update_fields(opts)

    case request_body do
      {:ok, request_body} ->
        result = Server.Integrations.Places.update_place(request_body)

        case result do
          {:error, err} -> conn |> put_status(400) |> json(%{error: err})
          _ -> conn
            |> put_resp_header("content-type", "application/json")
            |> send_resp(204, "")
        end

      {:error, err} ->
        conn |> put_status(400) |> json(%{error: err})
    end
  end

  def delete(conn, opts) do
    result = Server.Integrations.Places.delete_place(opts["id"])

    case result do
      {:error, err} -> conn |> put_status(400) |> json(%{error: err})
      _ -> conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(204, "")
    end
  end
end
