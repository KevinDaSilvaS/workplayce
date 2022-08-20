defmodule Server.Mappers.Auth do
  def validate_fields_login(fields) do
    user = Map.has_key?(fields, "user_id")
    company = Map.has_key?(fields, "company_id")

    case {user, company} do
      {false, false} -> {:error, "type not supported, or set"}
      {true, _} -> {:ok, Map.put_new(fields, "type", "USER")}
      {_, true} -> {:ok, Map.put_new(fields, "type", "COMPANY")}
    end
  end

  def validate_fields(fields) do
    password = Map.get(fields, "password")
        |> Server.Services.HashPasswords.hash_password()
    fields = Map.put(fields, "password", password)

    schema = %{
      "email" => %Litmus.Type.String{
        required: true
      },
      "password" => %Litmus.Type.String{
        required: true
      }
    }

    Litmus.validate(fields, schema)
  end
end
