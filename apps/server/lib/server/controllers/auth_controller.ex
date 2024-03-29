defmodule Server.AuthController do
  use Server, :controller

  def login(conn, opts) do
    request_body = Server.Mappers.Auth.validate_fields_login(opts)

    case request_body do
      {:ok, request_body} ->
        body = Server.Integrations.Auth.insert_auth(request_body)
        conn |> put_status(201) |> json(body)

      {:error, err} ->
        conn |> put_status(400) |> json(%{error: err})
    end
  end

  def login_user(conn, opts) do
    request_body = Server.Mappers.Auth.validate_fields(opts)

    case request_body do
      {:ok, request_body} ->
        email = Map.get(request_body, "email")
        password = Map.get(request_body, "password")
        user = Server.Integrations.Users.login(email, password)

        case user do
          nil -> conn |> put_status(404) |> json(%{error: "user resource not found"})
          _ ->
              payload = %{
                "user_id" => Map.get(user, "_id"),
                "type" => "USER"
              }
              body = Server.Integrations.Auth.insert_auth(payload)
              conn |> put_status(201) |> json(body)
        end

      {:error, err} ->
        conn |> put_status(400) |> json(%{error: err})
    end
  end

  def login_company(conn, opts) do
    request_body = Server.Mappers.Auth.validate_fields(opts)

    case request_body do
      {:ok, request_body} ->
        email = Map.get(request_body, "email")
        password = Map.get(request_body, "password")
        company = Server.Integrations.Companies.login(email, password)

        case company do
          nil -> conn |> put_status(404) |> json(%{error: "company resource not found"})
          _ ->
              payload = %{
                "company_id" => Map.get(company, "_id"),
                "type" => "COMPANY"
              }
              body = Server.Integrations.Auth.insert_auth(payload)
              conn |> put_status(201) |> json(body)
        end

      {:error, err} ->
        conn |> put_status(400) |> json(%{error: err})
    end
  end

  def get_token_info(conn, opts) do
    auth_token = Plug.Conn.get_req_header(conn, "auth-token") |> Enum.at(0)

    found_token = Server.Integrations.Auth.get_auth(auth_token)

    case found_token do
      nil -> conn |> put_status(404) |> json(%{error: "No info found with token: #{auth_token}"})
      _ -> conn |> put_status(200) |> json(found_token)
    end
  end
end
