defmodule Server.Mappers.Places do
  def map_filters(filters) do
    fields = ["address", "city", "company_id", "country", "description"]

    Enum.reduce(fields, %{}, fn field, acc ->
      value = Map.get(filters, field)
      case value do
        nil -> acc
        _   -> Map.put_new(acc, field, value)
      end
    end)
  end

  def validate_fields(fields) do
    schema = %{
      "address" => %Litmus.Type.String{
        required: true
      },
      "city" => %Litmus.Type.String{
        required: true
      },
      "company_id" => %Litmus.Type.String{
        required: true
      },
      "country" => %Litmus.Type.String{
        required: true
      },
      "description" => %Litmus.Type.String{
        required: true
      },
      "links" => %Litmus.Type.List{
        type: :string
      },
      "tags" => %Litmus.Type.List{
        type: :string
      }
    }

    Litmus.validate(fields, schema)
  end
end
