defmodule Server.BookingsController  do
  use Server, :controller
  @resource_name "Bookings"

  def show(conn, opts) do
    booking = Server.Integrations.Bookings.get_booking(opts["id"])
    case booking do
      nil -> conn |> put_status(404) |> json(%{error: "#{@resource_name} resource not found"})
      _ -> conn |> put_status(200) |> json(booking)
    end
  end

  def create(conn, opts) do
    request_body = Server.Mappers.Bookings.validate_fields(opts)

    case request_body do
      {:ok, request_body} ->
        body = Server.Integrations.Bookings.insert_booking(request_body)
        conn |> put_status(201) |> json(body)

      {:error, err} ->
        conn |> put_status(400) |> json(%{error: err})
    end
  end

  def update(conn, opts) do
    request_body = Server.Mappers.Bookings.validate_update_fields(opts)

    case request_body do
      {:ok, request_body} ->
        result = Server.Integrations.Bookings.update_booking(request_body)

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
    result = Server.Integrations.Bookings.delete_booking(opts["id"])

    case result do
      {:error, err} -> conn |> put_status(400) |> json(%{error: err})
      _ -> conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(204, "")
    end
  end
end
