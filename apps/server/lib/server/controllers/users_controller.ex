defmodule Server.UsersController do
  use Server, :controller
  @resource_name "User"

  def index(conn, opts) do
    {limit, page} = Server.Helpers.Pagination.set(opts)
    filters = Server.Mappers.Users.map_filters(opts)

    body =
      Server.Integrations.Users.get_users(filters,
        limit: limit,
        skip: (page - 1) * limit
      )

    conn |> put_status(200) |> json(body)
  end

  def show(conn, opts) do
    user = Server.Integrations.Users.get_user(opts["id"])

    case user do
      nil -> conn |> put_status(404) |> json(%{error: "#{@resource_name} resource not found"})
      _ -> conn |> put_status(200) |> json(user)
    end
  end

  def create(conn, opts) do
    request_body = Server.Mappers.Users.validate_fields(opts)

    case request_body do
      {:ok, request_body} ->
        email = Map.get(request_body, "email")
        userAlreadyExists = Server.Services.UserExists.user_exists?(email)

        case userAlreadyExists do
          true ->
            conn |> put_status(400) |> json(%{
              error: "#{@resource_name} already inserted for email: #{email}"
            })

          _ ->
            request_body = Map.put_new(request_body, "confirmed_email", false)
            body = Server.Integrations.Users.insert_user(request_body)
            conn |> put_status(201) |> json(body)
        end

      {:error, err} ->
        conn |> put_status(400) |> json(%{error: err})
    end
  end

  def update(conn, opts) do
    request_body = Server.Mappers.Users.validate_update_fields(opts)

    case request_body do
      {:ok, request_body} ->
        result = Server.Integrations.Users.update_user(request_body)

        case result do
          {:error, err} ->
            conn |> put_status(400) |> json(%{error: err})

          _ ->
            conn
            |> put_resp_header("content-type", "application/json")
            |> send_resp(204, "")
        end

      {:error, err} ->
        conn |> put_status(400) |> json(%{error: err})
    end
  end

  def delete(conn, opts) do
    result = Server.Integrations.Users.delete_user(opts["id"])

    case result do
      {:error, err} ->
        conn |> put_status(400) |> json(%{error: err})

      _ ->
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(204, "")
    end
  end
end
