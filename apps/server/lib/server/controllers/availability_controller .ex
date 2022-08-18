defmodule Server.AvailabilityController  do
  use Server, :controller
  @resource_name "Availability"

  def show(conn, opts) do
    availability = Server.Integrations.Availability.get_availability(opts["id"])
    case availability do
      nil -> conn |> put_status(404) |> json(%{error: "#{@resource_name} resource not found"})
      _ -> conn |> put_status(200) |> json(availability)
    end
  end

  def create(conn, opts) do
    request_body = Server.Mappers.Availability.validate_fields(opts)

    case request_body do
      {:ok, request_body} ->
        request_body = Map.put_new(request_body, "price", 0)
        body = Server.Integrations.Availability.insert_availability(request_body)
        conn |> put_status(201) |> json(body)

      {:error, err} ->
        conn |> put_status(400) |> json(%{error: err})
    end
  end

  def update(conn, opts) do
    request_body = Server.Mappers.Availability.validate_update_fields(opts)

    case request_body do
      {:ok, request_body} ->
        result = Server.Integrations.Availability.update_availability(request_body)

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
    result = Server.Integrations.Availability.delete_availability(opts["id"])

    case result do
      {:error, err} -> conn |> put_status(400) |> json(%{error: err})
      _ -> conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(204, "")
    end
  end
end
