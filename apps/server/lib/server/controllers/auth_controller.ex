defmodule Server.AuthController do
  use Server, :controller

  def login(conn, opts) do
    IO.inspect(conn)
    request_body = Server.Mappers.Auth.validate_fields(opts)

    case request_body do
      {:ok, request_body} ->
        body = Server.Integrations.Auth.insert_auth(request_body)
        conn |> put_status(201) |> json(body)

      {:error, err} ->
        conn |> put_status(400) |> json(%{error: err})
    end
  end
end
