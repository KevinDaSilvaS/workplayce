defmodule Server.CompaniesController do
  use Server, :controller
  @resource_name "Company"
  plug :authenticate

  def show(conn, opts) do
    company = Server.Integrations.Companies.get_company(opts["id"])

    case company do
      nil -> conn |> put_status(404) |> json(%{error: "#{@resource_name} resource not found"})
      _ -> conn |> put_status(200) |> json(company)
    end
  end

  def create(conn, opts) do
    request_body = Server.Mappers.Companies.validate_fields(opts)

    case request_body do
      {:ok, request_body} ->
        email = Map.get(request_body, "email")
        companyAlreadyExists = Server.Services.CompanyExists.company_exists?(%{
          "email" => email
        })

        case companyAlreadyExists do
          true ->
              conn |> put_status(400) |> json(%{
                error: "#{@resource_name} already inserted for email: #{email}"
              })

          _ ->
              request_body = Map.put_new(request_body, "max_offices", 1)
              request_body = Map.put_new(request_body, "confirmed_email", false)
              body = Server.Integrations.Companies.insert_company(request_body)
              conn |> put_status(201) |> json(body)
        end

      {:error, err} ->
        conn |> put_status(400) |> json(%{error: err})
    end
  end

  def update(conn, opts) do
    request_body = Server.Mappers.Companies.validate_update_fields(opts)

    case request_body do
      {:ok, request_body} ->
        result = Server.Integrations.Companies.update_company(request_body)

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
    result = Server.Integrations.Companies.delete_company(opts["id"])

    case result do
      {:error, err} -> conn |> put_status(400) |> json(%{error: err})
      _ -> conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(204, "")
    end
  end

  defp needs_auth?(conn) do
    methods = %{"PUT" => true, "PATCH" => true, "DELETE" => true}
    Map.get(methods, conn.method, false)
  end

  defp authenticate(conn, _) do
    case needs_auth?(conn) do
      true ->
        auth_token = Plug.Conn.get_req_header(conn, "auth-token")
                |> Enum.at(0)
        found_token = Server.Integrations.Auth.get_auth(auth_token) || %{}
        logged_in = Server.Services.LoggedIn.logged_in?(found_token)
        is_company = Server.Services.LoggedIn.is_company?(found_token)
        exists_in_db = Server.Integrations.Companies.get_company(
          Map.get(found_token, "company_id")) != nil
        is_authenticated = logged_in && is_company && exists_in_db

        case is_authenticated do
          true -> conn
          _ -> conn
            |> put_status(401)
            |> json(%{error: "Not authenticated"})
            |> halt()
        end
      _ ->
        conn
    end
  end
end
