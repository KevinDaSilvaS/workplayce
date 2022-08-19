defmodule Server.Mappers.Auth do
  def validate_fields(fields) do
    type = %{
      "COMPANY" => "COMPANY",
      "USER" => "USER"
    }

    valid = Map.get(type, Map.get(fields, "type", nil), nil)
    case valid do
      nil -> {:error, "type not supported, or set"}
      _ -> {:ok, fields}
    end
  end
end
