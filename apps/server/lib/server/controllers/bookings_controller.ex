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

  def get_company_bookings(conn, opts) do
    {limit, page} = Server.Helpers.Pagination.set(opts)
    body =
      Server.Integrations.Bookings.get_bookings(%{
        "company_id" => opts["company_id"]
        },
        limit: limit,
        skip: (page - 1) * limit
      )

    conn |> put_status(200) |> json(body)
  end

  def get_user_bookings(conn, opts) do
    {limit, page} = Server.Helpers.Pagination.set(opts)
    body =
      Server.Integrations.Bookings.get_bookings(%{
        "user_id" => opts["user_id"]
        },
        limit: limit,
        skip: (page - 1) * limit
      )

    conn |> put_status(200) |> json(body)
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
        request_body = Map.put(request_body, "validation_code", :crypto.strong_rand_bytes(10) |> Base.encode64())
        result = Server.Integrations.Bookings.update_booking(request_body)

        case result do
          {:error, err} -> conn |> put_status(400) |> json(%{error: err})
          {:ok, result} ->
            day = Map.get(result, "day")
            availability_id = Map.get(result, "availability_id")

            {:ok, total} = Server.Integrations.Bookings.total_bookings(%{
              "availability_id" => availability_id,
              "approved" => true
              })

            availability = Server.Integrations.Availability.get_availability(%{"_id" => availability_id}) || %{"available_spots" => 0, "days_available" => []}
            max_spots = Map.get(availability, "available_spots", 0)

            if total >= max_spots do
              days_available = Map.get(availability, "days_available")
              updated_available_days = Enum.filter(days_available,
                  fn available_day ->
                    available_day != day
                  end)

              payload = %{
                "id" => availability_id,
                "days_available" => updated_available_days
              }
              Server.Integrations.Availability.update_availability(payload)
            end

            conn
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
