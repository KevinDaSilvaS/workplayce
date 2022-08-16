defmodule Server.Controllers.CompaniesController do
  use Server, :controller

  def show(conn, opts) do
    company = Server.Integrations.Companies.get_company(opts["id"])

    case company do
      nil -> conn |> put_status(404) |> json(%{error: "Resource not found"})
      _ -> conn |> put_status(200) |> json(company)
    end
  end

  def create(conn, opts) do
    request_body = Server.Mappers.Companies.validate_fields(opts)

    case request_body do
      {:ok, request_body} ->
        body = Server.Integrations.Companies.insert_company(request_body)
        conn |> put_status(201) |> json(body)

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
          _ -> conn |> put_status(200) |> json(%{})
        end

      {:error, err} ->
        conn |> put_status(400) |> json(%{error: err})
    end
  end

  def delete(conn, opts) do
    result = Server.Integrations.Companies.delete_company(opts["id"])

    case result do
      {:error, err} -> conn |> put_status(400) |> json(%{error: err})
      _ -> conn |> put_status(200) |> json(%{})
    end
  end
end